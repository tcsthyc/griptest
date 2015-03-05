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
const int singleBarWidth=3;
const int spaceBetweenBars=2;

//text rect width (y axis,such as '10','15','20',etc.)
CGSize sublineTextRectSize;
UIColor *sublineTextColor;

//(sublineLength-xaxisLength)/2
const int sublineExtraSideLength=5;

//subline values
const int sublineValues[3]={10,15,20};
const int sublinesCount=3;
const int maxValueY=25;

//left & right padding of x-axis
const int xPadding=20;

//space between two finger sections, calculated according to other constraints
float spaceOnX;

//text of x axis
CGSize xTextRectSize;
UIColor *xTextColor;

//text rect on top
CGSize topTextRectSize;
UIColor *topTextColor;

//content size
CGSize contentSize;

//text alignment
NSMutableParagraphStyle *textParagraphStyle;

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
        
        sublineTextColor=[UIColor colorWithRed:150.0f/255 green:150.0f/255 blue:150.0f/255 alpha:1];
        xTextColor=sublineTextColor;
        topTextColor=[UIColor colorWithRed:227.0f/255 green:83.0f/255 blue:56.0f/255 alpha:1];
        
        float contentHeight=self.bounds.size.height-xTextRectSize.height-topTextRectSize.height;
        float contentWidth=self.bounds.size.width-sublineExtraSideLength-sublineTextRectSize.width;
        contentSize=CGSizeMake(contentWidth, contentHeight);
        spaceOnX=(contentWidth-2*xPadding-4*(10*singleBarWidth+9*spaceBetweenBars))/3.0f;
        
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    
    return self;
}

- (BarChart *)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        indexHistory=[[Queue alloc] initWithSize:10];
        middleHistory=[[Queue alloc] initWithSize:10];
        ringHistory=[[Queue alloc] initWithSize:10];
        littleHistory=[[Queue alloc] initWithSize:10];
        
        xTextRectSize=CGSizeMake(30.0f, 15.0f);
        topTextRectSize=CGSizeMake(30.0f, 15.0f);
        sublineTextRectSize=CGSizeMake(20.0f, 15.0f);
        
        sublineTextColor=[UIColor colorWithRed:150.0f/255 green:150.0f/255 blue:150.0f/255 alpha:1];
        xTextColor=sublineTextColor;
        topTextColor=[UIColor colorWithRed:227.0f/255 green:83.0f/255 blue:56.0f/255 alpha:1];
        textParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        textParagraphStyle.alignment = NSTextAlignmentCenter;
        
        float contentHeight=self.bounds.size.height-xTextRectSize.height-topTextRectSize.height;
        float contentWidth=self.bounds.size.width-sublineExtraSideLength-sublineTextRectSize.width;
        contentSize=CGSizeMake(contentWidth, contentHeight);
        spaceOnX=(contentWidth-2*xPadding-4*(10*singleBarWidth+9*spaceBetweenBars))/3.0f;
        
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
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    [self drawBarsWithCtx:ctx];
    [self drawAxisWithCtx:ctx];
    [self drawSublinesWithCtx:ctx];
    CGContextRestoreGState(ctx);
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
    
    float heightUnit=contentSize.height/maxValueY;
    for (int i=0; i<sublinesCount; i++) {
        //draw sublines
        CGContextMoveToPoint(ctx, sublineTextRectSize.width, heightUnit*sublineValues[i]);
        CGContextAddLineToPoint(ctx, self.bounds.size.width, heightUnit*sublineValues[i]);
        
        //draw subline text
        CGContextSaveGState(ctx);
        CGContextScaleCTM(ctx, 1, -1);
        CGRect textRect=CGRectMake(0, -heightUnit*sublineValues[i]-sublineTextRectSize.height/2, sublineTextRectSize.width, sublineTextRectSize.height);
        NSString *str = [NSString stringWithFormat:@"%d",sublineValues[i]];
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = sublineTextColor;
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        [str drawInRect:textRect withAttributes:attrs];
        CGContextRestoreGState(ctx);
    }
    CGContextStrokePath(ctx);
    CGContextRestoreGState(ctx);
}

-(void)drawBarsWithCtx:(CGContextRef)ctx{
    [self drawIndexBarsWithCtx:ctx];
    [self drawMiddleBarsWithCtx:ctx];
    [self drawRingBarsWithCtx:ctx];
    [self drawLittleBarsWithCtx:ctx];
}

