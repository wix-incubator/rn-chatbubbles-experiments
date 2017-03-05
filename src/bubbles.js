import React, { Component } from 'react';
import { StyleSheet, View, Text, Image } from 'react-native';

export class TextBubble extends Component {
  render() {
    const textStyle = this.props.side == 'left' ? styles.textLeft : styles.textRight;
    return (
      <View style={textStyle}>
        <Text style={styles.textBody}>{this.props.text}</Text>
      </View>
    );
  }
}

export class ImageBubble extends Component {
  render() {
    const imageStyle = this.props.side == 'left' ? styles.imageLeft : styles.imageRight;
    return (
      <Image style={imageStyle} source={{uri: this.props.url}} />
    );
  }
}

const styles = StyleSheet.create({
  textLeft: {
    borderRadius: 10,
    backgroundColor: '#71b4fc',
    width: 250,
    margin: 10,
    padding: 10
  },
  textRight: {
    borderRadius: 10,
    backgroundColor: '#8fdd90',
    width: 250,
    margin: 10,
    padding: 10,
    alignSelf: 'flex-end'
  },
  textBody: {
    color: 'white',
    fontSize: 16
  },
  imageLeft: {
    borderRadius: 10,
    width: 250,
    margin: 10,
    height: 150,
    backgroundColor: '#cccccc'
  },
  imageRight: {
    borderRadius: 10,
    width: 250,
    margin: 10,
    height: 150,
    backgroundColor: '#cccccc',
    alignSelf: 'flex-end'
  }
});
