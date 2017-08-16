import React, { Component } from 'react'
import { connect } from 'react-redux';
import TimerWrap from 'components/timer_wrap'


class main extends Component {
  render() {
    return (
      <div>
        <TimerWrap />
      </div>
    )
  }
}

// Map Redux state to component props
function mapStateToProps(state) {
  return {}
}

// Map Redux actions to component props
function mapDispatchToProps(dispatch) {
  return {}
}

// Connected Component
const App = connect(
  mapStateToProps,
  mapDispatchToProps
)(main)

export default App
