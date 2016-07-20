//
//  EmoPageViewController.m
//  CSImojiKeyboard
//
//  Created by SuhyongChoi on 2016. 7. 20..
//  Copyright © 2016년 Elenore. All rights reserved.
//

#import "EmoPageView.h"
#import "EmoCollectionViewCell.h"
@interface EmoPageView ()

@end

@implementation EmoPageView

- (void)awakeFromNib {
    
    
    CGFloat width = self.frame.size.width / 5;
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [_flowLayout setItemSize:CGSizeMake(width, width)];
    [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_myCollectionView setBounces:NO];
    [_myCollectionView setCollectionViewLayout:_flowLayout];
    [_myCollectionView setBackgroundColor:[UIColor clearColor]];
    [_myCollectionView registerNib:[UINib nibWithNibName:@"EmoCell" bundle:nil] forCellWithReuseIdentifier:@"emo_cell"];
    
    emoArray = [NSArray array];

    
}

- (void)setInitWithEmoticonArray:(NSArray*)array {
    
    emoArray = array;
    [_myCollectionView reloadData];
}


#pragma mark - UICollectionView DataSource

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.frame.size.width / 5;
    
    return CGSizeMake(width, width);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return emoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    EmoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"emo_cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[emoArray objectAtIndex:indexPath.row]];
    
    //    cell.backgroundColor = [UIColor redColor];
    //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    //[self.CellLabel setText:[recipeImages objectAtIndex:indexPath.row]];
    
    int pages = floor(_myCollectionView.contentSize.width / _myCollectionView.frame.size.width) + 1;
    [_pageControl setNumberOfPages:pages];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate selectImoWithImageName:[emoArray objectAtIndex:indexPath.row]];
}

#pragma mark - UIScrollVewDelegate for UIPageControl

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _myCollectionView.frame.size.width;
    float currentPage = _myCollectionView.contentOffset.x / pageWidth;
    
    if (0.0f != fmodf(currentPage, 1.0f)) {
        _pageControl.currentPage = currentPage + 1;
    } else {
        _pageControl.currentPage = currentPage;
    }
    NSLog(@"finishPage: %d", _pageControl.currentPage);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
