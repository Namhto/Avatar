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
    
    // Drawing code here.
    [[NSColor whiteColor] setFill];
    [NSBezierPath fillRect:self.bounds];
}

@end
