import React from 'react';
import PropTypes from 'prop-types';
import FontAwesome from 'react-fontawesome';

const JAVASCRIPT_HREF = 'javascript:;';

const ClipboardLink = ({ target }) => (
  <a href={JAVASCRIPT_HREF} className=".copy-to-clipboard" data-clipboard-target={target}>
    <FontAwesome name="clipboard" />
  </a>
);

ClipboardLink.propTypes = {
  target: PropTypes.string.isRequired,
};

export default ClipboardLink;
