import { h, Component } from 'preact';
import { PropTypes } from 'preact-compat';
import debounce from 'lodash.debounce';

import { CollectionList } from '../collectionList/collectionList';
import { CollectionForm } from '../collectionForm/collectionForm';

import {
  defaultState,
  loadNextPage,
  onSearchBoxType,
  performInitialSearch,
  search,
  toggleTag,
  clearSelectedTags,
} from '../searchableItemList/searchableItemList';
import { ItemListItem } from '../src/components/ItemList/ItemListItem';
import { ItemListItemArchiveButton } from '../src/components/ItemList/ItemListItemArchiveButton';
import { ItemListLoadMoreButton } from '../src/components/ItemList/ItemListLoadMoreButton';
import { ItemListTags } from '../src/components/ItemList/ItemListTags';

// Constant variables used within this components
const STATUS_VIEW_VALID = 'valid';
const STATUS_VIEW_ARCHIVED = 'archived';
const READING_LIST_ARCHIVE_PATH = '/readinglist/archive';
const READING_LIST_PATH = '/readinglist';

// A Preact functional component,
// if there are no selected tags and no query it renders all articles in a user's reading list
// else if there is a tag or query renders a static message about not finding any articles.
const FilterText = ({ selectedTags, query, value }) => {
  return (
    <h1>
      {selectedTags.length === 0 && query.length === 0
        ? value
        : 'Nothing with this filter 🤔'}
    </h1>
  );
};

// The main Preact component in this file
export class ReadingList extends Component {
  constructor(props) {
    super(props);

    // Destructures the keys of the props object
    const { availableTags, statusView } = this.props;

    // ! The local state of this component that uses an imported function to construct some default state and then adds the keys of availableTags, archiving, and statusView to the default state to customize it for this particular component
    this.state = defaultState({ availableTags, archiving: false, statusView });

    // ! The older method of binding methods to a component to preserve the value of this when the method is invoked in a different context. bind(this) is explicitly telling JavaScript to invoke these methods on the ReadingList instance as opposed to the object on which they are invoked at the time of invocation.
    // bind and initialize all shared functions
    this.onSearchBoxType = debounce(onSearchBoxType.bind(this), 300, {
      leading: true,
    });
    this.loadNextPage = loadNextPage.bind(this);
    this.performInitialSearch = performInitialSearch.bind(this);
    this.search = search.bind(this);
    this.toggleTag = toggleTag.bind(this);
    this.clearSelectedTags = clearSelectedTags.bind(this);
  }

  // ! A React lifecycle method that is invoked when this component is mounted to the DOM.
  // Sets up the search functionality for the component by assigning a search function to
  // the component's index piece of state and then invokes the initial search,
  // which returns a promise which upon resolution, assigns the results of the search to
  // the items key of the local state
  componentDidMount() {
    const { hitsPerPage, statusView } = this.state;

    this.performInitialSearch({
      containerId: 'reading-list',
      indexName: 'SecuredReactions',
      searchOptions: {
        hitsPerPage,
        filters: `status:${statusView}`,
      },
    });
  }

  // This changes the statusView piece of state between "valid" and "archived"
  // this.state.statusView is initially received as props and can be 'valid'.
  // It is taken from the dataset of the root element,
  // which is the parent element of the readingList.
  // This method is toggling the URL path in the browser to show the either /readinglist
  // or /readinlist/archive and also toggling the link text when clicking "View Archive"
  toggleStatusView = event => {
    event.preventDefault();

    const { query, selectedTags } = this.state;

    const isStatusViewValid = this.statusViewValid();

    const newStatusView = isStatusViewValid
      ? STATUS_VIEW_ARCHIVED
      : STATUS_VIEW_VALID;

    const newPath = isStatusViewValid
      ? READING_LIST_ARCHIVE_PATH
      : READING_LIST_PATH;

    // empty items so that changing the view will start from scratch
    this.setState({ statusView: newStatusView, items: [] });

    this.search(query, {
      page: 0,
      tags: selectedTags,
      statusView: newStatusView,
    });

    // change path in the address bar
    window.history.replaceState(null, null, newPath);
  };

  // This method send a PUT requests and updates the articles status
  // it will change the article in a user's reading list to archived
  toggleArchiveStatus = (event, item) => {
    event.preventDefault();

    const { statusView, items, totalCount } = this.state;
    window.fetch(`/reading_list_items/${item.id}`, {
      method: 'PUT',
      headers: {
        'X-CSRF-Token': window.csrfToken,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ current_status: statusView }),
      credentials: 'same-origin',
    });

    const t = this;
    const newItems = items;
    newItems.splice(newItems.indexOf(item), 1);
    t.setState({
      archiving: true,
      items: newItems,
      totalCount: totalCount - 1,
    });

