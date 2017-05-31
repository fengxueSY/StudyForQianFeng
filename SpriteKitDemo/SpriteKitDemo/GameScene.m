//
//  GameScene.m
//  SpriteKitDemo
//
//  Created by pk on 14/11/27.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        //背景 bg_01.jpg
        SKSpriteNode* bgSprite = [SKSpriteNode spriteNodeWithImageNamed:@"bg_01.jpg"];
        //z轴
        bgSprite.zPosition = -1;
        bgSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:bgSprite];
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInNode:self];
    
    SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithImageNamed:@"2.png"];
    sprite.position = point;
    [self addChild:sprite];
    //刚体
    //圆
    //sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sprite.size.width/2-5];
    //世界
    //重力
    self.physicsWorld.gravity = CGVectorMake(0, -100);
    //矩形
    sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    
    //力
    //sprite.physicsBody.velocity = CGVectorMake(500, 700);
}





@end
