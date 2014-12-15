//
//  FaCamera.swift
//  FaCamera
//
//  Created by Graham Heath on 12/15/14.
//
//



import Foundation

@objc(FaCamera) class FaCamera : CDVPlugin {


  var overlay:FaCameraViewControllerSwift?;
  
  //JS Callbacks
  var latestCommand: CDVInvokedUrlCommand?;
  var finishCommand: CDVInvokedUrlCommand?;
  var storeCommand:  CDVInvokedUrlCommand?;
  
  //var hasPendingOperation: Bool;

  
  func openCamera(command: CDVInvokedUrlCommand) {
  
    // Set the hasPendingOperation field to prevent the webview from crashing
//    hasPendingOperation = YES;
    
    // Save the CDVInvokedUrlCommand as a property.  We will need it later.
    latestCommand = command;
    
    // Make the overlay view controller.
    
    //Storyboard Rendering
    var sb:UIStoryboard = UIStoryboard(name:"FaCameraViewController", bundle:nil);
    
    
    self.overlay = sb.instantiateInitialViewController() as FaCameraViewControllerSwift;

    self.overlay!.setupPicker();
    
    //Xib rendering
    //  self.overlay = [[FaCameraViewController alloc] initWithNibName:@"FaCameraViewController" bundle:nil];
    self.overlay!.plugin = self;
    
    // Display the view.  This will "slide up" a modal view from the bottom of the screen.
    self.viewController.presentViewController(self.overlay!.picker, animated: false, completion: nil);
    
  }
  func capturedImageWithPath(imagePath: NSString) {
  
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: imagePath);

  
    pluginResult.setKeepCallbackAsBool(true);
    self.commandDelegate.sendPluginResult(pluginResult, callbackId: self.latestCommand?.callbackId)

  
  
  // Unset the self.hasPendingOperation property
  //self.hasPendingOperation = NO;
  
  // Hide the picker view
  //[self.viewController  dismissModalViewControllerAnimated:YES];
  }
  
  
  func finished(){
    var pluginResult = CDVPluginResult(status:CDVCommandStatus_OK, messageAsString:"finished");
  
    //  [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
  
    self.commandDelegate.sendPluginResult(pluginResult, callbackId: self.finishCommand?.callbackId);
  }
  
  func onFinish(command: CDVInvokedUrlCommand) {
    self.finishCommand = command;
  }
  
  func storeImage(command: CDVInvokedUrlCommand){
  
    let url:NSString = command.argumentAtIndex(0) as NSString;
    
    println("Test - " + url);
    

    
    let urlObj:NSURL = NSURL(string: url)!;
    
    let dataObj:NSData = NSData(contentsOfURL: urlObj, options: nil, error:nil)!;
    
    var image:UIImage = UIImage(data: dataObj)!;
  
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
  }
}
