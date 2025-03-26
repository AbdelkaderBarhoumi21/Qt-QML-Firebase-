import Felgo
import QtQuick
import "model"

App {
    id: app

    licenseKey: "CAD1CEE81074EBE7C44E02861AA8FAD8071779836F70DA70202F05B17724E38DE3588B5C950DE50747EB00D76D02A91016C393D1B8DD531A6A7AAD50878F76E0FE93A15FAD91F3013EE2E14FF5A66914DCACA764AC0925850D37EFE3E20A5ABCB34F901E43E49BDB70116FC9FD2F5666044C8981762C23E42369C86C4E956AEE05314337EFD6771940A6928FE744876642CC818C1278249E10A38263D47AA75EEF8C4595A9B91BBF1AD8F5F74BC261D4158159D009AEC40491F2E27E5114DC00930E6C4BA9932FD3479998D93FDE68541F6FFB4A9023989E567AA537E3484753266B82036A82F433B7F0D3A036F7AC4B8F1BE155780090AA7F745FB1313917F0AC55A695784B157EDB820F2DDEF51241EE15E3125B64DEFB035A03326720BD76B1FAC4F40936C7B1905E3F00BDC37F78"

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
