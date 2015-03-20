import bb.cascades 1.4
import bb.system 1.2

import "../Elements"

Sheet {
    id: sheet

    signal environmentCreated(string companyName, string environmentName);

    Page {
        titleBar: TitleBar {
            title: qsTr("New environment")
            acceptAction: ActionItem {
                id: createActionItem
                title: qsTr("Create")
                enabled: false
                attachedObjects: [
                    SystemToast {
                        id: environmentHasSuccessfullyBeenCreatedToast
                        body: qsTr("Environment has successfully been created!")
                    },
                    SystemToast {
                        id: environmentCouldNotBeCreatedToast
                        body: qsTr("Environment could not be created!")
                    },
                    SystemToast {
                        id: environmentAlreadyExistentToast
                        body: qsTr("Environment already existent!")
                    }
                ]
                onTriggered: {
                    var companyName = companyDropDown.value
                      , environmentName = environmentTextField.text;

                    if (giantswarm.hasEnvironment(companyName, environmentName)) {
                        if (giantswarm.createEnvironment(companyName, environmentName)) {
                            sheet.environmentCreated(companyName, environmentName);
                            environmentHasSuccessfullyBeenCreatedToast.show();
                            sheet.close();
                        } else {
                            environmentCouldNotBeCreatedToast.show();
                        }
                    } else {
                        environmentAlreadyExistentToast.show();
                    }
                }
            }
            dismissAction: ActionItem {
                title: qsTr("Cancel")
                onTriggered: {
                    sheet.close();
                }
            }
        }
        Container {
            SpacedContainer {
                LabeledDropDown {
                    id: companyDropDown
                    label: qsTr("Company")
                    onSelectedValueChanged: {
                        if (environmentTextField.text.length >= 0) {
                            createActionItem.enabled = true;
                        } else {
                            createActionItem.enabled = false;
                        }
                    }
                    onCreationCompleted: {
                        giantswarm.getCompanies().forEach(function (companyName) {
                            addOption(companyName);
                        });
                    }
                }
            }
            SpacedContainer {
                LabeledTextField {
                    id: environmentTextField
                    label: qsTr("Environment")
                    text: ""
                    input.flags: TextInputFlag.AutoCapitalizationOff
                    validator: Validator {
                        onValidate: {
                            if (environmentTextField.text.match(/^[a-z0-9]+$/)) {
                                state = ValidationState.Valid;
                            } else {
                                state = ValidationState.Invalid;
                            }
                        }
                    }
                    onTextChanged: {
                        if ((text.length >= 0) && (companyDropDown.value.length >= 0)) {
                            createActionItem.enabled = true;
                        } else {
                            createActionItem.enabled = false;
                        }
                    }
                }
            }
        }
    }
}
