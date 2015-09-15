//
//  Annotation.m
//  Restourant
//
//  Created by RAHUL on 9/15/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
@synthesize coordinate;


-(id)initWithLocation:(CLLocationCoordinate2D)coord{
    self =[super init];
    if(self){
        coordinate =coord;
    }
    return  self;
}
@end
