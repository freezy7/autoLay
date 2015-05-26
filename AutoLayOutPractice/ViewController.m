//
//  ViewController.m
//  AutoLayOutPractice
//
//  Created by R_style_Man on 14/12/20.
//  Copyright (c) 2014年 R_style_Man. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MMPlaceHolder.h"
#import "UIView+Masonry_LJC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //NSAssert(false, @"big man");
    
    WS(ws);
    UIView* sv = [UIView new];
    //[sv showPlaceHolder];
    sv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sv];//在做autoLayOut之前一定要将view添加到superView上
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(310, 310));
    }];
    
    UIView* sv11 = [UIView new];
    UIView* sv12 = [UIView new];
    UIView* sv13 = [UIView new];
    UIView* sv21 = [UIView new];
    UIView* sv31 = [UIView new];
    
    sv11.backgroundColor = [UIColor redColor];
    sv12.backgroundColor = [UIColor redColor];
    sv13.backgroundColor = [UIColor redColor];
    sv21.backgroundColor = [UIColor redColor];
    sv31.backgroundColor = [UIColor redColor];
    
    [sv addSubview:sv11];
    [sv addSubview:sv12];
    [sv addSubview:sv13];
    [sv addSubview:sv21];
    [sv addSubview:sv31];
    
    
    //给不同的大小 测试效果
    [sv11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@[sv12,sv13]);
        make.centerX.equalTo(@[sv21,sv31]);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [sv12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    [sv13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [sv21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    [sv31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 60));
    }];
    
    [sv distributeSpacingHorizontallyWith:@[sv11,sv12,sv13]];
    [sv disTributeSpacingVerticallyWith:@[sv11,sv21,sv31]];
    
    [sv showPlaceHolderWithAllSubviews];
    [sv hidePlaceHolder];
    
    
    
    //自动计算 scrollView contentSize
//    UIScrollView* scrollView = [UIScrollView new];
//    scrollView.backgroundColor = [UIColor whiteColor];
//    [sv addSubview:scrollView];
//    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
//    }];
//    
//    UIView* container = [UIView new];
//    [scrollView addSubview:container];
//    
//    [container mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(scrollView);
//        make.width.equalTo(scrollView);
//    }];
//    
//    int count = 10;
//    
//    UIView* lastView = nil;
//    
//    for (int i = 1; i <= count; ++i)
//    {
//        UIView* subv = [UIView new];
//        [container addSubview:subv];
//        NSLog(@"%d",arc4random());
//        subv.backgroundColor = [UIColor colorWithHue:(arc4random() % 256 / 256.0)
//                                          saturation:(arc4random() % 128 / 256.0)
//                                          brightness:(arc4random() % 128 / 256.0)
//                                               alpha:1];
//        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.and.right.equalTo(container);
//            make.height.mas_equalTo(@(20*i));
//            if (lastView)
//            {
//                make.top.mas_equalTo(lastView.mas_bottom);
//            }
//            else
//            {
//                make.top.mas_equalTo(container.mas_top);
//            }
//            
//        }];
//        
//        lastView = subv;
//        
//    }
//    
//    [container mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(lastView.mas_bottom);
//    }];
    
//    UIView* sv1 = [UIView new];
//    [sv1 showPlaceHolder];
//    sv1.backgroundColor = [UIColor redColor];
//    [sv addSubview:sv1];
//    
//    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
//        /*等价于
//        make.top.equalTo(sv).with.offset(10);
//        make.left.equalTo(sv).with.offset(10);
//        make.right.equalTo(sv).with.offset(-10);
//        make.bottom.equalTo(sv).with.offset(-10);
//         */
//        
//        /*也等价于
//         make.top.left.right.and.bottom.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
//         */
//    }];
    
//    UIView* sv2 = [UIView new];
//    UIView* sv3 = [UIView new];
//    sv2.backgroundColor = [UIColor orangeColor];
//    sv3.backgroundColor = [UIColor orangeColor];
//    [sv2 showPlaceHolder];
//    [sv3 showPlaceHolder];
//    
//    [sv addSubview:sv2];
//    [sv addSubview:sv3];
//    
//    int padding1 = 10;
//    
//    [sv2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(sv.centerY);
//        make.left.equalTo(sv.mas_left).with.offset(padding1);
//        make.right.equalTo(sv3.mas_left).with.offset(-padding1);
//        make.height.mas_equalTo(@150);
//        make.width.equalTo(sv3);
//        
//    }];
//    
//    [sv3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(sv.centerY);
//        make.left.equalTo(sv2.mas_right).with.offset(padding1);
//        make.right.equalTo(sv.mas_right).with.offset(-padding1);
//        make.height.mas_equalTo(@150);
//        make.width.equalTo(sv2);
//    }];
    
    
    
}

-(IBAction)fontSegue:(id)sender
{
    [self performSegueWithIdentifier:@"FontTableViewSegue" sender:sender];
}

-(void)donePressed:(UIBarButtonItem*)btn
{
    //[self prepareForSegue:@"AutoLayViewController" sender:btn];
    [self performSegueWithIdentifier:@"AutoLayViewControllerSegue" sender:btn];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
