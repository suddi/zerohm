#import "CircuitAnalysisViewController.h"

@implementation CircuitAnalysisViewController

-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
    //if broken resistor is double-tapped, open resistor builder screen
	if (touch.tapCount == 2)
    {
        if([touch view] == resistor0)
        {
            if(random == 0)
            {
                [self launchResistorBuilder];
            }
            else
            {
                [self gameOverCircuit];
            }
        }
		
		else if([touch view] == resistor1)
        {
            if(random == 1)
            {
                [self launchResistorBuilder];
            }
            else
            {
                [self gameOverCircuit];
            }
        }
		
		else if([touch view] == resistor2)
        {
            if(random == 2)
            {
                [self launchResistorBuilder];
            }
            else
            {
                [self gameOverCircuit];
            }
        }
		
		else if([touch view] == resistor3)
        {
            if(random == 3)
            {
                [self launchResistorBuilder];
            }
            else
            {
                [self gameOverCircuit];
            }
        }
		
		else if([touch view] == resistor4)
        {
            if(random == 4)
            {
                [self launchResistorBuilder];
            }
            else
            {
                [self gameOverCircuit];
            }
        }
		
		else if([touch view] == resistor5)
        {
            if(random == 5)
            {
                [self launchResistorBuilder];
            }
            else
            {
                [self gameOverCircuit];
            }
        }
		
		else if([touch view] == resistor6)
        {
            if(random == 6)
            {
                [self launchResistorBuilder];
            }
            else
            {
                [self gameOverCircuit];
            }
        }
		
		else if([touch view] == resistor7)
        {
            if(random == 7)
            {
                [self launchResistorBuilder];
            }
            else
            {
                [self gameOverCircuit];
            }
        }
		
		else if([touch view] == resistor8)
        {
            if(random == 8)
            {
                [self launchResistorBuilder];
            }
            else
            {
                [self gameOverCircuit];
            }
        }
		
		else if([touch view] == resistor9)
        {
            if(random == 9)
            {
                [self launchResistorBuilder];
            }
            else
            {
                [self gameOverCircuit];
            }
		}
    }
	
    // reset multimeter
	else
    {
		value.text = @"";
    }
	
    // Handle two finger touches
    if([[event allTouches] count] == 2)
    {
        // Determine location of two fingers
        UITouch *touch1 = [[[event allTouches] allObjects] objectAtIndex:0];
        UITouch *touch2 = [[[event allTouches] allObjects] objectAtIndex:1];
        // Forward touches to display handler
        [self updateDisplay:touch1 secondTouch:touch2]; 
    }
}
-(void) touchesMoved:(NSSet*)touches withEvent:(UIEvent *)event {
    // Do nothing
}

-(void) touchesEnded:(NSSet*)touches withEvent:(UIEvent *)event {
    // Do nothing
}

// launch resistor builder after correct broken resistor is identified
-(void) launchResistorBuilder {
    // display resistor builder screen
    [self presentModalViewController:resistorBuilderController animated:NO];
    
    // set up the skeleton and alterative resistors
    ZSkeletonGen* skel = resistorBuilderController.skeletonView;
    [skel generate: scale
        multiplier: mult];
    resistorBuilderController.render1.resistor = [skel getAlternative: 0];
    resistorBuilderController.render2.resistor = [skel getAlternative: 1];
    resistorBuilderController.render3.resistor = [skel getAlternative: 2];
    resistorBuilderController.render4.resistor = [skel getAlternative: 3];
    [skel setNeedsDisplay];
    
    // hide the alterate resistors we don't need
	resistorBuilderController.render1.hidden = (resistorBuilderController.render1.resistor == nil);
	resistorBuilderController.render2.hidden = (resistorBuilderController.render2.resistor == nil);
	resistorBuilderController.render3.hidden = (resistorBuilderController.render3.resistor == nil);
	resistorBuilderController.render4.hidden = (resistorBuilderController.render4.resistor == nil);
	
    // update display
	[resistorBuilderController.render1 setNeedsDisplay];
	[resistorBuilderController.render2 setNeedsDisplay];
	[resistorBuilderController.render3 setNeedsDisplay];
	[resistorBuilderController.render4 setNeedsDisplay];
    
    // set status flag for resistor builder launch
    builderStarted = YES;
}

