import QtQuick
import Felgo

Item {
    id: dataModel
    signal loggedIn
    signal loggedOut
    property var shoopingItems: ({})
    readonly property string dbKeyAllShoppingItems: "shoppinglist-user"
    FirebaseConfig {
        id: fbConfig
        projectId: "felgo-c3b90"
        databaseUrl: "https://felgo-c3b90-default-rtdb.europe-west1.firebasedatabase.app"
        apiKey: Qt.platform.os === "android" ? "AIzaSyDS3XzbEzTIpH2-g0mX2vwRhDDLdARB998" : ""
        applicationId: Qt.platform.os
                       === "android" ? "1:51121889931:android:34fd7dab9be7c0c1e1aa8e" : ""
    }
    FirebaseAuth {
        id: auth
        config: fbConfig
        onLoggedIn: {
            if (!success)
                nativeUtils.displayMessageBox(qsTr("Login failed"),
                                              qsTr("Reason: %1").arg(message),
                                              1)
        }
        onUserRegistered: {

            if (!success)
                nativeUtils.displayMessageBox(qsTr("Register failed"),
                                              qsTr("Reason: %1").arg(message),
                                              1)
        }
        onAuthenticatedChanged: if (authenticated)
                                    dataModel.loggedIn()
    }
    // Function to be used from the rest of the app to register a new user in
    // the Google Firebae Realtime Database.
    function registerUser(email, password) {
        auth.registerUser(email, password)
    }

    // Function to login based on existing email / password based authentication
    // for users that have already registered.
    function loginUser(email, password) {
        auth.loginUser(email, password)
    }

    // Log out from the Google Realtime Database.
    function logoutUser() {
        // logout is instant and always works (there is no callback)
        auth.logoutUser()
    }
    FirebaseDatabase {
        id: database
        config: fbConfig
        realtimeUserValueKeys: [dbKeyAllShoppingItems]
        onRealtimeUserValueChanged: if (key === dbKeyAllShoppingItems)
                                        shoppingItemsLoaded(value)
        onFirebaseReady: console.log("db ready")
        onWriteCompleted: console.log("Write completed")
    }
    function shoppingItemsLoaded(value) {
        dataModel.shoopingItems = value || {}
        console.log(JSON.stringify(dataModel.shoopingItems))
    }
    function addShoppingItem(text) {
        var time = new Date().getTime()
        var shoppingItem = {
            "date": time,
            "text": text
        }
        database.setUserValue(dbKeyAllShoppingItems + "/" + time, shoppingItem,
                              loadingFinished)
    }
    function loadingFinished() {
        console.log("Loading finished")
    }
    function deleteShoppingItem(id) {
        database.setUserValue(dbKeyAllShoppingItems + "/" + id, null,
                              loadingFinished)
    }
}
