//
//  StartScene.m
//  SpriteKitDemo
//
//  Created by pk on 14/11/27.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "StartScene.h"
#import "GameScene.h"

@interface StartScene (){
    SKSpriteNode* sprite;
}

@end

@implementation StartScene

- (instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        //label
        SKLabelNode* label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = @"飞机大Zhan";
        label.fontSize = 30.0;
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        //给场景添加节点
        //[self addChild:label];
        
        
        //精灵
        sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        //缩放
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        //手动设定精灵大小
        //sprite.size = CGSizeMake(200, 200);
        sprite.position = CGPointMake(CGRectGetMidX(self.frame), sprite.size.height/2);
        //锚点
        sprite.anchorPoint = CGPointMake(0.5, 0.5);
        [self addChild:sprite];
        
     
       
        //girl精灵 200 250
        SKSpriteNode* girlSprite = [SKSpriteNode spriteNodeWithImageNamed:@"s_1.png"];
        girlSprite.position = CGPointMake(100, 300);
        [self addChild:girlSprite];
        
        NSMutableArray* array = [NSMutableArray array];
        for (int i = 1; i < 9; i++) {
            //纹理
            SKTexture* texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"s_%d.png", i]];
            [array addObject:texture];
        }
        //Action
        SKAction* action = [SKAction animateWithTextures:array timePerFrame:0.1];
        [girlSprite runAction:[SKAction repeatActionForever:action]];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //得到触摸的点
    CGPoint point = [[touches anyObject] locationInNode:self];
    //判断飞机是否包含一个点
    if (CGRectContainsPoint(sprite.frame, point)) {
        //动作
        SKAction* flyAction = [SKAction moveByX:0 y:self.size.height duration:2.0];
        SKAction* flyAction2 = [SKAction moveToY:self.size.height + sprite.size.height/2 duration:2.0];
        //旋转
        SKAction* rotateAction = [SKAction rotateByAngle:M_PI duration:0.5];
        //重复动作
        //SKAction* repeatAction = [SKAction repeatActionForever:rotateAction];
        SKAction* repeatAction = [SKAction repeatAction:rotateAction count:4];
        //并行动作
        SKAction* groupAction = [SKAction group:@[flyAction, repeatAction]];
        //事件动作
        SKAction* blockAction = [SKAction runBlock:^{
            //粒子效果
            SKEmitterNode* emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Fire" ofType:@"sks"]];
            emitter.position = CGPointMake(sprite.size.width/2 - 100, -sprite.size.height/2 - 100);
            [sprite addChild:emitter];
        }];
        //动作队列
        SKAction* sequence = [SKAction sequence:@[repeatAction, blockAction, flyAction]];
        //飞机执行动作
        [sprite runAction:sequence completion:^{
            GameScene* scene = [GameScene sceneWithSize:self.size];
            //过渡
            SKTransition* transition = [SKTransition  doorsOpenVerticalWithDuration:1.0];
            //切换场景
            [self.view presentScene:scene transition:transition];
        }];
    }
}






@end