    // hide the snackbar in a few moments
    setTimeout(() => {
      t.setState({ archiving: false });
    }, 1000);
  };

  // ! If the status view is equal to 'valid', return true
  statusViewValid() {
    const { statusView } = this.state;
    return statusView === STATUS_VIEW_VALID;
  }

  // If there are no items to render, then render the FilterText component with the value prop showing the reading list to be empty.
  // If the statusView state is "valid" (e.g. reading list), then return the first message
  // If the statusView is "archive", then return the second message
  renderEmptyItems() {
    const { itemsLoaded, selectedTags, query } = this.state;

    if (itemsLoaded && this.statusViewValid()) {
      return (
        <div className="items-empty">
          <FilterText
            selectedTags={selectedTags}
            query={query}
            value="Your Reading List is Lonely"
          />
          <h3>
            Hit the
            <span className="highlight">SAVE</span>
            or
            <span className="highlight">
              Bookmark
              <span role="img" aria-label="Bookmark">
                🔖
              </span>
            </span>
            to start your Collection
          </h3>
        </div>
      );
    }

    return (
      <div className="items-empty">
        <FilterText
          selectedTags={selectedTags}
          query={query}
          value="Your Archive List is Lonely"
        />
      </div>
    );
  }

  // The main render method of this component, it is responsible for rendering content to the DOM
  render() {
    const {
      items,
      itemsLoaded,
      totalCount,
      availableTags,
      selectedTags,
      showLoadMoreButton,
      archiving,
    } = this.state;

    const isStatusViewValid = this.statusViewValid();

    const archiveButtonLabel = isStatusViewValid ? 'archive' : 'unarchive';

    // Render a list of ItemListItem components using the items piece of state that was set via the initial search,
    // and store the result in a variable for use later in the render method
    // Each ItemListItem is a single article listing that falls under "Reading List", it has an article title, author, date, reading time, tags, and an archive button
    const itemsToRender = items.map(item => {
      return (
        <ItemListItem item={item}>
          <ItemListItemArchiveButton
            text={archiveButtonLabel}
            onClick={e => this.toggleArchiveStatus(e, item)}
          />
        </ItemListItem>
      );
    });

    // When the archive button is clicked on an ItemListItem, a snackbar appears in the lower left of the viewport.
    const snackBar = archiving ? (
      <div className="snackbar">
        {isStatusViewValid ? 'Archiving...' : 'Unarchiving...'}
      </div>
    ) : (
      ''
    );

    // ! What is actually rendered
    return (
      <div className="home item-list">
        {/* ! The LEFT side of the view */}
        <div className="side-bar">
          <div className="widget filters">
            {/* ! The search bar to search your reading list */}
            <input
              onKeyUp={this.onSearchBoxType}
              placeHolder="search your list"
            />

            {/* ! The clear all text will appear if a tag is selected */}
            <div className="filters-header">
              <h4 className="filters-header-text">my tags</h4>
              {Boolean(selectedTags.length) && (
                <a
                  className="filters-header-action"
                  href={
                    isStatusViewValid
                      ? READING_LIST_PATH
                      : READING_LIST_ARCHIVE_PATH
                  }
                  onClick={this.clearSelectedTags}
                  data-no-instant
                >
                  clear all
                </a>
              )}
            </div>

            {/* ! The list of a user's tags */}
            <ItemListTags
              availableTags={availableTags}
              selectedTags={selectedTags}
              onClick={this.toggleTag}
            />

            {/* ! The link to change the view to the archive */}
            <div className="status-view-toggle">
              <a
                href={READING_LIST_ARCHIVE_PATH}
                onClick={e => this.toggleStatusView(e)}
                data-no-instant
              >
                {isStatusViewValid ? 'View Archive' : 'View Reading List'}
              </a>
            </div>
          </div>
        </div>

        {/* ! The RIGHT side of the view */}
        {/* ! Renders the itemsToRender defined above or invokes the renderEmptyItems method defined above */}
        <div className="items-container">
          <div className={`results ${itemsLoaded ? 'results--loaded' : ''}`}>
            <div className="results-header">
              {isStatusViewValid ? 'Reading List' : 'Archive'}
              {` (${totalCount > 0 ? totalCount : 'empty'})`}
            </div>
            <div>
              {items.length > 0 ? itemsToRender : this.renderEmptyItems()}
            </div>
          </div>

          <ItemListLoadMoreButton
            show={showLoadMoreButton}
            onClick={this.loadNextPage}
          />
        </div>

        {snackBar}
        <CollectionList />
        <CollectionForm />
      </div>
    );
  }
}

ReadingList.defaultProps = {
  statusView: STATUS_VIEW_VALID,
};

ReadingList.propTypes = {
  availableTags: PropTypes.arrayOf(PropTypes.string).isRequired,
  statusView: PropTypes.oneOf([STATUS_VIEW_VALID, STATUS_VIEW_ARCHIVED]),
};

FilterText.propTypes = {
  selectedTags: PropTypes.arrayOf(PropTypes.string).isRequired,
  value: PropTypes.string.isRequired,
  query: PropTypes.arrayOf(PropTypes.string).isRequired,
};
