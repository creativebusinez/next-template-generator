import React, { useEffect } from 'react';

type DisqusProps = {
  identifier: string;
  title: string;
  url: string;
};

const DisqusComments = ({ identifier, title, url }: DisqusProps) => {
  useEffect(() => {
    const d = document, s = d.createElement('script');
    s.src = 'https://YOUR_DISQUS_SHORTNAME.disqus.com/embed.js';
    s.setAttribute('data-timestamp', Date.now().toString());
    (d.head || d.body).appendChild(s);
  }, [identifier, title, url]);

  return <div id="disqus_thread"></div>;
};

export default DisqusComments;
