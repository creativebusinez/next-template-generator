import React from 'react';

const PaymentButton = () => (
  <a
    href="https://buy.stripe.com/test_XXXXXXXXXX"
    target="_blank"
    rel="noopener noreferrer"
    className="bg-green-500 text-white p-3 rounded inline-block"
  >
    Buy Now
  </a>
);

export default PaymentButton;
