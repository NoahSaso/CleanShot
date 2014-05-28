#define kName @"CleanShot"
#import <Custom/defines.h>

extern "C" UIImage* _UICreateScreenUIImage();

@interface SBScreenFlash : NSObject
+ (id)sharedInstance;
- (void)flash;
@end

%hook SBScreenShotter

- (void)saveScreenshot:(BOOL)screenshot {
	//Get screenshot
    UIImage *screenImage = _UICreateScreenUIImage();

    //Flash screen (:
    SBScreenFlash* screenFlash = [%c(SBScreenFlash) sharedInstance];
    [screenFlash flash];

    //Define new frame (* 2 for retina)
    CGRect newFrame = CGRectMake(0, 20 * 2, screenImage.size.width * 2, (screenImage.size.height - 20) * 2);

    //Crop screenshot to rect size
    CGImageRef imageRef = CGImageCreateWithImageInRect(screenImage.CGImage, newFrame);
    screenImage = [UIImage imageWithCGImage:imageRef]; 
    CGImageRelease(imageRef);

    //Save screenshot
    UIImageWriteToSavedPhotosAlbum(screenImage, nil, nil, nil);
    XLog(@"Wrote screenshot without status bar");
}

%end
