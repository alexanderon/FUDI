//
//  Database.m
//  MyDatabaseDemo
//
//  Created by NTechnosoft on 14/03/15.
//  Copyright (c) 2015 NTechnosoft. All rights reserved.
//

#import "Database.h"
#import "DataClass.h"

static NSString *filename = @"Restourant.sqlite";
static Database *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation Database


#pragma mark = init
-(id)init
{
    return self;
}

#pragma mark - Create instance
+(Database*)getInstance
{
    if (!sharedInstance)
    {
        sharedInstance = [[super allocWithZone:NULL]init];
        
        [sharedInstance createEditableCopyOfDatabaseIfNeeded];
        
    }
    return sharedInstance;
}

#pragma mark - Copy Database if needed
- (BOOL)createEditableCopyOfDatabaseIfNeeded
{
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:filename];
    NSLog(@"%@",writableDBPath);
    
    
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
        return success;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    NSLog(@"%@",defaultDBPath);
    return success;
}

#pragma mark - Open Database
-(BOOL)openDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:filename];
    const char *dbpath = [databasePath UTF8String];
    NSLog(@"%d",sqlite3_open(dbpath, &database) );
    return (sqlite3_open(dbpath, &database) == SQLITE_OK);
    
}

#pragma mark - Close Database
-(void)closeDB
{
    sqlite3_reset(statement);
    sqlite3_close(database);
}

#pragma mark-Fetch column names from the table

#pragma mark - Select all records

- (NSArray *)Select:(NSString *)tableName{
    NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
   // int count=0;
    
    if ([self openDB])
    {
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        NSLog(@"%d",SQLITE_OK );
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) != SQLITE_OK)
        {
            NSLog(@"not successfull");
        }
        else
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                do
                {
                    NSMutableDictionary *row = [NSMutableDictionary dictionary];
                    for (int i=0; i<sqlite3_column_count(statement); i++)
                    {
                        NSString *col = [NSString stringWithFormat:@"%s",sqlite3_column_name(statement, i)];
                        NSString *value = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, i)];;
                        [row setObject:value forKey :col];
                    }
                    [resultArray addObject:row];
                }   while (sqlite3_step(statement) == SQLITE_ROW);
                [self closeDB];
            //    NSLog(@"%@",resultArray);
                return resultArray;
            }
        }
    }
    [self closeDB];
  //  return NO;
    return NULL;
}




#pragma mark - Insert data to the Table


-(void)Insert:(NSString *)firstname LastName:(NSString *)lastname Email:(NSString *)email Mobile:(NSString *)mobile Password:(NSString *)password{
   
    NSString *querySQL = [NSString stringWithFormat:@"Insert into UserInfo(userFirstName,userLastName,userEmail,userMobile,userPassword)  values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",firstname ,lastname,email,mobile,password];
    
    if ([self openDB])
    {
        const char *query_stmt = [querySQL UTF8String];
        
        NSLog(@"%d",sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL));
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"successfull");
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                [self closeDB];
                
            }
            
            
            
        }
        else
        {
            NSLog(@"not successfull");
            [self closeDB];
        }
        
        
        
    }
    
    
}

#pragma mark - Check for Duplication

#pragma mark - Update data from the Table

-(void)Update:(NSString *)firstname LastName:(NSString *)lastname Email:(NSString *)email Mobile:(NSString *)mobile Password:(NSString *)password UniqueId:(int)uniqueId{
    
    NSString *querySQL = [NSString stringWithFormat:@"Update UserInfo set userFirstName=\"%@\",userLastName=\"%@\",userEmail=\"%@\",userMobile=\"%@\",userPassword=\"%@\" where userId=%d",firstname,lastname,email,mobile,password,uniqueId];
    
    NSLog(@"%@",querySQL);
    
    if ([self openDB])
    {
        const char *query_stmt = [querySQL UTF8String];
        
        NSLog(@"%d",sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL));
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"successfull");
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                [self closeDB];
                
            }
            
        }
        else
        {
            NSLog(@"not successfull");
            [self closeDB];
        }
        
        
    }
    
}


