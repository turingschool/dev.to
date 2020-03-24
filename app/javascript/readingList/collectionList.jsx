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
          { id: 1, title: 'first_test_post' },
          { id: 2, title: 'second_test_post' },
        ],
      });
    }
  }

  render() {
    const { collections } = this.state;
    const collectionsToRender = collections.map(collection => {
      return <Collection key={collection.id} title={collection.title} />;
    });

    return <section className="collection-cont">{collectionsToRender}</section>;
  }
}

CollectionList.propTypes = {
  collections: PropTypes.arrayOf(PropTypes.object).isRequired,
};
