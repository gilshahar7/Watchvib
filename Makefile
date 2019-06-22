include $(THEOS)/makefiles/common.mk

SUBPROJECTS += watchvibhook
SUBPROJECTS += watchvibsb

include $(THEOS_MAKE_PATH)/aggregate.mk

all::
	
