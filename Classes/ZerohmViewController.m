#import "ZerohmViewController.h"

@implementation ZerohmViewController


-(IBAction) doPracticeMode {
    tutorialButton.hidden = YES;
    practiceModeButton.hidden = YES;
    sortingModeButton.hidden = YES;
    analyzingModeButton.hidden = YES;
    guessColorButton.hidden = NO;
    guessValueButton.hidden = NO;
    backButton.hidden = NO;
}

-(IBAction) returnToMainMenu {
    tutorialButton.hidden = NO;
    practiceModeButton.hidden = NO;
    sortingModeButton.hidden = NO;
    analyzingModeButton.hidden = NO;
    guessColorButton.hidden = YES;
    guessValueButton.hidden = YES;
    backButton.hidden = YES;
}

-(IBAction) launchColorGuess {
    // Launch new view    
    [self presentModalViewController:colorGuessViewController animated:NO];
}

-(IBAction) launchValueGuess {
    // Launch new view    
    [self presentModalViewController:valueGuessViewController animated:NO];
}

-(IBAction) launchConveyorMode {
    // Launch new view    
    [self presentModalViewController:conveyorViewController animated:NO];
}

-(IBAction) launchCircuitMode {
    // Launch new view    
    [self presentModalViewController:circuitAnalysisViewController animated:NO];
}

-(IBAction) launchTutorial {
    // Launch new view    
    [self presentModalViewController:tutorialViewController animated:NO];
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
