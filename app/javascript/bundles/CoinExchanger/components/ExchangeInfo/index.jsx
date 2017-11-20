import React, { Component } from 'react';
import { wrapper, top, right, left } from './styles.css';

class ExchangeInfo extends Component {
  render() {
    return (
      <div className={wrapper}>
        <div className={top}></div>
        <div className={left}></div>
        <div className={right}></div>
      </div>
    );
  }
}

export default ExchangeInfo;
