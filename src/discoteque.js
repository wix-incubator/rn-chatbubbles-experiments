import React, { Component } from 'react';
import ReactNative, {
	AppRegistry,
	View,
	Text
} from 'react-native';

class Discoteque extends Component {
	getRandomColor() {
		const letters = '0123456789ABCDEF'.split('');
		let color = '#';

		for (var i = 0; i < 6; i++) {
			color += letters[Math.floor(Math.random() * 16)];
		}

		return color;
	};

	constructor(props) {
		super(props);
		this.myref = {};
		this.state = { color: this.getRandomColor(), index: props.index };
	}

	render() {
		if (this.props.isSlowdownEnabled == true) {
			console.log("Slowing down! 💩");
			for (i = 0; i < 3e5; i++);
		}
		return (
			<View ref={(r) => this.myref = r} style={{ width: 200, height: 200, backgroundColor: this.state.color }}>
				<Text style={{ fontSize: 50 }}>
					{this.state.index}
				</Text>
			</View>
		)
	}

	componentWillReceiveProps(newProps) {
		this.setState({ color: this.getRandomColor(), index: newProps.index });
	}
}

AppRegistry.registerComponent('Discoteque', () => Discoteque);