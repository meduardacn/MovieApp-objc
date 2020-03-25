//
//  Movie.h
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 19/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Movie : NSObject
// AMW: https://medium.com/@abhishek1nacc/atomic-nonatomic-retain-assign-copy-582b79d31568

@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* genres;
@property(nonatomic,strong) NSString* overview;
@property(nonatomic,strong) NSString* vote_average;
@property(nonatomic,strong) NSString* movieID;
@property(nonatomic,strong) NSString* poster_path;

@end