-(void)drawIndexBarsWithCtx:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, sublineTextRectSize.width+sublineExtraSideLength, xTextRectSize.height);
    CGContextSetRGBFillColor(ctx, 67/255.0f, 135/255.0f, 183/255.0f, 1);
    
    //draw bars
    int count=0;
    float curr;
    for(int i=1;i<=indexHistory.size;i++){
        curr=[[indexHistory.values objectAtIndex:(indexHistory.rear+i)%indexHistory.size] floatValue];
        CGContextFillRect(ctx, CGRectMake(xPadding+count*(singleBarWidth+spaceBetweenBars), 0, singleBarWidth, contentSize.height/maxValueY*curr));
        count++;
    }
    
    //draw text on bottom
    CGContextSaveGState(ctx);
    CGContextScaleCTM(ctx, 1, -1);
    float textRectCenterX=xPadding+(10*singleBarWidth+9*spaceBetweenBars)/2.0f;
    CGRect textRect=CGRectMake(textRectCenterX-xTextRectSize.width/2.0f, 0, xTextRectSize.width, xTextRectSize.height);
    NSString *str = @"食指";
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = xTextColor;
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSParagraphStyleAttributeName] = textParagraphStyle;
    [str drawInRect:textRect withAttributes:attrs];
    //draw text on top
    textRect=CGRectMake(textRectCenterX-topTextRectSize.width/2.0f, -contentSize.height-topTextRectSize.height, topTextRectSize.width, topTextRectSize.height);
    int latestIndex=indexHistory.rear==0?indexHistory.size-1:indexHistory.rear-1;
    str = [NSString stringWithFormat:@"%f",[[indexHistory.values objectAtIndex:latestIndex] floatValue]];
    attrs[NSForegroundColorAttributeName] = topTextColor;
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSParagraphStyleAttributeName] = textParagraphStyle;
    [str drawInRect:textRect withAttributes:attrs];
    CGContextRestoreGState(ctx);
    
    CGContextRestoreGState(ctx);
}

-(void)drawMiddleBarsWithCtx:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, sublineTextRectSize.width+sublineExtraSideLength+10*singleBarWidth+9*spaceBetweenBars+spaceOnX, xTextRectSize.height);
    CGContextSetRGBFillColor(ctx, 67/255.0f, 135/255.0f, 183/255.0f, 1);
    
    //draw bars
    int count=0;
    float curr;
    for(int i=1;i<=middleHistory.size;i++){
        curr=[[middleHistory.values objectAtIndex:(middleHistory.rear+i)%middleHistory.size] floatValue];
        CGContextFillRect(ctx, CGRectMake(xPadding+count*(singleBarWidth+spaceBetweenBars), 0, singleBarWidth, contentSize.height/maxValueY*curr));
        count++;
    }
    
    //draw text on bottom
    CGContextSaveGState(ctx);
    CGContextScaleCTM(ctx, 1, -1);
    float textRectCenterX=xPadding+(10*singleBarWidth+9*spaceBetweenBars)/2.0f;
    CGRect textRect=CGRectMake(textRectCenterX-xTextRectSize.width/2.0f, 0, xTextRectSize.width, xTextRectSize.height);
    NSString *str = @"中指";
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = xTextColor;
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSParagraphStyleAttributeName] = textParagraphStyle;
    [str drawInRect:textRect withAttributes:attrs];
    //draw text on top
    textRect=CGRectMake(textRectCenterX-topTextRectSize.width/2.0f, -contentSize.height-topTextRectSize.height, topTextRectSize.width, topTextRectSize.height);
    int latestIndex=middleHistory.rear==0?middleHistory.size-1:middleHistory.rear-1;
    str = [NSString stringWithFormat:@"%f",[[middleHistory.values objectAtIndex:latestIndex] floatValue]];
    attrs[NSForegroundColorAttributeName] = topTextColor;
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSParagraphStyleAttributeName] = textParagraphStyle;
    [str drawInRect:textRect withAttributes:attrs];
    CGContextRestoreGState(ctx);
    
    CGContextRestoreGState(ctx);
}

