import React, { Component } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import Timer from './timer'
import AddTimer from './add_timer'

export default class TimerWrap extends Component {
  constructor(props) {
    super(props)
    this.state = { numTimer: 0, data: {}, projects: [] };
  }

  componentDidMount() {
    axios.get('/timer.json').then(response => {
      let data = response.data;
      this.setState({ data: data })
      this.setState({ numTimer: data.timers.length })
    });
    axios.get('/projects.json').then(response => {
      this.setState({ projects: response.data.projects })
    })

    console.log(this.props.timers)
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
      axios.get('/timer.json').then(response => {
        let data = response.data;
        self.setState({ data: data })
        self.setState({ numTimer: data.timers.length })
      });
    })
  }

  onRemoveTimer() {
    axios.get('/timer.json').then(response => {
      let data = response.data;
      this.setState({ data: data })
      this.setState({ numTimer: data.timers.length })
    });
  }

  render() {
    const activeTimer = [];
    const timers = this.state.data.timers;

    for (let i = 0; i < this.state.numTimer; i += 1) {
      activeTimer.unshift(<Timer
                          key={i}
                          id={timers[i].id}
                          state={timers[i].state}
                          minutes={timers[i].minutes}
                          seconds={timers[i].seconds}
                          commentTimer={timers[i].comment}
                          projectId={timers[i].project_id}
                          projectTitles={this.state.projects}
                          removeTimer={this.onRemoveTimer.bind(this)}
                         />);
    };

    return (
      <section>
        <h2>Add a timer:</h2>
        <AddTimer
          addTimer={this.onAddActiveTimer.bind(this)}
          activeTimer={activeTimer}
          inputComment={(input) => this.comment = input}
          projects={this.state.projects}
          inputProject={(input) => this.project = input}
        />
      </section>

    )
  }
}
