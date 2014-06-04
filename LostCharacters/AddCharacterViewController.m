//
//  AddCharacterViewController.m
//  LostCharacters
//
//  Created by Robert Figueras on 6/3/14.
//
//

#import "AddCharacterViewController.h"
#define kScrollHeight 120
#define kCenterY 284


@interface AddCharacterViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *actorTextField;
@property (strong, nonatomic) IBOutlet UITextField *passengerTextField;
@property (strong, nonatomic) IBOutlet UITextField *episodesTextField;
@property (strong, nonatomic) IBOutlet UITextField *yearsTextField;
@property (strong, nonatomic) IBOutlet UITextField *ageTextField;
@property (strong, nonatomic) IBOutlet UITextField *quoteTextField;
@property (strong, nonatomic) IBOutlet UITextField *hairTextField;
@property BOOL didScroll;
@end

@implementation AddCharacterViewController

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


- (IBAction)addCharacterButtonPressed:(id)sender {
    self.addedActorName = self.actorTextField.text;
    self.addedPassengerName = self.passengerTextField.text;
    self.addedEpisodes = [NSNumber numberWithInt:self.episodesTextField.text.intValue];
    self.addedYears = self.yearsTextField.text;
    self.addedAge = [NSNumber numberWithInt:self.ageTextField.text.intValue];
    self.addedQuote = self.quoteTextField.text;
    self.addedHairColor = self.hairTextField.text;

}

@end
