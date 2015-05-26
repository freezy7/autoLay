//
//  AutoLayViewController.m
//  AutoLayOutPractice
//
//  Created by R_style Man on 15/5/25.
//  Copyright (c) 2015年 R_style_Man. All rights reserved.
//

#import "AutoLayViewController.h"

@interface AutoLayViewController ()

@end

@implementation AutoLayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"SnapShot";
    
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(snapShot:)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

-(void) snapShot:(UIBarButtonItem*) btn
{
//    // Want to create an image context - the size of the view and scale of the screen
//    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
//    // Render our snapshot into the image context
//    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
//    
//    // Grab the image from the context
//    UIImage* complexViewImage = UIGraphicsGetImageFromCurrentImageContext();
//    // Finish using the context
//    UIGraphicsEndImageContext();
//    
//    UIImageView* iv = [[UIImageView alloc] initWithImage:[self appleyBlurToImage:complexViewImage]];
//    
//    iv.center = self.view.center;
//    
//    [self.view addSubview:iv];
//    
//    [self performSelector:@selector(animateViewAwayAndReset:) withObject:iv afterDelay:0];
    
    
    UIView* snapshotView = [self.view snapshotViewAfterScreenUpdates:NO];
    
    [self.view addSubview:snapshotView];
    
    [self performSelector:@selector(animateViewAwayAndReset:) withObject:snapshotView];
}

// apply blur to image
-(UIImage*)appleyBlurToImage:(UIImage*)image
{
    CIContext* context = [CIContext contextWithOptions:nil];
    CIImage* ci_image = [CIImage imageWithCGImage:image.CGImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ci_image forKey:kCIInputImageKey];
    [filter setValue:@5 forKey:kCIInputRadiusKey];
    CIImage* result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    
    return [UIImage imageWithCGImage:cgImage scale:image.scale orientation:image.imageOrientation];
}

// animate and remove the snapshotView
-(void) animateViewAwayAndReset:(UIView*)view
{
    [UIView animateWithDuration:0.5 animations:^{
        view.center = CGPointMake(self.view.frame.size.width,64);
        view.bounds = CGRectZero;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