#pragma mark - Delete data from the Table


-(void)Del:(int)uniqueId
{
    NSString *querySQL = [NSString stringWithFormat:@"Delete from UserInfo where Stud_id=%d",uniqueId];
    
    NSLog(@"%@",querySQL);
    
    if ([self openDB])
    {
        const char *query_stmt = [querySQL UTF8String];
        
        NSLog(@"%d",sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL));
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"successfull");
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                [self closeDB];
                
            }
            
            
            
        }
        else
        {
            NSLog(@"not successfull");
            [self closeDB];
        }
        
        
    }
    
}

#pragma mark - validate user


-(int)validateUser:(NSString *)email Password:(NSString *)password
{
    NSString *searchName =email;
    DataClass *userProfile=[DataClass getInstance];
    
    
    int isExist =0;
    
    
    
//    NSString *querySQL = [NSString stringWithFormat:@"SELECT  userId FROM UserInfo where userEmail=\"%@\" AND userPassword=\"%@\"",email,password];
    
    NSString *querySQL=[NSString stringWithFormat:@"select  * from userInfo where userEmail=\"%@\" and userPassword =\"%@\"",email,password];
                        
    NSLog(@"%@",querySQL);
                        
    if ([self openDB])
    {
        int retVal;
        
        
        const char *query_stmt = [querySQL UTF8String];
        sqlite3_stmt *statement;
        
        if ((retVal =sqlite3_prepare_v2(database, query_stmt, -1, &statement, nil))==SQLITE_OK)
        {
            sqlite3_bind_text(statement, 3, [searchName UTF8String], -1, SQLITE_TRANSIENT );
            
            int result;
            if((result =sqlite3_step(statement)) ==SQLITE_ROW){
                
                userProfile.userId=sqlite3_column_int(statement, 0);
                userProfile.userFirstName=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                userProfile.userLastName=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                 userProfile.userEmail=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                 userProfile.userMobile=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                 userProfile.userPassword=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSLog(@"user detail %@ %@ ",userProfile.userFirstName,userProfile.userLastName);
                
                isExist =1;
            }
            else{
                NSLog(@"Either username or password is wrong.");
            }
           
            sqlite3_reset(statement);
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
        else
        {
            NSLog(@"failure in the prepare statement");
        }
        
        
    }
    [self closeDB];
    return isExist;
}


-(int)validateUser:(NSString *)email{
    NSString *searchName =email;
    DataClass *userProfile=[DataClass getInstance];
    
    
    int isExist =0;
    
    
    
    //    NSString *querySQL = [NSString stringWithFormat:@"SELECT  userId FROM UserInfo where userEmail=\"%@\" AND userPassword=\"%@\"",email,password];
    
    NSString *querySQL=[NSString stringWithFormat:@"select  * from userInfo where userEmail=\"%@\"",email];
    
    NSLog(@"%@",querySQL);
    
    if ([self openDB])
    {
        int retVal;
        
        
        const char *query_stmt = [querySQL UTF8String];
        sqlite3_stmt *statement;
        
        if ((retVal =sqlite3_prepare_v2(database, query_stmt, -1, &statement, nil))==SQLITE_OK)
        {
            sqlite3_bind_text(statement, 3, [searchName UTF8String], -1, SQLITE_TRANSIENT );
            
            int result;
            if((result =sqlite3_step(statement)) ==SQLITE_ROW){
                
                userProfile.userId=sqlite3_column_int(statement, 0);
                userProfile.userFirstName=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                userProfile.userLastName=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                userProfile.userEmail=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                userProfile.userMobile=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                userProfile.userPassword=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSLog(@"user detail %@ %@ ",userProfile.userFirstName,userProfile.userLastName);
                
                isExist =1;
            }
            else{
                NSLog(@"User with This Email Already registered");
                isExist=0;
            }
            
            sqlite3_reset(statement);
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
        else
        {
            NSLog(@"failure in the prepare statement");
        }
        
        
    }
    [self closeDB];

    return isExist;
}


@end
