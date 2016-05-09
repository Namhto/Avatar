//
//  AvatarView.m
//  Avatar
//
//  Created by Projet 2A on 03/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#import "AvatarView.h"

@implementation AvatarView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [[NSColor whiteColor] setFill];
    [NSBezierPath fillRect:self.bounds];
    
    // Drawing code here.
    /*if (self.image != nil) {
        NSImageRep *rep = [[self.image representations] objectAtIndex:0];
        NSSize imageSize = NSMakeSize(rep.pixelsWide, rep.pixelsHigh);
        [self.image drawInRect:NSMakeRect(0.0, 0.0, imageSize.width, imageSize.height)];
    }*/
    
    if (self.facesPath != nil) {
        [[NSColor blackColor] setStroke];
        [self.facesPath stroke];
    }
}

@end