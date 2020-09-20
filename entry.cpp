#include "Entry.h"
#include <QQmlEngine>
#include "AppState.h"

Entry::Entry()
{

}

void Entry::registerQmlTypes()
{
  qmlRegisterSingletonType<AppState>("AppState", 1, 0, "AppState", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return AppState().shared().get();
  });
}
