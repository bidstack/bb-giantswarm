#include "giantswarmclient.hpp"

using namespace Giantswarm;

GiantswarmClient::GiantswarmClient(QObject *parent) : QObject(parent) {
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

bool GiantswarmClient::updateEmail(QString email) {
    Q_UNUSED(email);
    return false;
}

bool GiantswarmClient::updatePassword(QString password) {
    Q_UNUSED(password);
    return false;
}

