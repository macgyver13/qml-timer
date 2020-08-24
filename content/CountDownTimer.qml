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
  property string mode: "Rest"
  property alias timer: countDownTimer
  property alias dial: dial
  property int workOutSeconds: 0
  property string workOutTime: ""
  property bool isActive: false

  Connections {
    target: Qt.application
    onStateChanged: {
      isActive = (Qt.application.state === Qt.ApplicationActive);
    }
  }

  function timeChanged() {
    seconds = seconds - 1;
    workOutSeconds = workOutSeconds + 1;
    if (seconds == 0) {
      playDing.play()
      if (mode === "Work") {
        mode = "Rest"
        seconds = restSeconds
        sets = sets + 1
      } else {
        mode = "Work"
        seconds = workSeconds
      }
    } else if (seconds == 3) {
      playShort.play()
    } else {
      if ( mode === "Work") {
        if ( (workSeconds > 29 && Math.round(workSeconds * .5) == seconds) || seconds == 10 )
          playShort.play()
      }
    }
    if (!isActive)
      return;
    var percentComplete = 0;
    if (mode === "Work") {
      percentComplete = seconds / workSeconds;
    } else {
      percentComplete = seconds / restSeconds;
    }
    if (workOutSeconds < 60){
      workOutTime = workOutSeconds;
    } else {
      var workOutMinutes = Math.floor(workOutSeconds / 60);
      var tempSeconds = (workOutSeconds % 60);
      workOutTime = workOutMinutes + ":" + (tempSeconds < 10 ? "0" + tempSeconds: tempSeconds);
    }
    dial.update(percentComplete,seconds);

  }

  Timer {
    id: countDownTimer
    interval: 1000; running: false; repeat: true;
    onTriggered: clock.timeChanged()
  }

  Knob {
    id: dial
    height: 360
  }

}
