import { combineReducers } from 'redux';

// Reducers
import recordsReducer from 'reducers/records_reducer';
import timersReducer from 'reducers/timers_reducer';
import activeTimerReducer from 'reducers/active_timer_reducer';

// Combine Reducers
var reducers = combineReducers({
    recordsState: recordsReducer,
    timersState: timersReducer,
    activeTimerState: activeTimerReducer
});

export default reducers;
