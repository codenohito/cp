import React, { Component } from 'react'
import axios from 'axios'

class Record extends Component {
  constructor(props) {
    super(props)
  }

  renderMinutes() {
    let minutes = Math.floor(this.props.amount % 60);
    return minutes < 10 ? ("0" + minutes) : minutes;
  }

  renderProjectTitle() {
    let projectId = this.props.project_id;
    let projects = this.props.projects;
    let projectsLength = projects.length;
    let projectTitle = "";

    for (let i = 0; i < projectsLength; i += 1) {
      if (projects[i].id == projectId) {
        projectTitle = projects[i].title;
        break;
      }
    }

    return projectTitle;

  }

  renderNakamaTitle() {
    let nakamaId = this.props.nakama_id;
    let nakama = this.props.nakama;
    let nakamaLength = nakama.length;
    let nakamaTitle = "";

    for (let i = 0; i < nakamaLength; i += 1) {
      if (nakama[i].id == nakamaId) {
        nakamaTitle = nakama[i].name;
        break;
      }
    }

    return nakamaTitle;
  }

  render() {
    return (
      <div>
        <div className="time-records-day">
          {this.props.theday}
        </div>
        <div className="time-record">
          <span className="edit-record-wrap">
            <a href={"timer/" + this.props.id + "/edit"} className="pure-button">✎</a>
          </span>
          <span className="tr-info-time">
            {Math.floor(this.props.amount / 60)}
            :
            {this.renderMinutes()}
          </span>
          { !this.props.isAdmin ? '' :
            <span className="tr-info-nakama das-nakama">
              @{this.renderNakamaTitle()}
            </span>
          }
          &nbsp;at&nbsp;
          <span className="tr-info-project">
            <a href={"projects/" + this.props.project_id}>
              {this.renderProjectTitle()}
            </a>
          </span>
          <div className="tr-info-comment">
            {this.props.comment}
          </div>
        </div>
      </div>
    )
  }
}

export default Record
