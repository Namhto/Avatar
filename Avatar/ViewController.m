//
//  ViewController.m
//  Avatar
//
//  Created by Projet 2A on 02/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation ViewController


- (void)viewWillAppear {
    
    self.photos = [[NSImage alloc] init];
    self.faceDetection = [[FaceDetection alloc] init];
    
    //NSImage *image = [[NSImage alloc] initWithContentsOfFile:@"/Users/projet2a/Desktop/file.JPG"];
    //self.avatarView.image = image;

    [super viewDidLoad];
    [super viewWillAppear];
    
    [self.cameraView initView];
    [self initCapturSeesion];
}

- (void)startDetection{

    // Face detection
    NSBezierPath *facesPath = [self.faceDetection processImage:@"/Users/projet2a/Desktop/file.JPG"];
    self.avatarView.image = [[NSImage alloc] initWithContentsOfFile:@"/Users/projet2a/Desktop/file.JPG"];
    
    // Update view
    
    self.avatarView.facesPath = facesPath;
    self.avatarView.needsDisplay = YES;
}

- (void) initCapturSeesion {

    session = [[AVCaptureSession alloc] init];
    
    if([session canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        [session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    AVCaptureDeviceInput *device_input = [[AVCaptureDeviceInput alloc] initWithDevice:
                                           [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo][0] error:nil];
    
    if([session canAddInput:device_input])
        [session addInput:device_input];
    
    still_image = [[AVCaptureStillImageOutput alloc] init];
    
    NSDictionary *output_settings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [still_image setOutputSettings : output_settings];
    
    [session addOutput:still_image];
}

- (IBAction)start:(id)sender {
    [session startRunning];
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 0.05 target: self
                                                      selector: @selector(photo:) userInfo: nil repeats: YES];
}

- (IBAction)stop:(id)sender {
    [session stopRunning];
}

- (void)photo : (NSTimer*) t {

    video_connection = nil;
    
    for(AVCaptureConnection *connection in still_image.connections) {
        for(AVCaptureInputPort *port in [connection inputPorts]) {
            if([[port mediaType] isEqual: AVMediaTypeVideo]) {
                video_connection = connection;
                break;
            }
            
        }
        
        if(video_connection)
            break;
    }
    
    [still_image captureStillImageAsynchronouslyFromConnection:video_connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
         if(imageDataSampleBuffer != nil) {
             
             NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation: imageDataSampleBuffer];
             
             self.photos = [[NSImage alloc] initWithData:data];
             self.data = [[NSData alloc] initWithData:data];
         }
    }];
    
    [self.cameraView drawImage: self.photos];
    [self.data writeToFile: @"/Users/projet2a/Desktop/file.JPG" atomically: NO];
    
    if(self.photos != nil)
        [self startDetection];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
