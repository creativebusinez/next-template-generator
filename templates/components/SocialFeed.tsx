import React from 'react';
import { TwitterTimelineEmbed } from 'react-twitter-embed';

const SocialFeed = () => (
  <div>
    <TwitterTimelineEmbed
      sourceType="profile"
      screenName="twitter_handle"
      options={{ height: 400 }}
    />
  </div>
);

export default SocialFeed;
