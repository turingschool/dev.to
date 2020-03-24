import { h } from 'preact';
import PropTypes from 'prop-types';

export const Collection = ({ title }) => {
  return <h1>{`${title}`}</h1>;
};

Collection.propTypes = {
  title: PropTypes.string.isRequired,
};
