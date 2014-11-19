//
//  FaCamFaceappLocalDetector.m
//  FaCamera
//
//  Created by Graham Heath on 11/19/14.
//
//

#import "FaCamFaceappLocalDetector.h"

@implementation FaCamFaceappLocalDetector


-(void) initLocal{
  NSDictionary *options = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithBool:NO],
                                                               [NSNumber numberWithInt:20],
                                                               FaceppDetectorAccuracyHigh, nil]
                                                      forKeys:[NSArray arrayWithObjects:FaceppDetectorTracking,
                                                               FaceppDetectorMinFaceSize,
                                                               FaceppDetectorAccuracy, nil]];
  
  self.detector = [FaceppLocalDetector detectorOfOptions:options andAPIKey:@"abf45752049a93d9f00e89123afe1ce3"];
  
}

-(void) localResultWithImage:(UIImage*)image {
  FaceppLocalResult *result = [self.detector detectWithImage:image];
  NSLog(@"Local Result With Image: count = %lu",(unsigned long)result.faces.count);
  for(size_t i=0; i<result.faces.count; i  ++){
    FaceppLocalFace *face = [result.faces objectAtIndex:i];
    NSLog(@"    rect%@, trackingId = %d", NSStringFromCGRect(face.bounds), face.trackingID);
    
  }
}

-(void) requestOnlineSDKResults{

}

@end