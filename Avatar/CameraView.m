//
//  CammeraView.m
//  Avatar
//
//  Created by Projet 2A on 03/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#import "CameraView.h"

@implementation CameraView

NSImageView *view;

- (void) drawRect:(NSRect)dirtyRect {
    [[NSColor blackColor] setFill];
    [NSBezierPath fillRect:self.bounds];
}

- (void) initView {
    
    view = [[NSImageView alloc] initWithFrame:self.bounds];
    [self addSubview:view];
}

- (void) drawImage : (NSImage *) img {
    
    [view setImage : img];
}

@end
