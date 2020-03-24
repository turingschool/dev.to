import { h } from 'preact';
import PropTypes from 'prop-types';

export const Collection = ({ title }) => {
  return (
    <section className="collection">
      <p>{`${title}`}</p>
    </section>
  );
};

Collection.propTypes = {
  title: PropTypes.string.isRequired,
};
