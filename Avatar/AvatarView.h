//
//  AvatarView.h
//  Avatar
//
//  Created by Projet 2A on 03/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AvatarView : NSView

@property (strong) NSImage *image;
@property NSBezierPath *facesPath;

@property Boolean *showAvatar;
@property Boolean *showCamera;
@property Boolean *showAvatarFill;

@property (strong) NSColor *avatarColor;

@property CGFloat lineWidth;

- (void) takePicture;

@end
