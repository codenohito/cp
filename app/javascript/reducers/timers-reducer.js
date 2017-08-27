import * as types from 'actions/action-types';

const initialState = {
  id: 0,
  nakama_id: 0,
  state: '',
  minutes: 0,
  seconds: 0,
  project_id: 0,
  comment: '',
  timers: {}
}

const timersReducer = function(state = initialState, action) {

  switch(action.type) {

    case types.GET_TIMER_NEW:
      return state;

    case types.GET_TIMER_RUN:
      return state;

    case types.GET_TIMER_PAUSE:
      return state;

    case types.GET_TIMER_FINISH:
      return state;

    case types.GET_TIMER_STATUS:
      return state;

  }

  return state;

}

export default timersReducer;
