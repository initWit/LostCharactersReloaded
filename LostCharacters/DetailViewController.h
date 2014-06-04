//
//  DetailViewController.h
//  LostCharacters
//
//  Created by Robert Figueras on 6/3/14.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
