//
//  FaCamera.h
//  FaCamera
//
//  Created by Graham Heath on 11/15/14.
//
//

#import <Cordova/CDV.h>
// Import the CustomCameraViewController class
#import "FaCameraViewController.h"

@interface FaCamera : CDVPlugin{
  CDVPluginResult* pluginResult;
}

// Cordova command method
-(void) openCamera:(CDVInvokedUrlCommand*)command;

// Create and override some properties and methods (these will be explained later)
-(void) capturedImageWithPath:(NSString*)imagePath;
@property (strong, nonatomic) FaCameraViewController* overlay;
@property (strong, nonatomic) CDVInvokedUrlCommand* latestCommand;
@property (readwrite, assign) BOOL hasPendingOperation;

@end