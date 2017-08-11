import React, { Component } from 'react'
import PropTypes from 'prop-types'

class Timer extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { value, onIncrement, onDecrement } = this.props
    return (
      <p>
        Hello World {value}
      </p>
    )
  }
}

export default Timer
