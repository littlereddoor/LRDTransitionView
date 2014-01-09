//
//  LRDTransitionView.h
//  ImageTransition
//
//  Created by Alan Morris on 07/01/2014.
//  Copyright (c) 2014 Little Red Door Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRDTransitionView : UIView

// An NSArray of images to be transitioned between
// The array must contain at least two images
@property (nonatomic, strong)       NSArray         *images;

// Number of seconds between an image starting to fade out, and the image being fully faded out
// Default: 30 seconds
@property (nonatomic, assign)       CGFloat         transitionDuration;

// Number of seconds to delay between an image being fully faded out, and the next image starting to fade out
// Default: 5 seconds
@property (nonatomic, assign)       CGFloat         delayTime;

// Whether to randomise the order that the images are displayed in
@property (nonatomic, assign)       BOOL            randomise;


// Create an instance with a given frame
-(id)initWithFrame:(CGRect)frame;

// Start the transitions
-(void)start;

// Stop any further transitions from starting, after the completion of the currently running transition
-(void)stop;

@end
