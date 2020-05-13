// <p>Number of total visits to the site: <span id="total-visits"></span></p>
// <p>Number of visits per day: <span id="daily-visits"></span></p>
// <p>Average active time on pages per day: <span id="avg-daily-time"></span></p>
// <p>Total articles read: <span id="total-articles"></span></p>
// <p>Total words read: <span id="total-words"></span></p>
// <p>Average articles & words per day: <span id="avg-daily-articles-words"></span></p>
// <p>Number of comments: <span id="total-comments"></span></p>

// const totalVisits = document

import { h, render } from 'preact';

const StatsDash = () => {
  return (
    <section>
      <p>
        Number of total visits to the site:
        <span>1</span>
      </p>
      <p>
        Number of visits per day:
        <span>2</span>
      </p>
      <p>
        Average active time on pages per day:
        <span>4</span>
      </p>
      <p>
        Total articles read:
        <span>5</span>
      </p>
      <p>
        Total words read:
        <span>3</span>
      </p>
      <p>
        Average articles & words per day:
        <span>4</span>
      </p>
      <p>
        Number of comments:
        <span>3</span>
      </p>
    </section>
  );
};

const loadStatsDash = () => {
  render(<StatsDash />);
};

loadStatsDash();
