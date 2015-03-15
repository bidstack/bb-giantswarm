import bb.cascades 1.4
import bb.system 1.2

import "../Elements"

Page {
    titleBar: TitleBar {
        title: qsTr("Account")
        acceptAction: ActionItem {
            title: qsTr("Save")
            attachedObjects: [
                SystemToast {
                    id: accountCouldNotBeSavedToast
                    body: qsTr("Could not save account!")
                },
                SystemToast {
                    id: accountHasSuccessfullyBeenSavedToast
                    body: qsTr("Account has succesfully been saved!")
                }
            ]
            onTriggered: {
                if (true) {
                    accountHasSuccessfullyBeenSavedToast.show();
                } else {
                    accountCouldNotBeSavedToast.show();
                }
            }
        }
    }
    Container {
        SpacedContainer {
            LabeledTextField {
                id: usernameTextField
                label: qsTr("Username")
                inputMode: TextFieldInputMode.Text
                hintText: qsTr("Enter your username here")
                text: ""
                active: false
            }
        }
        SpacedContainer {
            LabeledTextField {
                id: emailTextField
                label: qsTr("Email")
                inputMode: TextFieldInputMode.EmailAddress
                hintText: qsTr("Enter your email here")
                text: ""
                active: false
            }
        }
        SpacedContainer {
            LabeledTextField {
                id: passwordTextField
                label: qsTr("Password")
                inputMode: TextFieldInputMode.Password
                hintText: qsTr("Enter your password here")
                text: ""
            }
        }
    }
    onCreationCompleted: {
        var user = giantswarm.getUser();
        emailTextField.text = user["email"];
        usernameTextField.text = user["name"];
    }
}
