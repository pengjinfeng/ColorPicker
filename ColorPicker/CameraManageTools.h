//
//  CameraManageTools.h
//  TYC
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 pengjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CameraManageTools : NSObject<UIImagePickerControllerDelegate>
/**
 *  打开照相机，（**这里面的对象需要自己模态弹出相册，相机的页面）
 *
 *   返回图片库对象
 */
+ (void)openCamera:(id<UIImagePickerControllerDelegate>)delegate;
/**
 *  打开图片库
 *
 *  返回图片库对象
 */
+ (void)openImagePickController:(id<UIImagePickerControllerDelegate>)delegate;
@end
