/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtMultimedia 5.0
import QtQuick.Layouts 1.15

Item {
  id : clock
  width: 200

  height: 240


  MediaPlayer {
    id: playDing
    source: "qrc:/audio/ding.m4a"
  }

  MediaPlayer {
    id: playShort
    source: "qrc:/audio/short.m4a"
  }

  property int workSeconds: 60
  property int restSeconds: 60
  property int seconds: 60
  property int sets: 0
  property string mode: "rest"
  property alias timer: countDownTimer

  function timeChanged() {
    seconds = seconds - 1;
    if (seconds == 0) {
      playDing.play()
      if (mode === "work") {
        mode = "rest"
        seconds = restSeconds
        sets = sets + 1
      } else {
        mode = "work"
        seconds = workSeconds
      }
    } else {
//      if ( seconds % 10 == 0 && mode === "work" ) {
//        playShort.play()
//      }
      if ( mode === "work") {
        if ( (workSeconds > 29 && Math.round(workSeconds * .5) == seconds) || seconds == 10 || seconds == 3 )
          playShort.play()
      }
    }
  }

  Timer {
    id: countDownTimer
    interval: 1000; running: false; repeat: true;
    onTriggered: clock.timeChanged()
  }

  ColumnLayout {
    id: columnLayout
    spacing: 10

    Item {
      Layout.alignment: Qt.AlignHCenter
      width: 120; height: 200

      Image { id: background; source: "clock.png"; }

      Image {
        x: 97.5; y: 20
        source: "second.png"
        transform: Rotation {
          id: secondRotation
          origin.x: 2.5; origin.y: 80;
          angle: clock.seconds * 6
          Behavior on angle {
            SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
          }
        }
      }

      Image {
        anchors.centerIn: background; source: "center.png"
      }
    }

    RowLayout {
      Layout.leftMargin: 10
      Text {
        text: "Remaining:"
        color: "white"
        font.family: "Helvetica"; font.pixelSize: 40
      }

      Text {
        id: secondsLabel
        text: seconds
        color: "white"
        font.family: "Helvetica"; font.bold: true; font.pixelSize: 40
        style: Text.Raised; styleColor: "black"
      }
    }

    RowLayout {
      Layout.leftMargin: 10
      Text {
        text: "Activity:"
        color: "white"
        font.family: "Helvetica"; font.pixelSize: 40
      }

      Text {
        id: modeLabel
        text: mode
        color: "white"
        font.family: "Helvetica"; font.bold: true; font.pixelSize: 40
        style: Text.Raised; styleColor: "black"
      }
    }

    RowLayout {
      Layout.leftMargin: 10
      Text {
        text: "Sets:"
        color: "white"
        font.family: "Helvetica"; font.pixelSize: 40
      }

      Text {
        id: setLabel
        text: sets
        color: "white"
        font.family: "Helvetica"; font.bold: true; font.pixelSize: 40
        style: Text.Raised; styleColor: "black"
      }
    }
  }
}
