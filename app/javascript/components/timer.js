import React, { Component } from 'react'
import axios from 'axios'
import SecondsTohhmmss from 'utils/SecondsTohhmmss'

class Timer extends Component {
  constructor(props) {
    super(props)

    this.state = {
      clock: 0,
      time: '',
      offset: null,
      interval: null,
    };

    this.play = this.play.bind(this);
    this.pause = this.pause.bind(this);
    this.finish = this.finish.bind(this);
    this.reset = this.reset.bind(this);
  }

  componentDidMount() {
    if (this.props.state == 'running') {

      this.setState({clock: this.props.minutes * 60000 + this.props.seconds * 1000});
      this.play();

    } else if (this.props.state == 'paused') {

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

  update() {

    let clock = this.state.clock
    clock += this.calculateOffset()
    this.setState({clock: clock })

    let time = SecondsTohhmmss(clock / 1000)
    this.setState({time: time })

    document.title = this.state.time;

  }

  calculateOffset() {

    let now = Date.now()
    let newOffset = now - this.state.offset
    this.setState({offset: now })

    return newOffset

  }

  play() {

    if (!this.state.interval) {
      this.setState({offset: Date.now() })
      this.setState({interval: setInterval(this.update.bind(this), 1000) })

      let requestLink = `/timer/${this.props.id}/run`

      axios.get(requestLink)

      this.props.playTimer()
    }

  }

  pause() {

    if (this.state.interval) {
      clearInterval(this.state.interval)
      this.setState({interval: null })

      let requestLink = `/timer/${this.props.id}/pause`

      axios.get(requestLink)

      this.props.pauseTimer()
    }

  }

  finish() {

    clearInterval(this.state.interval)
    this.setState({interval: null })

    let requestLink = `/timer/${this.props.id}/finish`
    axios.get(requestLink)

    let elTimeRecord = document.getElementById('time_record_amount'),
        elProjectRecord = document.getElementById('time_record_project_id'),
        elCommentRecord = document.getElementById('time_record_comment');

    elTimeRecord.value = Math.round(this.state.clock / 60000)
    elProjectRecord.value = this.props.project_id
    elCommentRecord.value = this.props.comment

    this.props.finishTimer()
  }

  reset() {

    let clockReset = 0;
    this.setState({clock: clockReset })

    let time = SecondsTohhmmss(clockReset / 1000);
    this.setState({time: time })

  }

  render() {
    return (
      <div>
        { (this.props.state == 'finished') ? '' :
          <div className={ (this.props.state == 'paused') ? 'react-timer' : 'react-timer react-timer-active' }>
            <div className="pure-u-1-3">
              <h3 className="react-timer-project">{this.props.project}</h3>
              <p className="react-timer-comment">{this.props.comment}</p>
            </div>
            <div className="pure-u-2-3 timer-block">
              <h3 className="seconds">{this.state.time}</h3>
              <br />
              <div className="timer-button-group">
                <button onClick={this.pause} className="pure-button">pause</button>
                <button onClick={this.play} className="pure-button is-button-active">play</button>
                <button onClick={this.finish} className="pure-button timer-button-finish" >finish</button>
              </div>
            </div>
          </div>
        }
    </div>
    )
  }
}

export default Timer
