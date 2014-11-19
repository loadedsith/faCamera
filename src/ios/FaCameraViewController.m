//
//  FaCameraViewController.m
//  FaCamera
//
//  Created by Graham Heath on 11/15/14.
//
//
#import "FaCamera.h"
#import "FaCameraViewController.h"


@implementation FaCameraViewController

@synthesize whiteScreen;
-(IBAction)toggleFlash:(id)sender forEvent:(UIEvent*)event{
  if (self.picker.cameraFlashMode==UIImagePickerControllerCameraFlashModeAuto){
    //set flash indicator to on
    [(UIButton*)sender setTitle:@"⚡️" forState:UIControlStateNormal];

    self.picker.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
  }else if (self.picker.cameraFlashMode==UIImagePickerControllerCameraFlashModeOn){
    //set flash indicator to off
    
    [(UIButton*)sender setTitle:@"🚫" forState:UIControlStateNormal];
    self.picker.cameraFlashMode=UIImagePickerControllerCameraFlashModeOff;
  }else if (self.picker.cameraFlashMode==UIImagePickerControllerCameraFlashModeOff){
    //set flash indicator to auto
    [(UIButton*)sender setTitle:@"⚡︎" forState:UIControlStateNormal];
    self.picker.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
  }
}
-(IBAction)toggleCameraForward:(id)sender forEvent:(UIEvent*)event{
  if(self.picker.cameraDevice==UIImagePickerControllerCameraDeviceRear){
    self.picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
    [(UIButton*)sender setTitle:@"😃" forState:UIControlStateNormal];
  }else{
    self.picker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
    [(UIButton*)sender setTitle:@"🌆" forState:UIControlStateNormal];
  }
}
- (id)setupPicker{
  if (self) {
    self.whiteScreen = [[UIView alloc] initWithFrame:self.view.frame];
    self.whiteScreen.layer.opacity = 0.0f;
    self.whiteScreen.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    [self.view addSubview:self.whiteScreen];
    
    // Instantiate the UIImagePickerController instance
    self.picker = [[UIImagePickerController alloc] init];
    
    // Configure the UIImagePickerController instance
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;

    self.picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    self.picker.showsCameraControls = NO;

    // Make us the delegate for the UIImagePickerController
    self.picker.delegate = self;
    
    // Set the frames to be full screen
    //CGRect screenFrame = [[UIScreen mainScreen] bounds];
    //self.view.frame = screenFrame;
    //self.picker.view.frame = screenFrame;
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenFrame.size;   // 320 x 568

    // screen height divided by the pickerController height ... or:  568 / ( 320*4/3 )
    float scale = screenSize.height / screenSize.width*3/4;
    
    CGAffineTransform translate=CGAffineTransformMakeTranslation(0,(screenSize.height - screenSize.width*4/3)*0.5);
    CGAffineTransform fullScreen=CGAffineTransformMakeScale(scale, scale);
    self.picker.cameraViewTransform =CGAffineTransformConcat(fullScreen, translate);
    
    
    
    
    
    
    
    self.view.opaque = NO;
    self.view.backgroundColor = [UIColor clearColor];
    
    // Set this VC's view as the overlay view for the UIImagePickerController
    self.picker.cameraOverlayView = self.view;
  
    self.picker.cameraOverlayView.bounds = self.view.window.bounds;
    self.view.frame = screenFrame;
    self.picker.view.frame = screenFrame;
    
  }
  return self;
}

// Action method.  This is like an event callback in JavaScript.
-(IBAction) closePhotoButtonPressed:(id)sender forEvent:(UIEvent*)event {

  [self.plugin finished];

  [self.picker  dismissViewControllerAnimated:YES completion:nil];

}

-(void)flashScreen {
  CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
  NSArray *animationValues = @[ @0.8f, @0.0f ];
  NSArray *animationTimes = @[ @0.3f, @1.0f ];
  id timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  NSArray *animationTimingFunctions = @[ timingFunction, timingFunction ];
  [opacityAnimation setValues:animationValues];
  [opacityAnimation setKeyTimes:animationTimes];
  [opacityAnimation setTimingFunctions:animationTimingFunctions];
  opacityAnimation.fillMode = kCAFillModeForwards;
  opacityAnimation.removedOnCompletion = YES;
  opacityAnimation.duration = 0.4;
  
  [self.whiteScreen.layer addAnimation:opacityAnimation forKey:@"animation"];
}

// Action method.  This is like an event callback in JavaScript.
-(IBAction) takePhotoButtonPressed:(id)sender forEvent:(UIEvent*)event {
  // Call the takePicture method on the UIImagePickerController to capture the image.
  // Tell the plugin class that we're finished processing the image
  [self.picker takePicture];
  [self flashScreen];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

// Delegate method.  UIImagePickerController will call this method as soon as the image captured above is ready to be processed.  This is also like an event callback in JavaScript.
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
  double maxWidth = 800;
  
  // Get a reference to the captured image
  UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
  CGSize imageSize = [image size];
  CGSize newSize;
  double ratio = maxWidth / imageSize.width;
  
  int newHeight = round(ratio * imageSize.height);
  
//  if (imageSize.height>imageSize.width) {
    newSize = CGSizeMake(maxWidth, newHeight);
//  }else{
  //  newSize = CGSizeMake(800, 600);
//  }
  
  UIGraphicsBeginImageContext( newSize );
  [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
  UIImage* smImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  // Get a file path to save the JPEG
  NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString* documentsDirectory = [paths objectAtIndex:0];
  
  NSString *prefixString = @"MyFilename";

  NSString *guid = [[NSProcessInfo processInfo] globallyUniqueString] ;
  NSString *uniqueFileName = [NSString stringWithFormat:@"%@_%@", prefixString, guid];

  //NSLog(@"uniqueFileName: '%@'", uniqueFileName);

  NSString* filename = uniqueFileName;
  NSString* smFilename = [NSString stringWithFormat:@"%@smfpp42", uniqueFileName];
  //NSString* filename = @"test.jpg";
  
  NSString* imagePath = [documentsDirectory stringByAppendingPathComponent:filename];
  NSString* smImagePath = [documentsDirectory stringByAppendingPathComponent:smFilename];
  
  // Get the image data (blocking; around 1 second)
  NSData* imageData = UIImageJPEGRepresentation(image, 0.7);
  
  // Get the image data (blocking)
  NSData* smImageData = UIImageJPEGRepresentation(smImage, 0.0);
  
  // Write the data to the file
  [imageData writeToFile:imagePath atomically:YES];
  [smImageData writeToFile:smImagePath atomically:YES];

  // Tell the plugin class that we're finished processing the image
  [self.plugin capturedImageWithPath:smImagePath];
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
