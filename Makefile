ARCHS = arm64
TARGET = iphone:clang:latest:15.0
THEOS_PACKAGE_SCHEME = roothide
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = PlistPulse
PlistPulse_FILES = $(filter-out Sources/PPMRecorder.m,$(wildcard Sources/*.m))
PlistPulse_FRAMEWORKS = UIKit Foundation
PlistPulse_CFLAGS = -fobjc-arc -Wall
PlistPulse_CODESIGN_FLAGS = -SPlistPulse/Entitlements.plist
PlistPulse_RESOURCE_DIRS = PlistPulse

TOOL_NAME = PlistPulseRecorder
PlistPulseRecorder_FILES = Sources/PPMRecorder.m Sources/PPMShared.m Sources/PPMChange.m Sources/PPMDiffEngine.m
PlistPulseRecorder_FRAMEWORKS = Foundation
PlistPulseRecorder_CFLAGS = -fobjc-arc -Wall
PlistPulseRecorder_CODESIGN_FLAGS = -SPlistPulse/RecorderEntitlements.plist
PlistPulseRecorder_INSTALL_PATH = /usr/libexec

include $(THEOS_MAKE_PATH)/application.mk
include $(THEOS_MAKE_PATH)/tool.mk
