import bb.cascades 1.4

Container {
    property alias label: label.text
    property alias text: textField.text
    property alias inputMode: textField.inputMode
    property alias hintText: textField.hintText
    property alias active: textField.enabled
    property alias input: textField.input
    property alias validator: textField.validator

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