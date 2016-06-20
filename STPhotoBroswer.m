//
//  ；
//  STPhotoBroeser
//
//  Created by StriEver on 16/3/16.
//  Copyright © 2016年 StriEver. All rights reserved.
//


#import "STPhotoBroswer.h"
#import "STImageVIew.h"
#import "Masonry/Masonry.h"
#define MAIN_BOUNDS   [UIScreen mainScreen].bounds
#define Screen_Width  [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//图片距离左右 间距
#define SpaceWidth    10
@interface STPhotoBroswer ()<STImageViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) NSArray * imageArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UILabel * numberLabel;

//@property(nonatomic,strong)  UIButton *btnDeleta;


@end
@implementation STPhotoBroswer


- (instancetype)initWithImageArray:(NSArray *)imageArray currentIndex:(NSInteger)index{
    if (self == [super init]) {
        self.imageArray = imageArray;
        self.backgroundColor =[UIColor redColor];
        self.index = index;
        [self setUpView];
    }
    return self;
}
//--getter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
                       
//                       [UIScreen mainScreen].bounds];
        _scrollView.backgroundColor = [UIColor yellowColor];
        _scrollView.delegate = self;
        //这里
        _scrollView.contentSize = CGSizeMake((Screen_Width + 2*SpaceWidth) * self.imageArray.count, 300);
        _scrollView.contentOffset = CGPointMake(Screen_Width * self.index, 0);
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        [self daohangView];
        [self numberLabel];

        [self btnDeleta];


        
    }
    return _scrollView;
}
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, Screen_Width, 40)];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.text = [NSString stringWithFormat:@"%ld/%lu",self.index +1,(unsigned long)self.imageArray.count];
        [_daohangView addSubview:_numberLabel];
    }
    return _numberLabel;
    
}
-(UIView*)daohangView
{
    
    if (!_daohangView) {
        
        
        _daohangView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
        _daohangView.backgroundColor =[UIColor blackColor];
        
        [self addSubview:_daohangView];
        
    }
    
    
    return _daohangView;
    
}
-(UIButton *)btnDeleta
{
   if (!_btnDeleta) {
        _btnDeleta =[UIButton buttonWithType:UIButtonTypeCustom];
       [_btnDeleta addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
       
        [_btnDeleta setTitle:@"删除" forState:UIControlStateNormal];
        [_btnDeleta setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_daohangView addSubview:_btnDeleta];
       
       [_btnDeleta mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(_daohangView.mas_right);
           make.top.equalTo(_daohangView.mas_top).mas_equalTo(10);
           make.width.equalTo(_btnDeleta.mas_width);
           
       }];
    }
    return _btnDeleta;
    
    
}
-(void)btnAction
{
    NSLog(@"%ld",(long)self.index);
    
    [self.delegate STPhotoBroswerDidDeleteImage:self.index];
//NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys: [NSNumber numberWithInteger:self.index+1],@"textOne", nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"delePhoto" object:nil userInfo:dict];
    
     NSLog(@"删除照片");
    
    [self dismiss];
}
- (void)setUpView{
    
    int index = 0;
    for (UIImage * image in self.imageArray) {
        STImageVIew * imageView = [[STImageVIew alloc]init];
        imageView.delegate = self;
        imageView.image = image;
        imageView.tag = index;
        [self.scrollView addSubview:imageView];
        index ++;
    }
    
    
}
#pragma mark ---UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/Screen_Width;
    self.index = index;
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass(obj.class) isEqualToString:@"STImageVIew"]) {
            STImageVIew * imageView = (STImageVIew *) obj;
            [imageView resetView];
        }
    }];
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/%lu",self.index+1,(unsigned long)self.imageArray.count];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //主要为了设置每个图片的间距，并且使 图片铺满整个屏幕，实际上就是scrollview每一页的宽度是 屏幕宽度+2*Space  居中。图片左边从每一页的 Space开始，达到间距且居中效果。
    _scrollView.bounds = CGRectMake(0, 0, Screen_Width + 2 * SpaceWidth,Screen_Height);
    _scrollView.center = self.center;
    
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(SpaceWidth + (Screen_Width+20) * idx, 0,Screen_Width,Screen_Height);
    }];
}
- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    [window addSubview:self];
    self.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:.5 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)dismiss
{
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:.5 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0000000001, 0.00000001);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
#pragma mark ---STImageViewDelegate
- (void)stImageVIewSingleClick:(STImageVIew *)imageView{
    [self dismiss];
}
@end

