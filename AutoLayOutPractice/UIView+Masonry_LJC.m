//
//  UIView+Masonry_LJC.m
//  AutoLayOutPractice
//
//  Created by R_style_Man on 14/12/20.
//  Copyright (c) 2014年 R_style_Man. All rights reserved.
//

#import "UIView+Masonry_LJC.h"
#import "Masonry.h"

@implementation UIView (Masonry_LJC)

-(void)distributeSpacingHorizontallyWith:(NSArray *)views
{
    NSMutableArray* spaces = [NSMutableArray arrayWithCapacity:views.count + 1];
    
    for (int i = 0; i <= views.count + 1; ++i)
    {
        UIView* v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
         [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    UIView* v0 = spaces[0];
    
    //__weak __typeof(&*self) ws = self;
    WS(ws);
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.mas_left);
        make.centerY.equalTo(((UIView*)views[0]).mas_centerY);
    }];
    
    UIView* lastSpace = v0;
    for (int i = 0; i < views.count; ++i)
    {
        UIView* obj = views[i];
        UIView* space = spaces[i+1];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastSpace.mas_right);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(obj.mas_right);
            make.centerY.equalTo(obj.mas_centerY);
            make.width.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right);
    }];
    
}

-(void) disTributeSpacingVerticallyWith:(NSArray *)views
{
    NSMutableArray* spaces = [NSMutableArray arrayWithCapacity:views.count + 1];
    
    for (int i = 0; i<views.count + 1; ++i)
    {
        UIView* v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
        
    }
    
    UIView* v0 = spaces[0];
    
    WS(ws);
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_top);
        make.centerX.equalTo(((UIView*)views[0]).mas_centerX);
    }];
    
    UIView* lasrSpace = v0;
    
    for (int i = 0; i< views.count; ++i)
    {
        UIView* obj = views[i];
        UIView* space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lasrSpace.mas_bottom);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(obj.mas_bottom);
            make.centerX.equalTo(obj.mas_centerX);
            make.height.equalTo(v0);
        }];
        
        lasrSpace = space;
        
    }
    
    [lasrSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottom);
    }];
    
}

@end
