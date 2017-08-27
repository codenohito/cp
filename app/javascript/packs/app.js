import React, { Component } from 'react'
import { connect } from 'react-redux';
import axios from 'axios';
import TimerWrap from 'components/timer_wrap'

class main extends Component {
  componentDidMount() {
    axios.get('/timer.json').then(response => {
      store.dispatch({
        type: 'TIMERS_LIST',
        timers: response.data.timers
      });
    });
  }

  render() {
    return (
      <div>
        <TimerWrap timers={ this.props.timers }/>
      </div>
    )
  }
}

// Map Redux state to component props
function mapStateToProps(state) {
  return {
    timers: store.timersState.timers
  }
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
