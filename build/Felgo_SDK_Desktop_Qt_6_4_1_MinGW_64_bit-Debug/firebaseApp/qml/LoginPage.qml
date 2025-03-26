import QtQuick
import Felgo

AppPage {

    id: loginPage
    title: qsTr("Login")

    // The login signal is emitted when the user tapped on the button.
    // Depending on the state of the checkbox, the boolean is set to
    // true (register a new user) or false (login with an existing user)
    signal login(bool isRegister, string email, string password)

    Column {
        anchors.fill: parent
        anchors.margins: dp(12)
        spacing: dp(12)

        // Email text field
        AppTextField {
            id: textFieldEmail
            width: parent.width

            // Use a pre-defined user to make testing easier
            text: system.publishBuild ? "" : "abdelkader@gmail.com"

            placeholderText: qsTr("E-mail address")
            inputMethodHints: Qt.ImhEmailCharactersOnly
        }

        // Password text field
        AppTextField {
            id: textFieldPassword
            width: parent.width

            // Use a pre-defined password to make testing easier
            text: system.publishBuild ? "" : "123456"

            placeholderText: qsTr("Password")
            echoMode: TextInput.Password
        }

        // Check box to switch between mode to register a new user or to log in.
        AppCheckBox {
            id: checkBoxRegister
            text: qsTr("Register new user")
            checked: false
        }

        AppButton {
            text: checkBoxRegister.checked ? qsTr("Register") : qsTr("Login")

            // Button clicked -> emit signal to perform login / registration.
            onClicked: loginPage.login(checkBoxRegister.checked,
                                       textFieldEmail.text,
                                       textFieldPassword.text)
        }
    }
}
