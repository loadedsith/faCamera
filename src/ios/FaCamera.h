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
-(void) onFinish:(CDVInvokedUrlCommand*)command;

-(void) storeImage:(CDVInvokedUrlCommand*)command;

//Event that calls the onFinish
-(void) finished;

// Create and override some properties and methods (these will be explained later)
-(void) capturedImageWithPath:(NSString*)imagePath;
@property (strong, nonatomic) FaCameraViewController* overlay;

//JS Callbacks
@property (strong, nonatomic) CDVInvokedUrlCommand* latestCommand;
@property (strong, nonatomic) CDVInvokedUrlCommand* finishCommand;
@property (strong, nonatomic) CDVInvokedUrlCommand* storeCommand;

@property (readwrite, assign) BOOL hasPendingOperation;

@end