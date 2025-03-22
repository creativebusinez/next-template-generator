import React from 'react';
import Image from 'next/image';
import Link from 'next/link';
import { motion } from 'framer-motion';

type ProductCardProps = {
  id: string;
  name: string;
  price: number;
  imageUrl: string;
  category?: string;
  rating?: number;
  onSale?: boolean;
};

const ProductCard = ({ id, name, price, imageUrl, category, rating, onSale }: ProductCardProps) => {
  return (
    <motion.div 
      className="bg-white rounded-lg shadow-md overflow-hidden"
      whileHover={{ y: -5, transition: { duration: 0.2 } }}
    >
      <Link href={`/products/${id}`}>
        <div className="relative h-48 w-full">
          <Image 
            src={imageUrl} 
            alt={name}
            fill
            sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
            className="object-cover"
          />
          {onSale && (
            <div className="absolute top-2 right-2 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded">
              SALE
            </div>
          )}
        </div>
        <div className="p-4">
          {category && (
            <span className="text-xs text-gray-500 uppercase tracking-wide">
              {category}
            </span>
          )}
          <h3 className="font-medium text-gray-900 mt-1">{name}</h3>
          <div className="flex justify-between items-center mt-2">
            <span className="font-bold text-gray-900">
              ${price.toFixed(2)}
            </span>
            {rating && (
              <div className="flex items-center">
                <span className="text-yellow-400">★</span>
                <span className="text-sm text-gray-600 ml-1">{rating}</span>
              </div>
            )}
          </div>
        </div>
      </Link>
    </motion.div>
  );
};

export default ProductCard;