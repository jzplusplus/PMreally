#line 1 "/Users/jzplusplus/Documents/jailbreak/PMreally/PMreally/PMreally.xm"




#include <UIKit/UIKit.h>

#include <logos/logos.h>
#include <substrate.h>
@class EditAlarmViewController; @class AlarmViewController; 
static void (*_logos_orig$_ungrouped$EditAlarmViewController$_doneButtonClicked$)(EditAlarmViewController*, SEL, id); static void _logos_method$_ungrouped$EditAlarmViewController$_doneButtonClicked$(EditAlarmViewController*, SEL, id); static void (*_logos_orig$_ungrouped$AlarmViewController$activeChangedForAlarm$active$)(AlarmViewController*, SEL, id, BOOL); static void _logos_method$_ungrouped$AlarmViewController$activeChangedForAlarm$active$(AlarmViewController*, SEL, id, BOOL); 

#line 7 "/Users/jzplusplus/Documents/jailbreak/PMreally/PMreally/PMreally.xm"



static void _logos_method$_ungrouped$EditAlarmViewController$_doneButtonClicked$(EditAlarmViewController* self, SEL _cmd, id arg) {
    BOOL warnPM = YES;
    BOOL warnAM = NO;
    
    NSDictionary* plist = [NSDictionary dictionaryWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/jzplusplus.PMreally.plist"]];
    
    if (plist) { 
        NSNumber *pref = [plist objectForKey:@"pm"];
        if (pref) warnPM = [pref boolValue];
            
        pref = [plist objectForKey:@"am"];
        if (pref) warnAM = [pref boolValue];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"a"];
    NSString * ampm = [formatter stringFromDate:[[[self view] timePicker] date]];
    [formatter release];
    
    if( (warnPM && [ampm characterAtIndex:0] == 'P') || (warnAM && [ampm characterAtIndex:0] == 'A') )
    {
        NSString *title = [ampm stringByAppendingString:@", really?"];
        NSString *msg = [@"Did you really mean to set this alarm for " stringByAppendingString:[ampm stringByAppendingString:@"?"]];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:msg
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
                                                         handler:^(UIAlertAction *action)
                                                                {
                                                                    NSDate *d = [[[self view] timePicker] date];
                                                                    int offset = -43200;
                                                                    if([ampm characterAtIndex:0] == 'A') offset = 43200;
                                                                    d = [d dateByAddingTimeInterval: offset]; 
                                                                    [[[self view] timePicker] setDate:d animated:YES];
                                                                }
                                   ];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else _logos_orig$_ungrouped$EditAlarmViewController$_doneButtonClicked$(self, _cmd, arg);
}






static void _logos_method$_ungrouped$AlarmViewController$activeChangedForAlarm$active$(AlarmViewController* self, SEL _cmd, id arg1, BOOL arg2) {
    BOOL warnPM = YES;
    BOOL warnAM = NO;
    BOOL warnOnSwitch = YES;
    NSString *ampm = @"PM";
    
    NSDictionary* plist = [NSDictionary dictionaryWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/jzplusplus.PMreally.plist"]];
    
    if (plist) { 
        NSNumber *pref = [plist objectForKey:@"pm"];
        if (pref) warnPM = [pref boolValue];
            
        pref = [plist objectForKey:@"am"];
        if (pref) warnAM = [pref boolValue];
            
        pref = [plist objectForKey:@"switching"];
        if (pref) warnOnSwitch = [pref boolValue];
    }
    
    if([arg1 hour] < 12) ampm = @"AM";
    
    if( warnOnSwitch && (arg2 == YES) &&
       ( (warnPM && [arg1 hour] >= 12) || (warnAM && [arg1 hour] < 12) ))
    {
        NSString *title = [ampm stringByAppendingString:@", really?"];
        NSString *msg = [@"Did you really mean to set this alarm for " stringByAppendingString:[ampm stringByAppendingString:@"?"]];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:msg
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Yes, I did."
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action)
                                       {
                                           _logos_orig$_ungrouped$AlarmViewController$activeChangedForAlarm$active$(self, _cmd, arg1, arg2);
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
    else _logos_orig$_ungrouped$AlarmViewController$activeChangedForAlarm$active$(self, _cmd, arg1, arg2);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$EditAlarmViewController = objc_getClass("EditAlarmViewController"); MSHookMessageEx(_logos_class$_ungrouped$EditAlarmViewController, @selector(_doneButtonClicked:), (IMP)&_logos_method$_ungrouped$EditAlarmViewController$_doneButtonClicked$, (IMP*)&_logos_orig$_ungrouped$EditAlarmViewController$_doneButtonClicked$);Class _logos_class$_ungrouped$AlarmViewController = objc_getClass("AlarmViewController"); MSHookMessageEx(_logos_class$_ungrouped$AlarmViewController, @selector(activeChangedForAlarm:active:), (IMP)&_logos_method$_ungrouped$AlarmViewController$activeChangedForAlarm$active$, (IMP*)&_logos_orig$_ungrouped$AlarmViewController$activeChangedForAlarm$active$);} }
#line 124 "/Users/jzplusplus/Documents/jailbreak/PMreally/PMreally/PMreally.xm"
