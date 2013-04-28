//
//  TBNameUtil.h
//  TMXResolutionTool
//
//  Created by Tony BELTRAMELLI on 20/01/13.
//  Copyright (c) 2013 Tony BELTRAMELLI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBNameUtil : NSObject

+(NSString *)getFileNameFrom:(NSString *)name andRatio:(float)ratio;
+(NSString *)getFilePathFrom:(NSString *)path andRatio:(float)ratio;
+(NSString *)getFilePathFrom:(NSString *)path andWidth:(int)width andHeight:(int)height;

@end
