//
//  ImageConverter.h
//  Avatar
//
//  Created by Projet 2A on 09/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <vector>
#include "dlib/image_processing/full_object_detection.h"
#include "dlib/image_processing/frontal_face_detector.h"
#include "dlib/image_processing.h"
#include "dlib/serialize.h"
#include "dlib/image_io.h"
#include "load_image_abstract.h"
#include "png_loader.h"
#include "jpeg_loader.h"
#include "image_loader.h"
#include <fstream>


using namespace dlib;


@interface ImageConverter : NSObject

+ (void) convert : (NSImage*) img : (array2d<rgb_pixel>) pixels_array;

@end
