import React, { Component } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import SecondsTohhmmss from 'utils/SecondsTohhmmss'

// React component
export default class AddTimer extends Component {
  render () {
    console.log(this.props.activeTimer)
    return (
      <div>
        <p><a href="#" onClick={this.props.addTimer}>Add Timer</a></p>
        <h2>Active timers:</h2>
        <div>
          {this.props.activeTimer}
        </div>
      </div>
    );
  }
}
