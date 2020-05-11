// Sidebar tags for item list page
import { h } from 'preact';
import { PropTypes } from 'preact-compat';

// Renders the listing of tags on the left side of the readingList by mapping over a list of tags that is passed to it
// When a tag is selected the css class has "selected" appended to it
// The onClick handler is passed to it as a prop, therefor the functionality is not bound directly to this component but passed in as a dependency
export const ItemListTags = ({ availableTags, selectedTags, onClick }) => {
  const tagsHTML = availableTags.map(tag => (
    <a
      className={`tag ${selectedTags.indexOf(tag) > -1 ? 'selected' : ''}`}
      href={`/t/${tag}`}
      data-no-instant
      onClick={e => onClick(e, tag)}
    >
      {`#${tag}`}
    </a>
  ));
  return <div className="tags">{tagsHTML}</div>;
};

ItemListTags.propTypes = {
  availableTags: PropTypes.arrayOf(PropTypes.string).isRequired,
  selectedTags: PropTypes.arrayOf(PropTypes.string).isRequired,
  onClick: PropTypes.func.isRequired,
};
