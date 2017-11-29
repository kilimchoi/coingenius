import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { UncontrolledTooltip } from 'reactstrap';
import FontAwesome from 'react-fontawesome';

class InfoLabel extends Component {
  render() {
    const { children, iconId, tooltipText } = this.props;
    return (
      <h5>
        {children} <FontAwesome name="info-circle" id={iconId} />
        {iconId && (
          <UncontrolledTooltip placement="right" target={iconId}>
            {tooltipText}
          </UncontrolledTooltip>
        )}
      </h5>
    );
  }
}

InfoLabel.propTypes = {
  iconId: PropTypes.string,
  tooltipText: PropTypes.string,
};

InfoLabel.defaultProps = {
  iconId: '',
  tooltipText: '',
};

export default InfoLabel;
