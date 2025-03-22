import React from 'react';
import Image from 'next/image';
import Link from 'next/link';
import { motion } from 'framer-motion';

type BlogPostProps = {
  title: string;
  excerpt: string;
  content: string;
  coverImage: string;
  date: string;
  author: {
    name: string;
    avatar: string;
  };
  categories: string[];
  slug: string;
  isFeatured?: boolean;
};

const BlogPost = ({
  title,
  excerpt,
  content,
  coverImage,
  date,
  author,
  categories,
  slug,
  isFeatured = false
}: BlogPostProps) => {
  const formattedDate = new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });

  return (
    <motion.article 
      className={`bg-white rounded-lg shadow-md overflow-hidden ${isFeatured ? 'border-2 border-indigo-500' : ''}`}
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.3 }}
    >
      <div className="relative h-60 w-full">
        <Image
          src={coverImage}
          alt={title}
          fill
          sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
          className="object-cover"
        />
        {isFeatured && (
          <div className="absolute top-4 left-4 bg-indigo-500 text-white text-xs font-bold px-2 py-1 rounded">
            FEATURED
          </div>
        )}
      </div>
      
      <div className="p-6">
        <div className="flex flex-wrap gap-2 mb-3">
          {categories?.map(category => (
            <Link
              key={category}
              href={`/category/${category.toLowerCase()}`}
              className="text-xs bg-gray-100 text-gray-600 px-2 py-1 rounded hover:bg-gray-200 transition-colors"
            >
              {category}
            </Link>
          ))}
        </div>
        
        <Link href={`/blog/${slug}`}>
          <h2 className="text-2xl font-semibold text-gray-900 mb-2 hover:text-indigo-600 transition-colors">
            {title}
          </h2>
        </Link>
        
        <p className="text-gray-600 mb-4">{excerpt}</p>
        
        <div className="flex items-center justify-between">
          <div className="flex items-center">
            <div className="h-8 w-8 rounded-full overflow-hidden mr-2">
              <Image
                src={author.avatar}
                alt={author.name}
                width={32}
                height={32}
                className="object-cover"
              />
            </div>
            <span className="text-sm text-gray-700">{author.name}</span>
          </div>
          <span className="text-sm text-gray-500">{formattedDate}</span>
        </div>
      </div>
    </motion.article>
  );
};

export default BlogPost;
