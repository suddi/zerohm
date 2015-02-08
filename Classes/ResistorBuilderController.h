#import <UIKit/UIKit.h>
#import "ZSkeletonGen.h"


@interface ResistorBuilderController : UIViewController {

    // resistor template and draggable resistors
    IBOutlet ZSkeletonGen* skeletonView;
    IBOutlet ZResistorRender* render1;
    IBOutlet ZResistorRender* render2;
    IBOutlet ZResistorRender* render3;
    IBOutlet ZResistorRender* render4;
    
    // UI elements
    IBOutlet UIButton *doneButton;
    
    // drag locations
    CGPoint initialLocation;
    CGPoint tapLocation;
}


- (IBAction) returnToParentScreen;

@property (assign) ZSkeletonGen* skeletonView;
@property (assign) ZResistorRender* render1;
@property (assign) ZResistorRender* render2;
@property (assign) ZResistorRender* render3;
@property (assign) ZResistorRender* render4;

@end
