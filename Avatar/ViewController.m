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
        
    NSString *photoButtonPath = [[NSBundle mainBundle] pathForResource:@"photo" ofType:@"png"];
    
    [self.photo setImage:[[NSImage alloc] initWithContentsOfFile:photoButtonPath]];
    self.photos = [[NSImage alloc] init];
    self.faceDetection = [[FaceDetection alloc] init];
    
    [super viewDidLoad];
    [super viewWillAppear];
        
    [self initCapturSeesion];
    
    self.avatarView.showAvatar = true;
    self.avatarView.showCamera = true;
    
    [session startRunning];
    
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 0.05 target: self
                                                      selector: @selector(photo:) userInfo: nil repeats: YES];
}

- (void)startDetection{

    // Face detection
    NSString *path;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"file.JPG"]])
        path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"file.JPG"];
    else
        path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"init.JPG"];
        
    NSBezierPath *facesPath = [self.faceDetection processImage : path];
    self.avatarView.image = [[NSImage alloc] initWithContentsOfFile : path];
    
    // Update view
    
    self.avatarView.facesPath = facesPath;
    self.avatarView.needsDisplay = YES;
}

- (void) initCapturSeesion {

    session = [[AVCaptureSession alloc] init];
    
    if([session canSetSessionPreset:AVCaptureSessionPresetLow]) {
        [session setSessionPreset:AVCaptureSessionPresetLow];
    }
    
    AVCaptureDeviceInput *device_input = [[AVCaptureDeviceInput alloc] initWithDevice:
                                           [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo][0] error:nil];
    
    if([session canAddInput:device_input])
        [session addInput:device_input];
    
    still_image = [[AVCaptureStillImageOutput alloc] init];
    
    NSDictionary *output_settings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [still_image setOutputSettings : output_settings];
    
    [session addOutput:still_image];
    
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
    
    video_connection.automaticallyAdjustsVideoMirroring = NO;
    video_connection.videoMirrored = YES;
    
}

- (IBAction)takePicture:(id)sender {
    [self.avatarView takePicture];
}

- (void)photo : (NSTimer*) t {
    
    [still_image captureStillImageAsynchronouslyFromConnection:video_connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
         if(imageDataSampleBuffer != nil) {
             
             NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation: imageDataSampleBuffer];
             
             self.photos = [[NSImage alloc] initWithData:data];
             self.data = [[NSData alloc] initWithData:data];
         }
    }];
    
    [self.data writeToFile: [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"file.JPG"] atomically: NO];
    
    if(self.photos != nil)
        [self startDetection];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)Blanc:(id)sender{
    [self.avatarView setAvatarColor : [NSColor whiteColor]];
     }

- (IBAction)Bleu:(id)sender{
    [self.avatarView setAvatarColor : [NSColor blueColor]];
}

- (IBAction)Cyan:(id)sender{
    [self.avatarView setAvatarColor : [NSColor cyanColor]];
}

- (IBAction)Gris:(id)sender{
    [self.avatarView setAvatarColor : [NSColor grayColor]];
}


- (IBAction)GrisFonce:(id)sender{
    [self.avatarView setAvatarColor : [NSColor darkGrayColor]];
}

- (IBAction)Jaune:(id)sender{
    [self.avatarView setAvatarColor : [NSColor yellowColor]];
}

- (IBAction)Magenta:(id)sender{
    [self.avatarView setAvatarColor : [NSColor magentaColor]];
}

- (IBAction)Marron:(id)sender{
    [self.avatarView setAvatarColor : [NSColor brownColor]];
}

- (IBAction)Noir:(id)sender{
    [self.avatarView setAvatarColor : [NSColor blackColor]];
}

- (IBAction)Orange:(id)sender{
    [self.avatarView setAvatarColor : [NSColor orangeColor]];
}

- (IBAction)Rouge:(id)sender{
    [self.avatarView setAvatarColor:[NSColor redColor]];
}

- (IBAction)Vert:(id)sender{
    [self.avatarView setAvatarColor:[NSColor greenColor]];
}

- (IBAction)Violet:(id)sender{
    [self.avatarView setAvatarColor:[NSColor purpleColor]];
}


- (IBAction)toggleAvatar:(id)sender {
    if(self.avatarView.showAvatar)
        [self.avatarView setShowAvatar : false];
    else
        [self.avatarView setShowAvatar : true];
}

- (IBAction)toggleCamera:(id)sender {
    if(self.avatarView.showCamera)
        [self.avatarView setShowCamera : false];
    else
        [self.avatarView setShowCamera : true];
}
@end
