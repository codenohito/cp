const recordsReducer = function(state = [], action) {

  switch(action.type) {
    case 'GET_RECORDS':
      return _.concat(state, action.data);

    default:
      return state;
  }

  return state;

}

export default recordsReducer;
