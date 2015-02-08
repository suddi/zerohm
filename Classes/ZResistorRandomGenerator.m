#import "ZColor.h"
#import "ZResistor.h"

static void __init(void) {
    srand(time(NULL));     // initialize random seed
}

// generate the first band
static int __gen_first_value() {
    return rand() % 9 + 1;
}

// generate the second band
static int __gen_second_value() {
    return rand() % 10;
}

// generate third band
static int __gen_multipiler() {
    return rand() % 12;
}

// define tolerance colors
static int __gen_tolerance_color[] = {
    ZCOLOR_BROWN, ZCOLOR_RED, ZCOLOR_GREEN, ZCOLOR_BLUE,
    ZCOLOR_VIOLET, ZCOLOR_GRAY, ZCOLOR_GOLD, ZCOLOR_SILVER,
};

// generate tolerance band
static int __gen_tolerance() {
    int t = rand() % 8;
    return __gen_tolerance_color[t];
}

void InitializeGenerator() {
    __init();
}

ZResistor* GenerateResistor() {
    ZResistor* res = [[ZResistor alloc] init];
    // generate the four color bands
    ZColor* c[] = {
        [ZColor createColor: __gen_first_value()],
        [ZColor createColor: __gen_second_value()],
        [ZColor createColor: __gen_multipiler()],
        [ZColor createColor: __gen_tolerance()],
    };
    // set each color band
    for (int i = 0; i < 4; i++) {
        [res setColor: c[i] index: i];
    }
    return res;
}


