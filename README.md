#TMXResolutionTool
======================

TMX Resolution Tool is a command line tool to let game developers quickly convert their .tmx tile map files into different resolutions.
Usefull for iOS developers and the Apple Retina screen specifications, the script support the Retina resolution notation.

##Requirements

Developed, debugged, tested and realized on and for Mac OS Lion - Version 10.7.5, I didn't test yet on different Mac OS versions.  

Image type supported :  
".jpg, .jpeg, .png, .tif, .tiff, .bmp, .gif, .jp2, .j2k, .jpf, .jpx, .jpm, .mj2"

##Usage

```bash
	TMXResolution <tmx path> <resize ratio>
	TMXResolution <image path> <resize ratio>
	TMXResolution <image path> <new width> <new height>
```

##Example

Resolution 1x to 2x

```bash
	> bin/TMXResolutionTool sample/tile_map.tmx 2
	
	Success: new image at sample/sprite_sheet@2x.png
	Success: new image at sample/special@2x.png
	Success: new tmx at sample/tile_map@2x.tmx
```

Resolution 2x to 1x

```bash
	> bin/TMXResolutionTool sample/tile_map@2x.tmx 0.5
	
	Success: new image at sample/sprite_sheet.png
	Success: new image at sample/special.png
	Success: new tmx at sample/tile_map.tmx
```

Simple image resize with ratio

```bash
	> bin/TMXResolutionTool sample/sprite_sheet.png 4
	
	Success: new image at sample/sprite_sheet@4x.png
```

Simple image resize with specific width and height

```bash
	> bin/TMXResolutionTool sample/sprite_sheet.png 1024 2048
	
	Success: new image at sample/sprite_sheet_1024_2048.png
```

Have fun !
@Tbeltramelli <http://twitter.com/#!/tbeltramelli/>