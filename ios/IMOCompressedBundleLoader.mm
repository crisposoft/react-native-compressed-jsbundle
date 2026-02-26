#import "IMOCompressedBundleLoader.h"
#import "BrotliUtil.h"
#import "TraceUtil.h"
#import "IMOReactSource.h"

#define FALLBACK_TO_DEFAULT_LOADER()             \
  [RCTJavaScriptLoader loadBundleAtURL:sourceURL \
      onProgress:onProgress                      \
      onComplete:loadCallback];

@implementation IMOCompressedBundleLoader

#ifndef RCT_REMOVE_LEGACY_ARCH
+ (void)loadSourceForBridge:(RCTBridge *)bridge
             bridgeDelegate:(id<RCTBridgeDelegate>)delegate
                 onProgress:(RCTSourceLoadProgressBlock)onProgress
                 onComplete:(RCTSourceLoadBlock)loadCallback
{
    NSURL *sourceURL = [delegate sourceURLForBridge:bridge];
    
    [IMOCompressedBundleLoader loadBundleAtURL:sourceURL onProgress:onProgress onComplete:loadCallback];
}
#endif

+ (void)loadBundleAtURL:(NSURL *)sourceURL
             onProgress:(RCTSourceLoadProgressBlock)onProgress
             onComplete:(RCTSourceLoadBlock)loadCallback
{
    if (!sourceURL.isFileURL) {
        FALLBACK_TO_DEFAULT_LOADER();
        return;
    }
    
    CFTimeInterval startTime = CACurrentMediaTime();
    
    NSData *compressedData = [[NSData alloc] initWithContentsOfURL:sourceURL options:NSDataReadingMappedIfSafe error:nil];
    
    if (!compressedData) {
        FALLBACK_TO_DEFAULT_LOADER();
        return;
    }
    
    NSData *decompressedData = IMOTryDecompressingBrotli(compressedData);
    
    if (!decompressedData) {
        FALLBACK_TO_DEFAULT_LOADER();
        return;
    }
    
    IMOTraceDecompressionPerformance(startTime, compressedData.length, decompressedData.length);

    RCTSource *source = [IMOReactSource sourceWithUrl:sourceURL data:decompressedData];
    loadCallback(nil, source);
}
@end
