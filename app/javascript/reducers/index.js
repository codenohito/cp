import { combineReducers } from 'redux';

// Reducers
import recordsReducer from 'reducers/records-reducer';
import timersReducer from 'reducers/timers-reducer';

// Combine Reducers
var reducers = combineReducers({
    recordsState: recordsReducer,
    timersState: timersReducer
});

export default reducers;
