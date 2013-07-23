//
//  EndScene.m
//  Maze
//
//  Created by George Wu on 7/22/13.
//  Copyright (c) 2013 George Wu. All rights reserved.
//

#import "EndScene.h"

@interface EndScene ()
@property BOOL contentCreated;
@end

@implementation EndScene

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild:[self newCongratsNode]];
    [self addChild:[self newGameNode]];
}

- (SKLabelNode *)newCongratsNode
{
    SKLabelNode *congratsNode = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    congratsNode.text = @"Congratulations! You win!";
    congratsNode.name = @"congrats";
    congratsNode.fontSize = 42;
    congratsNode.fontColor = [SKColor greenColor];
    congratsNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    return congratsNode;
}

- (SKLabelNode *)newGameNode
{
    SKLabelNode *gameNode = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    gameNode.text = @"Touch screen to play again";
    gameNode.name = @"game";
    gameNode.fontSize = 42;
    gameNode.fontColor = [SKColor purpleColor];
    gameNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 40);
    return gameNode;
}

@end
