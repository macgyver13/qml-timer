#ifndef APPSTATE_H
#define APPSTATE_H

/* Singleton for use by c++ and QML for determining if the timer is running */

#include <QObject>
#include <QSharedPointer>

class AppState : public QObject
{
  Q_OBJECT

  Q_PROPERTY(bool isActive READ isActive WRITE setIsActive NOTIFY isActiveChanged)

public:
  explicit AppState(QObject *parent = nullptr);

  static QSharedPointer<AppState> shared();

  bool isActive();
  void setIsActive(bool isActive);

signals:
  void isActiveChanged();

private:
  bool m_isActive;
};

#endif // APPSTATE_H
