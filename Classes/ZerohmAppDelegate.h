#import <UIKit/UIKit.h>

@class ZerohmViewController;

@interface ZerohmAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ZerohmViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ZerohmViewController *viewController;

@end