// update the screen based on location of two finger touch
-(void)updateDisplay:(UITouch*) touch1 secondTouch:(UITouch*) touch2 {
    // Get tags of the tapped subviews
    int tag1 = [touch1 view].tag;
    int tag2 = [touch2 view].tag;
	
    if (tag1 == 0 || tag2 == 0)
    {
        value.text = [NSString stringWithFormat:@" "];		
    }
	
	//when a resistor is selected, display its resistance value
	//if the resistor is "broken" display the incorrect resistance value
    else if (((tag1 == 1) && (tag2 == 2)) || ((tag1 == 2) && (tag2 == 1))) //Resistor 0
    {	
		//if the resistor is hidden, then display nothing on the ohmeter
        if (resistor0.hidden == YES)
		{
			value.text = @"";
		}
		else
		{
			//if the resistor is incorrect, then display the value of the incorrect resistor
			if (random == 0)
			{	
				value.text = [incorrect resistorString];
			}
			//otherwise display the value of the displayed resistor
			else
			{
				value.text = [resistor0.resistor resistorString];
			}	
		}
	}		
	
	else if (((tag1 == 1) && (tag2 == 5)) || ((tag1 == 5) && (tag2 == 1))) //Resistor 3
	{
		if (resistor3.hidden == YES)
		{
			value.text = @"";
		}
		else
		{
			if (random == 3)
			{	
				value.text = [incorrect resistorString];
			}	
			else
			{	
				value.text = [resistor3.resistor resistorString];
			}	
		}
	}
	
	else if (((tag1 == 2) && (tag2 == 3)) || ((tag1 == 3) && (tag2 == 2))) //Resistor 1
	{
		if (resistor1.hidden == YES)
		{
			value.text = @"";
		}
		else
		{
			if (random == 1)
			{
				value.text = [incorrect resistorString];
			}
			else
			{
				value.text = [resistor1.resistor resistorString];
			}	
		}
	}
	
	else if (((tag1 == 2) && (tag2 == 6)) || ((tag1 == 6) && (tag2 == 2))) //Resistor 4
	{
		if (resistor4.hidden == YES)
		{
			value.text = @"";
		}
		else
		{
			if (random == 4)
			{
				value.text = [incorrect resistorString];
			}
			else
			{	
				value.text = [resistor4.resistor resistorString];
			}	
		}
	}
	
	else if (((tag1 == 3) && (tag2 == 4)) || ((tag1 == 4) && (tag2 == 3))) //Resistor 2
	{
		if (resistor2.hidden == YES)
		{
			value.text = @"";
		}
		else
		{
			if (random == 2)
			{
				value.text = [incorrect resistorString];
			}
			else
			{	
				value.text = [resistor2.resistor resistorString];
			}	
		}
	}
	
	else if (((tag1 == 3) && (tag2 == 7)) || ((tag1 == 7) && (tag2 == 3))) //Resistor 5
	{
		if (resistor5.hidden == YES)
		{
			value.text = @"";
		}
		else
		{
			if (random == 5)
			{
				value.text = [incorrect resistorString];
			}
			else
			{	
				value.text = [resistor5.resistor resistorString];
			}	
		}
	}
	
	else if (((tag1 == 4) && (tag2 == 8)) || ((tag1 == 8) && (tag2 == 4))) //Resistor 6
	{
		if (resistor6.hidden == YES)
		{
			value.text = @"";
		}
		else
		{
			if (random == 6)
			{
				value.text = [incorrect resistorString];
			}
			else
			{
				value.text = [resistor6.resistor resistorString];
			}	
		}
	}
	
	else if (((tag1 == 5) && (tag2 == 6)) || ((tag1 == 6) && (tag2 == 5))) //Resistor 7
	{
		if (resistor7.hidden == YES)
		{
			value.text = @"";
		}
		else
		{
			if (random == 7)
			{
				value.text = [incorrect resistorString];
			}
			else
			{	
				value.text = [resistor7.resistor resistorString];
			}	
		}
	}
	
	else if (((tag1 == 6) && (tag2 == 7)) || ((tag1 == 7) && (tag2 == 6))) //Resistor 8
	{
		if (resistor8.hidden == YES)
		{
			value.text = @"";
		}
		else
		{
			if (random == 8)
			{
				value.text = [incorrect resistorString];
			}
			else
			{	
				value.text = [resistor8.resistor resistorString];
			}	
		}
	}
	
	else if (((tag1 == 7) && (tag2 == 8)) || ((tag1 == 8) && (tag2 == 7))) //Resistor 9
	{
		if (resistor9.hidden == YES)
		{
			value.text = @"";
		}
		else
		{
			if (random == 9)
			{
				value.text = [incorrect resistorString];
			}
			else
			{	
				value.text = [resistor9.resistor resistorString];
			}	
		}
	}

}

