import React from 'react';
import { motion } from 'framer-motion';

type TimelineItem = {
  title: string;
  date: string;
  description: string;
  icon?: string;
  location?: string;
};

type TimelineProps = {
  items: TimelineItem[];
  title?: string;
};

const Timeline = ({ items, title = "Experience" }: TimelineProps) => {
  return (
    <div className="bg-white rounded-lg shadow-md p-6">
      <h2 className="text-2xl font-semibold text-gray-900 mb-6">{title}</h2>
      
      <div className="relative">
        {/* Vertical line */}
        <div className="absolute top-0 left-6 bottom-0 w-0.5 bg-gray-200" />
        
        <div className="space-y-8">
          {items.map((item, index) => (
            <motion.div 
              key={index}
              className="relative pl-14"
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: index * 0.1 }}
            >
              {/* Timeline dot */}
              <div className="absolute left-0 top-1 h-12 w-12 rounded-full bg-indigo-100 flex items-center justify-center z-10">
                {item.icon ? (
                  <span 
                    className="w-6 h-6 text-indigo-600" 
                    dangerouslySetInnerHTML={{ __html: item.icon }} 
                  />
                ) : (
                  <div className="h-4 w-4 rounded-full bg-indigo-500" />
                )}
              </div>
              
              <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
                <div className="flex flex-col sm:flex-row sm:justify-between sm:items-center mb-2">
                  <h3 className="text-lg font-medium text-gray-800">{item.title}</h3>
                  <div className="text-sm text-gray-500 mt-1 sm:mt-0">{item.date}</div>
                </div>
                
                {item.location && (
                  <div className="text-sm text-indigo-600 mb-2">{item.location}</div>
                )}
                
                <p className="text-gray-600">{item.description}</p>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Timeline;
