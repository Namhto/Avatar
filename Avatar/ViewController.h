//
//  ViewController.h
//  Avatar
//
//  Created by Projet 2A on 02/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CameraView.h"
#import "AvatarView.h"
#import <AVFoundation/AVFoundation.h>
#import "FaceDetection.h"

@interface ViewController : NSViewController {
    AVCaptureSession *session;
    AVCaptureConnection *video_connection;
    AVCaptureStillImageOutput *still_image;
}

@property (nonatomic, retain) IBOutlet CameraView *cameraView;
@property (nonatomic, retain) IBOutlet AvatarView *avatarView;
@property (weak) IBOutlet NSButton *start;
@property (weak) IBOutlet NSButton *stop;
@property (strong) NSImage *photos;
@property (strong) NSData *data;
@property FaceDetection *faceDetection;



- (void)startDetection;

- (void) initCapturSeesion;
- (void) photo:(NSTimer*) t;

- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;

@end

