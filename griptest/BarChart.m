//
//  BarChart.m
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "BarChart.h"

@implementation BarChart
@synthesize currentData;

//define some constants in one section
const int lineCount=10;
const int lineWidth=3;
const int lineSpace=2;

//text rect width (y axis,such as '10','15','20',etc.)
CGSize sublineTextRectSize;

//(sublineLength-xaxisLength)/2
const int sublineExtraSideLength=5;

//subline values
const int sublineValues[3]={10,15,20};
const int sublinesCount=3;

//left & right padding of x-axis
const int xPadding=10;

//space between two finger sections, calculated according to other constraints
int spaceOnX;

//text of x axis
CGSize xTextRectSize;

//text rect on top
CGSize topTextRectSize;

//content size
CGSize contentSize;

Queue *indexHistory;
Queue *middleHistory;
Queue *ringHistory;
Queue *littleHistory;

/*- (BarChart *)init
{
    self = [super init];
    
    if (self) {
        indexHistory=[[Queue alloc] initWithSize:10];
        middleHistory=[[Queue alloc] initWithSize:10];
        ringHistory=[[Queue alloc] initWithSize:10];
        littleHistory=[[Queue alloc] initWithSize:10];
    }
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(redrawAndNotify)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    return self;
}*/

- (BarChart *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        indexHistory=[[Queue alloc] initWithSize:10];
        middleHistory=[[Queue alloc] initWithSize:10];
        ringHistory=[[Queue alloc] initWithSize:10];
        littleHistory=[[Queue alloc] initWithSize:10];
        
        xTextRectSize=CGSizeMake(30.0f, 15.0f);
        topTextRectSize=CGSizeMake(30.0f, 15.0f);
        sublineTextRectSize=CGSizeMake(20.0f, 15.0f);
        
        float contentHeight=self.bounds.size.height-xTextRectSize.height-topTextRectSize.height;
        float contentWidth=self.bounds.size.width-sublineExtraSideLength-sublineTextRectSize.width;
        contentSize=CGSizeMake(contentWidth, contentHeight);
        
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    
    return self;
}

/*-(void)redrawAndNotify{
    //the method will call drawRect
    [self setNeedsDisplay];
}*/

- (void)drawRect:(CGRect)rect {
    // Drawing code
    //self.bounds
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    [self drawBarsWithCtx:ctx];
    [self drawAxisWithCtx:ctx];
    [self drawSublinesWithCtx:ctx];
}

-(void)drawAxisWithCtx:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    
    CGContextSetLineWidth(ctx, 2);
    CGContextSetRGBStrokeColor(ctx, 67.0/255, 135.0/255, 183.0/255, 1);
    CGContextMoveToPoint(ctx, sublineTextRectSize.width+sublineExtraSideLength, xTextRectSize.height);
    CGContextAddLineToPoint(ctx, self.bounds.size.width-sublineExtraSideLength, xTextRectSize.height);
    CGContextStrokePath(ctx);
    
    CGContextRestoreGState(ctx);
}

-(void)drawSublinesWithCtx:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    
    CGContextTranslateCTM(ctx, 0, xTextRectSize.height);
    
    CGContextSetLineWidth(ctx, 2);
    CGContextSetRGBStrokeColor(ctx, 150.0/255, 150.0/255, 150.0/255, 1);
    CGFloat lengths[2]={3.0f,3.0f};
    CGContextSetLineDash(ctx, 0,lengths, 2);
    
    float heightUnit=contentSize.height/(sublinesCount+1);
    for (int i=0; i<sublinesCount; i++) {
        CGContextMoveToPoint(ctx, sublineTextRectSize.width, heightUnit*(i+1));
        CGContextAddLineToPoint(ctx, self.bounds.size.width, heightUnit*(i+1));
    }
    
    CGContextStrokePath(ctx);
    
    //TODO: draw subline text
    
    CGContextRestoreGState(ctx);
}

-(void)drawBarsWithCtx:(CGContextRef)ctx{
    [self drawIndexBars];
    [self drawMiddleBars];
    [self drawRingBars];
    [self drawLittleBars];
}

-(void)drawIndexBars{
    
}

-(void)drawMiddleBars{
    
}

-(void)drawRingBars{
    
}

-(void)drawLittleBars{
    
}

-(void)onDataReceived:(DataUnit *)data{
    [indexHistory enqueue:data.index];
    [middleHistory enqueue:data.middle];
    [ringHistory enqueue:data.ring];
    [littleHistory enqueue:data.little];
}

@end
