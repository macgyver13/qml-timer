TEMPLATE     = app

QT          += qml quick multimedia

SOURCES     += main.cpp

ICON = clock.icns

ios {
  OBJECTIVE_SOURCES += noSleep.mm
  LIBS += -framework UIKit
  QMAKE_INFO_PLIST = content/Info.plist
}

iphoneos {
  QMAKE_POST_LINK += $$quote(cp $$PWD/clock.icns $$OUT_PWD/Debug-iphoneos/clock.app/;)
}

iphonesimulator {
  QMAKE_POST_LINK += $$quote(cp $$PWD/clock.icns $$OUT_PWD/Debug-iphonesimulator/clock.app/;)
}

RESOURCES   += clocks.qrc

target.path  = $$[QT_INSTALL_EXAMPLES]/clocks
INSTALLS    += target

OTHER_FILES  += clock.qml

DISTFILES += \
  clock.qml \
  content/CountDownTimer.qml \
  content/Knob.qml \
  content/clock.icns

HEADERS += \
  noSleep.h


