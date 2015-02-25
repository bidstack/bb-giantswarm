#include <QDebug>

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
    assertNotLoggedIn();

    QJsonObject object;
    object["password"] = QJsonValue(QString(password.toUtf8().toBase64()));

    QJsonDocument doc;
    doc.setObject(object);

    HttpRequest *request = new HttpRequest();
    request->setMethod("POST");
    request->setUrl(GIANTSWARM_API_URL + "/user/" + email + "/login");
    request->setBody(new HttpBody(doc.toJson()));

    HttpResponse *response = send(request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_SUCCESS);

    QJsonObject data = extractDataAsObject(response);
    m_token = data.take("Id").toString();

    if (m_token.isEmpty()) {
        qWarning() << "Could not find token in response!";
        return false;
    }

    return true;
}

bool GiantswarmClient::logout() {
    assertLoggedIn();

    HttpRequest* request = new HttpRequest();
    request->setMethod("POST");
    request->setUrl(GIANTSWARM_API_URL + "/token/logout");

    HttpResponse *response = send(request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_SUCCESS);

    m_token = "";
    return true;
}

bool GiantswarmClient::isLoggedIn() {
    return !m_token.isEmpty();
}

/**
 * Companies
 */

QVariantList GiantswarmClient::getCompanies() {
    assertLoggedIn();

    HttpRequest* request = new HttpRequest();
    request->setMethod("GET");
    request->setUrl(GIANTSWARM_API_URL + "/user/me/memberships");

    HttpResponse *response = send("companies", request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_SUCCESS);

    QVariantList companies;
    QJsonArray data = extractDataAsArray(response);

    for (int i = 0; i < data.size(); ++i) {
        companies.append(data.takeAt(i).toString());
    }

    return companies;
}

bool GiantswarmClient::hasCompanies() {
    return getCompanies().size() > 0;
}

bool GiantswarmClient::createCompany(QString companyName) {
    assertLoggedIn();

    QJsonObject object;
    object["company_id"] = QJsonValue(QString(companyName.toUtf8().toBase64()));

    QJsonDocument doc;
    doc.setObject(object);

    HttpRequest* request = new HttpRequest();
    request->setMethod("POST");
    request->setUrl(GIANTSWARM_API_URL + "/company");
    request->setBody(new HttpBody(doc.toJson()));

    HttpResponse* response = send(request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_CREATED);

    return true;
}

bool GiantswarmClient::deleteCompany(QString companyName) {
    assertLoggedIn();

    HttpRequest* request = new HttpRequest();
    request->setMethod("DELETE");
    request->setUrl(GIANTSWARM_API_URL + "/company/" + companyName);

    HttpResponse* response = send(request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_DELETED);

    return true;
}

/**
 * Company users
 */

QVariantList GiantswarmClient::getCompanyUsers(QString companyName) {
    assertLoggedIn();

    HttpRequest* request = new HttpRequest();
    request->setMethod("GET");
    request->setUrl(GIANTSWARM_API_URL + "/company/" + companyName);

    HttpResponse* response = send("company_users", request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_SUCCESS);

    QJsonObject data = extractDataAsObject(response);
    QJsonArray members = data["members"].toArray();

    QVariantList users;
    for (int i = 0; i < members.size(); ++i) {
        users.append(members.takeAt(i).toString());
    }

    return users;
}

bool GiantswarmClient::addUserToCompany(QString companyName, QString username) {
    assertLoggedIn();

    QJsonObject object;
    object["username"] = QJsonValue(QString(username.toUtf8().toBase64()));

    QJsonDocument doc;
    doc.setObject(object);

    HttpRequest* request = new HttpRequest();
    request->setMethod("POST");
    request->setUrl(GIANTSWARM_API_URL + "/company/" + companyName + "/members/add");
    request->setBody(new HttpBody(doc.toJson()));

    HttpResponse* response = send(request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_UPDATED);

    return true;
}

