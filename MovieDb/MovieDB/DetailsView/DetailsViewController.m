//
//  DetailsViewController.m
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 18/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UITextView *overviewText;

@end

@implementation DetailsViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)getMovieDetails: (int)  movieId {
    NSString* mId = [@(movieId) stringValue];
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=e33d6d132f3f10c719d71ad8b3149066&language=en-US", mId];

    NSURL *url = [NSURL URLWithString: urlString ];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *erro = nil;
        if (task!=nil) {
           id jsonObject = [NSJSONSerialization
                                JSONObjectWithData:[task dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
           if (jsonObject != nil && error == nil) {
             NSLog(@"Successfully deserialized...");
           }
        }
//        dispatch_sync(dispatch_get_main_queue(),^{
//            [tanl reloadData];
//        });
    }];
    [task resume];
    
}

@end
