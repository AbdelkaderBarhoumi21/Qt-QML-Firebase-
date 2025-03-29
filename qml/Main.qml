import Felgo
import QtQuick
import "model"

App {
    id: app

    licenseKey: "your license key "

    DataModel {
        id: dataModel
        onLoggedIn: stack.push(shoppingListPage)
    }

    NavigationStack {
        id: stack

        // Initially, the login page is always visible when starting the app.
        LoginPage {
            id: loginPage

            // The login page contains a form to enter user name and password.
            // A checkbox lets the user choose whether to log in or to register a
            // new user. In both cases, this slot is called.
            onLogin: function (email, password, isRegister) {
                if (isRegister) {
                    dataModel.registerUser(email, password)
                } else {
                    dataModel.loginUser(email, password)
                }
            }
        }
    }

    // The main shopping list page, which will be pushed to the
    // navigation stack after the login process has been completed
    // successfully.
    Component {
        id: shoppingListPage
        MasterPage {

            onPopped: dataModel.logoutUser()
            onAddNewShoppingItem: dataModel.addShoppingItem(text)
            // User deleted a shopping item -> forward the request to the data model.
            onDeleteShoppingItem: dataModel.deleteShoppingItem(id)
        }
    }
}
