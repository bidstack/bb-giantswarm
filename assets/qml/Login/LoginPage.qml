import bb.cascades 1.3

import "../Components"

Page {
    Container {
        layout: DockLayout {}
        Container {
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
                }
            }
            SpacedContainer {
                LabeledTextField {
                    id: passwordTextField
                    inputMode: TextFieldInputMode.Password
                    label: qsTr("Password")
                    hintText: qsTr("Enter your password here")
                }
            }
            SpacedContainer {
                horizontalAlignment: HorizontalAlignment.Center
                
                Button {
                    text: qsTr("Login")
                }
            }
        }
    }
}