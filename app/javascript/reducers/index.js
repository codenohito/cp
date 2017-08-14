// Reducer
export default (state = { count: 0, status: false }, action) => {
  const count = state.count
  switch (action.type) {
    case 'increase':
      return { count: count + 1, status: true }
    case 'PAUSE':
      return { count: count, status: false }
    case 'PLAY':
      return { count: count, status: true }
    case 'RESET':
      return { count: 0, status: true }
    default:
      return state
  }
}
