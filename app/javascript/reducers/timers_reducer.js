const timersReducer = function(state = [], action) {

  switch(action.type) {

    case 'GET_TIMERS':
      let data = [ ...state, ];
      for (let i = 0; i < action.data.length; i++) {
        data.push( action.data[i] );
      }
      return data

    case 'GET_TIMER_PLAY':
      return state.map(timer =>
        (timer.id !== action.id) ? timer : Object.assign({}, timer, {state: 'running'} )
      )

    case 'GET_TIMER_PAUSE':
      return state.map(timer =>
        (timer.id !== action.id) ? timer : Object.assign({}, timer, {state: 'paused'} )
      )

    case 'GET_TIMER_FINISH':
      return state.map(timer =>
        (timer.id !== action.id) ? timer : Object.assign({}, timer, {state: 'finished'} )
      )

    case 'ADD_TIMER':
      let addTimer = [ ...state, ];
      addTimer.push( action.data );
      return addTimer

    default:
      return state;

  }

  return state;

}

export default timersReducer;
