//
//  JsonData.h
//  Restourant
//
//  Created by RAHUL on 9/8/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonData : NSObject

@property (strong,nonatomic)   NSMutableArray* venues;
@property (strong,nonatomic)   NSMutableArray* stats;
@property (strong, nonatomic)   NSMutableArray* allTableData;
@property (strong, nonatomic)   NSMutableArray* filteredTableData;
@property (atomic)  BOOL isfilterd;


@end
