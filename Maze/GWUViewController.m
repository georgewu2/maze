//
//  GWUViewController.m
//  Maze
//
//  Created by George Wu on 7/22/13.
//  Copyright (c) 2013 George Wu. All rights reserved.
//

#import "GWUViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "WelcomeScene.h"
#import "MazeScene.h"

@interface GWUViewController ()

@end

@implementation GWUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    SKView *spriteView = (SKView *)self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    WelcomeScene *welcome = [[WelcomeScene alloc] initWithSize:CGSizeMake(640, 1136)];
    MazeScene *maze = [[MazeScene alloc] initWithSize:CGSizeMake(640, 1136)];
    SKView *spriteView = (SKView *)self.view;
    [spriteView presentScene:maze];
//    MazeScene *maze = [[MazeScene alloc] initWithSize:CGSizeMake(640, 1136)];
//    SKView *spriteView = (SKView *)self.view;
//    [spriteView presentScene:maze];
}

@end
