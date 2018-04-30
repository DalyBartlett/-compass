//
//  RatingStar.m
//  MallTemplate
//
//  Created by Stephen Zhuang on 14-4-23.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "RatingStar.h"

@implementation RatingStar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        _buttonArray = [[NSMutableArray alloc] init];
//        _buttonWidth = 20;
    }
    return self;
}

- (void)awakeFromNib
{
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    _buttonArray = [[NSMutableArray alloc] init];
//    // Drawing code
//    for (int i = 0; i < 5; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setBackgroundImage:[UIImage imageNamed:@"评分未选中"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"评分选中"] forState:UIControlStateSelected];
//        button.tag = i + 1;
//        [button setFrame:CGRectMake(2 * (i + 1) + _buttonWidth * i, 0, _buttonWidth, _buttonWidth)];
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:button];
//        
//        [_buttonArray addObject:button];
//    }
//    [self setRating:_rating];
//}

- (void)setButtonWidth:(CGFloat)buttonWidth
{
    _buttonWidth = buttonWidth;
    _buttonArray = [[NSMutableArray alloc] init];
    // Drawing code
    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//         if (_isAddCommnet) {
//             [button setBackgroundImage:[UIImage imageNamed:@"五角星灰"] forState:UIControlStateNormal];
//             [button setBackgroundImage:[UIImage imageNamed:@"五角星红"] forState:UIControlStateSelected];
//         }
//         else{
//             [button setBackgroundImage:[UIImage imageNamed:@"评分未选中"] forState:UIControlStateNormal];
//             [button setBackgroundImage:[UIImage imageNamed:@"评分选中"] forState:UIControlStateSelected];
//         }
        [button setBackgroundImage:[UIImage imageNamed:@"tygwc_ic_xingxing_h"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tygwc_ic_xingxing_n"] forState:UIControlStateSelected];
        button.tag = i + 1;
        [button setFrame:CGRectMake(2 * (i + 1) + _buttonWidth * i, 0, _buttonWidth, _buttonWidth)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [_buttonArray addObject:button];
    }

}

- (void)setRating:(NSInteger)rating
{
    _rating = rating;
    for (UIButton *button in _buttonArray) {
        if (button.tag <= rating) {
            [button setSelected:YES];
        } else {
            [button setSelected:NO];
        }
    }
}

- (void)buttonAction:(UIButton *)sender
{
    if (_isAddCommnet) {
        [self setRating:sender.tag];
        if (_ratingBlock) {
            _ratingBlock(sender.tag);
        }
    }

}


@end
