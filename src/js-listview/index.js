import React, { Component } from 'react';
import { StyleSheet, ListView } from 'react-native';
import { TextBubble, ImageBubble } from '../bubbles.js';

const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});

export default class JsListView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      dataSource: ds.cloneWithRows(this.props.rowsById, this.props.rowIds)
    };
  }
  render() {
    return (
      <ListView
        style={styles.container}
        dataSource={this.state.dataSource}
        renderRow={this.renderRow.bind(this)}
      />
    );
  }
  renderRow(row) {
    if (row.type == 'text') return <TextBubble text={row.text} side={row.side} />;
    if (row.type == 'image') return <ImageBubble url={row.url} side={row.side} />;
    return false;
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10
  }
});
