export const onRestartRequestStarted$ = (action$) =>
  action$.pipe(
    ofType(RESTART_REQUEST_STARTED),
    pluck("payload"),
    map((payload) =>
      setInRestart({
        inRestart: true,
        withToastMessage: payload.withToastMessage,
      })
    )
  );

export const onRestartRequestEnded$ = (action$) =>
  action$.pipe(
    ofType(RESTART_REQUEST_STARTED),
    switchMap(() => {
      return action$.pipe(
        ofType(SET_STATE),
        pluck("payload"),
        filter(equals(STATE.PLAYING)),
        mapTo(setInRestart({ inRestart: false, withToastMessage: true })),
        take(1)
      );
    })
  );

export const showNotificationOnRestart$ = (action$, state$) =>
  action$.pipe(
    ofType(SET_IN_RESTART),
    pluck("payload"),
    ifElse(
      ({ inRestart }) => inRestart,
      ({ withToastMessage }) => {
        if (withToastMessage) {
          return of(
            showLoadingNotification({
              message: toastMdcFallback(state$.value),
              hideOnTimeout: false,
              id: _RESTART_NOTIFICATION_ID,
            })
          );
        }

        return of(hideNotification(_RESTART_NOTIFICATION_ID));
      },
      () => of(hideNotification(_RESTART_NOTIFICATION_ID))
    )
  );