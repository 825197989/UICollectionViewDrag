//
//  ViewController.m
//  UICollectionViewTest
//
//  Created by Jootun on 2019/11/19.
//  Copyright © 2019 Jootun. All rights reserved.
//

#import "ViewController.h"
#import "MoveCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isChange;
@property (nonatomic, strong) NSMutableArray *cellAttributesArray;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(45, 45);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MoveCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MoveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //为每个cell 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [cell addGestureRecognizer:longPress];
    return cell;
    
}


- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    MoveCollectionViewCell *cell = (MoveCollectionViewCell *)longPress.view;
    NSIndexPath *cellIndexpath = [_collectionView indexPathForCell:cell];
    [_collectionView bringSubviewToFront:cell];
    _isChange = NO;
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            [self.cellAttributesArray removeAllObjects];
            for (int i = 0; i < 10; i++) {
                [self.cellAttributesArray addObject:[_collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            cell.center = [longPress locationInView:_collectionView];
            for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
                if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexpath != attributes.indexPath) {
                    _isChange = YES;
                    NSString *str = self.data[cellIndexpath.row];
                    [self.data removeObjectAtIndex:cellIndexpath.row];
                    [self.data insertObject:str atIndex:attributes.indexPath.row];
                    [self.collectionView moveItemAtIndexPath:cellIndexpath toIndexPath:attributes.indexPath];
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            if (!_isChange) {
                cell.center = [_collectionView layoutAttributesForItemAtIndexPath:cellIndexpath].center;
            }
        }
            break;
        default:
            break;
    }
}

- (NSMutableArray *)cellAttributesArray {
    if(_cellAttributesArray == nil) {
        _cellAttributesArray = [[NSMutableArray alloc] init];
    }
    return _cellAttributesArray;
}

- (NSMutableArray *)data
{
    if(!_data)
    {
        _data = [NSMutableArray arrayWithCapacity:0];
        for(int i = 0; i < 10; i++)
        {
            [_data addObject:@(i)];
        }
    }
    return _data;
}


@end
