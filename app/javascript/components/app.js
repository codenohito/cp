import React, { Component } from 'react'
import TimerWrap from 'containers/timer_wrap';
import RecordWrap from 'containers/record_wrap';

class App extends Component {
  render() {
    return (
      <div className="pure-g time-record-layout">
        <div className="timer-wrap pure-u-1 pure-u-md-1-2">
          <TimerWrap />
        </div>
        <div className="records-wrap pure-u-1 pure-u-md-1-2">
          <RecordWrap/>
        </div>
      </div>
    )
  }
}

export default App
