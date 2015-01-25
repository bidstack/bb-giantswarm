import bb.cascades 1.3

import "Welcome"
import "Company"

TabbedPane {
    tabs: [
        Tab {
            title: qsTr("Welcome")
            WelcomePage {}
        },
        Tab {
            title: qsTr("Companies")
            CompaniesPage {}
        },
        Tab {
            title: qsTr("Environments")
            Page {}
        },
        Tab {
            title: qsTr("Applications")
            Page {}
        },
        Tab {
            title: qsTr("Account")
            Page {}
        }
    ]
}