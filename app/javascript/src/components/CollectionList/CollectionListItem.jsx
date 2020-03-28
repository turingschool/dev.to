
// Item list item
import { h } from 'preact';
import { PropTypes } from 'preact-compat';

// this takes the title passed in
// this collection_id
// the user making the component
// this will a ref to a show page for that collection
export const CollectionListItem = ({ title, collectionId, userId }) => {
  const path = `${ userId }/collections/${ collectionId }`
return (
  <div className='item-wrapper'>
    <a className="item" href={path}>
      <div className="item-title">
        {title}
      </div>
    </a>
  </div>
)
};
