import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  View,
  TouchableOpacity,
  Image,
  Text,
  ScrollView
} from 'react-native';
import * as dataset from './dataset';

const { rowsById, rowIds } = dataset.generateDataset();

import JsListView from './js-listview';

export default class example extends Component {
  constructor(props) {
    super(props);
    this.state = {
      currentExample: JsListView
    }
  }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.body}>
          {this.renderContent()}
        </View>
      </View>
    );
  }

  renderContent() {
    const ExampleComponent = this.state.currentExample;
    return (<ExampleComponent rowsById={rowsById} rowIds={rowIds} />);
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'stretch',
    backgroundColor: 'white',
  },
  header: {
    height: 75,
    paddingTop: 14,
    paddingLeft: 20,
    flexDirection: 'row',
    backgroundColor: '#5894f3',
    alignItems: 'center',
    zIndex: 1001
  },
  body: {
    flex: 1,
    zIndex: 1000
  },
  menuContainer: {
    flex: 1,
    paddingTop: 30,
    paddingLeft: 40,
    backgroundColor: '#223f6b'
  },
  menuIcon: {
    width: 30,
    height: 30
  },
  headerTitle: {
    marginLeft: 30,
    color: 'white',
    fontSize: 20
  },
  button: {
    color: '#e0e0e0',
    fontSize: 20,
    marginBottom: 24
  }
});

AppRegistry.registerComponent('chatbubbles_js_naive', () => example);
