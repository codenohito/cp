import React, { Component } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import SecondsTohhmmss from 'utils/SecondsTohhmmss'

// React component
export default class AddTimer extends Component {
  constructor(props) {
    super(props)
    this.state = { comment: "", project_id: 0 };

    this.handleChangeComment = this.handleChangeComment.bind(this);
    this.handleChangeProject = this.handleChangeProject.bind(this);
  }

  handleChangeComment(event) {
    this.setState({comment: event.target.value});
  }

  handleChangeProject(event) {
    this.setState({project_id: event.target.value});
  }

  render () {
    return (
      <div>
        <form className="pure-form pure-form-stacked">
          <input
            type="text"
            className="pure-input-1-4"
            placeholder="Comment"
            value={this.state.comment}
            onChange={this.handleChangeComment}
            ref={this.props.inputComment}
          />
          <input
            type="number"
            className="pure-input-1-4"
            placeholder="- choose project -"
            value={this.state.project_id}
            onChange={this.handleChangeProject}
          />
        </form>
        <p><a href="#" onClick={this.props.addTimer}>Add Timer</a></p>
        <h2>Active timers:</h2>
        <div>
          {this.props.activeTimer}
        </div>
      </div>
    );
  }
}
