import 'preact/devtools';
import PropTypes from 'prop-types';
import { h } from 'preact';

// need to figure out how a html erb file coexist with the component
// can erb file render a componet, No, because JSX is Javascript, not HTML. but a gem called react rails
// search all reference cant trace where searchForm is called
// LOOK BY CLASSNAME

export const SearchForm = ({
  searchTerm,
  onSearch,
  onSubmitSearch,
  searchBoxId,
}) => (
  <form
    action="/search"
    acceptCharset="UTF-8"
    method="get"
    onSubmit={onSubmitSearch}
  >
    <input name="utf8" type="hidden" value="✓" />
    <input
      className="top-bar--search-input"
      type="text"
      name="q"
      id={searchBoxId}
      placeholder="Search"
      autoComplete="off"
      aria-label="search"
      onKeyDown={onSearch}
      value={searchTerm}
    />
  </form>
);

SearchForm.propTypes = {
  searchTerm: PropTypes.string.isRequired,
  searchBoxId: PropTypes.string.isRequired,
  onSearch: PropTypes.func.isRequired,
  onSubmitSearch: PropTypes.func.isRequired,
};
