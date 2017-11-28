import React, { Component } from "react";
import { UncontrolledTooltip } from "reactstrap";
import FontAwesome from "react-fontawesome";

class InfoLabel extends Component {
  render() {
    const { children, iconId, tooltipText } = this.props;
    return <h5>
        {children} <FontAwesome name="info-circle" id={iconId} />
        <UncontrolledTooltip placement="right" target={iconId}>
          {tooltipText}
        </UncontrolledTooltip>
      </h5>;
  }
}

export default InfoLabel;
