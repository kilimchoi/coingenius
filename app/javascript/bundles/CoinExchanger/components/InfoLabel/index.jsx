import React, { Component } from 'react';
import FontAwesome from 'react-fontawesome';

class InfoLabel extends Component {
  render() {
    const { children } = this.props;
    return (
      <h5>
        {children} <FontAwesome name="info-circle" />
      </h5>
    );
  }
}

export default InfoLabel;
