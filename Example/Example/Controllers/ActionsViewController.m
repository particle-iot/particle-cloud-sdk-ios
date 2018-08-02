//
// Created by Raimundas Sakalauskas on 19/07/2018.
// Copyright (c) 2018 Particle Inc. All rights reserved.
//

#ifdef USE_FRAMEWORKS
#import <ParticleSDK/ParticleCloud.h>
#else
#import "ParticleCloud.h"
#endif
#import "ActionsViewController.h"

#define DEVICE_NAME   @"NOT SET"
#define DEVICE_ID   @"NOT SET" //e.g. 3c0025000b47363330353437
#define DEVICE_RENAME_NAME   @"NOT SET"
#define VARIABLE_NAME   @"NOT SET"
#define FUNCTION_NAME   @"digitalWrite"
#define FUNCTION_ARGUMENTS   @[@"D7", @1]

@interface ActionsViewController()

@property (strong, nonatomic) ParticleDevice *selectedDevice;

@end


@implementation ActionsViewController {
    id _eventListenerID;
}

@synthesize selectedDevice;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateUI];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    //if we leave this view, we make sure to unsubscribe from the events stream
    [self unsubscribeFromEvents];
    self.selectedDevice = nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.section) {
        case 0:
            //Cloud
            switch (indexPath.row) {
                case 0:
                    [self listDevices];
                    break;
                case 1:
                    [self selectRandomDevice];
                    break;
                case 2:
                    [self selectDeviceWithName:DEVICE_NAME];
                    break;
                case 3:
                    [self selectDeviceWithID:DEVICE_ID];
                    break;
                case 4:
                    [self claimDevice:DEVICE_ID];
                    break;
            }
            break;
        case 1:
            //Device
            switch (indexPath.row) {
                case 0:
                    [self refreshDevice];
                    break;
                case 1:
                    [self listVariables];
                    break;
                case 2:
                    [self listFunctions];
                    break;
                case 3:
                    [self getVariable:VARIABLE_NAME];
                    break;
                case 4:
                    [self callFunction];
                    break;
                case 5:
                    [self renameDevice:DEVICE_RENAME_NAME];
                    break;
                case 6:
                    [self unclaimDevice];
                    break;
            }
            break;
        case 2:
            //Events
            if (_eventListenerID) {
                [self unsubscribeFromEvents];
            } else {
                [self subscribeToEvents];
            }
            break;
    }
}

#pragma mark Helpers

- (void)updateUI {
    if (_eventListenerID) {
        self.eventsCellLabel.text = @"Unsubscribe from device events";
    } else {
        self.eventsCellLabel.text = @"Subscribe to device events";
    }

    self.deviceNameLabel.text = [NSString stringWithFormat:@"Device name: %@", DEVICE_NAME];
    self.deviceIdLabel.text = [NSString stringWithFormat:@"Device ID: %@", DEVICE_ID];
    self.deviceIdLabel2.text = self.deviceIdLabel.text;
    self.renameLabel.text = [NSString stringWithFormat:@"New name: %@", DEVICE_RENAME_NAME];
    self.variableNameLabel.text = [NSString stringWithFormat:@"Variable name: %@", VARIABLE_NAME];
    self.functionNameLabel.text = [NSString stringWithFormat:@"Function name: %@", FUNCTION_NAME];
}


#pragma mark Particle Cloud Methods

- (void)listDevices {
    [[ParticleCloud sharedInstance] getDevices:^(NSArray *particleDevices, NSError *error) {
        if (!error) {
            NSLog(@"Particle devices available: %u", particleDevices.count);

            for (ParticleDevice *device in particleDevices) {
                NSLog(@"%@", device);
            }
        } else {
            NSLog(@"Error.localizedDescription = %@", error.localizedDescription);
        }
    }];
}

