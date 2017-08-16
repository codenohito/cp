import React, { Component } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import SecondsTohhmmss from 'utils/SecondsTohhmmss'

// React component
export default class Timer extends Component {
  constructor(props) {
    super(props)
    this.state = { clock: 0, time: '', offset: null, interval: null};
    this.reset = this.reset.bind(this);
    this.play = this.play.bind(this);
    this.pause = this.pause.bind(this);
  }

  componentDidMount() {
    // axios.get('/timer.json').then(response => {
    //   console.log(response.data)
    // });

    if (this.props.state == "running") {
      this.setState({clock: this.props.minutes * 60000 + this.props.seconds * 10})
      this.play()
    } else if (this.props.state == "paused") {
      this.setState({clock: this.props.minutes * 60000 + this.props.seconds * 1000})
      let time = SecondsTohhmmss((this.props.minutes * 60000 + this.props.seconds * 1000) / 1000)
      this.setState({time: time })
      this.pause();
    } else {
      this.reset();
      this.pause();
    }

  }

  componentWillUnmount() {
    this.pause()
  }

  reset() {
    let clockReset = 0
    this.setState({clock: clockReset })
    let time = SecondsTohhmmss(clockReset / 1000)
    this.setState({time: time })
  }

  update() {
    let clock = this.state.clock
    clock += this.calculateOffset()
    this.setState({clock: clock })
    let time = SecondsTohhmmss(clock / 1000)
    this.setState({time: time })
  }

  calculateOffset() {
    let now = Date.now()
    let newOffset = now - this.state.offset
    this.setState({offset: now })
    return newOffset
  }

  pause() {
    if (this.state.interval) {
      clearInterval(this.state.interval)
      this.setState({interval: null })

      let requestLink = `/timer/${this.props.id}/pause`

      console.log(requestLink)
      axios.get(requestLink)
    }
  }

  play() {
    if (!this.state.interval) {
      this.setState({offset: Date.now() })
      this.setState({interval: setInterval(this.update.bind(this), 1000) })

      let requestLink = `/timer/${this.props.id}/run`

      console.log(requestLink)

      axios.get(requestLink)
    }
  }

  render() {
    const timerStyle = {
      margin: "10px 0",
      padding: "2em",
      border: "1px solid #eee"
    };

    const buttonStyle = {
      background: "#fff",
      color: "#666",
      border: "1px solid #ddd",
      margin: "0.25em",
      padding: "0.75em",
      fontWeight: "200"
    };

    const secondsStyles = {
      fontSize: "200%",
      fontWeight: "200",
      lineHeight: "1.5",
      margin: "0px",
      color: "#666",
      display: "inline-block"
    };

    const groupButtons = {
      float: "right"
    }

    return (
      <div style={timerStyle} className="react-timer">
        <h3 style={secondsStyles} className="seconds"> {this.state.time} {this.props.prefix}</h3>
        <div style={groupButtons}>
          <button onClick={this.reset} style={buttonStyle} >reset</button>
          <button onClick={this.play} style={buttonStyle} >play</button>
          <button onClick={this.pause} style={buttonStyle} >pause</button>
        </div>
      </div>
    )
  }
}
