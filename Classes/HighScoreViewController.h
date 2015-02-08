#import <UIKit/UIKit.h>

@interface HighScoreViewController : UIViewController<UIWebViewDelegate> {

    // top 100 score web view
    IBOutlet UIWebView *scoreboard;
    
    // Messages
    IBOutlet UILabel *mainMessage;
    IBOutlet UILabel *status;
    
    // Input fields
    IBOutlet UILabel *usernameLabel;
    IBOutlet UILabel *passwordLabel;
    IBOutlet UILabel *emailLabel;
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    IBOutlet UITextField *emailField;
    
    // Buttons
    IBOutlet UIButton *newUserButton;
    IBOutlet UIButton *submitButton;
    IBOutlet UIButton *doneButton;
    
    bool isNewUser;
    int submissionScore;
    
}

-(void) prepareSubmitScore:(NSString *)score;
-(IBAction) toggleNewUser;
-(IBAction) doSubmitScore;
-(void) showHighScore;
-(IBAction) clickDone;
-(IBAction) doneKeyboardInput:(id) sender;
-(void) changeToHighScoreView:(bool) highScoreView;

@end

