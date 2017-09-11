const recordsReducer = function(state = [], action) {

  switch(action.type) {
    case 'GET_RECORDS':
      let data = [ ...state, ];
      for (let i = 0; i < action.data.length; i++) {
        data.push( action.data[i] );
      }
      return data

    case 'ADD_RECORD':
      let addRecord = [ ...state, ];
      addRecord.unshift( action.data );
      return addRecord

    default:
      return state;
  }

  return state;

}

export default recordsReducer;
