import React, { Component } from 'react'
import axios from 'axios'

export default class NewRecord extends Component {
  constructor(props) {
    super(props)

    let date = new Date();
    let newDate = `${date.getFullYear()}-${date.getMonth() < 10 ? "0" + date.getMonth() : date.getMonth()}-${date.getDay() < 10 ? "0" + date.getDay() : date.getDay()}`

    this.state = { theday: newDate, amount: this.props.amount, project_id: "" };

    this.handleChangeTheday = this.handleChangeTheday.bind(this);
    this.handleChangeAmount = this.handleChangeAmount.bind(this);
  }

  handleChangeTheday(event) {
    this.setState({theday: event.target.value});
  }

  handleChangeAmount(event) {
    this.setState({amount: event.target.value});
  }

  render () {
    return (
      <div>
        <form className="pure-form pure-form-stacked">
          <fieldset>
            <legend> New time record:</legend>
            <input
              className="pure-input-1-2"
              placeholder="date (yyyy-mm-dd)"
              value={this.state.theday}
              onChange={this.handleChangeTheday}
              ref={this.props.inputTheday}
            />
            <input
              className="pure-input-1-2"
              placeholder="spent time (in minutes)"
              value={this.state.amount}
              onChange={this.handleChangeAmount}
              ref={this.props.inputAmount}
            />
          </fieldset>
        </form>
      </div>
    )
  }
}
