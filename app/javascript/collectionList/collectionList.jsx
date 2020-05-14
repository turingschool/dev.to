import { h, Component } from 'preact';
import { CollectionListItem } from '../collectionListItem/collectionListItem';

const fakeCollections = [
  { id: 1, title: 'Best of JavaScript', tags: ['javascript', 'react'] },
  { id: 2, title: 'Fav Ruby', tags: ['ruby', 'rails'] },
];

export class CollectionList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      collections: [],
    };
  }

  componentDidMount() {
    // const response = fetch('http://localhost:3000/api/v0/machine_collections');
    // console.log(response);

    this.setState({ collections: fakeCollections });
  }

  render() {
    const { collections } = this.state;
    const renderedCollections = collections.map(collection => {
      return <CollectionListItem key={collection.id} collection={collection} />;
    });

    return (
      <section className="collection-list-container">
        <a href="/something" className="collection-list__link-create">
          Create a Collection
        </a>
        {renderedCollections}
      </section>
    );
  }
}

CollectionList.defaultProps = {
  collections: [],
};
