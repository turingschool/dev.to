import { h } from 'preact';
import render from 'preact-render-to-json';
import { CollectionList } from '../collectionList';

describe('<ContentList />', () => {
  it('renders properly', () => {
    const tree = render(<CollectionList />);
    expect(tree).toMatchSnapshot();
  });
});