// hide the resistors for end game display message
-(void) hideAllResistors
{
    resistor0.hidden = YES;
    resistor1.hidden = YES;
    resistor2.hidden = YES;
    resistor3.hidden = YES;
    resistor4.hidden = YES;
    resistor5.hidden = YES;
    resistor6.hidden = YES;
    resistor7.hidden = YES;
    resistor8.hidden = YES;
    resistor9.hidden = YES;
}

// update the screen with game over due to incorrect resistor identification
-(void) gameOverCircuit {
    [self hideAllResistors];
    gameOverText.hidden = NO;
    reasonGameOver.hidden = NO;
    gameOverText.text = @"Game Over!";
    reasonGameOver.text = @"That resistor was not broken.";
}

// update the screen with game over due to wrong resistor built
-(void) gameOverBuilder {
    [self hideAllResistors];
    gameOverText.hidden = NO;
    reasonGameOver.hidden = NO;
    gameOverText.text = @"Game Over!";
    reasonGameOver.text = @"The resistor you built was incorrect.";
}

// update the screen with success message
-(void) successBuilder {
    [self hideAllResistors];
    gameOverText.hidden = NO;
    reasonGameOver.hidden = NO;
    gameOverText.text = @"Congratuations!";
    reasonGameOver.text = @"You have fixed the circuit correctly.";
}

