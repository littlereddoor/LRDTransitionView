//
//  LRDTransitionView.m
//  ImageTransition
//
//  Created by Alan Morris on 07/01/2014.
//  Copyright (c) 2014 Little Red Door Ltd. All rights reserved.
//

#import "LRDTransitionView.h"

@interface LRDTransitionView ()
@property (nonatomic, weak)     UIImageView         *imageviewOne;
@property (nonatomic, weak)     UIImageView         *imageviewTwo;
@property (nonatomic, assign)   NSInteger           index;
@property (nonatomic, assign)   BOOL                isStopped;
@end

@implementation LRDTransitionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Create two image views to hold the two images that we will be transitioning between
        UIImageView *iv1 = [[UIImageView alloc] initWithFrame:frame];
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:iv1];
        [self addSubview:iv2];
        self.imageviewOne = iv1;
        self.imageviewTwo = iv2;
        
        // Default is to use non-random images
        self.randomise = NO;
        self.isStopped = NO;
    }
    return self;
}

-(void)animationOne
{
    // Pretty straightforward. Animate the alpha of the frontmost image out to zero, then move it behind the newly visible image, then make it visible again and set the next image on it
    [UIView animateWithDuration:self.transitionDuration delay:self.delayTime options:0 animations:^{
        [self.imageviewOne setAlpha:0];
    } completion:^(BOOL finished) {
        [self sendSubviewToBack:self.imageviewOne];
        [self.imageviewOne setImage:[self nextImage]];
        [self.imageviewOne setAlpha:1];
        if(!_isStopped)
        {
            [self animationTwo];
        }
    }];
}

-(void)animationTwo
{
    // Same as animation 1, but switch the imageviews around.
    [UIView animateWithDuration:self.transitionDuration delay:self.delayTime options:0 animations:^{
        [self.imageviewTwo setAlpha:0];
    } completion:^(BOOL finished) {
        [self sendSubviewToBack:self.imageviewTwo];
        [self.imageviewTwo setImage:[self nextImage]];
        [self.imageviewTwo setAlpha:1];
        if(!_isStopped)
        {
            [self animationOne];
        }
    }];
}

-(UIImage *)nextImage
{
    UIImage *image;
    
    if(_randomise)
    {
        // Return a random image from the array
        image = _images[arc4random_uniform([_images count])];
    }
    else
    {
        // Return the next image in the array
        
        // If we have displayed all of the images, go back to the first one in the array.
        if(self.index == [self.images count])
        {
            self.index = 0;
        }
        
        // Return the next image in the array, and increment for next time in.
        image = [self.images objectAtIndex:self.index];
        self.index ++;
    }
    
    return image;
}

-(void)start
{
    // Remove inhibit in case it has been set
    self.isStopped = NO;
    
    // Get out of here if the user has not supplied at least two images
    if([self.images count] < 2)
    {
        NSLog(@"ERROR: You must supply at least two images for transitioning between.");
        return;
    }
    
    // If the user hasn't set a transition time, use a default of 30 seconds.
    if(!_transitionDuration)
    {
        NSLog(@"WARNING: No transition time set, using default of 30 seconds.");
        self.transitionDuration = 30;
    }
    
    // If the user hasn't set a delay time, use a default of 5 seconds.
    if(!_delayTime)
    {
        NSLog(@"WARNING: No delay time set, using default of 5 seconds.");
        self.delayTime = 5;
    }
    
    // Set the two starting images
    [self.imageviewOne setImage:[self nextImage]];
    [self.imageviewTwo setImage:[self nextImage]];
    
    // Kick off the animations
    [self animationOne];
}

-(void)stop
{
    // Inhibit any further animations
    self.isStopped = YES;
}

@end
