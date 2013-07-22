//
//  WelcomeScene.m
//  Maze
//
//  Created by George Wu on 7/22/13.
//  Copyright (c) 2013 George Wu. All rights reserved.
//

#import "WelcomeScene.h"
#import "MazeScene.h"

@interface WelcomeScene ()
@property BOOL contentCreated;
@end

@implementation WelcomeScene

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor redColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild:[self newWelcomeNode]];
    [self addChild:[self newGameNode]];
}

- (SKLabelNode *)newWelcomeNode
{
    SKLabelNode *welcomeNode = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    welcomeNode.text = @"Mazeeeeee";
    welcomeNode.name = @"mazeNode";
    welcomeNode.fontSize = 80;
    welcomeNode.fontColor = [SKColor blueColor];
    welcomeNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    return welcomeNode;
}

- (SKLabelNode *)newGameNode
{
    SKLabelNode *gameNode = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    gameNode.text = @"Touch anywhere to start!";
    gameNode.name = @"gameNode";
    gameNode.fontSize = 42;
    gameNode.fontColor = [SKColor greenColor];
    gameNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 60);
    return gameNode;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKNode *welcomeNode = [self childNodeWithName:@"mazeNode"];
    SKNode *gameNode = [self childNodeWithName:@"gameNode"];
    if (welcomeNode != nil && gameNode != nil) {
        welcomeNode.name = nil;
        gameNode.name = nil;
        SKAction *fadeAway = [SKAction fadeOutWithDuration:0.25];
        SKAction *moveUp = [SKAction moveByX:0 y:600 duration:0.5];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *welcomeMove = [SKAction sequence:@[fadeAway, remove]];
        SKAction *gameMove = [SKAction sequence:@[moveUp, remove]];
        [welcomeNode runAction:welcomeMove];
        [gameNode runAction:gameMove completion:^{
            SKScene *mazeScene = [[MazeScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenHorizontalWithDuration:0.5];
            [self.view presentScene:mazeScene transition:doors];
        }];
    }
}

@end
