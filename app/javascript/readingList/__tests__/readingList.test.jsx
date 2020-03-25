import { h } from 'preact';
import render from 'preact-render-to-json';
import { ReadingList } from '../readingList';

describe('<ReadingList />', () => {
  it('renders properly', () => {
    const mockCollections = [
      { id: 1, name: 'first_test_post' },
      { id: 2, name: 'second_test_post' },
    ];
    const tree = render(
      <ReadingList availableTags={['discuss']} collections={mockCollections} />,
    );
    expect(tree).toMatchSnapshot();
  });
});
