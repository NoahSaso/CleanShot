export ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = CleanShot
CleanShot_FILES = Tweak.xm
CleanShot_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
