const initialState = {
  amount: "",
  projectId: 0,
  nakamaId: "",
  comment: ""
};

const newRecordReducer = function(state = initialState, action) {

  switch(action.type) {
    case 'SET_AMOUNT':
      return _.assign(state, { amount: action.amount });

    default:
      return state;
  }

  return state;

}

export default newRecordReducer;
