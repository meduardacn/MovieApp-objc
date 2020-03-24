//
//  ListTableViewCell.m
//  MovieDB
//
//  Created by Camile Ancines on 18/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell
@synthesize movie;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
