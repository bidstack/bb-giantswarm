/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>

#include <bb/system/SystemToast>
#include <bb/system/SystemUiPosition>

#include "activeframe.hpp"

using namespace bb::cascades;
using namespace bb::system;

using namespace Bidstack::Giantswarm;

ApplicationUI::ApplicationUI() : QObject()
{
    QSqlDatabase connection = QSqlDatabase::addDatabase("QSQLITE", "giantswarm");
    connection.setDatabaseName("./data/giantswarm.db");
    connection.open();

    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);
    m_giantswarm = new GiantswarmClient(connection);

    bool res = QObject::connect(
        m_pLocaleHandler, SIGNAL(systemLanguageChanged()),
        this, SLOT(onSystemLanguageChanged())
    );

    Q_ASSERT(res);
    Q_UNUSED(res);

    // initial load
    onSystemLanguageChanged();

    // Application cover
    ActiveFrame* activeFrame = new ActiveFrame();
    Application::instance()->setCover(activeFrame);

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.

    AbstractPane *root;
    QmlDocument *qml;

    if (false) {
        qml = QmlDocument::create("asset:///qml/main.qml").parent(this);
        root = qml->createRootObject<AbstractPane>();
    } else {
        qml = QmlDocument::create("asset:///qml/Login/LoginPage.qml").parent(this);
        root = qml->createRootObject<AbstractPane>();
        qml->connect(root, SIGNAL(finished()), this, SLOT(onSetupFinished()));
    }

    qml->setContextProperty("giantswarm", m_giantswarm);

    // Set created root object as the application scene
    Application::instance()->setScene(root);
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);

    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();

    QString file_name = QString("GiantSwarm_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}

void ApplicationUI::onSetupFinished()
{
    QmlDocument *qml = QmlDocument::create("asset:///qml/main.qml").parent(this);
    qml->setContextProperty("giantswarm", m_giantswarm);

    AbstractPane *root = qml->createRootObject<AbstractPane>();
    Application::instance()->setScene(root);

    SystemToast *toast = new SystemToast(this);
    toast->setBody(tr("Happy swarming!"));
    toast->setPosition(SystemUiPosition::BottomCenter);
    toast->show();
}
