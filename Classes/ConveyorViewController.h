#import <UIKit/UIKit.h>
#import "ZResistorRender.h"
#import "HighScoreViewController.h"

@interface ConveyorViewController : UIViewController {
    
    //high score view
    IBOutlet HighScoreViewController *highScoreViewController;
    
    //convyeor resistor and game buttons
    IBOutlet ZResistorRender *resistor;
	IBOutlet ZResistorRender *resistor2;
    IBOutlet UIButton *back;
    IBOutlet UIButton *lose;
    
    //score display
    IBOutlet UILabel *score;
    
    
    //answer bins and their titles
    IBOutlet UILabel *bin1;
    IBOutlet UILabel *bin2;
    IBOutlet UILabel *bin3;
    IBOutlet UILabel *bin4;
    IBOutlet UILabel *greaterLabel;
    IBOutlet UILabel *lessLabel;
    IBOutlet UILabel *toleranceLabel;
    IBOutlet UILabel *tester;
	IBOutlet UILabel *tester2;
    
    //wrong answer strikes
    IBOutlet UIView  *strikeOne;
    IBOutlet UIView  *strikeTwo;
    IBOutlet UIView  *strikeThree;
    
    //resistors used in game
    ZResistor* greaterThanResistor;
    ZResistor* lessThanResistor;
    ZResistor* toleranceResistor;
	ZResistor* currentResistor;
	ZResistor* currentResistor2;
    
    //implemented timer
    NSTimer *timer;
    
    //values to keep account of position, speed, no. of lives left
    float position, position2, increment;
    int correct, value, strikes;
    
    //timer enabled
    bool enabled;
	bool enabled2;
    
    //location of touch
    CGPoint initialLocation;
    CGPoint tapLocation;

}
@property (nonatomic, retain) NSTimer * timer;

-(IBAction) returnToMenu;
-(IBAction) submitScore;
-(IBAction) initialize;
-(void) targetMethod: (NSTimer*) timer;
-(void) genGreater;
-(void) genLesser;
-(BOOL) checkLessThan: (ZResistor*) _res;
-(BOOL) checkGreaterThan: (ZResistor*) _res;
-(BOOL) compareTolerance: (ZResistor*) _res;
-(void) checkStrikes;

@end
