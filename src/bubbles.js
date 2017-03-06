import React, { Component } from 'react';
import { StyleSheet, View, Text, Image } from 'react-native';

export class TextBubble extends Component {
  render() {
    const textStyle = this.props.owner === 'me' ? styles.textRight : styles.textLeft;
    return (
      <View style={textStyle}>
        <Text style={styles.textBody}>{this.props.text}</Text>
      </View>
    );
  }
}

export class ImageBubble extends Component {
  render() {
    const imageStyle = this.props.owner === 'me' ? styles.imageRight : styles.imageLeft;
    return (
      <Image style={imageStyle} source={require('./../img/1.jpg')} />
    );
  }
}

const styles = StyleSheet.create({
  textLeft: {
    borderRadius: 10,
    backgroundColor: '#71b4fc',
    width: 250,
    margin: 4,
    padding: 10
  },
  textRight: {
    borderRadius: 10,
    backgroundColor: '#8fdd90',
    width: 250,
    margin: 4,
    padding: 10,
    alignSelf: 'flex-end'
  },
  textBody: {
    color: 'white',
    fontSize: 16
  },
  imageLeft: {
    borderRadius: 10,
    width: 200,
    margin: 4,
    height: 200,
    backgroundColor: '#cccccc'
  },
  imageRight: {
    borderRadius: 10,
    width: 200,
    margin: 4,
    height: 200,
    backgroundColor: '#cccccc',
    alignSelf: 'flex-end'
  }
});
