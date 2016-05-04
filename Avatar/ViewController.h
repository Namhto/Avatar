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

@interface ViewController : NSViewController {
    AVCaptureSession *session;
    AVCaptureConnection *video_connection;
    AVCaptureStillImageOutput *still_image;
}

@property (nonatomic, retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, retain) IBOutlet CameraView *cameraView;
@property (nonatomic, retain) IBOutlet NSImageView *avatarView;
@property (nonatomic, retain) IBOutlet NSView *start;
@property (nonatomic, retain) IBOutlet NSView *stop;
@property (nonatomic, retain) IBOutlet NSView *photo;

- (void) initCapturSeesion;
- (void) setUpPreviewLayer;
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)takePicture:(id)sender;

@end