- (void)selectRandomDevice {
    __weak ActionsViewController *wSelf = self;
    [[ParticleCloud sharedInstance] getDevices:^(NSArray *particleDevices, NSError *error) {
        if (!error) {
            NSLog(@"Particle devices available: %u", particleDevices.count);

            if (particleDevices.count > 0) {
                int index = arc4random_uniform(particleDevices.count);
                __strong ActionsViewController *sSelf = wSelf;
                sSelf.selectedDevice = particleDevices[index];
                NSLog(@"Selected device: %@", sSelf.selectedDevice);
            } else {
                NSLog(@"Selected device: nil");
            }
        } else {
            NSLog(@"Selected device: nil");
            NSLog(@"Error.localizedDescription = %@", error.localizedDescription);
        }
    }];

}


- (void)selectDeviceWithName:(NSString *)name {
    self.selectedDevice = nil;

    if ([name isEqualToString:@"NOT SET"]) {
        NSLog(@"To run this action please change the value for DEVICE_NAME in ActionsViewController.m");
        return;
    }

    __weak ActionsViewController *wSelf = self;
    [[ParticleCloud sharedInstance] getDevices:^(NSArray *particleDevices, NSError *error) {
        if (!error) {
            // search for a specific device by name
            for (ParticleDevice *device in particleDevices) {
                if ([device.name isEqualToString:name]) {
                    __strong ActionsViewController *sSelf = wSelf;
                    sSelf.selectedDevice = device;
                    NSLog(@"Selected device: %@", device);
                    return;
                }
            }
            NSLog(@"Selected device: nil");
        } else {
            NSLog(@"Selected device: nil");
            NSLog(@"Error.localizedDescription = %@", error.localizedDescription);
        }
    }];
}


- (void)selectDeviceWithID:(NSString *)deviceID {
    self.selectedDevice = nil;

    if ([deviceID isEqualToString:@"NOT SET"]) {
        NSLog(@"To run this action please change the value for DEVICE_ID in ActionsViewController.m");
        return;
    }

    __weak ActionsViewController *wSelf = self;
    [[ParticleCloud sharedInstance] getDevice:deviceID completion:^(ParticleDevice *device, NSError *error) {
        if (!error) {
            __strong ActionsViewController *sSelf = wSelf;
            sSelf.selectedDevice = device;
            NSLog(@"Selected device: %@", device);
        } else {
            NSLog(@"Selected device: nil");
            NSLog(@"Error.localizedDescription = %@", error.localizedDescription);
        }
    }];
}

- (void)claimDevice:(NSString *)deviceID {
    if ([deviceID isEqualToString:@"NOT SET"]) {
        NSLog(@"To run this action please change the value for DEVICE_ID in ActionsViewController.m");
        return;
    }

    __weak ActionsViewController *wSelf = self;
    [[ParticleCloud sharedInstance] claimDevice:deviceID completion:^(NSError *error) {

        if (!error) {
            NSLog(@"Device claimed");
        } else {
            NSLog(@"Unable to claim the device");
            NSLog(@"Error.localizedDescription = %@", error.localizedDescription);
        }
    }];
}


#pragma mark Particle Device Methods

- (void)refreshDevice {
    if (!self.selectedDevice) {
        NSLog(@"Error trying to refresh the device. You must first select a device using one of the cloud actions.");
        return;
    }

    __weak ActionsViewController *wSelf = self;
    [self.selectedDevice refresh:^(NSError *error) {
        if (!error) {
            __strong ActionsViewController *sSelf = wSelf;
            NSLog(@"Refreshed device data: %@", sSelf.selectedDevice);
        } else {
            NSLog(@"Unable to refresh the device");
            NSLog(@"Error.localizedDescription = %@", error.localizedDescription);
        }
    }];
}


- (void)listVariables {
    if (!self.selectedDevice) {
        NSLog(@"Error trying to list device variables. You must first select a device using one of the cloud actions.");
        return;
    }

    NSLog(@"Particle device variables available: %u", self.selectedDevice.variables.count);
    for (NSString* key in self.selectedDevice.variables) {
        NSString *value = self.selectedDevice.variables[key];

        NSLog(@"%@ is of type %@", key, value);
    }
}

- (void)listFunctions {
    if (!self.selectedDevice) {
        NSLog(@"Error trying to list device functions. You must first select a device using one of the cloud actions.");
        return;
    }

    NSLog(@"Particle device functions available: %u", self.selectedDevice.functions.count);
    for (NSString* name in self.selectedDevice.functions) {
        NSLog(@"%@", name);
    }
}


