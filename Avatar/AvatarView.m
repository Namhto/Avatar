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
    if(self.showCamera)
        if (self.image != nil) {
            [self.image drawInRect:NSMakeRect(0.0, 0.0, self.bounds.size.width, self.bounds.size.height)];
        }
    
    if(self.showAvatar)
        if (self.facesPath != nil) {
           // [[NSColor redColor] setStroke];
            [self.avatarColor setStroke];
            [self.facesPath stroke];
        }
}

- (void) takePicture {
    
    NSImage *screen = [[NSImage alloc] initWithData:[self dataWithPDFInsideRect:[self bounds]]];
    
    NSData *data = [screen TIFFRepresentation];
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Captures/"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ss-mm-hh-ddmmyyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:[[NSDate alloc] init]];
    
    NSString *res = [[path stringByAppendingString:stringFromDate] stringByAppendingString:@".png"];
    [data writeToFile: res atomically:NO];
}

@end