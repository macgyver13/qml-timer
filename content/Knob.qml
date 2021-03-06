/****************************************************************************
Original work from: https://github.com/IndeemaSoftware/EEIoT/blob/master/EEIoT/Knob.qml
*****************************************************************************/

import QtQuick 2.0

//all the automatic meagurements are made from height of Item
Item {
    id: knob
    transformOrigin: Item.Center

    property var metaData : ["from", "to", "value",
        "reverse",
        "fromAngle", "toAngle",
        "lineWidth", "fontSize",
        "knobBackgroundColor", "knobColor",
        "title", "titleFont", "titleFontSize", "titleFontColor"]

    //value parameters
    property double from:0
    property double value: 0
    property double to: 1

    //progress from right to left
    property bool reverse: false

    //progress circle angle
    property double fromAngle: Math.PI - 1
    property double toAngle: Math.PI *2 + 1

    property int lineWidth: height / 10
    property int fontSize: height / 3

    property color knobBackgroundColor: Qt.rgba(0.1, 0.1, 0.1, 0.1)
    property color knobColor: Qt.rgba(1, 0, 0, 1)

    property string title: ""
    property alias titleFont: labelTitle.font.family
    property alias titleFontSize: labelTitle.font.pointSize
    property alias titleFontColor: labelTitle.color

    function update(value,seconds) {
        knob.value = value
        canvas.requestPaint()
        background.requestPaint()
        label.text = seconds.toFixed(0);
    }

    Text {
        id: labelTitle
        y: 0
        text: knob.title
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Canvas {
        id: background
        width: parent.height
        height: parent.height
        antialiasing: true

        property int radius: background.width/2

        onPaint: {

            if (knob.title !== "") {
                background.y = labelTitle.height
                background.x = labelTitle.height/2
                background.height = parent.height - labelTitle.height/2
                background.width = parent.height - labelTitle.height/2
                background.radius = background.height /2
            }

            var centreX = background.width / 2.0;
            var centreY = background.height / 2.0;

            var ctx = background.getContext('2d');
            ctx.strokeStyle = knob.knobBackgroundColor;
            ctx.lineWidth = knob.lineWidth;
            ctx.lineCap = "round"
            ctx.beginPath();
            ctx.clearRect(0, 0, background.width, background.height);
            ctx.arc(centreX, centreY, radius - knob.lineWidth, knob.fromAngle, knob.toAngle, false);
            ctx.stroke();
        }
    }

    Canvas {
        id:canvas
        width: parent.height
        height: parent.height
        antialiasing: true

        property double step: knob.value / (knob.to - knob.from) * (knob.toAngle - knob.fromAngle)
        property int radius: height/2

        Text {
            id: label
            width: 40
            height: 12
            font.bold: true
            z: 1
            font.pointSize: knob.fontSize
            color: titleFontColor
            text: "0"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
        }

        onPaint: {

            if (knob.title !== "") {
                canvas.y = labelTitle.height
                canvas.x = labelTitle.height/2
                canvas.height = parent.height - labelTitle.height/2
                canvas.width = parent.height - labelTitle.height/2
                canvas.radius = canvas.height /2
            }

            var centreX = canvas.width / 2.0;
            var centreY = canvas.height / 2.0;

            var ctx = canvas.getContext('2d');
            ctx.strokeStyle = knob.knobColor;
            ctx.lineWidth = knob.lineWidth;
            ctx.lineCap = "round"
            ctx.beginPath();
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            if (knob.reverse) {
                ctx.arc(centreX, centreY, radius - knob.lineWidth, knob.toAngle, knob.toAngle - step, true);
            } else {
                ctx.arc(centreX, centreY, radius - knob.lineWidth, knob.fromAngle, knob.fromAngle + step, false);
            }
            ctx.stroke();
        }
    }
}
