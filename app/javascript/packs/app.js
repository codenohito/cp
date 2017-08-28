import React, { Component } from 'react'
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux'
import axios from 'axios';
import TimerWrap from 'components/timer_wrap';
import { getTimers } from 'actions';

class main extends Component {
  constructor(props) {
    super(props)
    this.dance = this.dance.bind(this);
  }

  componentDidMount() {
    axios.get('/timer.json').then(response => {
       this.props.getTimers(response.data.timers)
    });
  }

  dance() {
    axios.get('/timer.json').then(response => {
      console.log("click")
      this.props.getTimers(response.data.timers)
    });
  }

  render() {
    return (
      <div>
        <TimerWrap timers={ this.props.timers }/>
        <button onClick={this.dance} className="pure-button">DANCEAPP</button>
      </div>
    )
  }
}

// Map Redux state to component props
function mapStateToProps(state) {
  return {
    timers: state.timersState
  }
}

// Map Redux actions to component props
function mapDispatchToProps(dispatch) {
  return {
    getTimers: (data) => dispatch(getTimers(data))
  }
}

// Connected Component
const App = connect(
  mapStateToProps,
  mapDispatchToProps
)(main)

export default App
