import { h } from 'preact';
import PropTypes from 'prop-types';

export const Collection = ({ name }) => {
  return (
    <section className="collection item-wrapper">
      <div className="item">
        <p className="item-title">{`${name}`}</p>
      </div>
    </section>
  );
};

Collection.propTypes = {
  name: PropTypes.string.isRequired,
};
