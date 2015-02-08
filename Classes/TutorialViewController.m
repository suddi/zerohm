#import "TutorialViewController.h"


@implementation TutorialViewController

// Refresh the view with the correct tutorial screen
-(void) updateScreen {
    // hide back button on first screen
    if(screenID == 1)
    {
        prevButton.hidden = YES;
    }
    else
    {
        prevButton.hidden = NO;
    }
    
    // hide forward button on last screen
    if(screenID == 7)
    {
        nextButton.hidden = YES;
    }
    else
    {
        nextButton.hidden = NO;
    }
    
    // display the right image by building file name from screen ID
    NSString *imageName = [NSString stringWithFormat:@"tutorial%d",screenID];
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    [imageView setImage:image];
    
    
}

// advance to next screen by incrementing screen ID
-(IBAction) nextScreen {
    screenID = screenID + 1;
    [self updateScreen];
}

// return to previous screen by decrementing screen ID
-(IBAction) prevScreen {
    screenID = screenID - 1;
    [self updateScreen];
}

// return to main menu
-(IBAction) returnToMenu {
    [self dismissModalViewControllerAnimated:NO];
}


- (void)viewDidAppear:(BOOL)animated {
    // display first tutorial screen
    screenID = 1;
    [self updateScreen];
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
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
