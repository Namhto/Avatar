//
//  AvatarView.m
//  Avatar
//
//  Created by Projet 2A on 03/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#import "AvatarView.h"

@implementation AvatarView

NSImageView *view;

- (void) drawRect:(NSRect)dirtyRect {
}

- (void) initView {
    
    view = [[NSImageView alloc] initWithFrame:self.bounds];
    [self addSubview:view];

}

- (void) drawImage : (NSImage *) img {
    
    if(img != nil)
        [view setImage : img];
}

@end