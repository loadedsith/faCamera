//
//  FaCamera.m
//  FaCamera
//
//  Created by Graham Heath on 11/15/14.
//
//

#import "FaCamera.h"

@implementation FaCamera

@dynamic hasPendingOperation;

// Cordova command method
-(void) openCamera:(CDVInvokedUrlCommand *)command {
  
  // Set the hasPendingOperation field to prevent the webview from crashing
  self.hasPendingOperation = YES;
  
  // Save the CDVInvokedUrlCommand as a property.  We will need it later.
  self.latestCommand = command;
  
  // Make the overlay view controller.
  
  //Storyboard Rendering
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"FaCameraViewController" bundle:nil];

  
  self.overlay = [sb instantiateInitialViewController];
  [self.overlay setupPicker];
  
  //Xib rendering
  //  self.overlay = [[FaCameraViewController alloc] initWithNibName:@"FaCameraViewController" bundle:nil];
  self.overlay.plugin = self;
  
  // Display the view.  This will "slide up" a modal view from the bottom of the screen.
  [self.viewController  presentViewController:self.overlay.picker animated:YES completion:nil];
}

// Method called by the overlay when the image is ready to be sent back to the web view
-(void) capturedImageWithPath:(NSString*)imagePath {
  
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:imagePath];
  
  [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
  
  [self.commandDelegate sendPluginResult:pluginResult callbackId:self.latestCommand.callbackId ];
  
  
  // Unset the self.hasPendingOperation property
  //self.hasPendingOperation = NO;
  
  // Hide the picker view
  //[self.viewController  dismissModalViewControllerAnimated:YES];
}

-(void) finished{
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"finished"];
  
  //  [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
  
  [self.commandDelegate sendPluginResult:pluginResult callbackId:self.finishCommand.callbackId ];
}

-(void) onFinish:(CDVInvokedUrlCommand *)command  {
  self.finishCommand = command;
}
-(void) storeImage:(CDVInvokedUrlCommand*)command{

  NSString *url = [command arguments][0];
  NSLog(@"Test - %@",url);
  UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];

  UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

@end
