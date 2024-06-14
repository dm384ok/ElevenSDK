//
//  EvelentHelper.m
//  
//
//

#import "ElevenWrap.h"
#import <PostHog/PostHog.h>
#import <WonderPush/WonderPush.h>

@implementation ElevenSDK

+ (void)load {
    
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

@end
