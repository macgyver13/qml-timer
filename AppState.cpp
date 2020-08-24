#include "AppState.h"

static QSharedPointer<AppState> sharedController = nullptr;

AppState::AppState(QObject *parent) : QObject(parent)
{
}

QSharedPointer<AppState> AppState::shared()
{
  if (sharedController == nullptr) {
    sharedController = QSharedPointer<AppState>(new AppState, &QObject::deleteLater);
  }
  return sharedController;
}

void AppState::setIsActive(bool isActive)
{
  m_isActive = isActive;
  emit isActiveChanged();
}

bool AppState::isActive()
{
  return m_isActive;
}
