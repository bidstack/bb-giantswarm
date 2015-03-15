import bb.cascades 1.4

Container {
    id: container

    signal selectedValueChanged();

    property alias label: label.text;
    property string value;

    attachedObjects: [
        ComponentDefinition {
            id: dropDownOption
            Option {}
        }
    ]

    function addOption(name) {
        var option = dropDownOption.createObject();
        option.text = name;
        dropDown.add(option);
    }

    Label {
        id: label
        text: "Untitled"
        textStyle.fontSize: FontSize.Large
    }
    DropDown {
        id: dropDown
        onSelectedValueChanged: {
            container.value = dropDown.options[selectedIndex].text;
            container.selectedValueChanged();
        }
    }
}