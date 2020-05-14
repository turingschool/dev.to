import { h } from 'preact';
import render from 'preact-render-to-json';
import { ReadingList } from '../readingList';

describe('<ReadingList />', () => {
  it('renders properly', () => {
    const tree = render(<ReadingList availableTags={['discuss']} />);
    expect(tree).toMatchSnapshot();
  });
});

// we will need to add tests for the functionality of this component
// and we will need to mock http requests to ensure they are sent with the correct arguments
