//
//  HCHomeViewController.m
//  Project
//
//  Created by 陈福杰 on 16/2/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCHomeViewController.h"
#import "HCHomeFamilyViewController.h"
#import "HCHomeFamilyGroupViewController.h"
#import "HCPublishViewController.h"
#import "AppDelegate.h"

@interface HCHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *leftItem;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) HCHomeFamilyViewController *family;
@property (nonatomic, strong) HCHomeFamilyGroupViewController *familyGroup;

@end

@implementation HCHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.family.view];
    [self.mainScrollView addSubview:self.familyGroup.view];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    if (_currentIndex == 0)
    {
        self.title = @"时光";
    }else if(_currentIndex == 1)
    {
        self.title = @"XXXX的家族";
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView.contentOffset.x == 0)
    {
        [self handleLeftItem];
    }
}

#pragma mark - private methods


- (void)handleLeftItem
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (app.leftSlideController.closed)
    {
        [app.leftSlideController openLeftView];
    }
    else
    {
        [app.leftSlideController closeLeftView];
    }
}

- (void)handleRightItem
{
    // 测试
    //    HCCreateGradeViewController *createGrade = [[HCCreateGradeViewController alloc] init];
    //    createGrade.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:createGrade animated:YES];
    //    return;
    //    HCHomeDetailViewController *detail = [[HCHomeDetailViewController alloc] init];
    //    [self.navigationController pushViewController:detail animated:YES];
    //    return;
    //    HCEditCommentViewController *editComment = [[HCEditCommentViewController alloc] init];
    //    UIViewController *rootController = self.view.window.rootViewController;
    //    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    //    {
    //        editComment.modalPresentationStyle=
    //        UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
    //    }else
    //    {
    //        rootController.modalPresentationStyle=
    //        UIModalPresentationCurrentContext|UIModalPresentationFullScreen;
    //    }
    //    [rootController presentViewController:editComment animated:YES completion:nil];
    //    return;
    
    HCPublishViewController *publish = [[HCPublishViewController alloc] init];
//    publish.data = @{@"data": self.dataSource};
    publish.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:publish animated:YES];
}

- (void)handleSegmentControl:(UISegmentedControl *)segment
{
    [self.mainScrollView setContentOffset:CGPointMake(segment.selectedSegmentIndex * WIDTH(self.view), -64) animated:YES];
}

#pragma mark - setter or getter

- (UIBarButtonItem *)leftItem
{
    if (!_leftItem)
    {
        _leftItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"time_but_left Sidebar") style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftItem)];
    }
    return _leftItem;
}

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"time_but_right Sidebar") style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem)];
    }
    return _rightItem;
}

- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView)
    {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-44)];
        _mainScrollView.contentSize = CGSizeMake(WIDTH(self.view)*2, 0);
        _mainScrollView.backgroundColor = [UIColor greenColor];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}

- (HCHomeFamilyViewController *)family
{
    if (!_family)
    {
        _family = [[HCHomeFamilyViewController alloc] init];
        _family.view.frame = CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-108);
        [self addChildViewController:_family];
    }
    return _family;
}

- (HCHomeFamilyGroupViewController *)familyGroup
{
    if (!_familyGroup)
    {
        _familyGroup = [[HCHomeFamilyGroupViewController alloc] init];
        _familyGroup.view.frame = CGRectMake(WIDTH(self.view), 0, WIDTH(self.view), HEIGHT(self.view)-108);
        [self addChildViewController:_familyGroup];
    }
    return _familyGroup;
}

@end