// return to main menu
-(IBAction) returnToMenu {
	[self initialize];  // reset all elements
    [self dismissModalViewControllerAnimated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    // Check answer and display result after exiting from resistor builder
    // Make sure to only check after resistor builder has been started
    if(resistorBuilderController.skeletonView != nil && builderStarted) 
    {
        if([resistorBuilderController.skeletonView validate])
        {
            [self successBuilder];
        }
        else
        {
            [self gameOverBuilder];
        }
    }
}

-(IBAction) initialize {
	InitializeGenerator();
	
	//rotate all objects for sideways screen view
	ohmmeter.transform = CGAffineTransformMakeRotation( M_PI/2 );
	value.transform = CGAffineTransformMakeRotation( M_PI/2 );
	back.transform = CGAffineTransformMakeRotation( M_PI/2 );
	resistor.transform = CGAffineTransformMakeRotation( M_PI/2 );
	wrong.transform = CGAffineTransformMakeRotation( M_PI/2 );
	resistor0.transform = CGAffineTransformMakeRotation( M_PI/2 );
	resistor1.transform = CGAffineTransformMakeRotation( M_PI/2 );
	resistor2.transform = CGAffineTransformMakeRotation( M_PI/2 );
	resistor7.transform = CGAffineTransformMakeRotation( M_PI/2 );
	resistor8.transform = CGAffineTransformMakeRotation( M_PI/2 );
	resistor9.transform = CGAffineTransformMakeRotation( M_PI/2 );
    gameOverText.transform = CGAffineTransformMakeRotation( M_PI/2 );
    reasonGameOver.transform = CGAffineTransformMakeRotation( M_PI/2 );
	
	//generate resistors for each of the resistors in the circuit
	resistor0.resistor = GenerateResistor();
	resistor1.resistor = GenerateResistor();
	resistor2.resistor = GenerateResistor();
	resistor3.resistor = GenerateResistor();
	resistor4.resistor = GenerateResistor();
	resistor5.resistor = GenerateResistor();
	resistor6.resistor = GenerateResistor();
	resistor7.resistor = GenerateResistor();
	resistor8.resistor = GenerateResistor();
	resistor9.resistor = GenerateResistor();
	incorrect = GenerateResistor();
	
	[resistor0 setNeedsDisplay];
	[resistor1 setNeedsDisplay];
	[resistor2 setNeedsDisplay];
	[resistor3 setNeedsDisplay];
	[resistor4 setNeedsDisplay];
	[resistor5 setNeedsDisplay];
	[resistor6 setNeedsDisplay];
	[resistor7 setNeedsDisplay];
	[resistor8 setNeedsDisplay];
	[resistor9 setNeedsDisplay];
	
	//set the meter to be blank
	value.text = @"";
	
	//hide all resistors except for those essential to the circuit
	resistor0.hidden = YES;
	resistor1.hidden = YES;
	resistor2.hidden = YES;
	resistor3.hidden = YES;
	resistor4.hidden = NO;
	resistor5.hidden = NO;
	resistor6.hidden = YES;
	resistor7.hidden = YES;
	resistor8.hidden = YES;
	resistor9.hidden = YES;
	randomized = NO;
    
    // hide game over text
    gameOverText.hidden = YES;
    reasonGameOver.hidden = YES;
    
    // initialize random seed
	srand(time(NULL));
	
	//randomly choose which resistors in the circuit to display
	for (int i = 0; i < 3; i++) 
	{
		hidden = rand() % 3;
		switch (hidden) 
		{
			case 0 : resistor0.hidden = NO; break;
			case 1 : resistor3.hidden = NO; break;
			case 2 : resistor7.hidden = NO; break;
		}
		hidden = rand() % 3;
		switch (hidden) 
		{
			case 0 : resistor2.hidden = NO; break;
			case 1 : resistor6.hidden = NO; break;
			case 2 : resistor9.hidden = NO; break;
		}
	}
	
	for (int i = 0; i < 2; i++) 
	{
		hidden = rand() % 2;
		switch (hidden) 
		{
			case 0 : resistor1.hidden = NO; break;
			case 1 : resistor8.hidden = NO; break;
		}
	}
	
	//randomly choose a resistor to be the broken resistor
	random = rand() % 10;
    scale = (rand() % 10) * 0.1;
    mult = (rand() % 3) + 1;
    ZResistor* correctResistor = ZSkeletonGenerateResistor(scale, mult);
	switch (random) 
	{
		case 0 : 
            resistor0.hidden = NO;
            resistor0.resistor = correctResistor;
            break;
		case 1 : 
            resistor1.hidden = NO; 
            resistor1.resistor = correctResistor;
            break;
		case 2 : 
            resistor2.hidden = NO; 
            resistor2.resistor = correctResistor;
            break;
		case 3 : 
            resistor3.hidden = NO;	
            resistor3.resistor = correctResistor;
            break;
		case 4 : 
            resistor4.resistor = correctResistor;
            break;
		case 5 : 
            resistor5.resistor = correctResistor;
            break;
		case 6 : 
            resistor6.hidden = NO; 
            resistor6.resistor = correctResistor; 
            break;
		case 7 : 
            resistor7.hidden = NO;	
            resistor7.resistor = correctResistor;
            break;
		case 8 : 
            resistor8.hidden = NO; 
            resistor8.resistor = correctResistor;
            break;
		case 9 : 
            resistor9.hidden = NO; 
            resistor9.resistor = correctResistor;
            break;
	}
    
    // Ensure that the incorrect resistor is actually incorrect and not equal to the correct resistor
    while([incorrect firstValue] == [correctResistor firstValue] 
          && [incorrect secondValue] == [correctResistor secondValue]
          && [incorrect multiplier] == [correctResistor multiplier])
    {
        incorrect = GenerateResistor();
    }
	
    // debug text
    resistor.hidden = YES;
    wrong.hidden = YES;
	resistor.text = [NSString stringWithFormat:@"%d", random];
	wrong.text = [correctResistor resistorString];
    NSLog(@"actual: %@", wrong.text);
    NSLog(@"wrong index: %d\n", random);
    
    builderStarted = NO; // haven't identified broken resistor yet
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




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
