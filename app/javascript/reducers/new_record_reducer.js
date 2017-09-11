const initialState = {
  amount: "",
  project_id: 0,
  comment: ""
};

const newRecordReducer = function(state = initialState, action) {

  switch(action.type) {
    case 'SET_NEW_RECORD':
      return action.data;

    case 'GET_NEW_RECORD':
      return state;

    default:
      return state;
  }

  return state;

}

export default newRecordReducer;
