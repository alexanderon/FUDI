//
//  Database.h
//  MyDatabaseDemo
//
//  Created by NTechnosoft on 14/03/15.
//  Copyright (c) 2015 NTechnosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Database : NSObject


+(Database*)getInstance;

- (BOOL)createEditableCopyOfDatabaseIfNeeded;
//- (NSMutableArray *)fetchColumnNames:(NSString *)tableName;
- (NSArray *)Select:(NSString *)tableName;

-(void)Insert:(NSString *)firstname LastName:(NSString *)lastname Email:(NSString *)email Mobile:(NSString *)mobile Password:(NSString *)password;

-(void)Del:(int)uniqueId;

-(void)Update:(NSString *)firstname LastName:(NSString *)lastname Email:(NSString *)email Mobile:(NSString *)mobile Password:(NSString *)password UniqueId:(int)uniqueId;

-(int)validateUser:(NSString *)email Password:(NSString *)password;
-(int)validateUser:(NSString *)email;


@end
