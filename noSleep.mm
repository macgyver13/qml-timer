#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "noSleep.h"

void noSleep::setTimerDisabled() {
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
}

