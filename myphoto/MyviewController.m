//
//  MyviewController.m
//  myphoto
//
//  Created by ios1 on 16/6/17.
//  Copyright © 2016年 huzhixin. All rights reserved.
//

#import "MyviewController.h"
#import "STPhotoBroswer.h"
#import "MyviewCollectionview.h"
#import "MysecondVC.h"
//#import "PhotoCotentView.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MyviewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, STPhotoBroswerDelegate>

//UICollectionViewDataSource,UICollectionViewDelegate,
@property(nonatomic,strong) UICollectionView *collectionView;

//@property (strong, nonatomic)  PhotoCotentView *contentView;

@property(nonatomic,strong) NSMutableArray *imgArr;

@property(nonatomic,strong) UIImageView *imgPhoto;


@property(nonatomic,strong)  NSMutableArray *btnArr;

@property (nonatomic, strong) NSMutableArray *imagePhotoArray;



@property(nonatomic ,assign) int a;

@end


@implementation MyviewController
-(void)viewDidLoad
{
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
        self.edgesForExtendedLayout =UIRectEdgeNone;
    }
    
    _imagePhotoArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imgArr =[NSMutableArray array];
    
    self.btnArr =[[NSMutableArray alloc]initWithCapacity:0];
    self.imgPhoto =[[UIImageView alloc]init];
    self.imgPhoto.image =[UIImage imageNamed:@"未标题-1"];
    self.imgPhoto.userInteractionEnabled =YES;
    self.imgPhoto.frame =CGRectMake(15, 15, KScreenWidth/4-20, KScreenWidth/4-20);

    [self.view addSubview:self.imgPhoto];
    
    UITapGestureRecognizer *taped =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(liulanPhtot)];
    [self.imgPhoto addGestureRecognizer:taped];
    
    
//    [self.imgArr addObject:[ UIImage imageNamed:@"未标题-1"]];
    
}

-(void)liulanPhtot
{
    
    if (self.imagePhotoArray.count == 4) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"最多只能选4张！OK？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    [self readImageFromCarmer];
    
    
    
}
//相册选择
-(void)readImageFromCarmer
{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing =YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    

    [self.imagePhotoArray addObject:image];
    [self reloadAllSubViewsWithIndex:1];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - <STPhotoBroswerDelegate>
- (void)STPhotoBroswerDidDeleteImage:(NSInteger)index
{
    NSLog(@"%@", self.imagePhotoArray);

    [self.imagePhotoArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:index]];

    [self reloadAllSubViewsWithIndex:0];
}

- (void)reloadAllSubViewsWithIndex:(NSInteger )currentIndex
{
    
    NSLog(@"%@", self.imagePhotoArray);

    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat marginX = 15;
    CGFloat marginY = 15;
    CGFloat buttonW = ([UIScreen mainScreen].bounds.size.width - 15 * 5) / 4;
    
    for (NSInteger i = 0; i < self.imagePhotoArray.count; i ++) {
        
        
        
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(marginX + i % 4 * (buttonW + marginX), marginY + i / 4 * (buttonW + marginY), buttonW, buttonW);
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:_imagePhotoArray[i] forState:UIControlStateNormal];
        [self.view addSubview:button];
        
        

    }
    
    
        CGFloat imgPhotoX = marginX + (self.imagePhotoArray.count) % 4 * (buttonW + marginX);
        CGFloat imgPhotoY = marginY + (self.imagePhotoArray.count)/ 4 * (buttonW + marginY);
        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.frame = CGRectMake(imgPhotoX, imgPhotoY, buttonW, buttonW);
    [photoButton setBackgroundImage:[UIImage imageNamed:@"未标题-1"] forState:UIControlStateNormal];
        [photoButton addTarget:self action:@selector(liulanPhtot) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:photoButton];

    
}

//** button放大的时候 */

-(void)buttonClick:(UIButton *)btn
{
    

    STPhotoBroswer *stpeee =[[STPhotoBroswer alloc]initWithImageArray:self.imagePhotoArray currentIndex:0];
    stpeee.delegate = self;
    stpeee.frame =CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200);
        [stpeee show];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    
  
    
}
@end
