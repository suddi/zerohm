#import "HighScoreViewController.h"
#import "ZWeb.h"

#define SCOREBOARD_URL "http://mike.struct.cn/media/scoreboard.html"

@implementation HighScoreViewController

// Called to initialize parameters and view before submitting score
-(void) prepareSubmitScore:(NSString *)score
{
    // Initialize view to login screen (hide high score and reg views)
    [self changeToHighScoreView:NO];
    isNewUser = YES;
    [self toggleNewUser];
    status.text = @"";
    [scoreboard loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
    // Store score
    submissionScore = [score intValue];
}

// Toggle High Score View
-(void) changeToHighScoreView:(bool)highScoreView
{
    scoreboard.hidden = !highScoreView;
    mainMessage.hidden = highScoreView;
    status.hidden = highScoreView;
    usernameLabel.hidden = highScoreView;
    passwordLabel.hidden = highScoreView;
    emailLabel.hidden = highScoreView;
    usernameField.hidden = highScoreView;
    passwordField.hidden = highScoreView;
    emailField.hidden = highScoreView;
    newUserButton.hidden = highScoreView;
    submitButton.hidden = highScoreView;
    
    
}

// Submit the score
-(void) doSubmitScore
{
    // Register user before submitting score
    if(isNewUser)
    {
        if([usernameField.text isEqualToString:@""] || [passwordField.text  isEqualToString:@""] || [emailField.text  isEqualToString:@""])
        {
            status.text = @"All fields must be completed";
            return;
        }
        // Attempt to register
        NSString* regResult = ZWebRegisterUser(usernameField.text,passwordField.text,emailField.text);
        
        // Process result
        if([regResult isEqualToString: @"OK"])
        {
            // All good, so continue as if user registered
            [self toggleNewUser];
        }
        else if ([regResult isEqualToString: @"FAIL"])
        {
            status.text = @"Username already taken.";
            return;
        }
        else if ([regResult isEqualToString: @"DB ERROR"])
        {
            status.text = @"Database error.";
            return;
        }
        else
        {
            status.text = @"Server unavailable.";
            return;
        }            
    }
    // Try submitting score
    NSString* submitResult = ZWebSubmitScore(usernameField.text,passwordField.text,submissionScore);
    
    // Process result
    if([submitResult isEqualToString: @"OK"])
    {
        [self showHighScore];
    }
    else if([submitResult isEqualToString: @"LOGIN ERROR"])
    {
        status.text = @"Invalid login or password.";
    }
    else if ([submitResult isEqualToString: @"DB ERROR"])
    {
        status.text = @"Database error.";
    }
    else
    {
        status.text = @"Server unavailable.";
    }
}

// Display high score table
- (void) showHighScore
{
    // Update the view to show table
    [self changeToHighScoreView:YES];
    scoreboard.hidden = NO;
    // Get the score table data from web
    [scoreboard loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@SCOREBOARD_URL]]];
}

// Update display to change between new user registration and score submission
- (IBAction)toggleNewUser
{
    if(isNewUser)
    {
        [newUserButton setTitle:@"New User?" forState:UIControlStateNormal];
        emailLabel.hidden = YES;
        emailField.hidden = YES;
        mainMessage.text = @"Please Login to Submit Your Score";
        isNewUser = NO;
    }
    else
    {
        [newUserButton setTitle:@"Existing User?" forState:UIControlStateNormal];
        emailLabel.hidden = NO;
        emailField.hidden = NO;
        mainMessage.text = @"Please Register to Submit Your Score";
        isNewUser = YES;
    }
}

// Exit high score
- (IBAction)clickDone
{
    [self dismissModalViewControllerAnimated:NO];
}


// Allow user to exit from keyboard on done
-(IBAction) doneKeyboardInput:(id) sender {
    [sender resignFirstResponder];
}

// Allow user to exit from keyboard on exiting field
-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event {
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
    [emailField resignFirstResponder];
    
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
