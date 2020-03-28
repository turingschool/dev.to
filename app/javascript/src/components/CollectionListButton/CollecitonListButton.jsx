import { h } from 'preact';
import { PropTypes } from 'preact-compat';


export const CollectionListButton = ({ userId }) =>  {
    const path = `${userId}/collections/new`
     return (
       <a href={path} >Add a Collection</a>
   )};
