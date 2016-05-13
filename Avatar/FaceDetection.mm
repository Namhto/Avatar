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

using namespace dlib;


@implementation FaceDetection {
    frontal_face_detector detector;
    shape_predictor sp;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        detector = get_frontal_face_detector();
        
        NSString *path = @"/Users/projet2a/Desktop/Avatar/Avatar/shape_predictor_68_face_landmarks.dat";
        deserialize([path UTF8String]) >> sp;
    }
    return self;
}

- (NSBezierPath *)processImage :(NSString *)imagePath
{
    array2d<rgb_pixel> img;
    
    load_image(img, [imagePath UTF8String]);
    
    std::vector<rectangle> dets = detector(img);
    std::cout << "Number of faces detected: " << dets.size() << std::endl;
    
    std::vector<full_object_detection> shapes;
    for (unsigned long j = 0; j < dets.size(); ++j)
    {
        full_object_detection shape = sp(img, dets[j]);
        std::cout << "number of parts: "<< shape.num_parts() << std::endl;
        std::cout << "pixel position of first part:  " << shape.part(0) << std::endl;
        std::cout << "pixel position of second part: " << shape.part(1) << std::endl;
        
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
            [self path:path lineToPoint:d.part(i) offset:offset]; // Courbe du contour du visage
        
        [self path:path moveToPoint:d.part(27) offset:offset];
        for (unsigned long i = 28; i <= 30; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // Ligne du nez
        
        [self path:path moveToPoint:d.part(17) offset:offset];
        for (unsigned long i = 18; i <= 21; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // sourcil
        
        [self path:path moveToPoint:d.part(22) offset:offset];
        for (unsigned long i = 23; i <= 26; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // sourcil
        
        [self path:path moveToPoint:d.part(30) offset:offset];
        for (unsigned long i = 31; i <= 35; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // dessine le nez
        [self path:path lineToPoint:d.part(30) offset:offset]; // lie le nez au sourcil sans cette ligne
        
        [self path:path moveToPoint:d.part(36) offset:offset];
        for (unsigned long i = 37; i <= 41; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // oeil
        [self path:path lineToPoint:d.part(36) offset:offset]; // lien oeil nez sans cette ligne
        
        [self path:path moveToPoint:d.part(42) offset:offset];
        for (unsigned long i = 43; i <= 47; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; //oeil
        [self path:path lineToPoint:d.part(42) offset:offset]; // lien oeil nez sans cette ligne
        
        [self path:path moveToPoint:d.part(48) offset:offset];
        for (unsigned long i = 49; i <= 59; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // Courbe du contour des lèvres
        [self path:path lineToPoint:d.part(48) offset:offset]; // lien oeil bouche sans cette ligne
        
        [self path:path moveToPoint:d.part(60) offset:offset];
        for (unsigned long i = 61; i <= 67; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // ligne intérieur lèvre : bouche
        [self path:path lineToPoint:d.part(60) offset:offset]; // lien courbe extérieure et intérieure bouche sans cette ligne
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



//Ajout pout remplir l'avatar

- (NSBezierPath *)processImageForFill :(NSString *)imagePath
{
    array2d<rgb_pixel> img;
    
    load_image(img, [imagePath UTF8String]);
    
    std::vector<rectangle> dets = detector(img);
    std::cout << "Number of faces detected: " << dets.size() << std::endl;
    
    std::vector<full_object_detection> shapes;
    for (unsigned long j = 0; j < dets.size(); ++j)
    {
        full_object_detection shape = sp(img, dets[j]);
        std::cout << "number of parts: "<< shape.num_parts() << std::endl;
        std::cout << "pixel position of first part:  " << shape.part(0) << std::endl;
        std::cout << "pixel position of second part: " << shape.part(1) << std::endl;
        
        shapes.push_back(shape);
    }
    return [self renderFaceDetectionsForFill:shapes offset:img.nr()];
}



- (NSBezierPath *)renderFaceDetectionsForFill:(const std::vector<dlib::full_object_detection>&)dets offset:(long)offset {
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
        
        //Ajout
        NSPoint pt1 = NSMakePoint(d.part(0).x(),d.part(0).y()-40);
        [self path:path lineToNSPoint:pt1 offset:offset]; // Permet de metre 1 point suplémentaire a 40px plus haut
        //Fin ajout
        
        for (unsigned long i = 1; i <= 16; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // Courbe du contour du visage
        
        // Ajout
        NSPoint pt2 = NSMakePoint(d.part(16).x(),d.part(16).y()-40);
        [self path:path lineToNSPoint:pt2 offset:offset]; // Permet de metre 1 point suplémentaire a 40px plus haut
        [self path:path lineToNSPoint:pt1 offset:offset];
        // Fin ajout
        
        [self path:path moveToPoint:d.part(27) offset:offset];
        for (unsigned long i = 28; i <= 30; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // Ligne du nez
        
        [self path:path moveToPoint:d.part(17) offset:offset];
        for (unsigned long i = 18; i <= 21; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // sourcil
        
        [self path:path moveToPoint:d.part(22) offset:offset];
        for (unsigned long i = 23; i <= 26; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // sourcil
        
        [self path:path moveToPoint:d.part(30) offset:offset];
        for (unsigned long i = 31; i <= 35; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // dessine le nez
        [self path:path lineToPoint:d.part(30) offset:offset]; // lie le nez au sourcil sans cette ligne
        
        [self path:path moveToPoint:d.part(36) offset:offset];
        for (unsigned long i = 37; i <= 41; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // oeil
        [self path:path lineToPoint:d.part(36) offset:offset]; // lien oeil nez sans cette ligne
        
        [self path:path moveToPoint:d.part(42) offset:offset];
        for (unsigned long i = 43; i <= 47; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; //oeil
        [self path:path lineToPoint:d.part(42) offset:offset]; // lien oeil nez sans cette ligne
        
        [self path:path moveToPoint:d.part(48) offset:offset];
        for (unsigned long i = 49; i <= 59; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // Courbe du contour des lèvres
        [self path:path lineToPoint:d.part(48) offset:offset]; // lien oeil bouche sans cette ligne
        
        [self path:path moveToPoint:d.part(60) offset:offset];
        for (unsigned long i = 61; i <= 67; ++i)
            [self path:path lineToPoint:d.part(i) offset:offset]; // ligne intérieur lèvre : bouche
        [self path:path lineToPoint:d.part(60) offset:offset]; // lien courbe extérieure et intérieure bouche sans cette ligne
    }
    return path;
}


//Ajout pour ajouter à la courbe de Bezier des NSPoint
- (void)path:(NSBezierPath *)path lineToNSPoint:(NSPoint)point offset:(long)offset
{
    [path lineToPoint:NSMakePoint(point.x, (offset - point.y))];
}

@end
