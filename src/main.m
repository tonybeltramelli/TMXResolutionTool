//
//  main.m
//  TMXResolutionTool
//
//  Created by Tony BELTRAMELLI on 09/01/13.
//  Copyright (c) 2013 Tony BELTRAMELLI. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBXMLParser.h"
#import "TBImageHandler.h"
#import "TBNameUtil.h"

const int MIN_ARGS_NUM = 3;

void processImage(int argc, const char * argv[], TBImageHandler *imageHandler, NSString *imagePath)
{
    if (argc == MIN_ARGS_NUM)
    {
        [imageHandler processImage:imagePath fromRatio:atof(argv[2])];
    }else{
        [imageHandler processImage:imagePath fromWidth:atof(argv[2]) andHeight:atof(argv[3])];
    }
}

int main(int argc, const char * argv[])
{    
    @autoreleasepool {
        
        if (argc < MIN_ARGS_NUM)
        {
            printf("Usage: \n");
            printf("    TMXResolution <tmx path> <resize ratio>\n");
            printf("    TMXResolution <image path> <resize ratio>\n");
            printf("    TMXResolution <image path> <new width> <new height>\n");
            exit(1);
        }
        
        NSString *path = [NSString stringWithUTF8String:argv[1]];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if([fileManager fileExistsAtPath:path] == NO)
        {
            printf("Error: file not found '%s'\n", [path UTF8String]);
            exit(1);
        }
        
        CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (CFStringRef) [path pathExtension], NULL);
        
        TBImageHandler *imageHandler = [[TBImageHandler alloc] initWithFileManager:fileManager];
        
        if (UTTypeConformsTo(fileUTI, kUTTypeImage))
        {
            processImage(argc, argv, imageHandler, path);
            [imageHandler release];
            imageHandler = nil;
            exit(1);
        }
        
        if (argc == MIN_ARGS_NUM+1)
        {
            printf("Error: <tmx path> with <resize ratio>\n");
            exit(1);
        }
        
        NSString *folderPath = [path stringByDeletingLastPathComponent];
        NSString *fileName = [TBNameUtil getFilePathFrom:path andRatio: atof(argv[2])];
        NSString *typeString = [path pathExtension];
        NSString *targetPath = [NSString stringWithFormat:@"%@.%@", fileName, typeString];
        
        NSData *contents = [fileManager contentsAtPath:path];
        
        TBXMLParser *parser = [[TBXMLParser alloc] init];
        NSMutableArray *images = [parser getImageNamesFromData:contents];
        
        int i = 0;
        int length = (int) [images count];
        
        for (i = 0; i < length; i++)
        {
            NSString *imagePath = [NSString stringWithFormat:@"%@/%@", folderPath, [images objectAtIndex:i]];
            processImage(argc, argv, imageHandler, imagePath);
        }
        
        NSData *data = [parser setDataWithRatio:atof(argv[2])];
        [data writeToFile:targetPath atomically: NO];
        printf("Success: new tmx at %s\n", [targetPath UTF8String]);
        
        [imageHandler release];
        imageHandler = nil;
        
        [fileManager release];
        fileManager = nil;
        
        [parser release];
        parser = nil;
    }
    return 0;
}