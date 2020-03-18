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
    _cardImage.layer.cornerRadius = 10;

}


@end
