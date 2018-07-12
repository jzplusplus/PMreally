#line 1 "/Users/jzplusplus/Documents/jailbreak/PMreally/PMreally/PMreally.xm"




#include <UIKit/UIKit.h>


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class MTAAlarmTableViewController; @class MTAAlarmEditViewController; @class EditAlarmViewController; @class AlarmViewController; 


#line 7 "/Users/jzplusplus/Documents/jailbreak/PMreally/PMreally/PMreally.xm"
static void (*_logos_orig$iOS11$MTAAlarmEditViewController$_doneButtonClicked$)(_LOGOS_SELF_TYPE_NORMAL MTAAlarmEditViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$iOS11$MTAAlarmEditViewController$_doneButtonClicked$(_LOGOS_SELF_TYPE_NORMAL MTAAlarmEditViewController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$iOS11$MTAAlarmTableViewController$activeChangedForAlarm$active$)(_LOGOS_SELF_TYPE_NORMAL MTAAlarmTableViewController* _LOGOS_SELF_CONST, SEL, id, BOOL); static void _logos_method$iOS11$MTAAlarmTableViewController$activeChangedForAlarm$active$(_LOGOS_SELF_TYPE_NORMAL MTAAlarmTableViewController* _LOGOS_SELF_CONST, SEL, id, BOOL); 
    


    static void _logos_method$iOS11$MTAAlarmEditViewController$_doneButtonClicked$(_LOGOS_SELF_TYPE_NORMAL MTAAlarmEditViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg) {
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
                                                                               _logos_orig$iOS11$MTAAlarmEditViewController$_doneButtonClicked$(self, _cmd, arg);
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
        else _logos_orig$iOS11$MTAAlarmEditViewController$_doneButtonClicked$(self, _cmd, arg);
    }

    

    


    static void _logos_method$iOS11$MTAAlarmTableViewController$activeChangedForAlarm$active$(_LOGOS_SELF_TYPE_NORMAL MTAAlarmTableViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, BOOL arg2) {
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
                                               _logos_orig$iOS11$MTAAlarmTableViewController$activeChangedForAlarm$active$(self, _cmd, arg1, arg2);
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
        else _logos_orig$iOS11$MTAAlarmTableViewController$activeChangedForAlarm$active$(self, _cmd, arg1, arg2);
    }

    


static void (*_logos_orig$iOS10$EditAlarmViewController$_doneButtonClicked$)(_LOGOS_SELF_TYPE_NORMAL EditAlarmViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$iOS10$EditAlarmViewController$_doneButtonClicked$(_LOGOS_SELF_TYPE_NORMAL EditAlarmViewController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$iOS10$AlarmViewController$activeChangedForAlarm$active$)(_LOGOS_SELF_TYPE_NORMAL AlarmViewController* _LOGOS_SELF_CONST, SEL, id, BOOL); static void _logos_method$iOS10$AlarmViewController$activeChangedForAlarm$active$(_LOGOS_SELF_TYPE_NORMAL AlarmViewController* _LOGOS_SELF_CONST, SEL, id, BOOL); 
    


    static void _logos_method$iOS10$EditAlarmViewController$_doneButtonClicked$(_LOGOS_SELF_TYPE_NORMAL EditAlarmViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg) {
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
                                               _logos_orig$iOS10$EditAlarmViewController$_doneButtonClicked$(self, _cmd, arg);
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
        else _logos_orig$iOS10$EditAlarmViewController$_doneButtonClicked$(self, _cmd, arg);
            }

    

    


    static void _logos_method$iOS10$AlarmViewController$activeChangedForAlarm$active$(_LOGOS_SELF_TYPE_NORMAL AlarmViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, BOOL arg2) {
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
                                                   _logos_orig$iOS10$AlarmViewController$activeChangedForAlarm$active$(self, _cmd, arg1, arg2);
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
            else _logos_orig$iOS10$AlarmViewController$activeChangedForAlarm$active$(self, _cmd, arg1, arg2);
                }

    



static __attribute__((constructor)) void _logosLocalCtor_fc84ab0b(int __unused argc, char __unused **argv, char __unused **envp) {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
        {Class _logos_class$iOS11$MTAAlarmEditViewController = objc_getClass("MTAAlarmEditViewController"); MSHookMessageEx(_logos_class$iOS11$MTAAlarmEditViewController, @selector(_doneButtonClicked:), (IMP)&_logos_method$iOS11$MTAAlarmEditViewController$_doneButtonClicked$, (IMP*)&_logos_orig$iOS11$MTAAlarmEditViewController$_doneButtonClicked$);Class _logos_class$iOS11$MTAAlarmTableViewController = objc_getClass("MTAAlarmTableViewController"); MSHookMessageEx(_logos_class$iOS11$MTAAlarmTableViewController, @selector(activeChangedForAlarm:active:), (IMP)&_logos_method$iOS11$MTAAlarmTableViewController$activeChangedForAlarm$active$, (IMP*)&_logos_orig$iOS11$MTAAlarmTableViewController$activeChangedForAlarm$active$);}
    } else {
        {Class _logos_class$iOS10$EditAlarmViewController = objc_getClass("EditAlarmViewController"); MSHookMessageEx(_logos_class$iOS10$EditAlarmViewController, @selector(_doneButtonClicked:), (IMP)&_logos_method$iOS10$EditAlarmViewController$_doneButtonClicked$, (IMP*)&_logos_orig$iOS10$EditAlarmViewController$_doneButtonClicked$);Class _logos_class$iOS10$AlarmViewController = objc_getClass("AlarmViewController"); MSHookMessageEx(_logos_class$iOS10$AlarmViewController, @selector(activeChangedForAlarm:active:), (IMP)&_logos_method$iOS10$AlarmViewController$activeChangedForAlarm$active$, (IMP*)&_logos_orig$iOS10$AlarmViewController$activeChangedForAlarm$active$);}
    }
}

