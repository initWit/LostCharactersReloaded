//
//  FilterCharacterViewController.m
//  LostCharacters
//
//  Created by Robert Figueras on 6/3/14.
//
//

#import "FilterCharacterViewController.h"
#define kScrollHeight 120
#define kCenterY 284

@interface FilterCharacterViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *actorTextField;
@property (strong, nonatomic) IBOutlet UITextField *passengerTextField;
@property (strong, nonatomic) IBOutlet UITextField *episodesTextField;
@property (strong, nonatomic) IBOutlet UITextField *yearsTextField;
@property (strong, nonatomic) IBOutlet UITextField *ageTextField;
@property (strong, nonatomic) IBOutlet UITextField *quoteTextField;
@property (strong, nonatomic) IBOutlet UITextField *hairTextField;
@property BOOL didScroll;
@end

@implementation FilterCharacterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.didScroll = NO;
}
- (IBAction)backgroundTapped:(id)sender
{
    [self.actorTextField resignFirstResponder];
    [self.passengerTextField resignFirstResponder];
    [self.episodesTextField resignFirstResponder];
    [self.yearsTextField resignFirstResponder];
    [self.ageTextField resignFirstResponder];
    [self.quoteTextField resignFirstResponder];
    [self.hairTextField resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.center = CGPointMake(self.view.center.x, kCenterY);
    }];
    self.didScroll = NO;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    int tagValue = textField.tag;

    if (tagValue > 0 && self.didScroll == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 200);
        }];
    }
    self.didScroll = YES;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.actorTextField resignFirstResponder];
    [self.passengerTextField resignFirstResponder];
    [self.episodesTextField resignFirstResponder];
    [self.yearsTextField resignFirstResponder];
    [self.ageTextField resignFirstResponder];
    [self.quoteTextField resignFirstResponder];
    [self.hairTextField resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.center = CGPointMake(self.view.center.x, kCenterY);
    }];
    self.didScroll = NO;

    return YES;
}


- (IBAction)filterCharacterButtonPressed:(id)sender {
    self.filterByActorName  = self.actorTextField.text;
    self.filterByPassengerName = self.passengerTextField.text;
    self.filterByEpisodes = [NSNumber numberWithInt:self.episodesTextField.text.intValue];
    self.filterByYears = self.yearsTextField.text;
    self.filterByAge = [NSNumber numberWithInt:self.ageTextField.text.intValue];
    self.filterByQuote = self.quoteTextField.text;
    self.filterByHairColor = self.hairTextField.text;
    
}

@end
