import React, { Component } from 'react';
import PropTypes from 'prop-types';
import StatusIcon from './StatusIcon';
import Separator from './Separator';
import { angleRightWrapper, circle } from './styles.css';

const separator = {
  iconName: 'angle-right',
  wrapperClass: angleRightWrapper,
  IconComponent: Separator,
};
const defaultIcon = {
  IconComponent: StatusIcon,
  wrapperClass: circle,
};
const icons = [
  {
    ...defaultIcon,
    key: 'arrow-circle-down',
    iconName: 'arrow-circle-down',
    text: 'Awaiting Deposit',
    enabledStates: ['pending', 'received', 'complete'],
  },
  { ...separator, key: 'separator-1' },
  {
    ...defaultIcon,
    key: 'exchange',
    iconName: 'exchange',
    wrapperClass: circle,
    text: 'Awaiting Exchange',
    enabledStates: ['received', 'complete'],
  },
  { ...separator, key: 'separator-2' },
  {
    ...defaultIcon,
    key: 'check',
    iconName: 'check',
    text: 'All Done!',
    enabledStates: ['complete'],
  },
];

class StatusProgress extends Component {
  isStateReached = (enabledStates = []) => enabledStates.includes(this.props.currentState);

  render() {
    return (
      <div className="text-center d-inline-flex">
        {icons.map(({ enabledStates, IconComponent, ...iconOptions }) => (
          <IconComponent {...iconOptions} enabled={this.isStateReached(enabledStates)} />
        ))}
      </div>
    );
  }
}

StatusProgress.propTypes = {
  currentState: PropTypes.string.isRequired,
};

export default StatusProgress;
