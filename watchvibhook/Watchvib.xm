#import <objc/runtime.h>
//#import <AudioToolbox/AudioToolbox.h>
//#import <AudioToolbox/AudioServices.h>

@interface COSSoundsController
-(void)setHapticStateValue:(NSInteger)arg1;
@end

extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

static void fireVib(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    COSSoundsController *pleasework = [[objc_getClass("COSSoundsController") alloc] init];
	[pleasework setHapticStateValue:1];
	//AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	double delayInSeconds = 0.5;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[pleasework setHapticStateValue:2];
		//AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	});
}

%ctor{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
		NULL,
		(CFNotificationCallback)fireVib, 
		CFSTR("com.gilshahar7.WatchvibFire"),
		NULL,
		CFNotificationSuspensionBehaviorDeliverImmediately
	);
}