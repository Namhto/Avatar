//
//  ViewController.h
//  Avatar
//
//  Created by Projet 2A on 02/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AvatarView.h"
#import <AVFoundation/AVFoundation.h>
#import "FaceDetection.h"

@interface ViewController : NSViewController {
    AVCaptureSession *session;
    AVCaptureConnection *video_connection;
    AVCaptureStillImageOutput *still_image;
}

@property (nonatomic, retain) IBOutlet AvatarView *avatarView;

@property (strong) NSImage *photos;
@property (strong) NSData *data;

@property FaceDetection *faceDetection;

@property (strong) IBOutlet NSButton *photo;

- (void)startDetection;

- (void) initCapturSeesion;
- (void) photo:(NSTimer*) t;

- (IBAction)takePicture:(id)sender;
- (IBAction)toggleAvatar:(id)sender;
- (IBAction)toggleCamera:(id)sender;
- (IBAction)toggleAvatarFill:(id)sender;

-(IBAction)Blanc:(id)sender;
-(IBAction)Bleu:(id)sender;
-(IBAction)Cyan:(id)sender;
-(IBAction)Gris:(id)sender;
-(IBAction)GrisFonce:(id)sender;
-(IBAction)Jaune:(id)sender;
-(IBAction)Magenta:(id)sender;
-(IBAction)Marron:(id)sender;
-(IBAction)Noir:(id)sender;
-(IBAction)Orange:(id)sender;
-(IBAction)Rouge:(id)sender;
-(IBAction)Vert:(id)sender;
-(IBAction)Violet:(id)sender;

- (IBAction)epaisseurFine:(id)sender;
- (IBAction)epaisseurNormale:(id)sender;
- (IBAction)epaisseurEpaisse:(id)sender;

-(IBAction)toCaptures:(id)sender;


@end

