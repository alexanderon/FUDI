//
//  AnnotationView.h
//  MKMapViewTutorial
//
//  Created by DilumNavanjana on 19/10/14.
//  Copyright (c) 2014 Dilum Navanjana. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface AnnotationView : MKAnnotationView
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event;
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event;
@end
