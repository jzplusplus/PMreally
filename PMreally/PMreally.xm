
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

#include <UIKit/UIKit.h>

%hook EditAlarmViewController

- (void)_doneButtonClicked: (id)arg
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"a"];
    NSString * ampm = [formatter stringFromDate:[[[self view] timePicker] date]];
    [formatter release];
    
    if([ampm characterAtIndex:0] == 'P')
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"PM, really?"
                                                                                 message:@"Did you really mean to set this alarm for PM?"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Yes, I did."
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action)
                                                                       {
                                                                           %orig(arg);
                                                                       }
                                       ];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Nope!"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action){}
                                   ];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else %orig(arg);
}

%end