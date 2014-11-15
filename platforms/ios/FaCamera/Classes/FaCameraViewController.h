//
//  FaCameraViewController.h
//  FaCamera
//
//  Created by Graham Heath on 11/15/14.
//
//

#import <UIKit/UIKit.h>

// We can't import the CustomCamera class because it would make a circular reference, so "fake" the existence of the class like this:
@class FaCamera;


@interface FaCameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

// Action method
-(IBAction) takePhotoButtonPressed:(id)sender forEvent:(UIEvent*)event;
-(IBAction) closePhotoButtonPressed:(id)sender forEvent:(UIEvent*)event;

@property (strong, nonatomic) FaCamera* plugin;
@property (strong, nonatomic) UIImagePickerController* picker;


@end
