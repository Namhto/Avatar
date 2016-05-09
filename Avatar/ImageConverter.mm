//
//  ImageConverter.m
//  Avatar
//
//  Created by Projet 2A on 09/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#import "ImageConverter.h"

using namespace dlib;

@implementation ImageConverter

const unsigned char* get_row( unsigned long i )
{
    return &data[i*width_*output_components_];
}

void read_image( const char* filename );
unsigned long height_;
unsigned long width_;
unsigned long output_components_;
std::vector<unsigned char> data;

+ (void) convert : (NSImage*) img : (array2d<rgb_pixel>) pixels_array {
        
    NSBitmapImageRep *rep = [[img representations] objectAtIndex:0];
    
    NSColor* color;
    
    image_view<array2d<rgb_pixel>> t(pixels_array);
    
    t.set_size(rep.pixelsHigh, rep.pixelsWide);
    
    for(int i=0; i < rep.pixelsHigh; i++) {
        for(int j=0; j < rep.pixelsWide; j++) {
            
            color = [rep colorAtX:j y:i];
            
            rgb_pixel p;
            p.red = [color redComponent];
            p.green = [color greenComponent];
            p.blue = [color blueComponent];
            
            assign_pixel( t[i][j], p );
        }
    }
}

@end
