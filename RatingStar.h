//
//  RatingStar.h
//  MallTemplate
//
//  Created by Stephen Zhuang on 14-4-23.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RatingBlock)(NSInteger star);

@interface RatingStar : UIView
@property (nonatomic , assign) CGFloat buttonWidth;
@property (nonatomic , strong) NSMutableArray *buttonArray;
@property (nonatomic , assign) NSInteger rating;
@property (nonatomic , copy) RatingBlock ratingBlock;
@property BOOL isAddCommnet;
- (void)setRating:(NSInteger)rating;
@end
