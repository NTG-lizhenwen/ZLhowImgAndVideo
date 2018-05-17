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
    [originalImageUrls addObject:@"http://m3.13400.com:9888/20180328/9420.mp3"];
    [originalImageUrls addObject:@"http://zhiling.oss-cn-shenzhen.aliyuncs.com/park1/20180515152221_1526368941186_add_topic_android0.mp4"];
    [originalImageUrls addObject:@"http://ww2.sinaimg.cn/large/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/536e7093jw1f6bqdj3lpjj20va134ana.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/75b1a75fjw1f6bqn35ij6j20ck0g8jtf.jpg"];
    [originalImageUrls addObject:@"http://zhiling.oss-cn-shenzhen.aliyuncs.com/park1/20180515152221_1526368941304_add_topic_android2.mp4"];
    [originalImageUrls addObject:@"http://s6.sinaimg.cn/mw690/0062ywFUgy6Y2pBG8Vn65&690"];
    
    
    for (int i=0; i<originalImageUrls.count; i++) {
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(10+110*(i%3), 110*(i/3), 100, 100);
        if (i==0||i==8) {
            if (i==0) {
                [but setImage:[UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfFile:[originalImageUrls objectAtIndex:i]]] forState:UIControlStateNormal];
            }else{
                [but setImage:[UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[originalImageUrls objectAtIndex:i]]]] forState:UIControlStateNormal];
            }
            
        }else if (i==2){
            [but setImage:[self musicImageWithMusicURL:[NSURL URLWithString:[originalImageUrls objectAtIndex:i]]] forState:UIControlStateNormal];
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
    [originalImageUrls addObject:@"http://m3.13400.com:9888/20180328/9420.mp3"];
    [originalImageUrls addObject:@"http://zhiling.oss-cn-shenzhen.aliyuncs.com/park1/20180515152221_1526368941186_add_topic_android0.mp4"];
    [originalImageUrls addObject:@"http://ww2.sinaimg.cn/large/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/536e7093jw1f6bqdj3lpjj20va134ana.jpg"];
    [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/75b1a75fjw1f6bqn35ij6j20ck0g8jtf.jpg"];
    [originalImageUrls addObject:@"http://zhiling.oss-cn-shenzhen.aliyuncs.com/park1/20180515152221_1526368941304_add_topic_android2.mp4"];
    [originalImageUrls addObject:@"http://s6.sinaimg.cn/mw690/0062ywFUgy6Y2pBG8Vn65&690"];
    
    NSMutableArray *medias=[NSMutableArray array];
    
    for (int i=0; i<originalImageUrls.count; i++) {
        ZLMediaInfo *info=[[ZLMediaInfo alloc]init];
        if (i==0) {
            info.isLocal=YES;
            info.type=ZLMediaInfoTypeGif;
        }else if (i==2){
            info.isLocal=NO;
            info.type=ZLMediaInfoTypeAudio;
        }else if (i==8){
            info.isLocal=NO;
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

/**
 *  通过音乐地址，读取音乐数据，获得图片
 *
 *  @param url 音乐地址
 *
 *  @return音乐图片
 */
- (UIImage *)musicImageWithMusicURL:(NSURL *)url {
    NSData *data = nil;
    // 初始化媒体文件
    AVURLAsset *mp3Asset = [AVURLAsset URLAssetWithURL:url options:nil];
    // 读取文件中的数据
    for (NSString *format in [mp3Asset availableMetadataFormats]) {
        for (AVMetadataItem *metadataItem in [mp3Asset metadataForFormat:format]) {
            //artwork这个key对应的value里面存的就是封面缩略图，其它key可以取出其它摘要信息，例如title - 标题
            if ([metadataItem.commonKey isEqualToString:@"artwork"]) {
                data = [(NSDictionary*)metadataItem.value objectForKey:@"data"];
                break;
            }
        }
    }
    if (!data) {
        // 如果音乐没有图片，就返回默认图片
        return [UIImage imageNamed:@"default"];
    }
    return [UIImage imageWithData:data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
