@interface UIApplication (openlistener)
+(id)sharedApplication;
-(BOOL)launchApplicationWithIdentifier:(id)arg1 suspended:(BOOL)arg2;
@end

@interface SpringBoard : UIApplication
-(BOOL)launchApplicationWithIdentifier:(id)arg1 suspended:(BOOL)arg2;
@end

%hook SpringBoard

extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

%new
-(void)watchvibFire{
	[self launchApplicationWithIdentifier:@"com.apple.Bridge" suspended:YES];
	double delayInSeconds = 0.5;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[self launchApplicationWithIdentifier:@"com.apple.Bridge" suspended:YES];
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.gilshahar7.WatchvibFire"), NULL, NULL, true);
	});

}

%end