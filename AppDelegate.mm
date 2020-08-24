#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "AppState.h"

@interface AppDelegate()

@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundUpdateTask;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate

+(AppDelegate *)sharedAppDelegate{
  static dispatch_once_t pred;
  static AppDelegate *shared = nil;
  dispatch_once(&pred, ^{
      shared = [[super alloc] init];
  });
  return shared;
}

- (AVAudioPlayer *)player{
  if (!_player){
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"silence.mp3" withExtension:nil];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [_player prepareToPlay];
    _player.numberOfLoops = -1;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback withOptions:(AVAudioSessionCategoryOptionAllowAirPlay + AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers) error:nil];
    [session setActive:YES error:nil];
  }
  return _player;
}

void InitializeDelegate ()
{
  [[UIApplication sharedApplication] setDelegate:[AppDelegate sharedAppDelegate]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
  return YES;
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
  [self beingBackgroundUpdateTask];
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
  [self endBackgroundUpdateTask];
}

- (void)beingBackgroundUpdateTask {
  if (AppState().shared().get()->isActive()) {
    [self.player play];
  }
  self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
      [self endBackgroundUpdateTask];
  }];
}
- (void)endBackgroundUpdateTask {
  [self.player stop];
  [[UIApplication sharedApplication] endBackgroundTask: self.backgroundUpdateTask];
  self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}
@end
