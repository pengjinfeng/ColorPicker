//
//  ColorPickManageTools.h
//  TYC
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 pengjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ColorPickManageTools : NSObject
////1.先将图片缩放imageView的大小
//UIImage *img = [self scaleToSize:self.bigImage.image size:self.bigImage.bounds.size];
////2.截取50，50大小的图片 这个image需要内存上管理，建议设置为全局变量，这样每次从重新赋值之后就不会有指针再指向他，系统能够就会自动释放这块内存空间
//UIImage *image = [self imageFromImage:img inRect:CGRectMake(point.x-25, point.y-25, 50, 50)];
//self.cutImage.image = image;
////3.注意观察滑块的颜色，赋值颜色
//self.slider.backgroundColor = [self mostColor:image scale:1];


/**
 *  获取图片的主色
 *
 *  @param image image
 *  @param scale 精准度0.1~1
 *
 *  @return 图片的主要颜色
 */
+ (NSDictionary *)mostColor:(UIImage *)image scale:(CGFloat)scale;
/**
 *  获取图片上一个点的颜色
 *
 *  @param point 点击的点的位置
 *  @param image image
 *  @param rect  点击的区域
 *
 *  @return 返回点击点的颜色
 */
+ (UIColor *)colorAtPixel:(CGPoint)point UIImage:(UIImage *)image CGRect:(CGRect)rect;
// 裁剪图片
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;
/**
 *  缩放图片
 *
 *  @param img  image
 *  @param size 缩放后的大小
 *
 *  @return image
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
@end
