import React, { Component } from 'react'
import { connect } from 'react-redux';
import axios from 'axios'
import Timer from 'components/timer'
import AddTimer from 'components/add_timer'
import { getTimers, playTimer, pauseTimer, finishTimer, addTimer, getActiveTimer } from 'actions';

class timerWrap extends Component {
  constructor(props) {
    super(props)

    this.state = {
      projects: []
    };

  }

  componentDidMount() {
    axios.get('/timer.json').then(response => {
      this.props.getTimers(response.data.timers)
    });
    axios.get('/projects.json').then(response => {
      this.setState({ projects: response.data.projects })
    })

  }

  onAddActiveTimer() {
      let comment = this.comment.value != null ? this.comment.value : "",
          project = this.project.value != null ?  this.project.value : "",
          token = document.head.querySelector("[name=csrf-token]").content,
          self = this;

      axios.post('/timer/new', {
        timer: {
          project_id: project,
          comment: comment
        },
        authenticity_token: token
      }).then(function (response) {
        self.props.addTimer(response.data.timer);
      })
  }

  render() {
    const timers = this.props.timers;
    let listTimer = null;

    if (timers.length) {

      listTimer = timers.map((timer, index) =>
        <Timer
          key={index}
          {...timer}

          playTimer={() => this.props.playTimer(timer.id)}
          pauseTimer={() => this.props.pauseTimer(timer.id)}
          finishTimer={() => this.props.finishTimer(timer.id)}

          project={
            this.state.projects.map(project =>
              (project.id === timer.project_id) ? project.title : ''
            )
          }

        />
      )
    }

    return (
      <div>
        <AddTimer
          projects={this.state.projects}
          addTimer={this.onAddActiveTimer.bind(this)}
          inputComment={(input) => this.comment = input}
          inputProject={(input) => this.project = input}
        />
        <br />
        <h2>Active timers: {this.state.dance}</h2>
        { timers.length ? listTimer : '0 active timers' }

      </div>
    )
  }

}

function mapStateToProps(state) {
  return {
    timers: state.timersState,
    activeTimer: state.activeTimerState
  }
}

function mapDispatchToProps(dispatch) {
  return {
    getTimers: (data) => dispatch(getTimers(data)),
    playTimer: (id) => dispatch(playTimer(id)),
    pauseTimer: (id) => dispatch(pauseTimer(id)),
    finishTimer: (id) => dispatch(finishTimer(id)),
    addTimer: (data) => dispatch(addTimer(data)),
    getActiveTimer: (id) => dispatch(getActiveTimer(id)),
  }
}

const TimerWrap = connect(
  mapStateToProps,
  mapDispatchToProps
)(timerWrap)

export default TimerWrap
