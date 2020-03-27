// Item list item
import { h } from 'preact';
import { PropTypes } from 'preact-compat';

// this takes the title passed in
// this collection_id 
// the user making the component
// this will a ref to a show page for that collection
export const CollectionListItem = ({ title, collection_id, user_id }) => {
  // this will be path to our collection show
  const path = `${ user_id }/collections/${ collection_id }`
 return (
   <div>
     <a href = { path }/> 
      <h1> {title}</h1>
     </a>
   </div>
 ) 
  };