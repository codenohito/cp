import React, { Component } from 'react'
import { connect } from 'react-redux'
import axios from 'axios'
import Record from 'components/record'
import NewRecord from 'components/new_timer_record'
import { getRecords, addRecord } from 'actions';

class recordWrap extends Component {
  constructor(props) {
    super(props)

    this.state = {
      projects: [],
      nakama: [],
      nakamaId: "",
      isAdmin: false,
      record: []
    }

    this.setNewRecord = this.setNewRecord.bind(this);

  }

  componentDidMount() {
    axios.get('/timer.json').then(response => {
      this.props.getRecords(response.data.records)

      this.setState({ isAdmin: response.data.isAdmin ? true : false,
                      nakama: response.data.nakama,
                      nakamaId: response.data.nakamaId
                    })
    });
    axios.get('/projects.json').then(response => {
      this.setState({ projects: response.data.projects })
    })
  }

  renderChildrenRecords() {
    let records = this.props.records;
    let listRecord = null;
    let curDay = null;

    for (let i = 0; i < records.length; i++) {

      if (records[i].theday != curDay) {
        curDay = records[i].theday;
      } else {
        _.assign(records[i], { theday: false });
      }

    }

    listRecord = records.map((record, index) =>
      <Record
        key={index}
        id={record.id}
        theday={record.theday}
        amount={record.amount}
        nakama_id={record.nakama_id}
        project_id={record.project_id}
        comment={record.comment}
        projects={this.state.projects}
        isAdmin={this.state.isAdmin}
        nakama={this.state.nakama}
      />
    )

    return listRecord
  }

  setNewRecord() {
    this.props.addRecord(this.state.record[0])
  }

  addRecord(newState) {
    this.setState({record: newState})
    this.setNewRecord()
  }

  render() {
    return (
      <div>
        <h2>New time record:</h2>
          <NewRecord
            inputTheday={(input) => this.theday = input}
            inputAmount={(input) => this.amount = input}
            inputProject={(input) => this.project = input}
            inputNakama={(input) => this.nakama = input}
            inputComment={(input) => this.comment = input}
            newRecord={this.props.newRecord}
            projects={this.state.projects}
            nakama={this.state.nakama}
            nakamaId={this.state.nakamaId}
            isAdmin={this.state.isAdmin}
            addRecord={(newState) => this.addRecord(newState)}
          />
        <h2>Records:</h2>
        <div className="time-records">
          { this.props.records.length ? this.renderChildrenRecords() : 'Have no records' }
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    records: state.recordsState,
    newRecord: state.newRecordState
  }
}

function mapDispatchToProps(dispatch) {
  return {
    getRecords: (data) => dispatch(getRecords(data)),
    addRecord: (data) => dispatch(addRecord(data))
  }
}

const RecordWrap = connect(
  mapStateToProps,
  mapDispatchToProps
)(recordWrap)

export default RecordWrap
