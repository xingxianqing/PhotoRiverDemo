//
//  TRPhoto.h
//  Day4PhotoRiver
//
//  Created by tarena on 14-8-4.
//  Copyright (c) 2014年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRDrawView.h"
typedef NS_ENUM(NSInteger, TRPhotoStatus) {
    TRPhotoStatusNormal,
    TRPhotoStatusBig,
    TRPhotoStatusDraw,
    TRPhotoStatusTogether,
};

@interface TRPhoto : UIView
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)TRDrawView *drawView;
@property (nonatomic)float speed;
@property (nonatomic)CGRect oldFrame;
@property (nonatomic)float oldSpeed;
@property (nonatomic)float oldAlpha;
@property (nonatomic)TRPhotoStatus status;
-(void)updateImage:(UIImage *)image;
-(void)setImageViewAlpha:(float)alpha;
@end
