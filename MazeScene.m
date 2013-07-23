//
//  MazeScene.m
//  Maze
//
//  Created by George Wu on 7/22/13.
//  Copyright (c) 2013 George Wu. All rights reserved.
//

#import "MazeScene.h"
#import "EndScene.h"

@interface MazeScene ()
@property BOOL contentCreated;
@property SKSpriteNode *hero;
@property SKSpriteNode *endNode;
@property NSArray *walls;
@end

@implementation MazeScene

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
        self.physicsWorld.gravity = CGPointMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    }
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    NSArray *maze = [self drawMaze];
    for (SKSpriteNode *wall in maze) {
//        wall.anchorPoint = CGPointMake(0.5, 0.5);
        wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
        wall.physicsBody.dynamic = NO;
        
        [self addChild:wall];
    }
    self.walls = maze;
    SKSpriteNode *hero = [self newHero];
    [self addChild:hero];
    SKSpriteNode *endNode = [self drawEnding];
    [self addChild:endNode];
}

- (SKSpriteNode *)drawEnding
{
    _endNode = [[SKSpriteNode alloc]initWithColor:[SKColor greenColor] size:CGSizeMake(32, 32)];
    _endNode.position = CGPointMake(self.size.width * .9, self.size.height * .05);
    return _endNode;
}
//- (SKShapeNode *)drawMaze
- (NSArray *)drawMaze
{
//    NSArray *wallLocations = [self generateWallLocations];
//    CGMutablePathRef myPath = CGPathCreateMutable();

    NSMutableArray *maze = [[NSMutableArray alloc] init];
    SKSpriteNode *wall1 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .2, self.frame.size.height * .1)];
    wall1.position = CGPointMake(self.size.width * 0.1, self.size.height * 0.05);
//    wall1.anchorPoint = CGPointMake(0, 0);
//    maze.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    SKSpriteNode *wall2 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .2, self.frame.size.height * .3)];
//    wall2.anchorPoint = CGPointMake(0, 0);
    wall2.position = CGPointMake(self.frame.size.width * .5, self.size.height * 0.15);
    SKSpriteNode *wall3 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .2, self.frame.size.height * .4)];
    wall3.position = CGPointMake(self.frame.size.width * .9, self.frame.size.height * .3);
    SKSpriteNode *wall4 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .2, self.frame.size.height * .7)];
    wall4.position = CGPointMake(self.frame.size.width * .3, self.frame.size.height * .55);
    SKSpriteNode *wall5 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .4, self.frame.size.height * .1)];
    wall5.position = CGPointMake(self.frame.size.width * .6, self.frame.size.height * .85);
    SKSpriteNode *wall6 = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(self.frame.size.width * .2, self.frame.size.height * .3)];
    wall6.position = CGPointMake(self.frame.size.width * .7, self.frame.size.height * .55);
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
    self.hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.hero.size];
    self.hero.physicsBody.dynamic = YES;
    self.hero.physicsBody.usesPreciseCollisionDetection = YES;
    return self.hero;
}

- (CGPoint)determineDirection:(CGPoint)location
{
    CGPoint velocity = self.hero.physicsBody.velocity;
    velocity.x *= .96;
    velocity.y *= .96;
    self.hero.physicsBody.velocity = velocity;
    CGPoint heroLocation = [self convertPoint:self.hero.position fromNode:self];
    CGPoint direction = CGPointMake(location.x - heroLocation.x, location.y - heroLocation.y);
    return direction;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint location = [t locationInNode:self];
    [self applyForceToHero:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint location = [t locationInNode:self];
    [self applyForceToHero:location];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ended!");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (BOOL)isNearHero:(CGPoint)location
{
    float distance = hypotf(self.hero.position.x - location.x, self.hero.position.y - location.y);
    if (distance < 32) {
        return YES;
    }
    return NO;
}

- (void)applyForceToHero:(CGPoint)location
{
    CGPoint direction = [self determineDirection:location];
    [self.hero.physicsBody applyForce:direction];
}

- (void)update:(NSTimeInterval)currentTime
{
    CGPoint velocity = self.hero.physicsBody.velocity;
    velocity.x *= .96;
    velocity.y *= .96;
    self.hero.physicsBody.velocity = velocity;
    
}

- (void)didSimulatePhysics
{
    if ([self isNearHero:self.endNode.position]) {
        SKAction *fadeaway = [SKAction fadeOutWithDuration:0.25];
        SKAction *remove = [SKAction removeFromParent];
        for (SKSpriteNode *wall in self.walls) {
            [wall runAction:[SKAction sequence:@[fadeaway,remove]]];
        }
        [self.hero runAction:[SKAction sequence:@[fadeaway, remove]]];
        [self.endNode runAction:[SKAction sequence:@[fadeaway,remove]] completion:^{
            SKScene *endScene = [[EndScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenHorizontalWithDuration:0.5];
            [self.view presentScene:endScene transition:doors];
        }];
    }
}
//- (NSArray *)generateWallLocations
//{
//    
//}

@end
