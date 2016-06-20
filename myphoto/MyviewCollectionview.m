//
//  MyviewCollectionview.m
//  593877243
//
//  Created by ios1 on 16/6/14.
//  Copyright © 2016年 huzhixin. All rights reserved.
//

#import "MyviewCollectionview.h"

@implementation MyviewCollectionview
-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self)
    {
//        self.nameLab =[[UILabel alloc]init];
//        self.nameLab.text=@"1111";
//        
//        [self.contentView addSubview:self.nameLab];
        self.img =[[UIImageView alloc]init];
        [self.contentView addSubview:self.img];
     
        
         [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            
             make.left.right.top.bottom.equalTo(self.contentView);  
             
         }];
        
        
//        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView.mas_top).offset(10);
//            make.width.mas_equalTo(self.nameLab.mas_width);
//            
//            make.left.mas_equalTo(self.img.mas_right);
//            
//        }];
        
        
    }
    return self;
}
@end
