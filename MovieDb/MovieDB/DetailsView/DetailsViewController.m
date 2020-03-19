//
//  DetailsViewController.m
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 18/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailsViewController.h"
#import "Details.h"

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
    [self getMovieDetails: @(419704)];
}

-(void)getMovieDetails: (NSString *)  movieId {
    Details *movie = [[Details alloc]init];
    NSData *dataJson;
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=e33d6d132f3f10c719d71ad8b3149066&language=en-US", movieId];
    
    NSURL *url = [NSURL URLWithString: urlString ];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL: url];

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
            
            NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"Data received: %@", myString);
        
            NSData *dataJson = [myString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:dataJson options:0 error:nil];
            [movie initWithJson: json];
        
    }] resume];
    //        self.movieTitle.text = [json objectForKey:@"original_title"];
    //        self.movieTitle.text = movie.title;
    
}

@end

