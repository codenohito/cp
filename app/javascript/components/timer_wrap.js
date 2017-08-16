import React, { Component } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import Timer from './timer'
import AddTimer from './add_timer'

export default class TimerWrap extends Component {
  constructor(props) {
    super(props)
    this.state = { numTimer: 0, data: {} };
  }

  componentDidMount() {
    axios.get('/timer.json').then(response => {
      let data = response.data;
      this.setState({ data: data})
      this.setState({ numTimer: data.timers.length })
      console.log(data)
    });
  }

  onAddActiveTimer () {
    axios.get('/timer/new').then(response => {
      axios.get('/timer.json').then(response => {
        let data = response.data;
        this.setState({ data: data})
        this.setState({ numTimer: data.timers.length })
        console.log(data)
      });
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
                    />);
    };

    return (
      <section>
        <h1>Timer</h1>
        <p>Lenght timer: {this.state.numTimer}</p>
        <h2>Add a timer:</h2>
        <AddTimer
          addTimer={this.onAddActiveTimer.bind(this)}
          activeTimer={activeTimer}
        />
        <h2>New time record:</h2>
        <p>:)</p>
        <h2>Records:</h2>
        <p>(:</p>
      </section>

    )
  }
}
