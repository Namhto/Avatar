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

    [super viewDidLoad];
    [super viewWillAppear];
    
    [self.cameraView initView];
    [self initCapturSeesion];
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
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self
                                                      selector: @selector(photo:) userInfo: nil repeats: YES];
}

- (IBAction)stop:(id)sender {
    [self.cameraView drawImage:nil];
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
             NSImage *img = [[NSImage alloc] initWithData:data];
             
             self.photos = img;
         }
    }];
    
    [self.cameraView drawImage: self.photos];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
