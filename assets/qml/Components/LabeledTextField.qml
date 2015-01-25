import bb.cascades 1.3

Container {
    property alias label: label.text
    property alias text: textfield.text
    property alias inputMode: textField.inputMode
    property alias hintText: textField.hintText

    Label {
        id: label
        textStyle.fontSize: FontSize.Large
        text: ""
    }
    TextField {
        id: textField
        textStyle.fontSize: FontSize.Large
        accessibility.labelledBy: label
        text: ""
    }
}