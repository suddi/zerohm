#import <UIKit/UIKit.h>
#import "ZResistorRender.h"


@interface ColorGuessViewController : UIViewController {

    // resistor display
    IBOutlet ZResistorRender* resistorView;
    IBOutlet UIButton *nextQuestion;
    
    // dragable color bands
    IBOutlet UIView *colorBand0;
    IBOutlet UIView *colorBand1;
    IBOutlet UIView *colorBand2;
    IBOutlet UIView *colorBand3;
    IBOutlet UIView *colorBand4;
    IBOutlet UIView *colorBand5;
    IBOutlet UIView *colorBand6;
    IBOutlet UIView *colorBand7;
    IBOutlet UIView *colorBand8;
    IBOutlet UIView *colorBand9;
    IBOutlet UIView *colorBand10;
    IBOutlet UIView *colorBand11;
    
    // color band background
    IBOutlet UIView *backgroundBox;
    
    // solution elements
    IBOutlet UILabel *resistorValue;
    IBOutlet UILabel *resistorAnswer;
    IBOutlet ZResistorRender* resistorViewAnswer;
    
    // drag locations
    CGPoint initialLocation;
    CGPoint tapLocation;
    
    ZResistor* correctAnswer;
}

-(IBAction) returnToMenu;
-(void) validateAnswer;
-(IBAction) showNewQuestion;
-(void) rearrangeColorBands;
@end
