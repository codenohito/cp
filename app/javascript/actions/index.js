export const getTimers = ( data ) => ({
  type: 'GET_TIMERS',
  data
})

export const playTimer = ( id ) => ({
  type: 'GET_TIMER_PLAY',
  id
})

export const pauseTimer = ( id ) => ({
  type: 'GET_TIMER_PAUSE',
  id
})

export const finishTimer = ( id ) => ({
  type: 'GET_TIMER_FINISH',
  id
})

export const addTimer = ( data ) => ({
  type: 'ADD_TIMER',
  data
})

export const getActiveTimer = ( id ) => ({
  type: 'GET_ACTIVE_TIMER',
  id
})

export const getRecords = ( data ) => ({
  type: 'GET_RECORDS',
  data
})

export const addRecord = ( data ) => ({
  type: 'ADD_RECORD',
  data
})

export const getNewRecord = () => ({
  type: 'GET_NEW_RECORD'
})

export const setNewRecord = ( data ) => ({
  type: 'SET_NEW_RECORD',
  data
})
