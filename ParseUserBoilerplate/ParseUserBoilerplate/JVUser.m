//
//  JVUser.m
//  ParseUserBoilerplate
//
//  Created by Joao Victor Chencci Marques on 04/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "JVUser.h"

@implementation JVUser

#pragma mark - Init
- (JVUser *)initWithUsername:(NSString *)username andPassword:(NSString *)password
{
    JVUser *response = [[JVUser alloc] init];
    [response setUsername:username];
    [response setEmail:username];
    [response setPassword:password];
    
    return response;
}

#pragma mark - Getters
- (NSString *)getObjectId
{
    return self[@"objectId"];
}

@end
