#line 1 "/Users/jzplusplus/Documents/jailbreak/PMreally/PMreally/PMreally.xm"




#include <UIKit/UIKit.h>





















#include <logos/logos.h>
#include <substrate.h>
@class EditAlarmViewController; 
static void (*_logos_orig$_ungrouped$EditAlarmViewController$_doneButtonClicked$)(EditAlarmViewController*, SEL, id); static void _logos_method$_ungrouped$EditAlarmViewController$_doneButtonClicked$(EditAlarmViewController*, SEL, id); 

#line 27 "/Users/jzplusplus/Documents/jailbreak/PMreally/PMreally/PMreally.xm"



static void _logos_method$_ungrouped$EditAlarmViewController$_doneButtonClicked$(EditAlarmViewController* self, SEL _cmd, id arg) {
    
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
                                                                           _logos_orig$_ungrouped$EditAlarmViewController$_doneButtonClicked$(self, _cmd, arg);
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
    else _logos_orig$_ungrouped$EditAlarmViewController$_doneButtonClicked$(self, _cmd, arg);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$EditAlarmViewController = objc_getClass("EditAlarmViewController"); MSHookMessageEx(_logos_class$_ungrouped$EditAlarmViewController, @selector(_doneButtonClicked:), (IMP)&_logos_method$_ungrouped$EditAlarmViewController$_doneButtonClicked$, (IMP*)&_logos_orig$_ungrouped$EditAlarmViewController$_doneButtonClicked$);} }
#line 65 "/Users/jzplusplus/Documents/jailbreak/PMreally/PMreally/PMreally.xm"
