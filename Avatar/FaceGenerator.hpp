//
//  FaceGenerator.hpp
//  Avatar
//
//  Created by Projet 2A on 03/05/2016.
//  Copyright © 2016 Projet 2A. All rights reserved.
//

#ifndef FaceGenerator_hpp
#define FaceGenerator_hpp

#include <stdio.h>
#include <string>
using namespace std;

class FaceGenerator
{
public:
    virtual void generateFace(string path, string predictor);
};

#endif /* FaceGenerator_hpp */
