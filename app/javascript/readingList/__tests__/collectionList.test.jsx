import { h } from 'preact';
import render from 'preact-render-to-json';
import { CollectionList } from '../collectionList';

describe('<ContentList />', () => {
  it('renders properly', () => {
    const mockCollections = [
      { id: 1, name: 'first_test_post' },
      { id: 2, name: 'second_test_post' },
    ];
    const tree = render(<CollectionList collections={mockCollections} />);
    expect(tree).toMatchSnapshot();
  });
});
