import bb.cascades 1.3
import bb.system 1.2

import "../Elements"

NavigationPane {
    id: navigation
    Page {
        titleBar: TitleBar {
            title: qsTr("Companies")
            attachedObjects: [
                ActionItem {
                    id: cancelActionItem
                    title: qsTr("Cancel")
                },
                ActionItem {
                    id: doneActionItem
                    title: qsTr("Done")
                },
                ActionItem {
                    id: refreshActionItem
                    title: qsTr("Refresh")
                }
            ]
            onCreationCompleted: {
                if (false) {
                    acceptAction = doneActionItem
                    dismissAction = cancelActionItem
                } else {
                    acceptAction = refreshActionItem
                }
            }
        }
        actions: [
            ActionItem {
                title: qsTr("Create")
                ActionBar.placement: ActionBarPlacement.Signature
                imageSource: "asset:///images/actions/official/ic_add.png"
                attachedObjects: [
                    SystemToast {
                        id: companyHasSuccessfullyBeenCreatedToast
                        body: qsTr("Company has successfully been created!")
                    },
                    SystemToast {
                        id: companyCouldNotBeCreatedToast
                        body: qsTr("Company could not be created!")
                    },
                    SystemPrompt {
                        id: createCompanyPrompt
                        title: qsTr("Create company")
                        body: qsTr("Please enter the company name:")
                        confirmButton.label: qsTr("Create")
                        cancelButton.label: qsTr("Cancel")
                        onFinished: {
                            if (result == SystemUiResult.ConfirmButtonSelection) {
                                if (true) {
                                    companiesDataModel.insert({ name: inputFieldTextEntry() });
                                    companyHasSuccessfullyBeenCreatedToast.show();
                                } else {
                                    companyCouldNotBeCreatedToast.show();
                                }
                            }
                        }
                    }
                ]
                onTriggered: {
                    createCompanyPrompt.show();
                }
            }
        ]
        Container {
            ListView {
                dataModel: GroupDataModel {
                    id: companiesDataModel
                    sortingKeys: [ "name" ]
                    sortedAscending: true
                    grouping: ItemGrouping.None
                }
                listItemComponents: ListItemComponent {
                    type: "item"
                    Container {
                        TwoLineListContainer {
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            ImageView {
                                imageSource: "asset:///images/actions/custom/ic_company.png"
                                verticalAlignment: VerticalAlignment.Center
                            }
                            Label {
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                text: ListItemData.name
                                textStyle.fontSize: FontSize.Large
                                verticalAlignment: VerticalAlignment.Center
                            }
                            ImageView {
                                imageSource: "asset:///images/actions/custom/ic_next.png"
                                verticalAlignment: VerticalAlignment.Center
                            }
                        }
                        Divider {}
                    }
                }
                onCreationCompleted: {
                    companiesDataModel.insertList([
                        { name: "bidstack" },
                        { name: "giantswarm" }
                    ]);
                }
                onTriggered: {
                    navigation.push(Qt.createComponent(
                        "CompanyPage.qml"
                    ).createObject(navigation, {
                        company: companiesDataModel.data(indexPath)
                    }));
                }
            }
        }
    }
}