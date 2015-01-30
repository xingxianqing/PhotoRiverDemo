//
//  TRPhoto.m
//  Day4PhotoRiver
//
//  Created by tarena on 14-8-4.
//  Copyright (c) 2014年 tarena. All rights reserved.
//

#import "TRPhoto.h"

@implementation TRPhoto

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.drawView = [[TRDrawView alloc]initWithFrame:self.bounds];
        [self addSubview:self.drawView];
        [self addSubview:self.imageView];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
        
        //加边
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeSubviewsAction)];
        [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self addGestureRecognizer:swipe];
    }
    return self;
}
-(void)changeSubviewsAction{
    if (self.status==TRPhotoStatusBig) {
        self.status = TRPhotoStatusDraw;
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    }else if (self.status == TRPhotoStatusDraw){
        self.status = TRPhotoStatusBig;
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    }
    
    
}
-(void)tapAction{//图片单击手势
    for (UIView *v in self.superview.subviews) {
        if ([v isMemberOfClass:[TRPhoto class]]) {
            TRPhoto *p = (TRPhoto*)v;
            //如果遍历的图片是当前放大的图片 不应该有限制
            if ([p isEqual:self]) {
                continue;
            }
            if (p.status == TRPhotoStatusBig||p.status==TRPhotoStatusDraw) {
                return;
            }

        }
        
    }
    
    
    [UIView animateWithDuration:.5 animations:^{
        if (self.status == TRPhotoStatusNormal) {
            self.oldAlpha = self.alpha;
            self.oldFrame = self.frame;
            self.oldSpeed = self.speed;
            self.frame = CGRectMake(60, (self.superview.bounds.size.height-300)/2, 200, 300);
            self.imageView.frame = self.bounds;
            self.drawView.frame = self.bounds;
            self.speed = 0;
            self.alpha = 1;
            self.status = TRPhotoStatusBig;//代表当前状态是大图状态
            //把控件显示到父视图的最前端
            [self.superview bringSubviewToFront:self];
        }else if (self.status == TRPhotoStatusBig){
            self.alpha = self.oldAlpha;
            self.frame = self.oldFrame;
            self.imageView.frame = self.bounds;
            self.drawView.frame = self.bounds;
            self.speed = self.oldSpeed;
            self.status = TRPhotoStatusNormal;//代表当前状态是normal
        }

    }];
    
    
    
}

-(void)setImageViewAlpha:(float)alpha{
    self.alpha = alpha;
    self.speed = 4*self.alpha +1;
    [self setTransform:CGAffineTransformScale(self.transform, self.alpha , self.alpha)];
}

-(void)moveAction{
    
    self.center = CGPointMake(self.center.x+self.speed, self.center.y);
    if (self.center.x>320+self.bounds.size.width/2) {
        
        self.center = CGPointMake(-self.bounds.size.width/2, arc4random()%(int)(568-self.bounds.size.height) + self.bounds.size.height/2);
    }
}

-(void)updateImage:(UIImage *)image{
    self.imageView.image = image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
