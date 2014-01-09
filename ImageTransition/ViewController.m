//
//  ViewController.m
//  ImageTransition
//
//  Created by Alan Morris on 07/01/2014.
//  Copyright (c) 2014 Little Red Door Ltd. All rights reserved.
//

#import "ViewController.h"
#import "LRDTransitionView.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet        UISlider            *transitionSlider;
@property (nonatomic, weak) IBOutlet        UISlider            *delaySlider;
@property (nonatomic, weak) IBOutlet        UILabel             *transitionValueLabel;
@property (nonatomic, weak) IBOutlet        UILabel             *delayValueLabel;
@property (nonatomic, weak) IBOutlet        UIButton            *startButton;
@property (nonatomic, weak) IBOutlet        UIButton            *stopButton;

@property (nonatomic, strong)               LRDTransitionView   *transitionView;

-(IBAction)sliderValueDidChange:(id)sender;
-(IBAction)startButtonTapped:(id)sender;
-(IBAction)stopButtonTapped:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Create an array of images to be used with the transition view
    UIImage *image1 = [UIImage imageNamed:@"blur1.png"];
    UIImage *image2 = [UIImage imageNamed:@"blur2.png"];
    UIImage *image3 = [UIImage imageNamed:@"blur3.png"];
    UIImage *image4 = [UIImage imageNamed:@"blur4.png"];
    UIImage *image5 = [UIImage imageNamed:@"blur5.png"];
    NSArray *images = @[image1, image2, image3, image4, image5];
    
    
    LRDTransitionView *transitionView = [[LRDTransitionView alloc] initWithFrame:self.view.frame];  // Create the transition view, fullscreen size
    self.transitionView = transitionView;
    
    [self.view addSubview:_transitionView];                                                          // Make the transition view visible
    [self.view sendSubviewToBack:_transitionView];
    [_transitionView setImages:images];                                                              // Pass the array of images to the transition view
    [_transitionView setTransitionDuration:3.0f];                                                    // Set the duration of the transition
    [_transitionView setDelayTime:4.0f];                                                             // Set the time between transitions
    [_transitionView setRandomise:YES];                                                              // Randomise the order that the images are displayed in
    [_transitionView start];                                                                         // Start the transitions
    
    
    [self.transitionValueLabel setText:[NSString stringWithFormat:@"%.1f", _transitionSlider.value]];
    [self.delayValueLabel setText:[NSString stringWithFormat:@"%.1f", _delaySlider.value]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI 

-(void)sliderValueDidChange:(id)sender
{
    if(sender == self.transitionSlider)
    {
        [_transitionView setTransitionDuration:_transitionSlider.value];
        [self.transitionValueLabel setText:[NSString stringWithFormat:@"%.1f", _transitionSlider.value]];
    }
    else if(sender == self.delaySlider)
    {
        [_transitionView setDelayTime:_delaySlider.value];
        [self.delayValueLabel setText:[NSString stringWithFormat:@"%.1f", _delaySlider.value]];
    }
}

-(void)startButtonTapped:(id)sender
{
    [_transitionView start];
}

-(void)stopButtonTapped:(id)sender
{
    [_transitionView stop];
}

@end
