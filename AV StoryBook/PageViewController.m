//
//  PageViewController.m
//  AV StoryBook
//
//  Created by Adam Goldberg on 2015-10-19.
//  Copyright © 2015 Adam Goldberg. All rights reserved.
//

#import "PageViewController.h"
#import "AVInfo.h"
#import "StoryPartViewController.h"

@interface PageViewController () 


@property (nonatomic, strong) NSArray *objectArray;

@end

@implementation PageViewController


- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    StoryPartViewController *currentVC = (StoryPartViewController *)viewController;
    NSInteger currentIndex = [self.objectArray indexOfObject:currentVC.avInfo];
    
    if (currentIndex == 0) {
        return nil;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    StoryPartViewController *spv = [storyboard instantiateViewControllerWithIdentifier:@"StoryPartViewController"];
    
    spv.avInfo = self.objectArray[currentIndex - 1];
    return spv;
}



- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    StoryPartViewController *currentVC = (StoryPartViewController *)viewController;
    NSInteger currentIndex = [self.objectArray indexOfObject:currentVC.avInfo];
    
    if (currentIndex == 4) {
        return nil;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    StoryPartViewController *spv = [storyboard instantiateViewControllerWithIdentifier:@"StoryPartViewController"];
    
    spv.avInfo = self.objectArray[currentIndex + 1];
    
    
        
    return spv;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.delegate = self;
    self.dataSource = self;
    
    AVInfo *object1 = [[AVInfo alloc] init];
    AVInfo *object2 = [[AVInfo alloc] init];
    AVInfo *object3 = [[AVInfo alloc] init];
    AVInfo *object4 = [[AVInfo alloc] init];
    AVInfo *object5 = [[AVInfo alloc] init];
    
    self.objectArray = @[object1, object2, object3, object4, object5];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    StoryPartViewController *storyPartViewController = [storyboard instantiateViewControllerWithIdentifier:@"StoryPartViewController"];
    storyPartViewController.avInfo = object1;
    [self setViewControllers:@[storyPartViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
  
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
