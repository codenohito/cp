const recordsReducer = function(state = [], action) {

  switch(action.type) {
    case 'GET_RECORDS':
      let arr = state;
      for (let i = 0; i < action.data.length ;i++) {
        arr.unshift(action.data[i])
      }
      console.log(arr)
      return arr.reverse();

    default:
      return state;
  }

  return state;

}

export default recordsReducer;
