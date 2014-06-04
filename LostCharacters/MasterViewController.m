//
//  MasterViewController.m
//  LostCharacters
//
//  Created by Robert Figueras on 6/3/14.
//
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AddCharacterViewController.h"
#import "CustomTableViewCell.h"
#import "FilterCharacterViewController.h"

@interface MasterViewController ()  <UITableViewDataSource>
@property NSMutableArray *characters;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBarButton;
@end

@implementation MasterViewController

- (void) viewDidLoad
{
    [self load];
    if (self.characters.count < 1) {
        [self createCharacterObjects];
    }
}

- (void) load
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Character"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"actor" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];

    self.characters = (NSMutableArray *)[self.managedObjectContext executeFetchRequest:request error:nil];
    [self.tableView reloadData];

}

- (void)createCharacterObjects
{

    NSManagedObject *character1 = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];
    [character1 setValue:@"Matthew Fox" forKey:@"actor"];
    [character1 setValue:@"Jack Shepard" forKey:@"passenger"];
    [character1 setValue:[NSNumber numberWithInt:100] forKey:@"episodes"];
    [character1 setValue:@"2004-2008" forKey:@"years"];
    [character1 setValue:[NSNumber numberWithInt:32] forKey:@"age"];
    [character1 setValue:@"Yo" forKey:@"quote"];
    [character1 setValue:@"Brown" forKey:@"hair"];
    [self.managedObjectContext save:nil];

    NSManagedObject *character2 = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];
    [character2 setValue:@"Evangeline Lilly" forKey:@"actor"];
    [character2 setValue:@"Kate Austen" forKey:@"passenger"];
    [character2 setValue:[NSNumber numberWithInt:83] forKey:@"episodes"];
    [character2 setValue:@"2002-2003" forKey:@"years"];
    [character2 setValue:[NSNumber numberWithInt:42] forKey:@"age"];
    [character2 setValue:@"Ha ha" forKey:@"quote"];
    [character2 setValue:@"Red" forKey:@"hair"];
    [self.managedObjectContext save:nil];

    NSManagedObject *character3 = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];
    [character3 setValue:@"Jorge Garcia" forKey:@"actor"];
    [character3 setValue:@"Hugo Hurley Reyes" forKey:@"passenger"];
    [character3 setValue:[NSNumber numberWithInt:121] forKey:@"episodes"];
    [character3 setValue:@"2002-2009" forKey:@"years"];
    [character3 setValue:[NSNumber numberWithInt:25] forKey:@"age"];
    [character3 setValue:@"Dude" forKey:@"quote"];
    [character3 setValue:@"Brown" forKey:@"hair"];
    [self.managedObjectContext save:nil];

    [self load];

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.characters.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *character = [self.characters objectAtIndex:indexPath.row];
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.actorLabel.text = [character valueForKey:@"actor"];
    cell.passengerLabel.text = [NSString stringWithFormat:@"%@",[character valueForKey:@"passenger"]];
    cell.yearsLabel.text = [character valueForKey:@"years"];
    cell.quoteLabel.text = [character valueForKey:@"quote"];
    cell.hairColorLabel.text = [character valueForKey:@"hair"];
    cell.episodesLabel.text = [NSString stringWithFormat:@"%@",[character valueForKey:@"episodes"]];
    cell.ageLabel.text = [NSString stringWithFormat:@"%@",[character valueForKey:@"age"]];

    return cell;
}

- (IBAction)unwindSegue:(UIStoryboardSegue *) segue
{
    AddCharacterViewController *sourceVC = segue.sourceViewController;
    NSString *newCharacterActor = sourceVC.addedActorName;
    NSString *newCharacterPassenger = sourceVC.addedPassengerName;
    NSNumber *newCharacterEpisodes = sourceVC.addedEpisodes;
    NSString *newCharacterYears = sourceVC.addedYears;
    NSNumber *newCharacterAge = sourceVC.addedAge;
    NSString *newCharacterQuote = sourceVC.addedQuote;
    NSString *newCharacterHairColor = sourceVC.addedHairColor;

    NSManagedObject *newCharacter = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];
    [newCharacter setValue:newCharacterActor forKey:@"actor"];
    [newCharacter setValue:newCharacterPassenger forKey:@"passenger"];
    [newCharacter setValue:newCharacterEpisodes forKey:@"episodes"];
    [newCharacter setValue:newCharacterYears forKey:@"years"];
    [newCharacter setValue:newCharacterAge forKey:@"age"];
    [newCharacter setValue:newCharacterQuote forKey:@"quote"];
    [newCharacter setValue:newCharacterHairColor forKey:@"hair"];


    [self.managedObjectContext save:nil];
    [self load];
}

- (IBAction)unwindFromFilterSegue:(UIStoryboardSegue *)segue
{
    FilterCharacterViewController *sourceVC = segue.sourceViewController;
    NSString *filterCharacterActor = sourceVC.filterByActorName;
    NSString *filterCharacterPassenger = sourceVC.filterByPassengerName;
    NSNumber *filterCharacterEpisodes = sourceVC.filterByEpisodes;
    NSString *filterCharacterYears = sourceVC.filterByYears;
    NSNumber *filterCharacterAge = sourceVC.filterByAge;
    NSString *filterCharacterQuote = sourceVC.filterByQuote;
    NSString *filterCharacterHairColor = sourceVC.filterByHairColor;

    NSFetchRequest *filterRequest = [[NSFetchRequest alloc] initWithEntityName:@"Character"];

    NSString *filterString = @"";

    if (filterCharacterActor) {
        filterString = [NSString stringWithFormat:@"actor like '%@'",filterCharacterActor];
    }

    NSLog(@"filterString is %@", filterString);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:filterString];
    filterRequest.predicate = predicate;
    self.characters = (NSMutableArray *)[self.managedObjectContext executeFetchRequest:filterRequest error:nil];
    [self.tableView reloadData];


}

- (IBAction)editButtonPressed:(id)sender {
    self.editing = ! self.editing;
    if (self.editing) {
        self.editBarButton.title = @"Done";
        [self.tableView setEditing:YES animated:YES];
    }
    else
    {
        self.editBarButton.title = @"Edit";
        [self.tableView setEditing:NO animated:NO];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.managedObjectContext deleteObject:[self.characters objectAtIndex:indexPath.row]];
    [self.managedObjectContext save:nil];
    [self load];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"SMOKE MONSTER";
}


@end
