const activeTimerReducer = function(state = -1, action) {

  if (action.type == 'GET_ACTIVE_TIMER') {
    return state = action.id;
  }

  return state;

}

export default activeTimerReducer;
