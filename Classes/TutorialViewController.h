#import <UIKit/UIKit.h>


@interface TutorialViewController : UIViewController {

    // Tutorial image view
    IBOutlet UIImageView *imageView;
    
    // Navigation buttons
    IBOutlet UIButton *prevButton;
    IBOutlet UIButton *nextButton;
    IBOutlet UIButton *exitButton;
    
    // Current screen index
    int screenID;
}

-(IBAction) prevScreen;
-(IBAction) nextScreen;
-(IBAction) returnToMenu;

@end
