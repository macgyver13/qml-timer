#ifndef APPDELEGATE
#define APPDELEGATE
#import <UIKit/UIKit.h>
#import "AppDelegate-C-Interface.h"
//#import <iosappstate.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
+(AppDelegate *)sharedAppDelegate;
@end
#endif // APPDELEGATE
