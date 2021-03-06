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
    
    //NSImage *image = [[NSImage alloc] initWithContentsOfFile:@"/Users/projet2a/Desktop/file.JPG"];
    //self.avatarView.image = image;
    
    [super viewDidLoad];
    [super viewWillAppear];
    
    [self initCapturSeesion];
    
    self.avatarView.showAvatar = true;
    self.avatarView.showCamera = true;
    self.avatarView.showAvatarFill = false;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *folderURL = [documentsDirectory stringByAppendingString:@"/Captures Avatar/"];
    
    BOOL isDir;
    NSFileManager *fileManager= [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:folderURL isDirectory:&isDir])
        [fileManager createDirectoryAtPath:folderURL withIntermediateDirectories:YES attributes:nil error:NULL];
    
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
    
    //Ajout du if
    if(self.avatarView.showAvatarFill == true && self.avatarView.showAvatar==false){
        
        NSBezierPath *facesPath = [self.faceDetection processImageForFill : path];
        self.avatarView.image = [[NSImage alloc] initWithContentsOfFile : path];
        
        // Update view
        
        self.avatarView.facesPath = facesPath;
        self.avatarView.needsDisplay = YES;
    }
    else{
        NSBezierPath *facesPath = [self.faceDetection processImage : path];
        self.avatarView.image = [[NSImage alloc] initWithContentsOfFile : path];
        
        // Update view
        
        self.avatarView.facesPath = facesPath;
        self.avatarView.needsDisplay = YES;
    }
    
    
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
        [self.avatarView setShowAvatarFill:false];
    [self.avatarView setShowAvatar : true];
}

- (IBAction)toggleCamera:(id)sender {
    if(self.avatarView.showCamera)
        [self.avatarView setShowCamera : false];
    else
        [self.avatarView setShowCamera : true];
}

- (IBAction)toggleAvatarFill:(id)sender{
    if(self.avatarView.showAvatarFill){
        [self.avatarView setShowAvatarFill: false];
    }
    else{
        [self.avatarView setShowAvatar : false];
        [self.avatarView setShowAvatarFill : true];
    }
}

- (IBAction)epaisseurFine:(id)sender{
    [self.avatarView setLineWidth : 1];
}

- (IBAction)epaisseurNormale:(id)sender{
    [self.avatarView setLineWidth : 2.5];
}

- (IBAction)epaisseurEpaisse:(id)sender{
    [self.avatarView setLineWidth : 5];
}

-(IBAction)toCaptures:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *folderURL = [NSURL fileURLWithPath: [documentsDirectory stringByAppendingString:@"/Captures Avatar/"]];
    [[NSWorkspace sharedWorkspace] openURL: folderURL];
}
@end
