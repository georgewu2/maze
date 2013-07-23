//
//  EndScene.m
//  Maze
//
//  Created by George Wu on 7/22/13.
//  Copyright (c) 2013 George Wu. All rights reserved.
//

#import "EndScene.h"
#import "MazeScene.h"

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
    gameNode.fontColor = [SKColor redColor];
    gameNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 60);
    return gameNode;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKNode *congratsNode = [self childNodeWithName:@"congrats"];
    SKNode *gameNode = [self childNodeWithName:@"game"];
    if (congratsNode != nil && gameNode != nil) {
        congratsNode.name = nil;
        gameNode.name = nil;
        SKAction *fadeAway = [SKAction fadeOutWithDuration:0.25];
        SKAction *moveUp = [SKAction moveByX:0 y:600 duration:0.5];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *welcomeMove = [SKAction sequence:@[fadeAway, remove]];
        SKAction *gameMove = [SKAction sequence:@[moveUp, remove]];
        [congratsNode runAction:welcomeMove];
        [gameNode runAction:gameMove completion:^{
            SKScene *mazeScene = [[MazeScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenHorizontalWithDuration:0.5];
            [self.view presentScene:mazeScene transition:doors];
        }];
    }
}

@end
