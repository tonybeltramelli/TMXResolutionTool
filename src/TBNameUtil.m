//
//  TBNameUtil.m
//  TMXResolutionTool
//
//  Created by Tony BELTRAMELLI on 20/01/13.
//  Copyright (c) 2013 Tony BELTRAMELLI. All rights reserved.
//

#import "TBNameUtil.h"

@implementation TBNameUtil

+(NSString *)getFileNameFrom:(NSString *)name andRatio:(float)ratio
{
    NSString *fileName = [[self getFilePathFrom:name andRatio:ratio] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    return fileName;
}

+(NSString *)getFilePathFrom:(NSString *)path andRatio:(float)ratio
{
    NSString *filePath = [path stringByDeletingPathExtension];
    NSString *folderPath = [NSString stringWithFormat:@"%@/", [path stringByDeletingLastPathComponent]];
    NSString *fileName = [filePath stringByReplacingOccurrencesOfString:folderPath withString:@""];
    NSString *nameSuffix = @"";
    
    NSArray *split = [fileName componentsSeparatedByString: @"@"];
    if([split count] == 2)
    {
        float currentRatio = [(NSString *)split[1] floatValue];
        ratio = currentRatio*ratio;
        
        filePath = [NSString stringWithFormat:@"%@%@", folderPath, (NSString *)split[0]];
    }
    
    if(ratio != 1) nameSuffix = [NSString stringWithFormat:@"@%gx", ratio];
    
    NSString *targetName = [NSString stringWithFormat:@"%@%@",filePath,nameSuffix];
    return targetName;
}

+(NSString *)getFilePathFrom:(NSString *)path andWidth:(int)width andHeight:(int)height
{
    NSString *filePath = [path stringByDeletingPathExtension];
    NSString *nameSuffix = [NSString stringWithFormat:@"_%d_%d", width, height];
    
    NSString *targetName = [NSString stringWithFormat:@"%@%@",filePath,nameSuffix];
    return targetName;
}

@end
