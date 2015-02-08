#import "ColorGuessViewController.h"


@implementation ColorGuessViewController

-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event {
    //determine what was tapped
    UITouch *touch = [touches anyObject];
    initialLocation = [touch view].center;
    //bring tapped object to front
    [[touch.view superview] bringSubviewToFront:touch.view];
    
}

-(void) touchesMoved:(NSSet*)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    tapLocation = [touch locationInView:self.view]; 
    
    // make correct band dragable
    if([touch view] == colorBand0)
    {
        colorBand0.center = tapLocation;
    }
    else if([touch view] == colorBand1)
    {
        colorBand1.center = tapLocation;
    }
    else if([touch view] == colorBand2)
    {
        colorBand2.center = tapLocation;
    }
    else if([touch view] == colorBand3)
    {
        colorBand3.center = tapLocation;
    }
    else if([touch view] == colorBand4)
    {
        colorBand4.center = tapLocation;
    }
    else if([touch view] == colorBand5)
    {
        colorBand5.center = tapLocation;
    }
    else if([touch view] == colorBand6)
    {
        colorBand6.center = tapLocation;
    }
    else if([touch view] == colorBand7)
    {
        colorBand7.center = tapLocation;
    }
    else if([touch view] == colorBand8)
    {
        colorBand8.center = tapLocation;
    }
    else if([touch view] == colorBand9)
    {
        colorBand9.center = tapLocation;
    }
    else if([touch view] == colorBand10)
    {
        colorBand10.center = tapLocation;
    }
    else if([touch view] == colorBand11)
    {
        colorBand11.center = tapLocation;
    }
}
-(void) touchesEnded:(NSSet*)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    tapLocation = [touch locationInView:self.view]; 
    
    // determine what band was dropped
    int c = -1;
    if([touch view] == colorBand0)  c = 0;
    else if([touch view] == colorBand1)  c = 1;
    else if([touch view] == colorBand2)  c = 2;
    else if([touch view] == colorBand3)  c = 3;
    else if([touch view] == colorBand4)  c = 4;
    else if([touch view] == colorBand5)  c = 5;
    else if([touch view] == colorBand6)  c = 6;
    else if([touch view] == colorBand7)  c = 7;
    else if([touch view] == colorBand8)  c = 8;
    else if([touch view] == colorBand9)  c = 9;
    else if([touch view] == colorBand10)  c = 10;
    else if([touch view] == colorBand11)  c = 11;
    
    // didn't touch a resistor band, so we don't need to handle anything
    if(c == -1)
    {
        return;
    }
    
    // if band was dropped on a band position, update resistor
    for(int i = 0; i < 4; i++)
    {
        if(CGRectContainsPoint([resistorView getColorBandPosition:i], tapLocation))
        {
            [[resistorView resistor] setColor: [ZColor createColor:c] index: i];
            [resistorView setNeedsDisplay];
        }
    }
    
    // return dragable band back to original location
    [touch view].center = initialLocation;
    if([[resistorView resistor] isFull])
    {
        [self validateAnswer];
    }
    
}

