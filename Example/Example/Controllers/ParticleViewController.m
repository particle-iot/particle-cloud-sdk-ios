//
// Before you explore this example, we strongly suggest to take a look at: https://docs.particle.io/reference/ios/.
//
// We tried to keep this example as simple as possible. It contains two views:
//  1) Login view - to access particle cloud methods, you must be logged in.
//  2) Action view - after successful login, simplified UI to try out some of the Particle Cloud methods
//
//  Created by Raimundas Sakalauskas on 02/07/2018.
//  Copyright © 2018 Particle Inc. All rights reserved.
//

#import "ParticleViewController.h"
#import <ParticleSDK/ParticleSDK.h>

//Make sure to change value of these constants
#define PARTICLE_USER   @"NOT SET"
#define PARTICLE_PASSWORD   @"NOT SET"

@interface ParticleViewController()

@property (assign) BOOL loggedIn;

@end


@implementation ParticleViewController

@synthesize loggedIn;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateButtonsState];
}

#pragma mark - SDK

- (void)login {

    if ([PARTICLE_USER isEqualToString:@"NOT SET"] || [PARTICLE_USER isEqualToString:@"NOT SET"]) {
        NSLog(@"To log in, you must change PARTICLE_USER and PARTICLE_PASSWORD constant values in ParticleViewController.m");
        return;
    }

    self.loginButton.enabled = NO;

    __weak ParticleViewController *wSelf = self;
    [[ParticleCloud sharedInstance] loginWithUser:PARTICLE_USER password:PARTICLE_PASSWORD completion:^(NSError *error) {
        __strong ParticleViewController *sSelf = wSelf;

        if (!error) {
            //Success
            NSLog(@"Successfully logged in to the cloud!\nAccess Token: %@", [ParticleCloud sharedInstance].accessToken);

            //Update UI state
            sSelf.loggedIn = YES;
            [sSelf updateButtonsState];
        } else {
            //Failed to log in
            NSLog(@"Error while logging in to the cloud: %@", error.localizedDescription);

            sSelf.loggedIn = NO;
            [sSelf updateButtonsState];
        }
    }];
}



- (void)logout {
    [[ParticleCloud sharedInstance] logout];
    NSLog(@"Successfully logged out!\nAccess Token: %@",[ParticleCloud sharedInstance].accessToken);

    //Update UI state
    self.loggedIn = NO;
    [self updateButtonsState];
}

#pragma mark - UI events

- (IBAction)loginButtonClicked:(UIButton *)sender {
    if (self.loggedIn) {
        [self logout];
    } else {
        [self login];
    }
}


#pragma mark - Helpers

- (void)updateButtonsState {
    self.loginButton.enabled = YES;

    if (self.loggedIn) {
        self.actionsButton.enabled = YES;
        [self.loginButton setTitle:@"Log out" forState:UIControlStateNormal];
    } else {
        self.actionsButton.enabled = NO;
        [self.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    }
}


@end
