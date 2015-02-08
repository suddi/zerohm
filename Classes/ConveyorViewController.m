#import "ConveyorViewController.h"
#include "ZResistor.h"

@implementation ConveyorViewController
@synthesize timer;

//referenced to "Back" button to return to main menu
-(IBAction) returnToMenu {
    [self dismissModalViewControllerAnimated:NO];
}

//referenced to "HighScoreViewController" when game ends
-(IBAction) submitScore {
    lose.hidden = YES;
    [self presentModalViewController:highScoreViewController animated:NO];
    [highScoreViewController prepareSubmitScore:score.text];
}

//positions all objects, sets initial values, starts timer
-(IBAction) initialize {
    InitializeGenerator();
    
    // Set up display with correct hidden views
    lose.hidden = YES;
    strikeOne.hidden = YES;
    strikeTwo.hidden = YES;
    strikeThree.hidden = YES;
    resistor.hidden = NO;
	resistor2.hidden = NO;
    tester.hidden = YES; // show debug label to show resistor value
	tester2.hidden = YES; // show debug label to show resistor value
    
    // Rotate elements on screen to sideways view
    lose.transform = CGAffineTransformMakeRotation( M_PI/2 );
    score.transform = CGAffineTransformMakeRotation( M_PI/2 );
    back.transform = CGAffineTransformMakeRotation( M_PI/2 );
    bin1.transform = CGAffineTransformMakeRotation( M_PI/2 );
    bin2.transform = CGAffineTransformMakeRotation( M_PI/2 );
    bin3.transform = CGAffineTransformMakeRotation( M_PI/2 );
    bin4.transform = CGAffineTransformMakeRotation( M_PI/2 );
    greaterLabel.transform = CGAffineTransformMakeRotation( M_PI/2 );
    lessLabel.transform = CGAffineTransformMakeRotation( M_PI/2 );
    toleranceLabel.transform = CGAffineTransformMakeRotation( M_PI/2 );
    resistor.transform = CGAffineTransformMakeRotation( M_PI/2 );
	resistor2.transform = CGAffineTransformMakeRotation( M_PI/2 );
    
    // Generate bins
    [self genGreater];
    [self genLesser];
    toleranceResistor = GenerateResistor();
    currentResistor = GenerateResistor();
	currentResistor2 = GenerateResistor();
    
    // Set bin labels
    bin1.text = [greaterThanResistor conveyorString];
    bin2.text = [lessThanResistor conveyorString];
    bin3.text = [NSString stringWithFormat:@"\u00B1 %@",[toleranceResistor tolerance]];
    bin4.text = @"Discard";
    tester.text = [currentResistor resistorString];
    NSLog(@"top: %@\n", tester.text);
	tester2.text = [currentResistor2 resistorString];
    NSLog(@"bottom: %@\n", tester2.text);
    // Set initial parameters
    position = 20.0;
	position2 = -20.0;
    increment = 0.25f;
    correct = 5;
    value = 0;
    strikes = 0;
    score.text = [NSString stringWithFormat: @"%d", value];
    
    // Display first resistor
    resistor.resistor = currentResistor;
    [resistor setNeedsDisplay];
    resistor.center = CGPointMake(185.0, position);
	
	resistor2.resistor = currentResistor2;
	[resistor2 setNeedsDisplay];
	resistor2.center = CGPointMake(159.0, position2);
    
    // Configure Timer
    enabled = YES;
	enabled2 = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.01 
                                             target:self 
                                           selector:@selector(targetMethod:) 
                                           userInfo:nil 
                                            repeats: YES];
}
// Method for timer which moves resistor across screen
-(void) targetMethod: (NSTimer*) timer {
    
        position = position + increment;
		position2 = position2 + increment;
		
		if(enabled == YES)
		{	
			resistor.center = CGPointMake(185.0, position);
			
        //if the resistor reaches the end of the screen, the user gets a strike
			if (position >= 500.0) {
				strikes = strikes + 1;
				[self checkStrikes];
				position = 20.0;
			}
		}
	
		if(enabled2 == YES)
		{	
			resistor2.center = CGPointMake(140.0, position2);
		
        //if the resistor reaches the end of the screen, the user gets a strike
			if (position2 >= 500.0) {
				strikes = strikes + 1;
				[self checkStrikes];
				position2 = 20.0;
			}
		}
	
        //if the resistor is still covered, it can not be dragged
        if(position <= 100.0) {
            resistor.userInteractionEnabled = NO;
        }
        else {
            resistor.userInteractionEnabled = YES;
        }
    
		if (position2 <= 100.0) {
			resistor2.userInteractionEnabled = NO;
		}
	
		else {
            resistor2.userInteractionEnabled = YES;
        }
    
}

