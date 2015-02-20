#include "giantswarmclient.hpp"

#include "../bidstack/cache/devnullcacheadapter.hpp"

#include "../qjson4/QJsonDocument.h"
#include "../qjson4/QJsonObject.h"
#include "../qjson4/QJsonArray.h"
#include "../qjson4/QJsonParseError.h"

using namespace Giantswarm;
using namespace Bidstack::Http;
using namespace Bidstack::Cache;

GiantswarmClient::GiantswarmClient(QObject *parent) : QObject(parent) {
    m_httpclient = new HttpClient();
    m_cache = new DevNullCacheAdapter();
    m_token = "";
}

/**
 * Authentication
 */

bool GiantswarmClient::login(QString email, QString password) {
    Q_UNUSED(email);
    Q_UNUSED(password);
    return false;
}

bool GiantswarmClient::logout() {
    return false;
}

bool GiantswarmClient::isLoggedIn() {
    return !m_token.isEmpty();
}

/**
 * Companies
 */

QVariantList GiantswarmClient::getCompanies() {
    QVariantList companies;
    return companies;
}

bool GiantswarmClient::hasCompanies() {
    return getCompanies().size() > 0;
}

bool GiantswarmClient::createCompany(QString companyName) {
    Q_UNUSED(companyName);
    return false;
}

bool GiantswarmClient::deleteCompany(QString companyName) {
    Q_UNUSED(companyName);
    return false;
}

/**
 * Company users
 */

QVariantList GiantswarmClient::getCompanyUsers(QString companyName) {
    Q_UNUSED(companyName);
    QVariantList users;
    return users;
}

bool GiantswarmClient::addUserToCompany(QString companyName, QString username) {
    Q_UNUSED(companyName);
    Q_UNUSED(username);
    return false;
}

bool GiantswarmClient::removeUserFromCompany(QString companyName, QString username) {
    Q_UNUSED(companyName);
    Q_UNUSED(username);
    return false;
}

/**
 * Environments
 */

QVariantList GiantswarmClient::getEnvironments() {
    QVariantList environments;
    return environments;
}

bool GiantswarmClient::hasEnvironments() {
    return getEnvironments().size() >= 1;
}

bool GiantswarmClient::hasEnvironment(QString companyName, QString environmentName) {
    Q_UNUSED(companyName);
    Q_UNUSED(environmentName);
    return false;
}

bool GiantswarmClient::createEnvironment(QString companyName, QString environmentName) {
    Q_UNUSED(companyName);
    Q_UNUSED(environmentName);
    return false;
}

bool GiantswarmClient::deleteEnvironment(QString companyName, QString environmentName) {
    Q_UNUSED(companyName);
    Q_UNUSED(environmentName);
    return false;
}

/**
 * Applications
 */

QVariantMap GiantswarmClient::getApplications() {
    QVariantMap applications;
    return applications;
}

/**
 * Instances
 */

QVariantMap GiantswarmClient::getInstanceStatistics(QString companyName, QString instanceId) {
    Q_UNUSED(companyName);
    Q_UNUSED(instanceId);
    QVariantMap statistics;
    return statistics;
}

/**
 * Account
 */

QVariantMap GiantswarmClient::getUser() {
    QVariantMap user;
    return user;
}

bool GiantswarmClient::updateEmail(QString email) {
    Q_UNUSED(email);
    return false;
}

bool GiantswarmClient::updatePassword(QString password) {
    Q_UNUSED(password);
    return false;
}

/**
 * Caching
 */

void GiantswarmClient::setCache(AbstractCacheAdapter *cache) {
    m_cache = cache;
}

/**
 * HTTP handling
 */

HttpResponse* GiantswarmClient::send(QString cacheKey, HttpRequest *request) {
    if (m_cache->has(cacheKey)) {
        return generateResponseFromCachableString(m_cache->fetch(cacheKey));
    }

    HttpResponse *response = send(request);

    if (response->isSuccessful()) {
        m_cache->store(cacheKey, generateCachableStringFromResponse(response));
    }

    return response;
}

HttpResponse* GiantswarmClient::send(HttpRequest *request) {
    return m_httpclient->send(request);
}

/**
 * Example:
 *
 *   {
 *     "status": 200,
 *     "headers": [ { "name": "Content-Type", "value": "application/json" } ],
 *     "body": "{\"result\":\"success\"}"
 *   }
 *
 */
QString GiantswarmClient::generateCachableStringFromResponse(HttpResponse* response) {
    QMap<QString, QString> responseHeaders = response->headers();

    QJsonArray headers;
    foreach (QString key, responseHeaders.keys()) {
        QJsonObject header;
        header["name"] = QJsonValue(key);
        header["value"] = QJsonValue(responseHeaders[key]);
        headers.append(QJsonValue(headers));
    }

    QJsonObject object;
    object["status"] = QJsonValue(response->status());
    object["headers"] = QJsonValue(headers);
    object["body"] = QJsonValue(response->body()->toString());

    QJsonDocument doc;
    doc.setObject(object);

    return QString(doc.toJson());
}

HttpResponse* GiantswarmClient::generateResponseFromCachableString(QString string) {
    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(string.toUtf8(), &err);

    if (doc.isNull()) {
        throw "Failed to parse cached HTTP response: " + err.errorString();
    }

    QJsonObject object = doc.object();
    QJsonArray headers = object.take("headers").toArray();

    QMap<QString, QString> responseHeaders;
    for (int i = 0; i < headers.size(); ++i) {
        QJsonObject header = headers.at(i).toObject();
        QString name = header.take("name").toString();
        QString value = header.take("value").toString();
        responseHeaders[name] = value;
    }

    HttpResponse *response = new HttpResponse(
        object.take("status").toInt(),
        responseHeaders,
        new HttpBody(object.take("body").toString())
    );

    return response;
}
