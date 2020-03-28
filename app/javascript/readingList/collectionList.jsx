import { h, Component } from 'preact';
import PropTypes from 'prop-types';
import { Collection } from './components/Collection';

// const root = document.getElementById('collection-list');

export class CollectionList extends Component {
  constructor({ collections }) {
    super({ collections });

    this.state = {
      collections,
    };
  }

  componentDidMount() {
    const { collections } = this.state;
    if (!collections.length) {
      this.setState({
        collections: [
          { id: 1, name: 'first_test_post' },
          { id: 2, name: 'second_test_post' },
        ],
      });
    }
  }

  render() {
    const { collections } = this.state;
    const collectionsToRender = collections.map(collection => {
      return <Collection key={collection.id} name={collection.name} />;
    });

    return (
      <section
        className="collection-cont results results--loaded"
        id="reading-collection"
      >
        <div className="results-header collection-header">
          {collections.length
            ? `Collections (${collections.length})`
            : 'Collections'}
          <a className="new-collection" href="/readingcollections/new">
            +
          </a>
        </div>
        {collectionsToRender}
      </section>
    );
  }
}

CollectionList.propTypes = {
  collections: PropTypes.arrayOf(PropTypes.object).isRequired,
};
