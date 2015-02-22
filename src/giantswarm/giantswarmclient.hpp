#ifndef GIANTSWARM_CLIENT_HPP
#define GIANTSWARM_CLIENT_HPP

#include <QObject>
#include <QVariantList>
#include <QVariantMap>

#include "../bidstack/http/httpclient.hpp"
#include "../bidstack/http/httpresponse.hpp"
#include "../bidstack/cache/abstractcacheadapter.hpp"

#include "../qjson4/QJsonObject.h"
#include "../qjson4/QJsonArray.h"

const QString GIANTSWARM_API_URL = "https://api.giantswarm.io/v1";

using namespace Bidstack::Http;
using namespace Bidstack::Cache;

namespace Giantswarm {

    class GiantswarmClient : public QObject {
        Q_OBJECT

    public:
        GiantswarmClient(QObject *parent = 0);

    public:
        void setCache(AbstractCacheAdapter *cache);

    public:
        Q_INVOKABLE bool login(QString email, QString password);
        Q_INVOKABLE bool logout();
        Q_INVOKABLE bool isLoggedIn();

        Q_INVOKABLE QVariantList getCompanies();
        Q_INVOKABLE bool hasCompanies();
        Q_INVOKABLE bool createCompany(QString companyName);
        Q_INVOKABLE bool deleteCompany(QString companyName);

        Q_INVOKABLE QVariantList getCompanyUsers(QString companyName);
        Q_INVOKABLE bool addUserToCompany(QString companyName, QString username);
        Q_INVOKABLE bool removeUserFromCompany(QString companyName, QString username);

        Q_INVOKABLE QVariantList getEnvironments();
        Q_INVOKABLE bool hasEnvironments();
        Q_INVOKABLE bool hasEnvironment(QString companyName, QString environmentName);
        Q_INVOKABLE bool createEnvironment(QString companyName, QString environmentName);
        Q_INVOKABLE bool deleteEnvironment(QString companyName, QString environmentName);

        Q_INVOKABLE QVariantList getApplications(QString companyName, QString environmentName);
        Q_INVOKABLE QVariantMap getApplicationStatus(QString companyName, QString environmentName, QString applicationName);
        Q_INVOKABLE QVariantMap getApplicationConfiguration(QString companyName, QString environmentName, QString applicationName);
        Q_INVOKABLE bool startApplication(QString companyName, QString environmentName, QString applicationName);
        Q_INVOKABLE bool stopApplication(QString companyName, QString environmentName, QString applicationName);
        Q_INVOKABLE bool scaleApplicationUp(QString companyName, QString environmentName, QString applicationName, QString serviceName, QString componentName);
        Q_INVOKABLE bool scaleApplicationUp(QString companyName, QString environmentName, QString applicationName, QString serviceName, QString componentName, int count);
        Q_INVOKABLE bool scaleApplicationDown(QString companyName, QString environmentName, QString applicationName, QString serviceName, QString componentName);
        Q_INVOKABLE bool scaleApplicationDown(QString companyName, QString environmentName, QString applicationName, QString serviceName, QString componentName, int count);

        Q_INVOKABLE QVariantMap getInstanceStatistics(QString companyName, QString instanceId);

        Q_INVOKABLE QVariantMap getUser();
        Q_INVOKABLE bool updateEmail(QString email);
        Q_INVOKABLE bool updatePassword(QString old_password, QString new_password);

        Q_INVOKABLE bool ping();

    private:
        HttpResponse* send(QString cacheKey, HttpRequest *request);
        HttpResponse* send(HttpRequest *request);

        QString generateCachableStringFromResponse(HttpResponse *response);
        HttpResponse* generateResponseFromCachableString(QString string);

        QJsonObject extractDataAsObject(HttpResponse* response);
        QJsonArray extractDataAsArray(HttpResponse* response);

    private:
        QString m_token;
        HttpClient *m_httpclient;
        AbstractCacheAdapter *m_cache;
    };

};

#endif
