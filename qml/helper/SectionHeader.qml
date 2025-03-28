import QtQuick
import Felgo

Rectangle {
    color: Qt.darker(Theme.tintColor, 4)
    width: parent.width
    height: iconRect.height + 2 * dp(Theme.navigationBar.defaultBarItemPadding)

    property alias iconType: iconItem.iconType
    property alias text: appText.text
    property alias image: imageItem.source

    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: dp(10)

        Rectangle {
            id: iconRect
            visible: imageItem.source != "" || iconItem.iconType !== ""
            width: dp(Theme.navigationBar.defaultIconSize) * 2.5
            height: visible ? dp(Theme.navigationBar.defaultIconSize) * 2.5 : appText.height
            radius: width * 0.5
            color: Theme.backgroundColor
            AppIcon {
                id: iconItem
                anchors.centerIn: parent
                visible: iconItem.iconType !== ""
            }
            Image {
                id: imageItem
                visible: !iconItem.visible && imageItem.source != ""
                anchors.centerIn: parent
                width: dp(Theme.navigationBar.defaultIconSize) * 1.5
                height: width / sourceSize.width * sourceSize.height
            }
        }

        AppText {
            id: appText
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.backgroundColor
            font.pixelSize: iconRect.visible ? sp(16) : dp(14)
            font.bold: true
        }

    }
}
