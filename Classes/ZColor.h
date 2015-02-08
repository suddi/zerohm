#import <Foundation/Foundation.h>

#define ZCOLOR_BLACK 0
#define ZCOLOR_BROWN 1
#define ZCOLOR_RED 2
#define ZCOLOR_ORANGE 3
#define ZCOLOR_YELLOW 4
#define ZCOLOR_GREEN 5
#define ZCOLOR_BLUE 6
#define ZCOLOR_VIOLET 7
#define ZCOLOR_GRAY 8
#define ZCOLOR_WHITE 9
#define ZCOLOR_GOLD 10
#define ZCOLOR_SILVER 11

#define ZCOLOR_VALUE_INVALID -255

@interface ZColor : NSObject {
    int colorId;
}

// constructors
+ (ZColor*) createColor: (int) color;
+ (ZColor*) createColorWithNumeric: (int) value;
+ (ZColor*) createColorWithMultiplier: (int) value;
+ (ZColor*) createColorWithTolerance: (NSString*) value;

- (void) setNumeric: (int) value;
- (void) setMultiplier: (int) value;
- (void) setTolerance: (NSString*) value;

- (void) setColorId: (int) color;
- (int) getColorId;

///Returns the band value of the color.
///Checks if the color ID is between 0 and 9 and then returns the value of the color ID. Otherwise returns invalid value.
///
- (int) numeric;

///Returns the multiplier value of the color.
///Checks the color ID and returns the corresponding exponent for the multiplier value.
///
- (int) multiplier;

///Returns the tolerance value of the color.
///Checks the color ID and returns the corresponding tolerance percentage.
///
- (NSString*) tolerance;

- (BOOL) compare: (ZColor*) other;

@end