bool GiantswarmClient::removeUserFromCompany(QString companyName, QString username) {
    assertLoggedIn();

    QJsonObject object;
    object["username"] = QJsonValue(QString(username.toUtf8().toBase64()));

    QJsonDocument doc;
    doc.setObject(object);

    HttpRequest* request = new HttpRequest();
    request->setMethod("POST");
    request->setUrl(GIANTSWARM_API_URL + "/company/" + companyName + "/members/remove");
    request->setBody(new HttpBody(doc.toJson()));

    HttpResponse* response = send(request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_UPDATED);

    return true;
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

QVariantList GiantswarmClient::getApplications(QString companyName, QString environmentName) {
    Q_UNUSED(companyName);
    Q_UNUSED(environmentName);
    QVariantList applications;
    return applications;
}

QVariantMap GiantswarmClient::getApplicationStatus(QString companyName, QString environmentName, QString applicationName) {
    Q_UNUSED(companyName);
    Q_UNUSED(environmentName);
    Q_UNUSED(applicationName);
    QVariantMap status;
    return status;
}

QVariantMap GiantswarmClient::getApplicationConfiguration(QString companyName, QString environmentName, QString applicationName) {
    Q_UNUSED(companyName);
    Q_UNUSED(environmentName);
    Q_UNUSED(applicationName);
    QVariantMap configuration;
    return configuration;
}

bool GiantswarmClient::startApplication(QString companyName, QString environmentName, QString applicationName) {
    Q_UNUSED(companyName);
    Q_UNUSED(environmentName);
    Q_UNUSED(applicationName);
    return false;
}

bool GiantswarmClient::stopApplication(QString companyName, QString environmentName, QString applicationName) {
    Q_UNUSED(companyName);
    Q_UNUSED(environmentName);
    Q_UNUSED(applicationName);
    return false;
}

bool GiantswarmClient::scaleApplicationUp(QString companyName, QString environmentName, QString applicationName, QString serviceName, QString componentName) {
    return scaleApplicationUp(
        companyName,
        environmentName,
        applicationName,
        serviceName,
        componentName,
        1 // scale up by 1 instance
    );
}

bool GiantswarmClient::scaleApplicationUp(QString companyName, QString environmentName, QString applicationName, QString serviceName, QString componentName, int count) {
    assertLoggedIn();

    HttpRequest* request = new HttpRequest();
    request->setMethod("POST");
    request->setUrl(GIANTSWARM_API_URL + "/company/" + companyName + "/env/" + environmentName + "/app/" + applicationName + "/service/" + serviceName + "/component/" + componentName + "/scaleup/" + QString::number(count));

    HttpResponse* response = send(request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_UPDATED);

    return true;
}

bool GiantswarmClient::scaleApplicationDown(QString companyName, QString environmentName, QString applicationName, QString serviceName, QString componentName) {
    return scaleApplicationUp(
        companyName,
        environmentName,
        applicationName,
        serviceName,
        componentName,
        1 // scale down by 1 instance
    );
}

bool GiantswarmClient::scaleApplicationDown(QString companyName, QString environmentName, QString applicationName, QString serviceName, QString componentName, int count) {
    assertLoggedIn();

    HttpRequest* request = new HttpRequest();
    request->setMethod("POST");
    request->setUrl(GIANTSWARM_API_URL + "/company/" + companyName + "/env/" + environmentName + "/app/" + applicationName + "/service/" + serviceName + "/component/" + componentName + "/scaleup/" + QString::number(count));

    HttpResponse* response = send(request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_DELETED);

    return true;
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
    assertLoggedIn();

    HttpRequest* request = new HttpRequest();
    request->setMethod("GET");
    request->setUrl(GIANTSWARM_API_URL + "/user/me");

    HttpResponse* response = send("user", request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_SUCCESS);

    QJsonObject data = extractDataAsObject(response);

    QVariantMap user;
    user["name"] = data.take("username").toString();
    user["email"] = data.take("email").toString();

    return user;
}

bool GiantswarmClient::updateEmail(QString email) {
    assertLoggedIn();

    QVariantMap user = getUser();

    QJsonObject object;
    object["old_email"] = QJsonValue(user.take("email").toString());
    object["new_email"] = QJsonValue(email);

    QJsonDocument doc;
    doc.setObject(object);

    HttpRequest* request = new HttpRequest();
    request->setMethod("POST");
    request->setUrl(GIANTSWARM_API_URL + "/user/me/email/update");
    request->setBody(new HttpBody(doc.toJson()));

    HttpResponse* response = send(request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_UPDATED);

    return true;
}

bool GiantswarmClient::updatePassword(QString old_password, QString new_password) {
    assertLoggedIn();

    QVariantMap user = getUser();

    QJsonObject object;
    object["old_password"] = QJsonValue(QString(old_password.toUtf8().toBase64()));
    object["new_password"] = QJsonValue(QString(new_password.toUtf8().toBase64()));

    QJsonDocument doc;
    doc.setObject(object);

    HttpRequest* request = new HttpRequest();
    request->setMethod("POST");
    request->setUrl(GIANTSWARM_API_URL + "/user/me/password/update");
    request->setBody(new HttpBody(doc.toJson()));

    HttpResponse* response = send(request);
    assertStatusCode(response, GIANTSWARM_STATUS_CODE_UPDATED);

    return true;
}

/**
 * Cluster
 */

bool GiantswarmClient::ping() {
    HttpRequest* request = new HttpRequest();
    request->setMethod("GET");
    request->setUrl(GIANTSWARM_API_URL + "/ping");

    HttpResponse* response = send(request);

    return response->body()->toString() == "\"OK\"";
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
    m_cache->store(cacheKey, generateCachableStringFromResponse(response));

    return response;
}

HttpResponse* GiantswarmClient::send(HttpRequest *request) {
    QMap<QString, QString> headers;
    headers["Accept"] = "application/json";
    headers["User-Agent"] = "bb-giantswarm/0.0.1";

    if (!m_token.isEmpty()) {
        headers["Authorization"] = "giantswarm " + m_token;
    }

    if (!request->body()->isEmpty()) {
        headers["Content-Type"] = "application/json";
    }

    request->setHeaders(headers);

    HttpResponse* response = m_httpclient->send(request);

    if (response->isForbidden()) {
        throw "Not allowed to request URI!";
    } else if (response->isClientError()) {
        throw "An client error occured!";
    } else if (response->isServerError()) {
        throw "An server error occured!";
    } else if (response->isRedirection()) {
        throw "Received response contains a redirection!";
    } else if (response->isNotFound()) {
        throw "Requested URI does not exist!";
    } else if (!response->isSuccessful()) {
        throw "Unexpected response status!";
    }

    return response;
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

/**
 * Helpers
 */

QJsonObject GiantswarmClient::extractDataAsObject(HttpResponse* response) {
    QByteArray json = response->body()->toByteArray();

    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(json, &err);

    if (doc.isNull()) {
        qWarning() << "Failed to parse JSON:" << err.errorString();
        return QJsonObject();
    }

    return doc.object()["data"].toObject();
}

QJsonArray GiantswarmClient::extractDataAsArray(HttpResponse* response) {
    QByteArray json = response->body()->toByteArray();

    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(json, &err);

    if (doc.isNull()) {
        qWarning() << "Failed to parse JSON:" << err.errorString();
        return QJsonArray();
    }

    return doc.object()["data"].toArray();
}

/**
 * Assertions
 */

void GiantswarmClient::assertLoggedIn() {
    if (!isLoggedIn()) {
        throw "You need to be logged in to use this method!";
    }
}

void GiantswarmClient::assertNotLoggedIn() {
    if (isLoggedIn()) {
        throw "You need to be logged out to use this method!";
    }
}

void GiantswarmClient::assertStatusCode(HttpResponse* response, int status) {
    QByteArray data = response->body()->toByteArray();

    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(data, &err);

    if (doc.isNull()) {
        throw "Could not parse JSON to check status_code: " + err.errorString();
    }

    if ((int)doc.object()["status_code"].toDouble() != status) {
        throw "Status code mismatch!";
    }
}