-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event {
    //determine what was tapped
    UITouch *touch = [touches anyObject];
    initialLocation = [touch view].center;
    //bring tapped object to front
    //[[touch.view superview] bringSubviewToFront:touch.view];
    
}

-(void) touchesMoved:(NSSet*)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    tapLocation = [touch locationInView:self.view]; 
    
    if([touch view] == resistor) 
    {
        enabled = NO;
        resistor.center = tapLocation;
    }
	
	else if([touch view] == resistor2) 
    {
        enabled2 = NO;
        resistor2.center = tapLocation;
    }
	
}

-(void) touchesEnded:(NSSet*)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    tapLocation = [touch locationInView:self.view];
    if(([touch view] == resistor) || ([touch view] == resistor2))
    {
       if([touch view] == resistor)
	   {
		   
		   //determine if the resistor was dragged into a bin
        
		   // Greater than bin
		   if (CGRectContainsPoint(CGRectMake(240,127,55,88), tapLocation))
		   {
			   //check to see if the bin was a correct answer
			   if([self checkGreaterThan: (ZResistor*) currentResistor] == YES)
			   {
				   correct = correct - 1;
				   value = value + (10 * increment * 2);
			   }
			   else 
			   {
				   strikes = strikes + 1;
			   }    
            
		   }
		   // less than bin
		   else if (CGRectContainsPoint(CGRectMake(240,254,55,88), tapLocation)) 
		   {
			   if ([self checkLessThan: (ZResistor*) currentResistor] == YES)
			   {
				   correct = correct -1;
				   value = value + (10 * increment * 2);
			   }
			   else 
			   {
				   strikes = strikes + 1;
			   }    
		   }
		   // tolerance bin
		   else if (CGRectContainsPoint(CGRectMake(20,127,55,88), tapLocation))
		   {
			   if([self compareTolerance: (ZResistor*) currentResistor] == YES)
			   {
				   correct = correct-1;
				   value = value + (10 * increment * 2);
			   }
			   else 
			   {
				   strikes = strikes + 1;
			   }    
		   }        
		   // discard bin
		   else if (CGRectContainsPoint(CGRectMake(20,254,55,88), tapLocation)) 
		   {
			   if(([self checkGreaterThan: (ZResistor*) currentResistor] == NO) && ([self checkLessThan: (ZResistor*) currentResistor] == NO) &&    ([self compareTolerance: (ZResistor*) currentResistor] == NO))
			   {
				   correct = correct -1;
				   value = value + (10 * increment * 2);
			   }
			   else 
			   {
				   strikes = strikes + 1;
			   }    
		   }
		   
		   //dragged on the conveyor belt
		   else if (CGRectContainsPoint(CGRectMake(117,112,86,340), tapLocation))
		   {
			   enabled = YES;
		   }
		   // dragged somewhere else
		   else 
		   {
			   strikes = strikes + 1;
		   }    
	   }
		
	   else if ([touch view] == resistor2)
	   {
			
			if (CGRectContainsPoint(CGRectMake(240,127,55,88), tapLocation))
			{
				//check to see if the bin was a correct answer
				if([self checkGreaterThan: (ZResistor*) currentResistor2] == YES)
				{
					correct = correct - 1;
					value = value + (10 * increment * 2);
				}
				else 
				{
					strikes = strikes + 1;
				}    
			}
        // less than bin
			else if (CGRectContainsPoint(CGRectMake(240,254,55,88), tapLocation)) 
			{
				if ([self checkLessThan: (ZResistor*) currentResistor2] == YES)
				{
					correct = correct -1;
					value = value + (10 * increment * 2);
				}
				else 
				{
					strikes = strikes + 1;
				}    
			}
        // tolerance bin
			else if (CGRectContainsPoint(CGRectMake(20,127,55,88), tapLocation))
			{
				if([self compareTolerance: (ZResistor*) currentResistor2] == YES)
				{
					correct = correct-1;
					value = value + (10 * increment * 2);
				}
				else 
				{
					strikes = strikes + 1;
				}    
			}        
			// discard bin
			else if (CGRectContainsPoint(CGRectMake(20,254,55,88), tapLocation)) 
			{
				if(([self checkGreaterThan: (ZResistor*) currentResistor2] == NO) && ([self checkLessThan: (ZResistor*) currentResistor2] == NO) &&    ([self compareTolerance: (ZResistor*) currentResistor2] == NO))
				{
					correct = correct -1;
					value = value + (10 * increment * 2);
				}
				else 
				{
					strikes = strikes + 1;
				}    
			}
		   
		   //dragged on the conveyor belt
			else if (CGRectContainsPoint(CGRectMake(117,112,86,340), tapLocation))
			{
				enabled2 = YES;
			}
		   // dragged somewhere else
			else 
			{
				strikes = strikes + 1;
			}    
	   }
			
        //increases speed after 5 correct answers
        if (correct == 0) 
        {
            correct = 5;
            increment = increment * 2.0;
        }
        
        //check the number of incorrect answers
        [self checkStrikes];
        if ((strikes < 3) && (enabled == NO))
        {
            //generate a new resistor
            score.text = [NSString stringWithFormat: @"%d", value];
            currentResistor = GenerateResistor();
            resistor.resistor = currentResistor;
            [resistor setNeedsDisplay];
            position = 20.0;
            enabled = YES;
            tester.text = [currentResistor resistorString];
            NSLog(@"top: %@\n", tester.text);
        }
		
		else if ((strikes < 3) && (enabled2 == NO))
        {
            //generate a new second resistor
            score.text = [NSString stringWithFormat: @"%d", value];
            currentResistor2 = GenerateResistor();
            resistor2.resistor = currentResistor2;
            [resistor2 setNeedsDisplay];
            position2 = 20.0;
            enabled2 = YES;
            tester2.text = [currentResistor2 resistorString];
            NSLog(@"bottom: %@\n", tester2.text);
        }
	}
}

