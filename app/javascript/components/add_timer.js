import React, { Component } from 'react'
import axios from 'axios'
import SecondsTohhmmss from 'utils/SecondsTohhmmss'

export default class AddTimer extends Component {
  constructor(props) {
    super(props)
    this.state = { comment: "", project_id: "" };

    this.handleChangeComment = this.handleChangeComment.bind(this);
    this.handleChangeProject = this.handleChangeProject.bind(this);
  }

  handleChangeComment(event) {
    this.setState({comment: event.target.value});
  }

  handleChangeProject(event) {
    this.setState({project_id: event.target.value});
  }

  renderOptionSelect() {
    const optionProjects = [];
    const optionLength = this.props.projects.length;
    for (let i = 0; i < optionLength; i += 1) {
      optionProjects.unshift(<option
                              key={i}
                              value={this.props.projects[i].id}>
                              {this.props.projects[i].title}
                             </option>);
    };

    return optionProjects;
  }

  render () {
    return (
      <div>
        <form className="pure-form pure-form-stacked">
          <select
            value={this.state.project_id}
            onChange={this.handleChangeProject}
            ref={this.props.inputProject}>

            <option value="">- choose project -</option>
            {this.renderOptionSelect()}

          </select>
          <input
            type="text"
            className="pure-input-1-2"
            placeholder="Comment"
            value={this.state.comment}
            onChange={this.handleChangeComment}
            ref={this.props.inputComment}
          />

        </form>
        <p><a href="#" className="pure-button pure-button-primary " onClick={this.props.addTimer}>Add Timer</a></p>
      </div>
    );
  }
}
