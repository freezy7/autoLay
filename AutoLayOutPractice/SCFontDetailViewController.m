//
//  SCFontDetailViewController.m
//  AutoLayOutPractice
//
//  Created by R_style Man on 15/5/26.
//  Copyright (c) 2015年 R_style_Man. All rights reserved.
//

#import "SCFontDetailViewController.h"
#import <CoreText/CoreText.h>

@interface SCFontDetailViewController ()

@end

@implementation SCFontDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)handleDownloadPressed:(id)sender
{
    self.downloadProgressBar.hidden = NO;
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler((CFArrayRef)@[_fontDescriptor], NULL, ^bool(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
        double progressValue = [[(__bridge NSDictionary*)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
        if (state == kCTFontDescriptorMatchingDidFinish) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.downloadProgressBar.hidden = YES;
                [self updateView];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.downloadProgressBar.progress = progressValue;
            });
        }
        return (bool)YES;
    });
}

-(void)updateView
{
    NSString* fontName = [self.fontDescriptor objectForKey:UIFontDescriptorNameAttribute];
    self.title = fontName;
    
    UIFont* font = [UIFont fontWithName:fontName size:26.f];
    if (font && [font.fontName isEqualToString:fontName]) {
        self.sampleTextLabel.font = font;
        self.downloadButton.enabled = NO;
        self.detailDescriptorLabel.text = @"Font avaliable";
    }else{
        self.sampleTextLabel.font = [UIFont systemFontOfSize:font.pointSize];
        self.downloadButton.enabled = YES;
        self.detailDescriptorLabel.text = @"This font is not yet download";
    }
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
