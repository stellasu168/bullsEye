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
    int _score;
    int _round;
}

// First time
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self startNewGame];
    [self updateLabels];
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal
                      forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted
                      forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"]
                               resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    
    [self.slider setMinimumTrackImage:trackLeftImage
                             forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    
    [self.slider setMaximumTrackImage:trackRightImage
                             forState:UIControlStateNormal];
}

// Reset the slider to 50 and calculate a new random number. Lather, rinse, repeat.
- (void)startNewRound
{
    _round += 1;
    _targetValue = 1 + arc4random_uniform(100);
    _currentValue = 50;
    // Ask the slider for its value through self.slider.value
    self.slider.value = _currentValue;
    
}

- (void)startNewGame
{
    _score = 0;
    _round = 0;
    [self startNewRound];
}

- (void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d", _targetValue];
    self.scorelabel.text = [NSString stringWithFormat:@"%d", _score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", _round];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert
{
    
    int difference = abs(_targetValue - _currentValue);
    int points = 100 - difference;
    
    NSString *title;
    if (difference == 0) {
        title = @"Perfect!";
        points += 100;
    } else if (difference < 5) {
        title = @"You almost had it!";
        if (difference == 1) {
            points += 50;
        }
    } else if (difference < 10) {
        title = @"Pretty good!";
    } else {
        title = @"Not even close...";
    }
    
    _score += points;
    
    // NSString is the iPhone's string object. A new string object is named message.
    // The * is used because NSString is an object and objects have an * in their name
    // %d is used for integer values.
    NSString *message = [NSString stringWithFormat:
                         @"You scored %d points", points];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
    
}

- (IBAction)sliderMoved:(UISlider *)slider
{
    _currentValue = lroundf(slider.value);
}

- (IBAction)startOver
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

- (void)alertView:(UIAlertView *)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