- (void)getVariable:(NSString *)variableName {
    if (!self.selectedDevice) {
        NSLog(@"Error trying to list device functions. You must first select a device using one of the cloud actions.");
        return;
    }

    if ([variableName isEqualToString:@"NOT SET"]) {
        NSLog(@"To run this action please change the value for VARIABLE_NAME in ActionsViewController.m");
        return;
    }

    [self.selectedDevice getVariable:variableName completion:^(id result, NSError *error) {
        if (!error) {
            NSLog(@"Variable value: %@", result);
        } else {
            NSLog(@"Unable to get the variable names %@", variableName);
            NSLog(@"Error.localizedDescription = %@", error.localizedDescription);
        }
    }];
}

- (void)callFunction {
    if (!self.selectedDevice) {
        NSLog(@"Error trying to list device functions. You must first select a device using one of the cloud actions.");
        return;
    }

    [self.selectedDevice callFunction:FUNCTION_NAME withArguments:FUNCTION_ARGUMENTS completion:^(NSNumber *resultCode, NSError *error) {
        if (!error) {
            NSLog(@"Successfully called function %@", FUNCTION_NAME);
        } else {
            NSLog(@"Unable to call function %@", FUNCTION_NAME);
            NSLog(@"Error.localizedDescription = %@", error.localizedDescription);
        }
    }];
}



- (void)renameDevice:(NSString *)newName {
    if (!self.selectedDevice) {
        NSLog(@"Error trying to rename the device. You must first select a device using one of the cloud actions.");
        return;
    }

    if ([newName isEqualToString:@"NOT SET"]) {
        NSLog(@"To run this action please change the value for DEVICE_RENAME_NAME in ActionsViewController.m");
        return;
    }

    __weak ActionsViewController *wSelf = self;
    [self.selectedDevice rename:newName completion:^(NSError *error) {
        if (!error) {
            __strong ActionsViewController *sSelf = wSelf;
            NSLog(@"Device renamed: %@", sSelf.selectedDevice);
        } else {
            NSLog(@"Unable to rename the device");
            NSLog(@"Error.localizedDescription = %@", error.localizedDescription);
        }
    }];
}


- (void)unclaimDevice {
    if (!self.selectedDevice) {
        NSLog(@"Error trying to unclaim the device. You must first select a device using one of the cloud actions.");
        return;
    }

    if (![self.selectedDevice.id isEqualToString:DEVICE_ID]) {
        NSLog(@"To run this action, make sure you select device using \"Select device by ID\" action. This way, after"
               " unclaiming the device, you will be able to reclaim it using \"Claim device with ID\" action.");
        return;
    }

    __weak ActionsViewController *wSelf = self;
    [self.selectedDevice unclaim:^(NSError *error) {
        if (!error) {
            __strong ActionsViewController *sSelf = wSelf;
            sSelf.selectedDevice = nil;
            NSLog(@"Device unclaimed");
        } else {
            NSLog(@"Unable to unclaim the device");
            NSLog(@"Error.localizedDescription = %@", error.localizedDescription);
        }
    }];
}


#pragma mark Particle Events

- (void)subscribeToEvents {
    if (_eventListenerID) {
        [self unsubscribeFromEvents];
    }

    _eventListenerID = [[ParticleCloud sharedInstance] subscribeToMyDevicesEventsWithPrefix:nil handler:^(ParticleEvent *event, NSError *error) {
        if (!error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Got event with name %@ and data %@", event.event, event.data);
            });
        }
        else
        {
            NSLog(@"Error occurred: %@", error.localizedDescription);
        }
    }];

    if (_eventListenerID) {
        //Update UI state
        [self updateUI];
        NSLog(@"Successfully subscribed to device events. Will receive all public and private events sent by your device fleet.");
    }
}


- (void)unsubscribeFromEvents {
    if (_eventListenerID) {
        [[ParticleCloud sharedInstance] unsubscribeFromEventWithID:_eventListenerID];
        _eventListenerID = nil;

        NSLog(@"Successfully unsubscribed from device events. Will no longer receive events sent by your device fleet.");
    }

    //Update UI state
    [self updateUI];

}




@end
