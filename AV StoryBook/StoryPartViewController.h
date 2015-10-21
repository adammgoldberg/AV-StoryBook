//
//  StoryPartViewController.h
//  AV StoryBook
//
//  Created by Adam Goldberg on 2015-10-19.
//  Copyright © 2015 Adam Goldberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVInfo.h"

@import AVFoundation;

@interface StoryPartViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>




@property (nonatomic, strong) AVInfo *avInfo;




@end
