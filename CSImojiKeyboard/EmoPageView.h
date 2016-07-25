//
//  EmoPageViewController.h
//  CSImojiKeyboard
//
//  Created by SuhyongChoi on 2016. 7. 20..
//  Copyright © 2016년 Elenore. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmoSelectDelegate;

@interface EmoPageView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate> {
    
    NSArray *emoArray;
    
}

- (void)setInitWithEmoticonArray:(NSArray*)array;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) id<EmoSelectDelegate>delegate;
@end

@protocol EmoSelectDelegate <NSObject>

@required
- (void)selectImoWithImageName:(NSString*)imageName;

@end