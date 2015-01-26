import bb.cascades 1.3
import bb.system 1.2

Page {
    titleBar: TitleBar {
        title: "bidstack"
        acceptAction: ActionItem {
            title: qsTr("Refresh")
        }
    }
    actions: [
        ActionItem {
            title: qsTr("Add")
            ActionBar.placement: ActionBarPlacement.Signature
            imageSource: "asset:///images/actions/official/ic_add.png"
            attachedObjects: [
                SystemPrompt {
                    id: addUserPrompt
                    title: qsTr("Add user")
                    body: qsTr("Please enter the username:")
                    cancelButton.label: qsTr("Cancel")
                    confirmButton.label: qsTr("Add")
                    onFinished: {
                        if (result == SystemUiResult.ConfirmButtonSelection) {
                            if (true) {
                                usersDataModel.insert({ name: value });
                                userHasSuccessfullyBeenAddedToast.show();
                            } else {
                                userCouldNotBeAddedToast.show();
                            }
                        }
                    }
                },
                SystemToast {
                    id: userCouldNotBeAddedToast
                    body: qsTr("Could not add user to this company!")
                },
                SystemToast {
                    id: userHasSuccessfullyBeenAddedToast
                    body: qsTr("User has successfully been added!")
                }
            ]
            onTriggered: {
                addUserPrompt.show();
            }
        }
    ]
    Container {
        ListView {
            dataModel: GroupDataModel {
                id: usersDataModel
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
                            imageSource: "asset:///images/actions/official/ic_contact.png"
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
                        ImageButton {
                            defaultImageSource: "asset:///images/actions/official/ic_delete.png"
                            verticalAlignment: VerticalAlignment.Center
                            attachedObjects: [
                                SystemDialog {
                                    id: removeUserDialog
                                    title: ListItemData.name
                                    body: qsTr("Do you really want to remove this user?")
                                    cancelButton.label: qsTr("No")
                                    confirmButton.label: qsTr("Yes")
                                    onFinished: {
                                        if (result == SystemUiResult.ConfirmButtonSelection) {
                                            if (true) {
                                                usersDataModel.removeAt(ListItem.indexPath);
                                                userHasSuccessfullyBeenRemovedToast.show();
                                            } else {
                                                userCouldNotBeRemovedToast.show();
                                            }
                                        }
                                    }
                                },
                                SystemToast {
                                    id: userCouldNotBeRemovedToast
                                    body: qsTr("Could not remove user from this company!")
                                },
                                SystemToast {
                                    id: userHasSuccessfullyBeenRemovedToast
                                    body: qsTr("The user has successfully been removed!")
                                }
                            ]
                            onClicked: {
                                removeUserDialog.show();
                            }
                        }
                    }
                    Divider {}
                }
            }
            onCreationCompleted: {
                usersDataModel.insertList([
                    { name: "jan.pieper" },
                    { name: "support" }
                ]);
            }
        }
    }
}
