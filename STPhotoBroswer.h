//
//  STPhotoBroswer.h
//  STPhotoBroeser
//
//  Created by StriEver on 16/3/16.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STPhotoBroswerDelegate <NSObject>

- (void)STPhotoBroswerDidDeleteImage:(NSInteger)index;

@end

@interface STPhotoBroswer : UIView
/**
 * @brief 初始化方法  图片以数组的形式传入, 需要显示的当前图片的索引
 *
 * @param  imageArray需要显示的图片以数组的形式传入.
 * @param  index 需要显示的当前图片的索引
 */



@property(nonatomic,strong) UIButton *btnDeleta;


@property(nonatomic,strong)  UIView *daohangView;

//@property(nonatomic,strong)  
- (instancetype)initWithImageArray:(NSArray *)imageArray currentIndex:(NSInteger)index;
- (void)show;
@property (nonatomic, strong) id delegate;

@end
