#import "ValueGuessViewController.h"
#include "ZResistor.h"
#include <stdlib.h>


@implementation ValueGuessViewController

-(IBAction) validateGuess:(id) sender {    
    // hide choices
    resistorLabel.hidden = NO;
    choice1.hidden = YES;
    choice2.hidden = YES;
    choice3.hidden = YES;
    choice4.hidden = YES;
    nextQuestion.hidden = NO;
    
    // compare input with answer
    NSString *guessValue = [sender currentTitle];
    if([guessValue isEqualToString: resistorValue])
    {
        // show that answer is correct 
        resistorLabel.textColor = [UIColor greenColor];
        resistorLabel.text = [NSString stringWithFormat:@"Correct!\n%@", guessValue];
    }
    else
    {
        // show that answer is incorrect and give correct answer
        resistorLabel.textColor = [UIColor redColor];
        resistorLabel.text = [NSString stringWithFormat:@"Incorrect. The answer is:\n%@",resistorValue];
    }
}

-(IBAction) returnToMenu {
    [self dismissModalViewControllerAnimated:NO];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated {
    InitializeGenerator();
    [self showNewQuestion];
}

- (IBAction)showNewQuestion {
    // display answer buttons
    resistorLabel.hidden = YES;
    choice1.hidden = NO;
    choice2.hidden = NO;
    choice3.hidden = NO;
    choice4.hidden = NO;
    nextQuestion.hidden = YES;
    
    // create a new question
    resistorView.resistor = GenerateResistor();
    [resistorView setNeedsDisplay];
    
    int random = rand() % 4; // determine which button location to put the correct answer
    // create three other choices and select their button positions
    ZResistor* resistorChoices[4];
    for(int i = 0; i < 4; i++)
    {
        if(i==random) // correct answer
        {
            resistorChoices[i] = resistorView.resistor;
        }
        else
        {
            resistorChoices[i] = GenerateResistor();
        }
    }
    // update buttons
    [choice1 setTitle:[resistorChoices[0] resistorString] forState:UIControlStateNormal];
    [choice2 setTitle:[resistorChoices[1] resistorString] forState:UIControlStateNormal];
    [choice3 setTitle:[resistorChoices[2] resistorString] forState:UIControlStateNormal];
    [choice4 setTitle:[resistorChoices[3] resistorString] forState:UIControlStateNormal];
    
    // save answer for use in validation
    resistorValue = [resistorView.resistor resistorString];
    resistorLabel.text = resistorValue;
}


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
