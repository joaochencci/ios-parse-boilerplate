//
//  JVUser.h
//  ParseUserBoilerplate
//
//  Created by Joao Victor Chencci Marques on 04/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <Parse/Parse.h>

@interface JVUser : PFUser

- (JVUser *)initWithUsername:(NSString *)username andPassword:(NSString *)password;

- (NSString *)getObjectId;

@end
