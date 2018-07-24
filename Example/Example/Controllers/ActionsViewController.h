//
// Created by Raimundas Sakalauskas on 19/07/2018.
// Copyright (c) 2018 Particle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActionsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *eventsCellLabel;

@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceIdLabel2;

@property (weak, nonatomic) IBOutlet UILabel *variableNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *functionNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *renameLabel;



@end
