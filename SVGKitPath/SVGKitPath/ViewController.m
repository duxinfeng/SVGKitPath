//
//  ViewController.m
//  SVGKitPath
//
//  Created by Xinfeng Du on 2019/3/20.
//  Copyright © 2019 XXB. All rights reserved.
//

#import "ViewController.h"
#import "SVGPathElement.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat scale = self.view.bounds.size.width / 1080; // 1080 是svg画布宽高
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"svg" ofType:@"json"]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString *wordPath = [json objectForKey:@"path"];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width);
    view.center = self.view.center;
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
//    view.transform = CGAffineTransformMakeScale(scale, scale);
    
    NSMutableArray *array = [self jsonStringToObject:wordPath];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];

    for (NSString *string in array) {
        NSLog(@"路径--> %@",string);

        SVGPathElement *pathElement = [[SVGPathElement alloc] init];
        [pathElement parseData:string];
      
        UIBezierPath *bPath = [UIBezierPath bezierPathWithCGPath:pathElement.pathForShapeInRelativeCoords];
        [bPath applyTransform:CGAffineTransformMakeScale(scale, scale)];
        
        [bezierPath appendPath:bPath];
    }
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.fillColor = [UIColor blackColor].CGColor;
    [view.layer addSublayer:shapeLayer];
    
}

- (id)jsonStringToObject:(NSString *)string
{
    NSError *error;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (object != nil && error == nil){
        return object;
    }else{
        return nil;
    }
}

@end
