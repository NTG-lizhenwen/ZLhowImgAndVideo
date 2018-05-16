//
//  ViewController.m
//  ZLhowImgAndVideo
//
//  Created by ZhenwenLi on 2018/5/15.
//  Copyright © 2018年 lizhenwen. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import "ZLShowMultimedia.h"
#import "UIImage+GIF.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.2 创建图片原图链接数组
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"FM" ofType:@"gif"];
    NSMutableArray *originalImageUrls = [NSMutableArray array];
    // 添加图片(原图)链接
    [originalImageUrls addObject:imagePath];
    [originalImageUrls addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526450961960&di=8b06696d23165b2d281640fdc662820a&imgtype=0&src=http%3A%2F%2Fa3.topitme.com%2F2%2F67%2F74%2F11489000958d174672o.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"];
    [originalImageUrls addObject:@"http://zhiling.oss-cn-shenzhen.aliyuncs.com/park1/20180515152221_1526368941186_add_topic_android0.mp4"];
    [originalImageUrls addObject:@"http://ww2.sinaimg.cn/large/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/536e7093jw1f6bqdj3lpjj20va134ana.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/75b1a75fjw1f6bqn35ij6j20ck0g8jtf.jpg"];
    [originalImageUrls addObject:@"http://zhiling.oss-cn-shenzhen.aliyuncs.com/park1/20180515152221_1526368941304_add_topic_android2.mp4"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/86afb21egw1f6bq3lq0itj20gg0c2myt.jpg"];
    
    
    for (int i=0; i<originalImageUrls.count; i++) {
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(10+110*(i%3), 110*(i/3), 100, 100);
        if (i==0) {
            [but setImage:[UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfFile:[originalImageUrls objectAtIndex:i]]] forState:UIControlStateNormal];
        }else{
            if (i==3||i==7) {
                [but setImage:[self firstFrameWithVideoURL:[NSURL URLWithString:[originalImageUrls objectAtIndex:i]] size:CGSizeMake(100, 100)] forState:UIControlStateNormal];
            }else{
                [but sd_setImageWithURL:[NSURL URLWithString:[originalImageUrls objectAtIndex:i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_head"]];
            }
        }
        
        [but addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        but.tag=10+i;
        [self.view addSubview:but];
    }
    
    
}


-(void)onClick:(UIButton *)but
{
    // 1.2 创建图片原图链接数组
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"FM" ofType:@"gif"];
    NSMutableArray *originalImageUrls = [NSMutableArray array];
    // 添加图片(原图)链接
    [originalImageUrls addObject:imagePath];
    [originalImageUrls addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526450961960&di=8b06696d23165b2d281640fdc662820a&imgtype=0&src=http%3A%2F%2Fa3.topitme.com%2F2%2F67%2F74%2F11489000958d174672o.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"];
    [originalImageUrls addObject:@"http://zhiling.oss-cn-shenzhen.aliyuncs.com/park1/20180515152221_1526368941186_add_topic_android0.mp4"];
    [originalImageUrls addObject:@"http://ww2.sinaimg.cn/large/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/536e7093jw1f6bqdj3lpjj20va134ana.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/75b1a75fjw1f6bqn35ij6j20ck0g8jtf.jpg"];
    [originalImageUrls addObject:@"http://zhiling.oss-cn-shenzhen.aliyuncs.com/park1/20180515152221_1526368941304_add_topic_android2.mp4"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/86afb21egw1f6bq3lq0itj20gg0c2myt.jpg"];
    
    NSMutableArray *medias=[NSMutableArray array];
    
    for (int i=0; i<originalImageUrls.count; i++) {
        ZLMediaInfo *info=[[ZLMediaInfo alloc]init];
        if (i==0) {
            info.isLocal=YES;
            info.type=ZLMediaInfoTypeGif;
        }else{
            info.isLocal=NO;
            if (i==3||i==7) {
                info.type=ZLMediaInfoTypeVideo;
            }else{
                info.type=ZLMediaInfoTypePhoto;
            }
        }
        info.url=[originalImageUrls objectAtIndex:i];
        UIButton *but1=(UIButton *)[self.view viewWithTag:10+i];
        info.insetsImageView=but1.imageView;
        
        [medias addObject:info];
    }
    
    ZLShowMultimedia *zlShow=[[ZLShowMultimedia alloc]init];
    zlShow.infos=medias;
    zlShow.currentIndex=but.tag-10;
    [zlShow show];
}

#pragma mark ---- 获取图片第一帧
- (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size {
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
        
    }
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
