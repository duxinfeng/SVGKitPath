//
//  SVGPathElement.h
//  SVGKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVGPathElement : NSObject 

- (void) parseData:(NSString *)data;

@property (nonatomic, readwrite) CGPathRef pathForShapeInRelativeCoords;

@end
