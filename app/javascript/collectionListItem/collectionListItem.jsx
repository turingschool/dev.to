import { h } from 'preact';
import { PropTypes } from 'preact-compat';

export const CollectionListItem = ({ collection }) => {
  const renderedTags = collection.tag_list.map(tag => {
    return <p className="collection-item__tag">{`#${tag}`}</p>;
  });
  return (
    <article className="collection-item">
      <div className="collection-item__header">
        <h1>{collection.title}</h1>
      </div>
      <div className="collection-item__body">
        <div className="collection-item__tag-container">{renderedTags}</div>
        <p className="collection-item__body-text">
          There are ## articles in this collection.
        </p>
        <button type="button" className="collection-item__edit-button">
          EDIT
        </button>
      </div>
    </article>
  );
};

CollectionListItem.propTypes = {
  collection: PropTypes.shape({
    id: PropTypes.string,
    title: PropTypes.string,
    tag_list: PropTypes.arrayOf(PropTypes.string),
  }).isRequired,
};
