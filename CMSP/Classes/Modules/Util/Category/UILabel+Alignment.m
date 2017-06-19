//
//  UILabel+Alignment.m
//  CMSP
//
//  Created by 刘刚 on 2017/6/7.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "UILabel+Alignment.h"

@implementation UILabel (Alignment)

- (void)changeAlignmentRightandLeft{
    
    CGRect textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil];
    
    CGFloat margin = (self.frame.size.width - textSize.size.width) / (self.text.length - 1);
    
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    [attributeString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    
    self.attributedText = attributeString;
    
}

@end
