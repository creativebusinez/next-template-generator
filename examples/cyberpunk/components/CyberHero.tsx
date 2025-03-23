import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import type { MouseEvent } from 'react';

const CyberHero = () => {
  const [mousePosition, setMousePosition] = useState({ x: 0, y: 0 });

  // Parallax effect on mouse move
  useEffect(() => {
    const handleMouseMove = (e: MouseEvent) => {
      setMousePosition({
        x: e.clientX / window.innerWidth,
        y: e.clientY / window.innerHeight,
      });
    };

    window.addEventListener('mousemove', handleMouseMove);
    return () => window.removeEventListener('mousemove', handleMouseMove);
  }, []);

  return (
    <div className="relative min-h-screen cyber-grid bg-gray-900 overflow-hidden">
      {/* Animated background elements */}
      <motion.div
        className="absolute inset-0"
        animate={{
          backgroundPosition: `${mousePosition.x * 50}px ${mousePosition.y * 50}px`
        }}
        style={{
          backgroundImage: 'radial-gradient(circle, rgba(66, 56, 255, 0.1) 2px, transparent 2px)',
          backgroundSize: '50px 50px',
        }}
      />

      <div className="container mx-auto px-6 py-24 relative z-10">
        {/* Floating card with glass effect */}
        <motion.div
          initial={{ y: 100, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 1, type: "spring" }}
          className="glass neon-border rounded-2xl p-8 max-w-2xl mx-auto floating"
        >
          {/* Glowing title */}
          <motion.h1
            className="text-4xl md:text-6xl font-bold text-white text-glow mb-6"
            animate={{ scale: [1, 1.02, 1] }}
            transition={{ duration: 2, repeat: Infinity }}
          >
            Cyberpunk Future
          </motion.h1>

          <p className="text-indigo-200 text-lg mb-8">
            Enter the digital frontier where reality meets imagination.
            Experience the future of web design.
          </p>

          {/* Interactive button with hover effect */}
          <motion.button
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            className="btn-primary bg-indigo-600 text-glow neon-border"
          >
            Enter Matrix
          </motion.button>
        </motion.div>

        {/* Decorative elements */}
        {[...Array(3)].map((_, i) => (
          <motion.div
            key={i}
            className="absolute w-32 h-32 bg-indigo-500/10 rounded-full"
            animate={{
              x: [0, 100, 0],
              y: [0, -100, 0],
              opacity: [0.5, 0.8, 0.5],
            }}
            transition={{
              duration: 10,
              repeat: Infinity,
              delay: i * 2,
            }}
            style={{
              left: `${30 + i * 20}%`,
              top: `${20 + i * 20}%`,
            }}
          />
        ))}
      </div>
    </div>
  );
};

export default CyberHero; 