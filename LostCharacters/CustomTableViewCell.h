//
//  CustomTableViewCell.h
//  LostCharacters
//
//  Created by Robert Figueras on 6/3/14.
//
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *actorLabel;
@property (strong, nonatomic) IBOutlet UILabel *passengerLabel;
@property (strong, nonatomic) IBOutlet UILabel *episodesLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearsLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *quoteLabel;
@property (strong, nonatomic) IBOutlet UILabel *hairColorLabel;

@end
