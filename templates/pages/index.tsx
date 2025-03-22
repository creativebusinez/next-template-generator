import { motion } from 'framer-motion';
import React from 'react';

export default function Home() {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.5 }}
      className="space-y-8"
    >
      <section className="py-20 bg-gradient-to-br from-indigo-600 via-purple-600 to-indigo-700 text-white rounded-lg shadow-xl mb-16">
        <div className="container mx-auto px-6 text-center">
          <h1 className="text-5xl md:text-6xl font-bold text-white mb-6">Welcome to Your Site</h1>
          <p className="text-xl md:text-2xl text-indigo-100 max-w-3xl mx-auto">This is a modern, responsive website built with Next.js and Tailwind CSS.</p>
        </div>
      </section>
      
      <div className="container mx-auto px-4">
        <h2 className="text-3xl font-bold mb-8 text-gray-900">Our Features</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <motion.div 
            whileHover={{ y: -5 }}
            className="bg-white rounded-xl shadow-lg p-6 transition-all hover:shadow-xl border border-gray-100"
          >
            <div className="bg-indigo-100 text-indigo-600 p-3 rounded-full w-14 h-14 flex items-center justify-center mb-4">
              <svg xmlns="http://www.w3.org/2000/svg" className="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <h3 className="text-xl font-semibold mb-2 text-gray-800">Feature 1</h3>
            <p className="text-gray-600">Description of your first feature goes here.</p>
          </motion.div>
          <motion.div 
            whileHover={{ y: -5 }}
            className="bg-white rounded-xl shadow-lg p-6 transition-all hover:shadow-xl border border-gray-100"
          >
            <div className="bg-indigo-100 text-indigo-600 p-3 rounded-full w-14 h-14 flex items-center justify-center mb-4">
              <svg xmlns="http://www.w3.org/2000/svg" className="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" />
              </svg>
            </div>
            <h3 className="text-xl font-semibold mb-2 text-gray-800">Feature 2</h3>
            <p className="text-gray-600">Description of your second feature goes here.</p>
          </motion.div>
          <motion.div 
            whileHover={{ y: -5 }}
            className="bg-white rounded-xl shadow-lg p-6 transition-all hover:shadow-xl border border-gray-100"
          >
            <div className="bg-indigo-100 text-indigo-600 p-3 rounded-full w-14 h-14 flex items-center justify-center mb-4">
              <svg xmlns="http://www.w3.org/2000/svg" className="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
              </svg>
            </div>
            <h3 className="text-xl font-semibold mb-2 text-gray-800">Feature 3</h3>
            <p className="text-gray-600">Description of your third feature goes here.</p>
          </motion.div>
        </div>
      </div>
    </motion.div>
  );
}
