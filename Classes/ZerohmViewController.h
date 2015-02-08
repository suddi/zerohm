#import <UIKit/UIKit.h>
#import "ColorGuessViewController.h"
#import "ValueGuessViewController.h"
#import "ConveyorViewController.h"
#import "CircuitAnalysisViewController.h"
#import "TutorialViewController.h"

@interface ZerohmViewController : UIViewController {
    
    // Subviews for color guessing and value guessing
    IBOutlet ColorGuessViewController *colorGuessViewController;
    IBOutlet ValueGuessViewController *valueGuessViewController;
    IBOutlet ConveyorViewController *conveyorViewController;
    IBOutlet CircuitAnalysisViewController *circuitAnalysisViewController;
    IBOutlet TutorialViewController *tutorialViewController;
    
    IBOutlet UIButton *tutorialButton;
    IBOutlet UIButton *practiceModeButton;
    IBOutlet UIButton *sortingModeButton;
    IBOutlet UIButton *analyzingModeButton;
    IBOutlet UIButton *guessValueButton;
    IBOutlet UIButton *guessColorButton;
    IBOutlet UIButton *backButton;

}

// basic menu items
-(IBAction) doPracticeMode;
-(IBAction) returnToMainMenu;
-(IBAction) launchColorGuess;
-(IBAction) launchValueGuess;
-(IBAction) launchConveyorMode;
-(IBAction) launchCircuitMode;
-(IBAction) launchTutorial;
@end