-(void)drawRingBarsWithCtx:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, sublineTextRectSize.width+sublineExtraSideLength+(10*singleBarWidth+9*spaceBetweenBars+spaceOnX)*2, xTextRectSize.height);
    CGContextSetRGBFillColor(ctx, 67/255.0f, 135/255.0f, 183/255.0f, 1);
    
    //draw bars
    int count=0;
    float curr;
    for(int i=1;i<=ringHistory.size;i++){
        curr=[[ringHistory.values objectAtIndex:(ringHistory.rear+i)%ringHistory.size] floatValue];
        CGContextFillRect(ctx, CGRectMake(xPadding+count*(singleBarWidth+spaceBetweenBars), 0, singleBarWidth, contentSize.height/maxValueY*curr));
        count++;
    }
    
    //draw text on bottom
    CGContextSaveGState(ctx);
    CGContextScaleCTM(ctx, 1, -1);
    float textRectCenterX=xPadding+(10*singleBarWidth+9*spaceBetweenBars)/2.0f;
    CGRect textRect=CGRectMake(textRectCenterX-xTextRectSize.width/2.0f, 0, xTextRectSize.width, xTextRectSize.height);
    NSString *str = @"无名指";
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = xTextColor;
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSParagraphStyleAttributeName] = textParagraphStyle;
    [str drawInRect:textRect withAttributes:attrs];
    //draw text on top
    textRect=CGRectMake(textRectCenterX-topTextRectSize.width/2.0f, -contentSize.height-topTextRectSize.height, topTextRectSize.width, topTextRectSize.height);
    int latestIndex=ringHistory.rear==0?ringHistory.size-1:ringHistory.rear-1;
    str = [NSString stringWithFormat:@"%f",[[ringHistory.values objectAtIndex:latestIndex] floatValue]];
    attrs[NSForegroundColorAttributeName] = topTextColor;
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSParagraphStyleAttributeName] = textParagraphStyle;
    [str drawInRect:textRect withAttributes:attrs];
    CGContextRestoreGState(ctx);
    
    CGContextRestoreGState(ctx);
}

-(void)drawLittleBarsWithCtx:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, sublineTextRectSize.width+sublineExtraSideLength+(10*singleBarWidth+9*spaceBetweenBars+spaceOnX)*3, xTextRectSize.height);
    CGContextSetRGBFillColor(ctx, 67/255.0f, 135/255.0f, 183/255.0f, 1);
    
    //draw bars
    int count=0;
    float curr;
    for(int i=1;i<=littleHistory.size;i++){
        curr=[[littleHistory.values objectAtIndex:(littleHistory.rear+i)%littleHistory.size] floatValue];
        CGContextFillRect(ctx, CGRectMake(xPadding+count*(singleBarWidth+spaceBetweenBars), 0, singleBarWidth, contentSize.height/maxValueY*curr));
        count++;
    }
    
    //draw text on bottom
    CGContextSaveGState(ctx);
    CGContextScaleCTM(ctx, 1, -1);
    float textRectCenterX=xPadding+(10*singleBarWidth+9*spaceBetweenBars)/2.0f;
    CGRect textRect=CGRectMake(textRectCenterX-xTextRectSize.width/2.0f, 0, xTextRectSize.width, xTextRectSize.height);
    NSString *str = @"小指";
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = xTextColor;
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSParagraphStyleAttributeName] = textParagraphStyle;
    [str drawInRect:textRect withAttributes:attrs];
    //draw text on top
    textRect=CGRectMake(textRectCenterX-topTextRectSize.width/2.0f, -contentSize.height-topTextRectSize.height, topTextRectSize.width, topTextRectSize.height);
    int latestIndex=littleHistory.rear==0?littleHistory.size-1:littleHistory.rear-1;
    str = [NSString stringWithFormat:@"%f",[[littleHistory.values objectAtIndex:latestIndex] floatValue]];
    attrs[NSForegroundColorAttributeName] = topTextColor;
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSParagraphStyleAttributeName] = textParagraphStyle;
    [str drawInRect:textRect withAttributes:attrs];
    CGContextRestoreGState(ctx);
    
    CGContextRestoreGState(ctx);
}

-(void)onDataReceived:(DataUnit *)data{
    [indexHistory enqueue:data.index];
    [middleHistory enqueue:data.middle];
    [ringHistory enqueue:data.ring];
    [littleHistory enqueue:data.little];
}

@end
