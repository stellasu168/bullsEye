//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by Stella Su on 2/24/14.
//  Copyright (c) 2014 Stella Su. All rights reserved.
//

#import "BullsEyeViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController
{
    // _currentValue is an instance variable. The scope is the same as the scope of the object
    int _currentValue;
    int _targetValue;
}

// First time
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self startNewRound];
    [self updateLabels];
}

// Reset the slider to 50 and calculate a new random number. Lather, rinse, repeat.
- (void)startNewRound
{
    _targetValue = 1 + arc4random_uniform(100);
    _currentValue = 50;
    // Ask the slider for its value through self.slider.value
    self.slider.value = _currentValue;
}

- (void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d", _targetValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert
{
    // NSString is the iPhone's string object. A new string object is named message.
    // The * is used because NSString is an object and objects have an * in their name
    // %d is used for integer values.
    NSString *message = [NSString stringWithFormat:
                         @"The value of the slider is: %d\nThe target value is: %d", _currentValue, _targetValue];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Hello, World"
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
    
    // Calling this method while showing the alert.
    [self startNewRound];
    [self updateLabels];
}

- (IBAction)sliderMoved:(UISlider *)slider
{
    _currentValue = lroundf(slider.value);
}

@end
