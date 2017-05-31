//
//  MyView.m
//  Quartz2DDemo
//
//  Created by pk on 14/12/19.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (void)drawRect:(CGRect)rect {
    /*
    UIImage* bgImage = [UIImage imageNamed:@"2.jpg"];
    //以图片为模板在一个区域绘制
    //[bgImage drawAsPatternInRect:self.bounds];
    //在一点绘制
    //[bgImage drawAtPoint:CGPointMake(0, 0)];
    //在一个区域绘制
    [bgImage drawInRect:self.bounds];
    
    UIImage* image = [UIImage imageNamed:@"1.jpg"];
    //混合模式
    [image drawAtPoint:CGPointMake(20, 50)blendMode:kCGBlendModeDarken alpha:1.0];
     
    
    //画文字
    NSString* str = @"月黑风高的夜晚，潘松彪走在路上，遇到了贱贱，从此，两人过上了幸福快乐的生活。。。";
    [str drawInRect:self.bounds withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0], NSForegroundColorAttributeName: [UIColor blueColor]}];
    
    //得到绘图上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //线宽
    CGContextSetLineWidth(ref, 10);
    //相交方式
    CGContextSetLineJoin(ref, kCGLineJoinRound);
    //虚线 画20 空10
    CGFloat lengths[] = {20, 10};
    //0在这是起点位置
    CGContextSetLineDash(ref, 0, lengths, 2);
    CGContextSetLineCap(ref, kCGLineCapRound);
    //线颜色
    CGContextSetStrokeColorWithColor(ref, [UIColor blueColor].CGColor);
    //移动到起始点
    CGContextMoveToPoint(ref, 50, 50);
    //添加一条直线
    CGContextAddLineToPoint(ref, 250, 50);
    CGContextAddLineToPoint(ref, 150, 200);
    //CGContextAddLineToPoint(ref, 50, 50);
    CGContextClosePath(ref);
    //画线
    CGContextStrokePath(ref);
    
    //画矩形
    CGContextAddRect(ref, CGRectMake(50, 250, 200, 200));
    //填充颜色
    CGContextSetFillColorWithColor(ref, [UIColor redColor].CGColor);
    //透明度
    CGContextSetAlpha(ref, 1);
    //设置阴影 羽化程度
    //CGContextSetShadow(ref, CGSizeMake(50, 50), 30);
    CGContextSetShadowWithColor(ref, CGSizeMake(50, 50), 20, [UIColor purpleColor].CGColor);
    //填充
    CGContextFillPath(ref);
    CGContextSetFillColorWithColor(ref, [UIColor orangeColor].CGColor);
    //画圆
    CGContextSetShadowWithColor(ref, CGSizeMake(0, 0), 0, [UIColor clearColor].CGColor);
    CGContextAddEllipseInRect(ref, CGRectMake(50, 250, 200, 200));
    //填充+描边
    CGContextDrawPath(ref, kCGPathFillStroke);
     

    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ref, 150, 150);
    //圆心，半径，起始结束弧度，顺时针，逆时针
    CGContextAddArc(ref, 150, 150, 100, 0, 120 * M_PI / 180, 1);
    CGContextFillPath(ref);
    CGContextSetFillColorWithColor(ref, [UIColor redColor].CGColor);
    CGContextMoveToPoint(ref, 170, 170);
    CGContextAddArc(ref, 170, 170, 100, 0, 120 * M_PI / 180, 0);
    CGContextFillPath(ref);
     */
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ref, 50, 50);
    //弧线
    //CGContextAddQuadCurveToPoint(ref, 150, 700, 250, 50);
    CGContextAddCurveToPoint(ref, 100, 300, 150, 50, 200, 300);
    CGContextStrokePath(ref);
}





@end
