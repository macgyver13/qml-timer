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
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "content" as Content
import Qt.labs.settings 1.0

Rectangle {
  id: root
  width: 400; height: 740
  color: countDownTimer.mode == "Work" ? "#05b508" : "#0523b5"

  property bool isPortrait: width < height
  function initializeClock() {
    countDownTimer.seconds = restSeconds.text;
    countDownTimer.workSeconds = workSeconds.text;
    countDownTimer.restSeconds = restSeconds.text;
    countDownTimer.sets = 0
    countDownTimer.mode = "Rest"
  }

  GridLayout {
    id: inputLayout
    rowSpacing: 10
    columnSpacing: 10
    anchors.fill: parent
    anchors.margins: 10
    Layout.minimumWidth: root.width
    Layout.minimumHeight: root.height
    flow: isPortrait ? GridLayout.TopToBottom : GridLayout.LeftToRight

    Rectangle {
      Layout.minimumWidth: 340
      Layout.minimumHeight: 200
      color: "#22222205"
      RowLayout {
        id: workRow
        Text {
          text: "Work:"
          color: "white"
          font.family: "Helvetica"; font.pixelSize: 40
        }

        TextInput {
          id: workSeconds
          text: "45"
          color: "white"
          font.family: "Helvetica"; font.bold: true; font.pixelSize: 40
        }

        Settings {
          property alias workSeconds: workSeconds.text
        }
      }
      RowLayout {
        id: restRow
        anchors.top: workRow.bottom
        anchors.topMargin: 10
        Text {
          text: "Rest:"
          color: "white"
          font.family: "Helvetica"; font.pixelSize: 40
        }

        TextInput {
          id: restSeconds
          text: "30"
          color: "white"
          font.family: "Helvetica"; font.bold: true; font.pixelSize: 40
        }
        Settings {
          property alias restSeconds: restSeconds.text
        }
      }
      RowLayout {
        id: buttonRow
        anchors.top: restRow.bottom
        anchors.topMargin: 20

        Button {
          Layout.alignment:Qt.AlignCenter

          contentItem: Text {
            text: countDownTimer.timer.running ? "Pause" : "Resume"
            color: "white"
            font.family: "Helvetica"; font.bold: true; font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }
          background: Rectangle {
            implicitHeight: 60
            implicitWidth: 180
            color: "grey"
            radius: 10
          }

          onClicked: {
            if (countDownTimer.timer.running)
              countDownTimer.timer.stop()
            else
              countDownTimer.timer.start()
          }
        }

        Button {
          Layout.alignment:Qt.AlignCenter

          contentItem: Text {
            text: countDownTimer.timer.running ? "Stop" : "Start"
            color: "white"
            font.family: "Helvetica"; font.bold: true; font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }
          background: Rectangle {
            implicitHeight: 60
            implicitWidth: 180
            color: "grey"
            radius: 10
          }

          onClicked: {
            if (countDownTimer.timer.running) {
              countDownTimer.timer.stop()
            } else {
              countDownTimer.timer.start()
              initializeClock();
            }
          }
        }
      }

      RowLayout {
        id: setRow
        anchors.top: buttonRow.bottom
        anchors.topMargin: 30
        Text {
          text: "Set:"
          color: "white"
          font.family: "Helvetica"; font.pixelSize: 20
        }

        Text {
          text: countDownTimer.sets
          color: "white"
          font.family: "Helvetica"; font.bold: true; font.pixelSize: 40
        }
      }

    }

    Rectangle {
      color: "#22222205"
      Layout.minimumWidth: 400
      Layout.minimumHeight: 340
      Content.CountDownTimer {
        id: countDownTimer
        anchors.centerIn: parent
        implicitHeight: 400
        implicitWidth: implicitHeight
      }
      Text {
        anchors.bottom: countDownTimer.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 50
        text: countDownTimer.mode
        width: 100
        color: "white"
        font.family: "Helvetica"; font.bold: true; font.pixelSize: 40
      }
    }
  }
}
