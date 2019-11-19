//
//  MoveCollectionViewCell.m
//  UICollectionViewTest
//
//  Created by Jootun on 2019/11/19.
//  Copyright © 2019 Jootun. All rights reserved.
//

#import "MoveCollectionViewCell.h"

@implementation MoveCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        view.backgroundColor = [UIColor colorWithHue: (arc4random() % 255 / 256.0) saturation:((arc4random()% 255 / 256.0 ) + 0.5) brightness:(( arc4random() % 255 / 256.0 )) alpha:1];
        [self addSubview:view];
    }
    return self;
}
@end
