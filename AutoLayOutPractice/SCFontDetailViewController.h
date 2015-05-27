//
//  SCFontDetailViewController.h
//  AutoLayOutPractice
//
//  Created by R_style Man on 15/5/26.
//  Copyright (c) 2015年 R_style_Man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCFontDetailViewController : UIViewController

@property (strong,nonatomic) UIFontDescriptor* fontDescriptor;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptorLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UILabel *sampleTextLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgressBar;

@end
