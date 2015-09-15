//
//  DataClass.m
//  Restourant
//
//  Created by RAHUL on 9/7/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "DataClass.h"

@implementation DataClass

static DataClass *instance = nil;

+ (DataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [DataClass new];
        }
    }
    return instance;
}

@end
