//
//  FaceppFaceset.m
//  FaceppSDK+Demo
//
//  Created by youmu on 13-4-12.
//  Copyright (c) 2013年 Megvii. All rights reserved.
//

#import "FaceppFaceset.h"
#import "FaceppClient.h"

@implementation FaceppFaceset

-(FaceppResult*) addFaceWithFacesetName:(NSString*)facesetName orFacesetId:(NSString*)facesetId andFaceId:(NSArray*)faceId {
    NSMutableArray *params = [NSMutableArray arrayWithCapacity:10];
    if ((faceId != nil) && ([faceId count]>0)) {
        [params addObject:@"face_id"];
        NSMutableString *faces = [NSMutableString stringWithString:[faceId objectAtIndex:0]];
        for (int i=1; i<[faceId count]; i++)
            [faces appendFormat:@",%@", [faceId objectAtIndex:i]];
        [params addObject:faces];
    }
    if (facesetId != nil) {
        [params addObject:@"faceset_id"];
        [params addObject:facesetId];
    }
    if (facesetName != nil) {
        [params addObject:@"faceset_name"];
        [params addObject:facesetName];
    }
    return [FaceppClient requestWithParameters:@"faceset/add_face" :params];
}

-(FaceppResult*) create {
    return [FaceppClient requestWithParameters:@"faceset/create" :nil];
}

-(FaceppResult*) createWithFacesetName:(NSString*)facesetName andFaceId:(NSArray*)faceId andTag:(NSString*)tag {
    NSMutableArray *params = [NSMutableArray arrayWithCapacity:10];
    if (facesetName != nil) {
        [params addObject:@"faceset_name"];
        [params addObject:facesetName];
    }
    if (tag != nil) {
        [params addObject:@"tag"];
        [params addObject:tag];
    }
    if ((faceId != nil) && ([faceId count]>0)) {
        [params addObject:@"face_id"];
        NSMutableString *faces = [NSMutableString stringWithString:[faceId objectAtIndex:0]];
        for (int i=1; i<[faceId count]; i++)
            [faces appendFormat:@",%@", [faceId objectAtIndex:i]];
        [params addObject:faces];
    }
    return [FaceppClient requestWithParameters:@"faceset/create" :params];
}

-(FaceppResult*) deleteWithFacesetName:(NSString*)facesetName orFacesetId:(NSString*)facesetId {
    NSMutableArray *params = [NSMutableArray arrayWithCapacity:10];
    if (facesetId != nil) {
        [params addObject:@"faceset_id"];
        [params addObject:facesetId];
    }
    if (facesetName != nil) {
        [params addObject:@"faceset_name"];
        [params addObject:facesetName];
    }
    return [FaceppClient requestWithParameters:@"faceset/delete" :params];
}

-(FaceppResult*) getInfoWithFacesetName:(NSString*)facesetName orFacesetId:(NSString*)facesetId {
    NSMutableArray *params = [NSMutableArray arrayWithCapacity:10];
    if (facesetId != nil) {
        [params addObject:@"faceset_id"];
        [params addObject:facesetId];
    }
    if (facesetName != nil) {
        [params addObject:@"faceset_name"];
        [params addObject:facesetName];
    }
    return [FaceppClient requestWithParameters:@"faceset/get_info" :params];
}

-(FaceppResult*) removeAllFaceWithFacesetName:(NSString *)facesetName orFacesetId:(NSString *)facesetId {
    return [self removeFaceWithFacesetName:facesetName orFacesetId:facesetId andFaceId:[NSArray arrayWithObject:@"all"]];
}

-(FaceppResult*) removeFaceWithFacesetName:(NSString*)facesetName orFacesetId:(NSString*)facesetId andFaceId:(NSArray*)faceId {
    NSMutableArray *params = [NSMutableArray arrayWithCapacity:10];
    if (facesetName != nil) {
        [params addObject:@"faceset_name"];
        [params addObject:facesetName];
    }
    if (facesetId != nil) {
        [params addObject:@"faceset_id"];
        [params addObject:facesetId];
    }
    if ((faceId != nil) && ([faceId count]>0)) {
        [params addObject:@"face_id"];
        NSMutableString *faces = [NSMutableString stringWithString:[faceId objectAtIndex:0]];
        for (int i=1; i<[faceId count]; i++)
            [faces appendFormat:@",%@", [faceId objectAtIndex:i]];
        [params addObject:faces];
    }
    return [FaceppClient requestWithParameters:@"faceset/remove_face" :params];
    
}

-(FaceppResult*) setInfoWithFacesetName:(NSString*)facesetName orFacesetId:(NSString*)facesetId andName:(NSString*)name andTag:(NSString*)tag {
    NSMutableArray *params = [NSMutableArray arrayWithCapacity:10];
    if (facesetId != nil) {
        [params addObject:@"faceset_id"];
        [params addObject:facesetId];
    }
    if (facesetName != nil) {
        [params addObject:@"faceset_name"];
        [params addObject:facesetName];
    }
    if (name != nil) {
        [params addObject:@"name"];
        [params addObject:name];
    }
    if (tag != nil) {
        [params addObject:@"tag"];
        [params addObject:tag];
    }
    return [FaceppClient requestWithParameters:@"faceset/set_info" :params];
}

@end
