import bb.cascades 1.3

Label {
    property string status;
    
    text: status
    textStyle.fontSize: FontSize.Small
    
    onCreationCompleted: {
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