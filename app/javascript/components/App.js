import React from 'react'
import { connect } from 'react-redux'
import Counter from 'components/Counter'

const App = (state, ownProps) => (
  <div>
    <Counter
      value={store.getState()}
      onIncrement={() => store.dispatch({ type: 'INCREMENT' })}
      onDecrement={() => store.dispatch({ type: 'DECREMENT' })}
    />
  </div>
)

export default App
