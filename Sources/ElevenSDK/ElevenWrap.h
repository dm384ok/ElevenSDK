//
//  EvelentHelper.h
//  
//
//

#import <Foundation/Foundation.h>
#import <UnityAds/UnityAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface ElevenSDK : NSObject <UnityAdsInitializationDelegate, UnityAdsLoadDelegate, UnityAdsShowDelegate>

-(void)initializationComplete;

@end

NS_ASSUME_NONNULL_END
