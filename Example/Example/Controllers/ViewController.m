//
//  ViewController.m
//  Example
//
//  Created by Raimundas Sakalauskas on 02/07/2018.
//  Copyright © 2018 Particle Inc. All rights reserved.
//

#import "ViewController.h"
#import <ParticleSDK/ParticleSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ParticleCloud sharedInstance];
}


@end
