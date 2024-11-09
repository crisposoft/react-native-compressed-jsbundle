#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>

@interface IMOCompressedBundleLoader : NSObject

+ (void)loadSourceForBridge:(RCTBridge *)bridge
             bridgeDelegate:(id<RCTBridgeDelegate>)delegate
                 onProgress:(RCTSourceLoadProgressBlock)onProgress
                 onComplete:(RCTSourceLoadBlock)loadCallback;

+ (void)loadBundleAtURL:(NSURL *)sourceURL
             onProgress:(RCTSourceLoadProgressBlock)onProgress
             onComplete:(RCTSourceLoadBlock)loadCallback;
@end
