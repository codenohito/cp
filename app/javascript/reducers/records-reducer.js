import * as types from 'actions/action-types';

const initialState = {
  id:	0,
  theday:	'',
  amount:	0,
  nakama_id: 0,
  comment: '',
  created_at:	'',
  updated_at:	''
};

const recordsReducer = function(state = initialState, action) {

  return state;

}

export default recordsReducer;