-(void) validateAnswer {
    
    // hide bands and show the solution resistor
    colorBand0.hidden = YES;
    colorBand1.hidden = YES;
    colorBand2.hidden = YES;
    colorBand3.hidden = YES;
    colorBand4.hidden = YES;
    colorBand5.hidden = YES;
    colorBand6.hidden = YES;
    colorBand7.hidden = YES;
    colorBand8.hidden = YES;
    colorBand9.hidden = YES;
    colorBand10.hidden = YES;
    colorBand11.hidden = YES;
    backgroundBox.hidden = YES;
    nextQuestion.hidden = NO;
    resistorAnswer.hidden = NO;

    // compare correct answer to user input
    NSString *correctValue = [correctAnswer resistorString];
    NSString *guessValue = [[resistorView resistor] resistorString];
    if([guessValue isEqualToString: correctValue])
    {
        // show that answer is correct
        resistorValue.textColor = [UIColor greenColor];
        resistorAnswer.textColor = [UIColor greenColor];
        resistorAnswer.text = @"Correct!";

    }
    else
    {
        // show that answer is incorrect and display correct resistor
        resistorValue.textColor = [UIColor redColor];
        resistorAnswer.textColor = [UIColor redColor];
        resistorAnswer.text = @"Incorrect. The answer is:";
        resistorViewAnswer.hidden = NO;
        resistorViewAnswer.resistor = correctAnswer;
        [resistorViewAnswer setNeedsDisplay];
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
    InitializeGenerator(); // update seed
    // Set draggable color bands to correct color
    colorBand0.backgroundColor = ColorGetUIColor(0);
    colorBand1.backgroundColor = ColorGetUIColor(1);
    colorBand2.backgroundColor = ColorGetUIColor(2);
    colorBand3.backgroundColor = ColorGetUIColor(3);
    colorBand4.backgroundColor = ColorGetUIColor(4);
    colorBand5.backgroundColor = ColorGetUIColor(5);
    colorBand6.backgroundColor = ColorGetUIColor(6);
    colorBand7.backgroundColor = ColorGetUIColor(7);
    colorBand8.backgroundColor = ColorGetUIColor(8);
    colorBand9.backgroundColor = ColorGetUIColor(9);
    colorBand10.backgroundColor = ColorGetUIColor(10);
    colorBand11.backgroundColor = ColorGetUIColor(11);
}

- (void)viewDidAppear:(BOOL)animated {
    // display question
    [self showNewQuestion];
}


- (IBAction)showNewQuestion {
    // display color bands and hide solution resistor
    colorBand0.hidden = NO;
    colorBand1.hidden = NO;
    colorBand2.hidden = NO;
    colorBand3.hidden = NO;
    colorBand4.hidden = NO;
    colorBand5.hidden = NO;
    colorBand6.hidden = NO;
    colorBand7.hidden = NO;
    colorBand8.hidden = NO;
    colorBand9.hidden = NO;
    colorBand10.hidden = NO;
    colorBand11.hidden = NO;
    backgroundBox.hidden = NO;
    nextQuestion.hidden = YES;
    resistorViewAnswer.hidden = YES;
    resistorAnswer.hidden = YES;
    
    // create question
    correctAnswer = GenerateResistor();
    // update question display
    resistorValue.text = [correctAnswer resistorString];
    resistorValue.textColor = [UIColor blackColor];
    // create blank resistor to show on screen
    resistorView.resistor = [[ZResistor alloc] init];
    [resistorView setNeedsDisplay];
    // shuffle the color bands
    [self rearrangeColorBands];
}

- (void)rearrangeColorBands {
    // define possible array positions
    int remainingPositions[12] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 };
    int offset[12];
    // create sequence of shuffled offsets
    for(int i = 0; i < 12; i++)
    {
        int choice = rand() % (12-i); // pick random index from remaining choices
        offset[i] = remainingPositions[choice]; // get element from that location
        remainingPositions[choice] = remainingPositions[(11-i)]; // rearrange array so unchosen elements at front
    }
    
    // place bands in the randomized order
    colorBand0.center = CGPointMake(43+(offset[0]%6)*46,313+(offset[0]/6)*80);
    printf("%d",43+(offset[0]%6)*46);
    colorBand1.center = CGPointMake(43+(offset[1]%6)*46,313+(offset[1]/6)*80);
    colorBand2.center = CGPointMake(43+(offset[2]%6)*46,313+(offset[2]/6)*80);
    colorBand3.center = CGPointMake(43+(offset[3]%6)*46,313+(offset[3]/6)*80);
    colorBand4.center = CGPointMake(43+(offset[4]%6)*46,313+(offset[4]/6)*80);
    colorBand5.center = CGPointMake(43+(offset[5]%6)*46,313+(offset[5]/6)*80);
    colorBand6.center = CGPointMake(43+(offset[6]%6)*46,313+(offset[6]/6)*80);
    colorBand7.center = CGPointMake(43+(offset[7]%6)*46,313+(offset[7]/6)*80);
    colorBand8.center = CGPointMake(43+(offset[8]%6)*46,313+(offset[8]/6)*80);
    colorBand9.center = CGPointMake(43+(offset[9]%6)*46,313+(offset[9]/6)*80);
    colorBand10.center = CGPointMake(43+(offset[10]%6)*46,313+(offset[10]/6)*80);
    colorBand11.center = CGPointMake(43+(offset[11]%6)*46,313+(offset[11]/6)*80);
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
