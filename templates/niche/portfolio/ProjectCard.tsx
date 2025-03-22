import React from 'react';
import Image from 'next/image';
import Link from 'next/link';
import { motion } from 'framer-motion';

type ProjectCardProps = {
  title: string;
  description: string;
  image: string;
  tags: string[];
  link: string;
  featured?: boolean;
};

const ProjectCard = ({ title, description, image, tags, link, featured = false }: ProjectCardProps) => {
  return (
    <motion.div 
      className={`rounded-lg overflow-hidden shadow-md bg-white ${
        featured ? 'border-2 border-indigo-500' : ''
      }`}
      whileHover={{ y: -8, transition: { duration: 0.2 } }}
    >
      <div className="relative h-48 w-full">
        <Image
          src={image}
          alt={title}
          fill
          sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
          className="object-cover"
        />
        {featured && (
          <div className="absolute top-3 right-3 bg-indigo-500 text-white px-2 py-1 text-xs font-bold rounded">
            FEATURED
          </div>
        )}
      </div>
      
      <div className="p-5">
        <h3 className="text-xl font-semibold text-gray-900 mb-2">{title}</h3>
        <p className="text-gray-600 mb-4 line-clamp-2">{description}</p>
        
        <div className="flex flex-wrap gap-2 mb-4">
          {tags.map(tag => (
            <span 
              key={tag} 
              className="bg-gray-100 text-gray-600 text-xs px-2 py-1 rounded"
            >
              {tag}
            </span>
          ))}
        </div>
        
        <Link 
          href={link} 
          className="inline-block bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700 transition-colors"
        >
          View Project
        </Link>
      </div>
    </motion.div>
  );
};

export default ProjectCard;