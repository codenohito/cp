import React, { Component } from 'react'
import axios from 'axios'

export default class NewRecord extends Component {
  constructor(props) {
    super(props)

    let date = new Date();
    let newDate = `${date.getFullYear()}-${(date.getMonth() + 1) < 10 ? "0" + (date.getMonth() + 1) : (date.getMonth() + 1)}-${date.getUTCDate() < 10 ? "0" + date.getUTCDate() : date.getUTCDate()}`
    this.state = {
      theday: newDate,
      amount: this.props.newRecord.amount,
      project: this.props.newRecord.project_id,
      nakama: this.props.nakamaId,
      comment: this.props.newRecord.comment
    };

    this.handleChangeTheday  = this.handleChangeTheday.bind(this);
    this.handleChangeAmount  = this.handleChangeAmount.bind(this);
    this.handleChangeProject = this.handleChangeProject.bind(this);
    this.handleChangeNakama  = this.handleChangeNakama.bind(this);
    this.handleChangeComment = this.handleChangeComment.bind(this);
  }

  componentWillReceiveProps(nextProps) {
    this.setState({nakama: nextProps.nakamaId});

    this.setState({
      amount: nextProps.newRecord.amount,
      project: nextProps.newRecord.project_id,
      comment: nextProps.newRecord.comment
    })
  }

  handleChangeTheday(event) {
    this.setState({theday: event.target.value});
  }

  handleChangeAmount(event) {
    this.setState({amount: event.target.value});
  }

  handleChangeProject(event) {
    this.setState({project: event.target.value});
  }

  handleChangeNakama(event) {
    this.setState({nakama: event.target.value});
  }

  handleChangeComment(event) {
    this.setState({comment: event.target.value});
  }

  handleSubmit(event) {
    let token = document.head.querySelector("[name=csrf-token]").content;
    let self = this;
    let props = {
      theday: self.state.theday != null ? self.state.theday : "",
      amount: self.state.amount != null ?  self.state.amount : "",
      nakama_id: self.state.nakama != null ? self.state.nakama : "",
      project_id: self.state.project != null ? self.state.project : "",
      comment: self.state.comment != null ? self.state.comment : "",
      authenticity_token: token,
      utf8: "✓"
    };

    axios.post('/timer/records.json', props
    ).then(function (response) {
      let record = [{
        theday: self.state.theday != null ? self.state.theday : "",
        amount: self.state.amount != null ?  parseInt(self.state.amount) : "",
        nakama_id: self.state.nakama != null ? self.state.nakama : "",
        project_id: self.state.project != null ? parseInt(self.state.project) : "",
        comment: self.state.comment != null ? self.state.comment : "",
        id: response.data.record_id
      }];

      self.props.addRecord(record)
    }).catch(function (error) {
      console.log(error);
    });
    event.preventDefault();
  }

  renderOptionProject() {
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

  renderOptionNakama() {
    const optionNakama = [];
    const optionLength = this.props.nakama.length;
    for (let i = 0; i < optionLength; i += 1) {
      optionNakama.unshift(<option
                              key={i}
                              value={this.props.nakama[i].id}
                              >
                              {this.props.nakama[i].name}
                             </option>);
    };

    return optionNakama;
  }

  render () {
    return (
      <div>
        <form onSubmit={this.handleSubmit.bind(this)} className="pure-form pure-form-stacked">
          <fieldset>
            <legend> New time record:</legend>
            <input
              placeholder="date (yyyy-mm-dd)"
              value={this.state.theday}
              onChange={this.handleChangeTheday}
              ref={this.props.inputTheday}
            />
            <input
              placeholder="spent time (in minutes)"
              value={this.state.amount}
              onChange={this.handleChangeAmount}
              ref={this.props.inputAmount}
            />
            { !this.props.isAdmin ? "" :
              <select
                value={this.state.nakama || ""}
                onChange={this.handleChangeNakama}
                ref={this.props.inputNakama}>

                <option value="">- choose nakama -</option>
                {this.renderOptionNakama()}

              </select>
            }
            <select
              value={this.state.project}
              onChange={this.handleChangeProject}
              ref={this.props.inputProject}>

              <option value="">- choose project -</option>
              {this.renderOptionProject()}

            </select>
            <input
              className="pure-input-1-2"
              placeholder="Comment"
              value={this.state.comment}
              onChange={this.handleChangeComment}
              ref={this.props.inputComment}
            />
            <p>
              <button className="pure-button pure-button-primary">Save</button>
            </p>
          </fieldset>
        </form>
      </div>
    )
  }
}
