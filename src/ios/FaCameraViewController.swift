//
//  FaCameraViewController.swift
//  FaCamera
//
//  Created by Graham Heath on 11/20/14.
//
//

import Foundation

class FaCameraViewControllerSwift:UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{// <>

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder);
    
  }
  
  var plugin = FaCamera();
  
  var picker:UIImagePickerController = UIImagePickerController();
  
  var whiteScreen:UIView = UIView();

  
  
  @IBAction func toggleFlash(sender: UIButton, event: UIEvent){
    if (picker.cameraFlashMode ==  UIImagePickerControllerCameraFlashMode.Auto){
      
      //set flash indicator to on
      sender.setTitle("⚡️", forState: UIControlState.Normal);
      picker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.On;
      
    }else if (picker.cameraFlashMode == UIImagePickerControllerCameraFlashMode.On){
    
      //set flash indicator to off
      sender.setTitle("", forState: UIControlState.Normal);
      picker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Off;

    }else if (picker.cameraFlashMode == UIImagePickerControllerCameraFlashMode.Off) {
      
      //set flash indicator to auto
      sender.setTitle("", forState: UIControlState.Normal);
      picker.cameraFlashMode=UIImagePickerControllerCameraFlashMode.Auto;
      
    }
  }
  
  @IBAction func toggleCameraForward(sender:UIButton, event:UIEvent){
  
    if (picker.cameraDevice == UIImagePickerControllerCameraDevice.Rear) {
      picker.cameraDevice = UIImagePickerControllerCameraDevice.Front;
    } else {
      picker.cameraDevice = UIImagePickerControllerCameraDevice.Rear;
    }
  
  }
  
  func setupPicker(){
    
    picker =  UIImagePickerController();
    
    whiteScreen = UIView(frame: self.view.frame);// .initWithFrame(self.view.frame)
    whiteScreen.layer.opacity = 0.0;
    whiteScreen.layer.backgroundColor = UIColor.whiteColor().CGColor;
    
    self.view.addSubview(whiteScreen);
    
    // Instantiate the UIImagePickerController instance
    picker =  UIImagePickerController();
    
    // Configure the UIImagePickerController instance
    picker.sourceType = UIImagePickerControllerSourceType.Camera;
    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo;
    
    picker.cameraDevice = UIImagePickerControllerCameraDevice.Rear;
    picker.showsCameraControls = false;
  
    // Make us the delegate for the UIImagePickerController
    picker.delegate = self;
    
    // Set the frames to be full screen
    //CGRect screenFrame = [[UIScreen mainScreen] bounds];
    //self.view.frame = screenFrame;
    //self.picker.view.frame = screenFrame;
    
    let screenFrame = UIScreen.mainScreen().bounds;
      
    let screenSize = screenFrame.size;   // 320 x 568
    
    // screen height divided by the pickerController height ... or:  568 / ( 320*4/3 )
    let scale = screenSize.height / screenSize.width*3/4;
    
    let translate=CGAffineTransformMakeTranslation(0,(screenSize.height - screenSize.width * 4/3) * 0.5);
      
    let fullScreen=CGAffineTransformMakeScale(scale, scale);

    picker.cameraViewTransform = CGAffineTransformConcat(fullScreen, translate);

  
    
    self.view.opaque = false;
    self.view.backgroundColor = UIColor.clearColor();
    
    // Set this VC's view as the overlay view for the UIImagePickerController
    picker.cameraOverlayView = self.view;

//    newPicker.cameraOverlayView.bounds = self.view.window!.bounds;
    picker.cameraOverlayView?.bounds = UIScreen.mainScreen().bounds;
    
    self.view.frame = screenFrame;
    picker.view.frame = screenFrame;

  }
  
  @IBAction func closePhotoButtonPressed(sender:UIButton, event:UIEvent) {
  
    plugin.finished();
    picker.dismissViewControllerAnimated(false, completion:nil);
  
  }
  
  func flashScreen(){
    let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity");
    let animationValues = [ 0.8, 0.0 ];
    let animationTimes = [ 0.3, 1.0 ];
    
    let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear);
    
    let animationTimingFunctions = [ timingFunction, timingFunction ];
    
    opacityAnimation.values = animationValues;
    opacityAnimation.keyTimes = animationTimes;
    opacityAnimation.timingFunctions = animationTimingFunctions;
    
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = true;
    opacityAnimation.duration = 0.4;
    
    self.whiteScreen.layer.addAnimation(opacityAnimation,forKey:"animation");
  }
  
  // Action method.  This is like an event callback in JavaScript.
  @IBAction func takePhotoButtonPressed(sender:UIButton, event:UIEvent) {
  // Call the takePicture method on the UIImagePickerController to capture the image.
  // Tell the plugin class that we're finished processing the image
    picker.takePicture();
    //self.flashScreen();
  }
  
//   func viewDidLoad() {
//    super.viewDidLoad();
//    // Do any additional setup after loading the view from its nib.
//    newPicker =  UIImagePickerController();
//    newPicker.delegate = self;
//  
//  }
//  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning();
  // Dispose of any resources that can be recreated.
  }
  
  // Delegate method.  UIImagePickerController will call this method as soon as the image captured above is ready to be processed.  This is also like an event callback in JavaScript.
  func imagePickerController(picker:UIImagePickerController, didFinishPickingMediaWithInfo info:NSDictionary) {
  
    let maxWidth:CGFloat = 800;
    
    // Get a reference to the captured image
    let image:UIImage = (info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage);
    let imageSize = image.size;
    //var newSize:CGSize = CGSize.zeroSize;
    let ratio = maxWidth / imageSize.width;
    
    let newHeight = round(ratio * imageSize.height);
    
    //  if (imageSize.height>imageSize.width) {
    let newSize = CGSizeMake(maxWidth, newHeight);
    //  }else{
    //  newSize = CGSizeMake(800, 600);
    //  }
    
    
    
    UIGraphicsBeginImageContext( newSize );
    image.drawInRect(CGRectMake(0,0,newSize.width,newSize.height));
    let smImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    // Get a file path to save the JPEG
    let documentsDirectory:String = NSHomeDirectory() + "/Documents/";
  
    
    let prefixString = "MyFilename";
    

    
    let guid = NSProcessInfo.processInfo().globallyUniqueString;

    let uniqueFileName = prefixString + "_" + guid;

    let filename = uniqueFileName;

    let smFilename = uniqueFileName + "smfpp42";//really just need to append sm to indicate that its small, but it seems the odds of a UUID ending in "sm" are too great, so we padded. It means *sm*all *f*ace *p*lus *p*lus [the answer to life, the universe, and everything]

    let imagePath = documentsDirectory.stringByAppendingPathComponent(filename);
    let smImagePath = documentsDirectory.stringByAppendingPathComponent(smFilename);

    // Get the image data (blocking; around 1 second)
    let imageData = UIImageJPEGRepresentation(image, 0.7);
    
    // Get the image data (blocking)
    let smImageData = UIImageJPEGRepresentation(smImage, 1);
    
    // Write the data to the file
    imageData.writeToFile(  imagePath, atomically:true);
    smImageData.writeToFile(smImagePath, atomically:true);
    
    // Tell the plugin class that we're finished processing the image
    self.plugin.capturedImageWithPath(smImagePath);



  }
  
}