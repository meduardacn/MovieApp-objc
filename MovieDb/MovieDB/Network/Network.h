//
//  Network.h
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 20/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"

@interface Network : NSObject {
    NSString* apiKey;
    NSMutableURLRequest* request;
    Parser* parser;
}

@property(nonatomic,retain) NSString* apiKey;
@property(nonatomic,retain) NSMutableURLRequest* request;
@property(nonatomic,retain) Parser* parser;

-(instancetype)init;
-(void) fetchMovieWithID: (NSString *) movieId withCompletionHandler: (void (^)(Movie *))completionHandler;
@end