//generates a resistor with a multiplier greater than 4
-(void) genGreater {
    greaterThanResistor = GenerateResistor();
    while([greaterThanResistor multiplier] < 5)
    {
        greaterThanResistor = GenerateResistor();
    }
}

//generates a resistor with a multiplier less than 5
-(void) genLesser {
    lessThanResistor = GenerateResistor();
    while([lessThanResistor multiplier] > 4) 
    {
        lessThanResistor = GenerateResistor();
    }
}    

//checks to see if a resistor is larger than the bin value
-(BOOL) checkGreaterThan: (ZResistor*) _res {
	if([_res multiplier] > [greaterThanResistor multiplier])
    {
        return YES;
    }
    else if([_res multiplier] == [greaterThanResistor multiplier]) 
    {
        if([_res firstValue] > [greaterThanResistor firstValue])
        {
            return YES;
        }
        else if([_res firstValue] == [greaterThanResistor firstValue]) 
        {
            if([_res secondValue] > [greaterThanResistor secondValue])
            {
                return YES;
            }
        }
        else
        {
            // no match
        }
    }
    else
    {
        // no match
    }
    return NO;
}

//checks to see if a resistor is less than the bin value
-(BOOL) checkLessThan: (ZResistor*) _res {
    if([_res multiplier] < [lessThanResistor multiplier])
    {
        return YES;
    }
    else if([_res multiplier] == [lessThanResistor multiplier])
    {
        if([_res firstValue] < [lessThanResistor firstValue])
        {
            return YES;
        }
        else if([_res firstValue] == [lessThanResistor firstValue])
        {
            if([_res secondValue] < [lessThanResistor secondValue])
            {
                return YES;
            }
        }
        else
        {
            // no match
        }
    }
    else
    {
        // no match
    }
    return NO;
}

//checks if a reistor has the same tolerance as the bin value
-(BOOL) compareTolerance: (ZResistor*) _res {
    if([[_res tolerance] isEqualToString: [toleranceResistor tolerance]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}    

//shows red squares for strikes, ends game if there are 3 strikes
-(void) checkStrikes {
    if (strikes == 1) 
    {
        strikeOne.hidden = NO;
    }    
    else if (strikes == 2)
    {
        strikeTwo.hidden = NO;
    }
    else if (strikes == 3) 
    {
        strikeThree.hidden = NO;
        lose.hidden = NO;
        enabled = NO;
		enabled2 = NO;
        resistor.hidden = YES;
		resistor2.hidden = YES;
    }
    else
    {
        // should not get here.
    }
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
    [self initialize];
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
