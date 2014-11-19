//
//  FaCamFaceappLocalDetector.h
//  FaCamera
//
//  Created by Graham Heath on 11/19/14.
//
//

#import "FaceppLocalDetector.h"

@interface FaCamFaceappLocalDetector : FaceppLocalDetector

-(void) initLocal;
-(void) localResultWithImage:(UIImage*)image;
-(void) requestOnlineSDKResults;

@property (strong, nonatomic)  FaceppLocalDetector *detector;

@end
