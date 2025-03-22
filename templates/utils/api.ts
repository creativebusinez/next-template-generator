// Add helper functions for interacting with external APIs if needed.
export const fetchData = async (url: string) => {
  const res = await fetch(url);
  return res.json();
};
