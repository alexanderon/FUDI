//
//  Annotation.h
//  Restourant
//
//  Created by RAHUL on 9/15/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Annotation :NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong) NSString *title;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
