import React, { Component } from 'react';
import {
  AppRegistry,
  View,
  StyleSheet,
  requireNativeComponent
} from 'react-native';
import * as dataset from './dataset';

const bubbles = dataset.generateSimpleDataset();

const ALBubblesView = requireNativeComponent('ALBubblesView', null);

export default class nativeExample extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View style={styles.container}>
        <ALBubblesView style={styles.body} bubbles={bubbles} />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white'
  },
  body: {
    flex: 1,
    zIndex: 1000
  }
});

AppRegistry.registerComponent('native', () => nativeExample);
