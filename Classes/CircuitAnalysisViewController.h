#import <UIKit/UIKit.h>
#import "ZResistorRender.h"
#import "ResistorBuilderController.h"

@interface CircuitAnalysisViewController : UIViewController {
	
	//resistors displayed on screen
	IBOutlet ZResistorRender *resistor0;
	IBOutlet ZResistorRender *resistor1;
	IBOutlet ZResistorRender *resistor2;
	IBOutlet ZResistorRender *resistor3;
	IBOutlet ZResistorRender *resistor4;
	IBOutlet ZResistorRender *resistor5;
	IBOutlet ZResistorRender *resistor6;
	IBOutlet ZResistorRender *resistor7;
	IBOutlet ZResistorRender *resistor8;
	IBOutlet ZResistorRender *resistor9;
    
    IBOutlet ResistorBuilderController *resistorBuilderController;
	
	//incorrect resistor value
	ZResistor* incorrect;
	
    //menu buttons/display and ohmeter label
	IBOutlet UILabel *ohmmeter;
    IBOutlet UILabel *value; 
	IBOutlet UIButton *back;
	
	IBOutlet UILabel *resistor;
	IBOutlet UILabel *wrong;
	
    IBOutlet UILabel *gameOverText;
    IBOutlet UILabel *reasonGameOver;
    
	//values which determine if a resistor is hidden/incorrect
	int hidden, random;
	bool randomized;
    double scale;
    int mult;
    
    bool builderStarted;
}

-(void) updateDisplay:(UITouch*) touch1 secondTouch:(UITouch*) touch2;
-(IBAction) returnToMenu;
-(IBAction) initialize;
-(void) launchResistorBuilder;
-(void) gameOverCircuit;
-(void) gameOverBuilder;
-(void) successBuilder;

@end

