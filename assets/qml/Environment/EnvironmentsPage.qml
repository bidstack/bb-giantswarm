import bb.cascades 1.4
import bb.system 1.2

import "../Elements"

NavigationPane {
    id: nav
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
                attachedObjects: [
                    EnvironmentCreatePage {
                        id: environmentCreatePage
                        onEnvironmentCreated: {
                            environmentsDataModel.insert({
                                name: companyName + "/" + environmentName
                            });
                        }
                    }
                ]
                onTriggered: {
                    environmentCreatePage.open();
                }
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
                        id: item
                        TwoLineListContainer {
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
                                                var parts = ListItemData.name.split("/")
                                                  , companyName = parts[0]
                                                  , environmentName = parts[1];

                                                var deleted = giantswarm.deleteEnvironment(
                                                    companyName,
                                                    environmentName
                                                );

                                                if (deleted) {
                                                    item.ListItem.view.dataModel.removeAt(item.ListItem.indexPath);
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
                    environmentsDataModel.insertList(
                        giantswarm.getEnvironments().map(function (environment) {
                            return {
                                name: environment["company_name"] + "/" + environment["name"]
                            };
                        })
                    );
                }
            }
        }
    }
}