import React, { Component } from 'react'
import { connect } from 'react-redux';
import axios from 'axios'
import Timer from 'components/timer'
import AddTimer from 'components/add_timer'
import { getTimers, playTimer, pauseTimer, finishTimer, addTimer, getActiveTimer, setNewRecord, getNewRecord } from 'actions';

class timerWrap extends Component {
  constructor(props) {
    super(props)

    this.state = {
      projects: []
    }
    this.setFinishAmountTimer = this.setFinishAmountTimer.bind(this)
  }

  componentDidMount() {
    axios.get('/timer.json').then(response => {
      this.props.getTimers(response.data.timers)
    });
    axios.get('/projects.json').then(response => {
      this.setState({ projects: response.data.projects })
    })
  }

  onAddActiveTimer(event) {
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
    event.preventDefault();
  }

  setFinishAmountTimer(newData) {
    this.props.setNewRecord(newData)
  }

  renderChildrenTimers() {
    const timers = this.props.timers;
    let listTimer = null;

    listTimer = timers.map((timer, index) =>
      <Timer
        key={index}
        {...timer}

        playTimer={() => this.props.playTimer(timer.id)}
        pauseTimer={() => this.props.pauseTimer(timer.id)}
        finishTimer={() => this.props.finishTimer(timer.id)}

        onActivetimer={() => this.props.getActiveTimer(timer.id)}
        onPauseActiveTimer={() => this.props.getActiveTimer(-1)}
        isActive={this.props.activeTimer}

        project={
          this.state.projects.map(project =>
            (project.id === timer.project_id) ? project.title : ''
          )
        }

        getFinishData={(newData) => this.setFinishAmountTimer(newData)}

      />
    )

    return listTimer;
  }

  render() {
    return (
      <div>
        <h1>Timer</h1>
        <AddTimer
          projects={this.state.projects}
          addTimer={this.onAddActiveTimer.bind(this)}
          inputComment={(input) => this.comment = input}
          inputProject={(input) => this.project = input}
        />
        <br />
        <h2>Active timers:</h2>
        { this.props.timers.length ? this.renderChildrenTimers() : '0 active timers' }

      </div>
    )
  }

}

function mapStateToProps(state) {
  return {
    timers: state.timersState,
    activeTimer: state.activeTimerState,
    newRecord: state.newRecordState
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
    setNewRecord: (data) => dispatch(setNewRecord(data)),
    getNewRecord: () => dispatch(getNewRecord())
  }
}

const TimerWrap = connect(
  mapStateToProps,
  mapDispatchToProps
)(timerWrap)

export default TimerWrap
