import React from 'react';
import Link from 'next/link';
import { motion } from 'framer-motion';

type Category = {
  name: string;
  slug: string;
  count: number;
};

type CategoryListProps = {
  categories: Category[] | string[];
  activeCategorySlug?: string;
};

const CategoryList = ({ categories, activeCategorySlug }: CategoryListProps) => {
  // Check if categories are of type string[]
  const isStringArray = categories.length > 0 && typeof categories[0] === 'string';

  return (
    <motion.div 
      className="bg-white shadow-md rounded-lg p-6"
      initial={{ opacity: 0, x: -20 }}
      animate={{ opacity: 1, x: 0 }}
      transition={{ duration: 0.3 }}
    >
      <h3 className="text-lg font-semibold text-gray-900 mb-4">Categories</h3>
      <ul className="space-y-2">
        <li>
          <Link 
            href="/blog"
            className={`block px-3 py-2 rounded-md transition-colors ${
              !activeCategorySlug ? 'bg-indigo-50 text-indigo-700' : 'text-gray-700 hover:bg-gray-50'
            }`}
          >
            All Posts
          </Link>
        </li>
        {isStringArray 
          ? (categories as string[]).map((category) => (
            <li key={category}>
              <Link
                href={`/category/${category.toLowerCase()}`}
                className={`flex justify-between px-3 py-2 rounded-md transition-colors ${
                  activeCategorySlug === category.toLowerCase()
                    ? 'bg-indigo-50 text-indigo-700' 
                    : 'text-gray-700 hover:bg-gray-50'
                }`}
              >
                <span>{category}</span>
              </Link>
            </li>
          ))
          : (categories as Category[]).map((category) => (
            <li key={category.slug}>
              <Link
                href={`/category/${category.slug}`}
                className={`flex justify-between px-3 py-2 rounded-md transition-colors ${
                  activeCategorySlug === category.slug 
                    ? 'bg-indigo-50 text-indigo-700' 
                    : 'text-gray-700 hover:bg-gray-50'
                }`}
              >
                <span>{category.name}</span>
                <span className="bg-gray-100 text-gray-600 text-xs px-2 py-1 rounded-full">
                  {category.count}
                </span>
              </Link>
            </li>
          ))
        }
      </ul>
    </motion.div>
  );
};

export default CategoryList;
