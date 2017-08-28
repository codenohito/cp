//   case types.GET_TIMER_NEW:
//     return state;
//
//   case types.GET_TIMER_RUN:
//     return state;
//
//   case types.GET_TIMER_PAUSE:
//     return state;
//
//   case types.GET_TIMER_FINISH:
//     return state;
//
//   case types.GET_TIMER_STATUS:
//     return state;
//
//   case 'GET_TIMER_LIST':
//     return state;
// }

const timersReducer = function(state = 0, action) {

  switch(action.type) {

    case 'GET_TIMERS_LIST':
      return state = action.data;

    default:
      return state;

  }

  return state;

}

export default timersReducer;
