TEMPLATE     = app

QT          += qml quick multimedia

SOURCES     += main.cpp
RESOURCES   += clocks.qrc

target.path  = $$[QT_INSTALL_EXAMPLES]/demos/clocks
INSTALLS    += target

OTHER_FILES  += \
                clocks.qml \
                content/*.png

DISTFILES += \
  clock.qml \
  content/CountDownTimer.qml \
  content/Knob.qml
