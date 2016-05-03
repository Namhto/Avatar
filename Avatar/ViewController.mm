//
//  ViewController.m
//  Avatar
//
//  Created by Projet 2A on 02/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#import "ViewController.h"
#import "FaceGenerator.hpp"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
    
    FaceGenerator fg;
    
    fg.generateFace("../../../dlib-18.18/examples/faces/2007_007763.jpg", "../../../dlib-18.18/examples/build/shape_predictor_68_face_landmark.dat");
    
}

@end
