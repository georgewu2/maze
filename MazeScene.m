//
//  MazeScene.m
//  Maze
//
//  Created by George Wu on 7/22/13.
//  Copyright (c) 2013 George Wu. All rights reserved.
//

#import "MazeScene.h"

@interface MazeScene ()
{
    BOOL _heroIsMoving;
}
@property BOOL contentCreated;
@property SKSpriteNode *hero;
@end

@implementation MazeScene

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
        _heroIsMoving = NO;
    }
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    NSArray *maze = [self drawMaze];
    for (SKSpriteNode *wall in maze) {
        wall.anchorPoint = CGPointMake(0, 0);
//        wall.
        [self addChild:wall];
    }
    SKSpriteNode *hero = [self newHero];
    [self addChild:hero];
}


//- (SKShapeNode *)drawMaze
- (NSArray *)drawMaze
{
//    NSArray *wallLocations = [self generateWallLocations];
//    CGMutablePathRef myPath = CGPathCreateMutable();

    NSMutableArray *maze = [[NSMutableArray alloc] init];
    SKSpriteNode *wall1 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .2, self.frame.size.height * .1)];
//    wall1.anchorPoint = CGPointMake(0, 0);
//    maze.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    SKSpriteNode *wall2 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .2, self.frame.size.height * .3)];
//    wall2.anchorPoint = CGPointMake(0, 0);
    wall2.position = CGPointMake(self.frame.size.width * .4, 0);
    SKSpriteNode *wall3 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .2, self.frame.size.height * .4)];
    wall3.position = CGPointMake(self.frame.size.width * .8, self.frame.size.height * .1);
    SKSpriteNode *wall4 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .2, self.frame.size.height * .7)];
    wall4.position = CGPointMake(self.frame.size.width * .2, self.frame.size.height * .2);
    SKSpriteNode *wall5 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .4, self.frame.size.height * .1)];
    wall5.position = CGPointMake(self.frame.size.width * .4, self.frame.size.height * .8);
    SKSpriteNode *wall6 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .2, self.frame.size.height * .3)];
    wall6.position = CGPointMake(self.frame.size.width * .6, self.frame.size.height * .4);
    [maze addObject:wall1];
    [maze addObject:wall2];
    [maze addObject:wall3];
    [maze addObject:wall4];
    [maze addObject:wall5];
    [maze addObject:wall6];
    return maze;
}

- (SKSpriteNode *)newHero
{
    self.hero = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(32, 32)];
    self.hero.position = CGPointMake(self.frame.size.width * .3, self.size.height * .05);
//    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size];
    self.hero.physicsBody.dynamic = YES;
    return self.hero;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint location = [t locationInNode:self];
    if ([self isNearHero:location]) {
        _heroIsMoving = YES;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint location = [t locationInNode:self];
    if (_heroIsMoving == YES) {
        self.hero.position = location;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _heroIsMoving = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
- (BOOL)isNearHero:(CGPoint)location
{
    float distance = hypotf(self.hero.position.x - location.x, self.hero.position.y - location.y);
    if (distance < 32) {
        return YES;
    }
    return NO;
}

//- (NSArray *)generateWallLocations
//{
//    
//}

@end
