import bb.cascades 1.3
import bb.system 1.2

import "../Components"

NavigationPane {
    id: navigation
    Page {
        titleBar: TitleBar {
            title: qsTr("Environments")
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
                title: qsTr("Add")
                ActionBar.placement: ActionBarPlacement.Signature
                imageSource: "asset:///images/actions/official/ic_add.png"
            }
        ]
        Container {
            ListView {
                dataModel: GroupDataModel {
                    id: environmentsDataModel
                    sortingKeys: [ "name" ]
                    sortedAscending: true
                    grouping: ItemGrouping.None
                }
                listItemComponents: ListItemComponent {
                    type: "item"
                    Container {
                        SpacedContainer {
                            verticalSpacing: ui.du(1)
                            horizontalSpacing: ui.du(2)
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            ImageView {
                                imageSource: "asset:///images/actions/custom/ic_environment.png"
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
                                        id: removeEnvironmentDialog
                                        title: ListItemData.name
                                        body: qsTr("Do you really want to remove this environment?")
                                        cancelButton.label: qsTr("No")
                                        confirmButton.label: qsTr("Yes")
                                        onFinished: {
                                            if (result == SystemUiResult.ConfirmButtonSelection) {
                                                if (true) {
                                                    environmentsDataModel.remove(ListItem.indexPath);
                                                    environmentHasSuccessfullyBeenRemovedToast.show();
                                                } else {
                                                    environmentCouldNotBeRemovedToast.show();
                                                }
                                            }
                                        }
                                    },
                                    SystemToast {
                                        id: environmentCouldNotBeRemovedToast
                                        body: qsTr("Could not remove environment!")
                                    },
                                    SystemToast {
                                        id: environmentHasSuccessfullyBeenRemovedToast
                                        body: qsTr("Environment has successfully been removed!")
                                    }
                                ]
                                onClicked: {
                                    removeEnvironmentDialog.show();
                                }
                            }
                        }
                        Divider {}
                    }
                }
                onCreationCompleted: {
                    environmentsDataModel.insertList([
                        { name: "bidstack/staging" },
                        { name: "giantswarm/production" }
                    ]);
                }
                onTriggered: {
                    var company = environmentsDataModel.data(indexPath);
                }
            }
        }
    }
}