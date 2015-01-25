import bb.cascades 1.3

import "Welcome"
import "Company"
import "Environment"
import "Account"

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
            EnvironmentsPage {}
        },
        Tab {
            title: qsTr("Applications")
            Page {}
        },
        Tab {
            title: qsTr("Account")
            AccountPage {}
        }
    ]
}