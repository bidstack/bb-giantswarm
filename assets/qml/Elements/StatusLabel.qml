import bb.cascades 1.4

Label {
    property string status;

    text: status
    textStyle.fontSize: FontSize.Small

    onStatusChanged: {
        if (status == "up") {
            textStyle.color = Color.Green
        } else if (status == "starting") {
            textStyle.color = Color.create("#FF5C00")
        } else if ((status == "failed") || (status == "down")) {
            textStyle.color = Color.Red
        } else {
            textStyle.color = Color.Gray
        }
    }
}
