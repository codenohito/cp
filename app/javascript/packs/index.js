import React, { Component } from 'react'
import PropTypes from 'prop-types'
import ReactDOM from 'react-dom'
import { createStore } from 'redux'
import { Provider, connect } from 'react-redux'
import timer from 'reducers'
import axios from 'axios';
import SecondsTohhmmss from './SecondsTohhmmss'

let offset = null, interval = null

// Action
const increaseAction = { type: 'increase' }
const pause = { type: 'PAUSE' }
const play = { type: 'PLAY' }
const reset = { type: 'RESET' }

// React component
export default class Timer extends Component {
  constructor(props) {
    super(props)
    this.state = { clock: 0, time: ''};
    this.reset = this.reset.bind(this);
    this.play = this.play.bind(this);
    this.pause = this.pause.bind(this);
  }

  componentDidMount() {
    axios.get('/timer.json').then(response => {
      console.log(response.data)
    });
    // axios.get('/timer/new/run').then(response => {
    //   this.props.onClockReset()
    //   this.play()
    // });
  }

  componentWillUnmount() {
    this.pause()
  }

  reset() {
    this.props.onClockReset()
    let clockReset = 0
    this.setState({clock: clockReset })
    let time = SecondsTohhmmss(clockReset / 1000)
    this.setState({time: time })
    this.props.onClockReset()
  }

  update() {
    let clock = this.state.clock
    clock += this.calculateOffset()
    this.setState({clock: clock })
    let time = SecondsTohhmmss(clock / 1000)
    this.setState({time: time })

    this.props.onIncreaseClick(time)
  }

  calculateOffset() {
    let now = Date.now()
    let newOffset = now - offset
    offset = now
    return newOffset
  }

  pause() {
    if (interval) {
      clearInterval(interval)
      interval = null
      this.props.onPause()

      // axios.get('/timer/new/run').then(response => {
      //   console.log(response.data)
      // });
    }
  }

  play() {
    if (!interval) {
      offset = Date.now()
      interval = setInterval(this.update.bind(this), 1000)
      this.props.onPlay()

      // axios.get('/timer/new/run').then(response => {
      //   console.log(response.data)
      // });
    }
  }

  render() {
    const { value, status, onIncreaseClick, onPlay, onPause, onClockReset } = this.props

    const timerStyle = {
      margin: "0px",
      padding: "2em"
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
      color: "#666"
    };

    return (
      <div style={timerStyle} className="react-timer">
        <h3 style={secondsStyles} className="seconds"> {this.state.time} {this.props.prefix}</h3>
        <br />
        <button onClick={this.reset} style={buttonStyle} >reset</button>
        <button onClick={this.play} style={buttonStyle} >play</button>
        <button onClick={this.pause} style={buttonStyle} >pause</button>
        <br />
        <div>
          <span>{value}</span>
          <br />
          <span>{status + ""}</span>
        </div>
      </div>
    )
  }
}

Timer.propTypes = {
  value: PropTypes.number.isRequired,
  status: PropTypes.bool,
  onIncreaseClick: PropTypes.func.isRequired,
  onPause: PropTypes.func,
  onPlay: PropTypes.func,
  onClockReset: PropTypes.func,
  options: PropTypes.object
}

// Store
const store = createStore(timer)

// Map Redux state to component props
function mapStateToProps(state) {
  return {
    value: state.count,
    status: state.status
  }
}

// Map Redux actions to component props
function mapDispatchToProps(dispatch) {
  return {
    onIncreaseClick: () => dispatch(increaseAction),
    onPause: () => dispatch(pause),
    onPlay: () => dispatch(play),
    onClockReset: () => dispatch(reset)
  }
}

// Connected Component
const App = connect(
  mapStateToProps,
  mapDispatchToProps
)(Timer)

ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('root')
)
