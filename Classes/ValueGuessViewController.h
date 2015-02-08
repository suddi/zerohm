#import <UIKit/UIKit.h>
#import "ZResistorRender.h"

@interface ValueGuessViewController : UIViewController {
    
    // resistor display
    IBOutlet UILabel *resistorLabel;
    IBOutlet ZResistorRender* resistorView;
    
    // next question button
    IBOutlet UIButton *nextQuestion;
    
    // answer buttons
    IBOutlet UIButton *choice1;
    IBOutlet UIButton *choice2;
    IBOutlet UIButton *choice3;
    IBOutlet UIButton *choice4;
    
    NSString *resistorValue; // store correct answer


}

-(IBAction) showNewQuestion;
-(IBAction) validateGuess:(id) sender;
-(IBAction) returnToMenu;
@end
