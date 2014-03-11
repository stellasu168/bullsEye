//
//  BullsEyeViewController.h
//  BullsEye
//
//  Created by Stella Su on 2/24/14.
//  Copyright (c) 2014 Stella Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BullsEyeViewController : UIViewController

// An outlet named slider that can be connected to a UISlider object.
@property (nonatomic, weak) IBOutlet UISlider *slider;
@property (nonatomic, weak) IBOutlet UILabel *targetLabel;
@property (nonatomic, weak) IBOutlet UILabel *scorelabel;
@property (nonatomic, weak) IBOutlet UILabel *roundLabel;

- (IBAction)showAlert;
- (IBAction)sliderMoved:(UISlider *)slider;
- (IBAction)startOver;

@end
