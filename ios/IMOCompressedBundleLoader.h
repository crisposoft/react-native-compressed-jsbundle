#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>

@interface IMOCompressedBundleLoader : NSObject

#ifndef RCT_REMOVE_LEGACY_ARCH
+ (void)loadSourceForBridge:(RCTBridge *)bridge
             bridgeDelegate:(id<RCTBridgeDelegate>)delegate
                 onProgress:(RCTSourceLoadProgressBlock)onProgress
                 onComplete:(RCTSourceLoadBlock)loadCallback;
#endif

+ (void)loadBundleAtURL:(NSURL *)sourceURL
             onProgress:(RCTSourceLoadProgressBlock)onProgress
             onComplete:(RCTSourceLoadBlock)loadCallback;
@end
