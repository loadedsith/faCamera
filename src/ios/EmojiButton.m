//
//  EmojiButton.m
//  FaCamera
//
//  Created by Graham Heath on 11/19/14.
//
//

#import "EmojiButton.h"

@implementation EmojiButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect frame = self.titleLabel.frame;
  frame.size.height = self.bounds.size.height;
  frame.origin.y = self.titleEdgeInsets.top;
  self.titleLabel.frame = frame;
}

@end
