import bb.cascades 1.4
import bb.system 1.2

import "../Elements"

NavigationPane {
    id: nav

    signal finished();

    Page {
        Container {
            layout: DockLayout {}
            Container {
                function checkAndSetLoginButtonStatus() {
                    var emailIsGiven = emailTextField.text.length > 0
                      , passwordIsGiven = passwordTextField.text.length > 0;

                    loginButton.enabled = emailIsGiven && passwordIsGiven;
                }
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                ImageView {
                    imageSource: "asset:///images/giantswarm.png"
                    scalingMethod: ScalingMethod.AspectFit
                    horizontalAlignment: HorizontalAlignment.Center
                    bottomMargin: 0
                }
                SpacedContainer {
                    LabeledTextField {
                        id: emailTextField
                        inputMode: TextFieldInputMode.EmailAddress
                        label: qsTr("Email")
                        hintText: qsTr("Enter your email here")
                        onTextChanged: checkAndSetLoginButtonStatus()
                    }
                }
                SpacedContainer {
                    LabeledTextField {
                        id: passwordTextField
                        inputMode: TextFieldInputMode.Password
                        label: qsTr("Password")
                        hintText: qsTr("Enter your password here")
                        onTextChanged: checkAndSetLoginButtonStatus()
                    }
                }
                SpacedContainer {
                    horizontalAlignment: HorizontalAlignment.Center

                    Button {
                        id: loginButton
                        text: qsTr("Login")
                        enabled: false
                        attachedObjects: [
                            SystemToast {
                                id: loginFailedToast
                                body: "Login failed! Please check your credentials and try again!"
                            }
                        ]
                        onClicked: {
                            var email = emailTextField.text
                              , password = passwordTextField.text;

                            if (giantswarm.login(email, password)) {
                                // TODO: Open environments wizard
                                nav.finished();
                            } else {
                                loginFailedToast.show();
                            }
                        }
                    }
                }
            }
        }
    }
}