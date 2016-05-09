//
//  FaceDetection.m
//  Avat
//
//  Created by Philippe Studer on 04/05/2016.
//  Copyright © 2016 Philippe Studer. All rights reserved.
//

#import "FaceDetection.h"
#include <vector>
#include "dlib/image_processing/full_object_detection.h"
#include "dlib/image_processing/frontal_face_detector.h"
#include "dlib/image_processing.h"
#include "dlib/serialize.h"
#include "dlib/image_io.h"
#include "ImageConverter.h"

using namespace dlib;


@implementation FaceDetection {
    frontal_face_detector detector;
    shape_predictor sp;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // We need a face detector.  We will use this to get bounding boxes for
        // each face in an image.
        detector = get_frontal_face_detector();
        // And we also need a shape_predictor.  This is the tool that will predict face
        // landmark positions given an image and face bounding box.  Here we are just
        // loading the model from the shape_predictor_68_face_landmarks.dat file you gave
        // as a command line argument.
        NSString *path = @"/Users/projet2a/Desktop/Avatar_2016/Avatar/shape_predictor_68_face_landmarks.dat";
        deserialize([path UTF8String]) >> sp;
    }
    return self;
}

- (NSBezierPath *)processImage:(NSImage *)image
{
    array2d<rgb_pixel> img;
    
    [ImageConverter convert:image : img];
    // Make the image larger so we can detect small faces.
    //pyramid_up(img);
    
    // Now tell the face detector to give us a list of bounding boxes
    // around all the faces in the image.
    std::vector<rectangle> dets = detector(img);
    std::cout << "Number of faces detected: " << dets.size() << std::endl;
    
    // Now we will go ask the shape_predictor to tell us the pose of
    // each face we detected.
    std::vector<full_object_detection> shapes;
    for (unsigned long j = 0; j < dets.size(); ++j)
    {
        full_object_detection shape = sp(img, dets[j]);
        std::cout << "number of parts: "<< shape.num_parts() << std::endl;
        std::cout << "pixel position of first part:  " << shape.part(0) << std::endl;
        std::cout << "pixel position of second part: " << shape.part(1) << std::endl;
        // You get the idea, you can get all the face part locations if
        // you want them.  Here we just store them in shapes so we can
        // put them on the screen.
        shapes.push_back(shape);
    }
    return [self renderFaceDetections:shapes offset:img.nr()];
}

- (NSBezierPath *)renderFaceDetections:(const std::vector<dlib::full_object_detection>&)dets offset:(long)offset {
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path setLineWidth:1.0f];
    
    for (unsigned long i = 0; i < dets.size(); ++i)
    {
        DLIB_CASSERT(dets[i].num_parts() == 68,
                     "\t std::vector<image_window::overlay_line> render_face_detections()"
                     << "\n\t Invalid inputs were given to this function. "
                     << "\n\t dets["<<i<<"].num_parts():  " << dets[i].num_parts()
                     );
        const dlib::full_object_detection& d = dets[i];
        
        [self path:path moveToPoint:d.part(0) offset:offset];
        for (unsigned long i = 1; i <= 16; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset];
        
        [self path:path moveToPoint:d.part(27) offset:offset];
        for (unsigned long i = 28; i <= 30; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset];
        
        [self path:path moveToPoint:d.part(17) offset:offset];
        for (unsigned long i = 18; i <= 21; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset];
        
        [self path:path moveToPoint:d.part(22) offset:offset];
        for (unsigned long i = 23; i <= 26; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset];
        
        [self path:path moveToPoint:d.part(30) offset:offset];
        for (unsigned long i = 31; i <= 35; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset];
        [self path:path lineToPoint:d.part(30) offset:offset];
        
        [self path:path moveToPoint:d.part(36) offset:offset];
        for (unsigned long i = 37; i <= 41; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset];
        [self path:path lineToPoint:d.part(36) offset:offset];
        
        [self path:path moveToPoint:d.part(42) offset:offset];
        for (unsigned long i = 43; i <= 47; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset];
        [self path:path lineToPoint:d.part(42) offset:offset];
        
        [self path:path moveToPoint:d.part(48) offset:offset];
        for (unsigned long i = 49; i <= 59; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset];
        [self path:path lineToPoint:d.part(48) offset:offset];
        
        [self path:path moveToPoint:d.part(60) offset:offset];
        for (unsigned long i = 61; i <= 67; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset];
        [self path:path lineToPoint:d.part(60) offset:offset];
    }
    return path;
}

- (void)path:(NSBezierPath *)path moveToPoint:(const point&)point offset:(long)offset
{
    [path moveToPoint:NSMakePoint(point.x(), (offset - point.y()))];
}

- (void)path:(NSBezierPath *)path lineToPoint:(const point&)point offset:(long)offset
{
    [path lineToPoint:NSMakePoint(point.x(), (offset - point.y()))];
}

@end
