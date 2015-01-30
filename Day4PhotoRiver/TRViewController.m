//
//  TRViewController.m
//  Day4PhotoRiver
//
//  Created by tarena on 14-8-4.
//  Copyright (c) 2014年 tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRPhoto.h"
@interface TRViewController ()
@property (nonatomic, strong)NSMutableArray *photos;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photos = [NSMutableArray array];
    NSMutableArray *imagePaths = [NSMutableArray array];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = @"/Users/xingxianqing/Desktop/图片";
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
    for (NSString *fileName in fileNames) {
        if ([fileName hasSuffix:@"jpg"]) {
            NSString *imagePath = [path stringByAppendingPathComponent:fileName];
            [imagePaths addObject:imagePath];
        }
    }
    //添加9个Photo对象到界面
    for (int i=0; i<9; i++) {
        TRPhoto *photo = [[TRPhoto alloc]initWithFrame:CGRectMake(-200, arc4random()%468, 80, 120)];
        [photo updateImage:[UIImage imageWithContentsOfFile:imagePaths[i]]];
        float alpha = i*1.0/10 + 0.2;
        [photo setImageViewAlpha:alpha];
        [self.view addSubview:photo];
        
        [self.photos addObject:photo];
    }
    
    
    //添加双击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [tap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:tap];
    
    
}

-(void)tapAction{//双击事件
    //判断如果有图片的状态为放大 或 绘制的时候不能集合
    for (TRPhoto *p in self.photos) {
        if (p.status == TRPhotoStatusBig||p.status==TRPhotoStatusDraw) {
            return;
        }
    }
    

    float w = self.view.bounds.size.width/3;
    float h = self.view.bounds.size.height/3;
    
    
    
    
    [UIView animateWithDuration:.5 animations:^{
        //判断当前图片的状态
        TRPhoto *photo = self.photos[0];
        if (photo.status == TRPhotoStatusNormal) {//如果是流动状态 让图片集合
            for (int i=0; i<self.photos.count; i++) {
                TRPhoto *photo = self.photos[i];
                photo.oldAlpha = photo.alpha;
                photo.oldFrame = photo.frame;
                photo.oldSpeed = photo.speed;
                photo.frame = CGRectMake(i%3*w, i/3*h, w, h);
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.speed = 0;
                photo.alpha = 1;
                photo.status = TRPhotoStatusTogether;
            }
            
            
            
        }else if (photo.status == TRPhotoStatusTogether){//如果是集合状态 让图片流动
            
            for (int i=0; i<self.photos.count; i++) {
                TRPhoto *photo = self.photos[i];
                
                photo.frame = photo.oldFrame;
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.speed = photo.oldSpeed;
                photo.alpha = photo.oldAlpha;
                photo.status = TRPhotoStatusNormal;
            }
            
            
            
        }

    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
