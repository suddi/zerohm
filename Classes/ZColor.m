#import "ZColor.h"

@implementation ZColor

// creates a color from the color ID
+ (ZColor*) createColor: (int) color {
    if (color < 0 || color > 11)
        return nil;
    ZColor* ins = [ZColor alloc];
    [ins setColorId: color];
    return ins;
}

// create a color from the numeric value
+ (ZColor*) createColorWithNumeric: (int) value {
    ZColor* ins = [ZColor alloc];
    [ins setNumeric: value];
    return ins;
}

// creates a color form the multiplier value
+ (ZColor*) createColorWithMultiplier: (int) value {
    ZColor* ins = [ZColor alloc];
    [ins setMultiplier: value];
    return ins;
}

// creates a color from the tolerance value (string)
+ (ZColor*) createColorWithTolerance: (NSString*) value {
    ZColor* ins = [ZColor alloc];
    [ins setTolerance: value];
    return ins;
}

- (void) setNumeric: (int) value {
    if (value < 10)
        colorId = value;
}

- (void) setMultiplier: (int) value {
    if (value < 10 && value >= 0)
        colorId = value;
    else if (value == -1)
        colorId = 10;
    else if (value == -2)
        colorId = 11;
}

- (void) setTolerance: (NSString*) value {
    if ([value isEqualToString: @"1%"]) 
    {
        colorId = ZCOLOR_BROWN;
    } 
    else if ([value isEqualToString: @"2%"]) 
    {
        colorId = ZCOLOR_RED;
    } 
    else if ([value isEqualToString: @"0.5%"])
    {
        colorId = ZCOLOR_GREEN;
    }
    else if ([value isEqualToString: @"0.25%"]) 
    {
        colorId = ZCOLOR_BLUE;
    } 
    else if ([value isEqualToString: @"0.1%"])
    {
        colorId = ZCOLOR_VIOLET;
    } 
    else if ([value isEqualToString: @"0.05%"]) 
    {
        colorId = ZCOLOR_GRAY;
    }
    else if ([value isEqualToString: @"5%"])
    {
        colorId = ZCOLOR_GOLD;
    }
    else if ([value isEqualToString: @"10%"])
    {
        colorId = ZCOLOR_SILVER;
    }
    else if (![value isEqualToString: @"20%"])
    {
        colorId = ZCOLOR_VALUE_INVALID;
    }
}

- (void) setColorId: (int) colorIdentifier {
    if (colorIdentifier < 0 || colorIdentifier > 11)
        return;
    colorId = colorIdentifier;
}

- (int) getColorId {
    return colorId;
}

- (BOOL) compare: (ZColor*) other {
    return [other getColorId] == colorId;
}

///Returns the band value of the color.
///Checks if the color ID is between 0 and 9 and then returns the value of the color ID. Otherwise returns invalid value.
///
- (int) numeric {
    if (colorId <= 9 && colorId >= 0)
    {
        return colorId;
    }
    
    else
    {
        return ZCOLOR_VALUE_INVALID;
    }
}

///Returns the multiplier value of the color.
///Checks the color ID and returns the corresponding exponent for the multiplier value.
///
- (int) multiplier {
    if (colorId <=9 && colorId >=0) 
    {
        return colorId;
    }
    
    else if (colorId == 10)
    {
        return -1;
    }
    
    else if (colorId == 11)
    {
        return -2;
    }
    
    else
    {
        return ZCOLOR_VALUE_INVALID;
    }
}

///Returns the tolerance value of the color.
///Checks the color ID and returns the corresponding tolerance percentage.
///
- (NSString*) tolerance {
    NSString* toleranceValue;
    
    if (colorId == 1) 
    {
        toleranceValue = @"1%";
    }
    
    else if (colorId == 2)
    {
        toleranceValue = @"2%";
    }
    
    else if (colorId == 5) 
    {
        toleranceValue = @"0.5%";
    }
    
    else if (colorId == 6) 
    {
        toleranceValue = @"0.25%";
    }
    
    else if (colorId == 7) 
    {
        toleranceValue = @"0.1%";
    }
    
    else if (colorId == 8) 
    {
        toleranceValue = @"0.05%";
    }
    
    else if (colorId == 10) 
    {
        toleranceValue = @"5%";
    }
    
    else if (colorId == 11) {
        toleranceValue = @"10%";
    }
    
    else 
    {
        toleranceValue = @"";
    }
    
    return toleranceValue;
}    

@end
