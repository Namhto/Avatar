//
//  ViewController.m
//  Avatar
//
//  Created by Projet 2A on 02/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "FaceGenerator.hpp"

@implementation ViewController


- (void)viewWillAppear {
    
    self.photos = [[NSMutableArray alloc] init];

    [super viewDidLoad];
    [super viewWillAppear];
    
    [self.avatarView initView];
    [self initCapturSeesion];
    [self setUpPreviewLayer];
}

- (void) viewDidLoad {

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
}

- (void) setUpPreviewLayer {
    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    
    [[self previewLayer] setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [[self previewLayer] setFrame:self.cameraView.bounds];
    [self.cameraView.layer addSublayer:self.previewLayer];
    
    still_image = [[AVCaptureStillImageOutput alloc] init];
    
    NSDictionary *output_settings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [still_image setOutputSettings : output_settings];
    
    [session addOutput:still_image];
}

- (IBAction)start:(id)sender {
    [session startRunning];
}

- (IBAction)stop:(id)sender {
    [session stopRunning];
    [self.avatarView drawImage:nil];
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
             
             [self.photos addObject: img];
         }
    }];
    
    [self.avatarView drawImage:[self.photos lastObject]];
}

- (IBAction) takePicture:(id)sender {
    
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self //60fps
                                                      selector: @selector(photo:) userInfo: nil repeats: YES];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
    
    // FaceGenerator fg;
}

@end
