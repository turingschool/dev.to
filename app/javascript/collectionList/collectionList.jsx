import { h } from 'preact';
import PropTypes from 'prop-types';
import { CollectionListItem } from '../collectionListItem/collectionListItem';
import { CollectionForm } from '../collectionForm/collectionForm';

export const CollectionList = ({ collections }) => {
  const renderedCollections = collections.map(collection => {
    return <CollectionListItem key={collection.id} collection={collection} />;
  });

  return (
    <section className="collection-list-container">
      <CollectionForm />
      <a href="/something" className="collection-list__link-create">
        Create a Collection
      </a>
      {renderedCollections}
    </section>
  );
};

CollectionList.propTypes = {
  collections: PropTypes.arrayOf(
    PropTypes.shape({
      title: PropTypes.string,
      user_id: PropTypes.integer,
      created_at: PropTypes.string,
      updated_at: PropTypes.string,
      tag_list: PropTypes.arrayOf(PropTypes.string),
    }),
  ).isRequired,
};
