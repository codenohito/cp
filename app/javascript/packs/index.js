import React from 'react'
import ReactDOM from 'react-dom'
import { combineReducers } from 'redux'
import { Provider } from 'react-redux'
import App from 'components/App'
import reducer from 'reducers'
import * as reducers from 'reducers';

const reducer = combineReducers(reducers);
const store = createStore(reducer)

const render = () => ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('root')
)
//
render()
store.subscribe(render)
