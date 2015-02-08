#import "ResistorBuilderController.h"


@implementation ResistorBuilderController
@synthesize skeletonView;
@synthesize render1;
@synthesize render2;
@synthesize render3;
@synthesize render4;


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
    
    // make correct resistor dragable
    if([touch view] == render1)
    {
        render1.center = tapLocation;
    }
    else if([touch view] == render2)
    {
        render2.center = tapLocation;
    }
    else if([touch view] == render3)
    {
        render3.center = tapLocation;
    }
    else if([touch view] == render4)
    {
        render4.center = tapLocation;
    }
  }
-(void) touchesEnded:(NSSet*)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    tapLocation = [touch locationInView:self.view]; 
    
    // determine which resistor was dragged
    ZResistor *draggedResistor;
    
    if([touch view] == render1)
    {
        draggedResistor = [render1 resistor];
    }
    else if([touch view] == render2)
    {
       draggedResistor = [render2 resistor];
    }
    else if([touch view] == render3)
    {
        draggedResistor = [render3 resistor];
    }
    else if([touch view] == render4)
    {
        draggedResistor = [render4 resistor];
    }
    else
    {
        return; // resistor wasn't dragged
    }
    
    ZResistorRender *resistorAtDroppedLocation = [skeletonView findResistorRender:tapLocation];
    if(resistorAtDroppedLocation == nil)
    {
        // nothing to do
    }
    else
    {
		[resistorAtDroppedLocation setResistor: draggedResistor];
        // update display
        [resistorAtDroppedLocation setNeedsDisplay];
    }

    // return dragable band back to original location
    [touch view].center = initialLocation;
}

- (void)viewDidAppear:(BOOL)animated {
    // rotate screen elements for landscape view
    skeletonView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    doneButton.transform = CGAffineTransformMakeRotation(M_PI / 2);
    render1.transform =  CGAffineTransformMakeRotation(M_PI / 2);
    render2.transform =  CGAffineTransformMakeRotation(M_PI / 2);
    render3.transform =  CGAffineTransformMakeRotation(M_PI / 2);
    render4.transform =  CGAffineTransformMakeRotation(M_PI / 2);
    
}

-(IBAction) returnToParentScreen {
    // return to circuit
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
/*
- (void) viewDidLoad {
    render1.resistor = [skeletonView getAlternative: 0];
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
