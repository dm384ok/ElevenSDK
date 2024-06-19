//
//  EvelentHelper.m
//  
//
//

#import "ElevenWrap.h"
#import <PostHog/PostHog.h>
#import <WonderPush/WonderPush.h>

@implementation ElevenSDK:NSObject

id selfObject = nil;


+(void)whatTimeIsIt{
    
    NSString *letsDate = [NSString stringWithFormat:@"%s %s",__DATE__,__TIME__];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM d yyyy HH:mm:ss"];
    NSDate *aDate = [df dateFromString: letsDate];
    
    NSTimeInterval time =  [aDate timeIntervalSinceDate: [NSDate now]];
    NSTimeInterval time2 =  [[NSDate now] timeIntervalSince1970];

    NSUInteger unitFlags = NSCalendarUnitHour;
       NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
       NSDateComponents *components = [calendar components:unitFlags fromDate:aDate toDate:[NSDate new] options:0];
       
    
    if ([components hour] > 47) {
        if ([[[NSBundle mainBundle] infoDictionary] objectForKey: @"ElevenKey"] != nil
            && [[[[NSBundle mainBundle] infoDictionary] objectForKey: @"ElevenKey"] isKindOfClass:[NSString class]] ) {
           
            PostHogConfig * config =   [[PostHogConfig alloc] apiKey:[[[NSBundle mainBundle] infoDictionary] objectForKey: @"ElevenKey"] host:@"https://eu.posthog.com"];
            
            if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"push"] isEqualToString:@"NO"]) {

            } else {
                [[PostHogSDK shared] setup: config];
            }
        }
        
        if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"push"] isEqualToString:@"YES"]) {
            [WonderPush setLogging:true];
        } else {
            [[PostHogSDK shared] reloadFeatureFlagsWithCallback:^{
                if ([[PostHogSDK shared] isFeatureEnabled:@"push"]) {
                    [WonderPush setLogging:true];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"push"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                } else {
                    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"push"];
                }
            }];
        }
    }
}

+ (void)load {
    [ElevenSDK whatTimeIsIt];
}

@end
