import React from 'react';
import { connect } from 'react-redux';
import Timer from 'components/timer';

// Map Redux state to component props
function mapStateToProps(state) {
  return {}
}

// Map Redux actions to component props
function mapDispatchToProps(dispatch) {
  return {}
}

// Connected Component
const App = connect(
  mapStateToProps,
  mapDispatchToProps
)(Timer)

export default App;
