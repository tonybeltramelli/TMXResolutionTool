//
//  TBImageHandler.m
//  TMXResolutionTool
//
//  Created by Tony BELTRAMELLI on 09/01/13.
//  Copyright (c) 2013 Tony BELTRAMELLI. All rights reserved.
//

#import "TBImageHandler.h"
#import "TBNameUtil.h"

@implementation TBImageHandler
{
    int type;
    NSString *typeString;
}

-(id) initWithFileManager:(NSFileManager *)fileManager
{
    self = [super init];
    if (self) {
        _fileManager = fileManager;
    }
    return self;
}

-(void) processImage:(NSString *)path fromRatio:(float)ratio
{
    NSImage *image = [self getImageFromPath:path];
    int width = image.size.width * ratio;
    int height = image.size.height * ratio;
    
    [self resizeAndSaveImage:image at:path withSize:NSMakeSize(width, height) withName:[TBNameUtil getFilePathFrom:path andRatio:ratio]];
}

-(void) processImage:(NSString *)path fromWidth:(int)width andHeight:(int)height
{
    NSImage *image = [self getImageFromPath:path];
    
    [self resizeAndSaveImage:image at:path withSize:NSMakeSize(width, height) withName:[TBNameUtil getFilePathFrom:path andWidth:width andHeight:height]];
}

-(void) resizeAndSaveImage:(NSImage *)image at:(NSString *)path withSize:(NSSize)size withName:(NSString *)newName
{
    NSImageView *view = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, size.width, size.height)];
    [view setImageScaling:NSImageScaleAxesIndependently];
    [view setImage:image];
    
    NSRect rect = view.frame;
    NSBitmapImageRep *imageRep = [view bitmapImageRepForCachingDisplayInRect:rect];
    [view cacheDisplayInRect:rect toBitmapImageRep:imageRep];
    
    NSData *data = [imageRep representationUsingType:type properties:nil];
    NSString *targetName = [NSString stringWithFormat:@"%@.%@",newName,typeString];
    printf("Success: new image at %s\n", [targetName UTF8String]);
    [data writeToFile: targetName atomically: NO];
}

-(NSImage *) getImageFromPath:(NSString *)path
{
    if([_fileManager fileExistsAtPath:path] == NO)
    {
        printf("Error: file not found '%s'\n", [path UTF8String]);
        return nil;
    }
    
    typeString = [path pathExtension];
    CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (CFStringRef) typeString, NULL);
    
    if (!UTTypeConformsTo(fileUTI, kUTTypeImage))
    {
        NSLog(@"Error: The file is not an image\n");
        return nil;
    }
    
    if([typeString isEqualToString:@"jpg"] == YES ||
       [typeString isEqualToString:@"jpeg"] == YES)
    {
        type = NSJPEGFileType;
    }else if([typeString isEqualToString:@"png"] == YES)
    {
        type = NSPNGFileType;
    }else if([typeString isEqualToString:@"tif"] == YES ||
             [typeString isEqualToString:@"tiff"] == YES)
    {
        type = NSTIFFFileType;
    }else if([typeString isEqualToString:@"bmp"] == YES)
    {
        type = NSBMPFileType;
    }else if([typeString isEqualToString:@"gif"] == YES)
    {
        type = NSGIFFileType;
    }else if([typeString isEqualToString:@"jp2"] == YES ||
             [typeString isEqualToString:@"j2k"] == YES ||
             [typeString isEqualToString:@"jpf"] == YES ||
             [typeString isEqualToString:@"jpx"] == YES ||
             [typeString isEqualToString:@"jpm"] == YES ||
             [typeString isEqualToString:@"mj2"] == YES)
    {
        type = NSJPEG2000FileType;
    }
    
    NSData *contents = [_fileManager contentsAtPath:path];
    if (!contents)
    {
        printf("Error: file error\n");
        return nil;
    }
    
    NSImage *image = [[NSImage alloc] initWithData:contents];
    return image;
}

- (void)dealloc
{
    [_fileManager release];
    
    [super dealloc];
}

@end
