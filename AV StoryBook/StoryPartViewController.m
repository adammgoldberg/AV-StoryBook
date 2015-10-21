//
//  StoryPartViewController.m
//  AV StoryBook
//
//  Created by Adam Goldberg on 2015-10-19.
//  Copyright © 2015 Adam Goldberg. All rights reserved.
//

#import "StoryPartViewController.h"

@interface StoryPartViewController () <UIAlertViewDelegate, UIGestureRecognizerDelegate, AVAudioSessionDelegate>


@property (strong, nonatomic) IBOutlet UIButton *micButton;



@property (strong, nonatomic) IBOutlet UIImageView *storyImage;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;








@end

@implementation StoryPartViewController






- (IBAction)cameraButtonPressed:(id)sender
{

    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose" message:@"Pick an Action" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //
        }];
        [alertController addAction:cancelAction];
        
        
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self takePhoto];
        }];
        [alertController addAction:takePhotoAction];
        
        UIAlertAction *choosePicture = [UIAlertAction actionWithTitle:@"Choose From Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self choosePhotoFromLibrary];
        }];
        [alertController addAction:choosePicture];
        
        [self presentViewController:alertController animated:YES completion:nil];
        

        
    }   else {
        
       [self choosePhotoFromLibrary];
    }

}
    
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld", (long)buttonIndex);
    if (buttonIndex == 0) {
        [self takePhoto];
    } else if (buttonIndex == 1){
        [self choosePhotoFromLibrary];
    }
}
    
- (void)takePhoto
{
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = NO;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}



- (void)choosePhotoFromLibrary
{
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = NO;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
     UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
   // UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.storyImage.image = chosenImage;
    self.avInfo.storyImage = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)tapImage:(id)sender {
    NSLog(@"tapped");
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.avInfo.audioRecording error:nil];
    [self.audioPlayer play];
}


- (IBAction)microphoneButtonPressed:(id)sender {
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];

    if (self.audioRecorder.recording) {
        self.micButton.tintColor = [UIColor blueColor];
        [self.micButton setTitle:@"Microphone Button" forState:UIControlStateNormal];
        [self.audioRecorder stop];
        self.avInfo.audioRecording = self.audioRecorder.url;
    } else {
        NSString *rando = [[NSUUID UUID] UUIDString];
        NSString *filename = [NSString stringWithFormat:@"%@.aac", rando];
        NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
        NSURL *tempUrl = [[NSURL alloc] initFileURLWithPath:tempPath];
        
        NSError *error = nil;
        self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:tempUrl settings:@{ AVFormatIDKey : @(kAudioFormatMPEG4AAC) } error:&error];
        self.micButton.tintColor = [UIColor redColor];
        [self.micButton setTitle:@"recording" forState:UIControlStateNormal];
        [self.audioRecorder record];
        NSLog(@"recording is %@", self.avInfo.audioRecording);
        NSLog(@"noise is %@", self.audioRecorder.url);
        
    }
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.storyImage.image = self.avInfo.storyImage;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    
//    NSArray *gestures = self.parentViewController.view.gestureRecognizers;
//    for (UIGestureRecognizer *gesture in gestures) {
//        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
//            [self.parentViewController.view removeGestureRecognizer:gesture];
//        }
//    }
    
    
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
