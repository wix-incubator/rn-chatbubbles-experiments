import React, { Component } from 'react';
import { StyleSheet, View, Text, Image } from 'react-native';

export class TextBubble extends Component {
	render() {
		const textStyle = this.props.owner === 'me' ? styles.textRight : styles.textLeft;
		const bodyStyle = this.props.owner === 'me' ? styles.textBodyRight : styles.textBodyLeft;
		return (
			<View style={textStyle}>
				<Text style={bodyStyle}>{this.props.text}</Text>
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
		backgroundColor: '#DFE2E2',
		width: 250,
		margin: 4,
		padding: 8
	},
	textRight: {
		borderRadius: 10,
		backgroundColor: '#007AFF',
		width: 250,
		margin: 4,
		padding: 8,
		alignSelf: 'flex-end'
	},
	textBodyLeft: {
		color: 'black',
		fontSize: 17
	},
	textBodyRight: {
		color: 'white',
		fontSize: 17
	},
	imageLeft: {
		borderRadius: 10,
		width: 200,
		margin: 4,
		height: 200,
		backgroundColor: '#DFE2E2'
	},
	imageRight: {
		borderRadius: 10,
		width: 200,
		margin: 4,
		height: 200,
		backgroundColor: '#007AFF',
		alignSelf: 'flex-end'
	}
});
