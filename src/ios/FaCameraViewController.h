//
//  FaCameraViewController.h
//  FaCamera
//
//  Created by Graham Heath on 11/15/14.
//
//

#import <UIKit/UIKit.h>

// We can't import the CustomCamera class because it would make a circular reference, so "fake" the existence of the class like this:
@class FaCameraOld;


@interface FaCameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (id)setupPicker;

// Action method
-(IBAction) takePhotoButtonPressed:(id)sender forEvent:(UIEvent*)event;
-(IBAction) closePhotoButtonPressed:(id)sender forEvent:(UIEvent*)event;

//camera ui
-(IBAction)toggleFlash:(id)sender forEvent:(UIEvent*)event;
-(IBAction)toggleCameraForward:(id)sender forEvent:(UIEvent*)event;

@property (strong, nonatomic) FaCameraOld* plugin;
@property (strong, nonatomic) UIImagePickerController* picker;
@property (nonatomic, strong) UIView *whiteScreen;


@end
