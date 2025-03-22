import React from 'react';
import { motion } from 'framer-motion';

type Skill = {
  name: string;
  level: number; // 1-5
  icon?: string;
};

type SkillCategory = {
  name: string;
  skills: Skill[];
};

type SkillsProps = {
  categories: SkillCategory[];
};

const Skills = ({ categories }: SkillsProps) => {
  const container = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1
      }
    }
  };

  const item = {
    hidden: { opacity: 0, y: 20 },
    show: { opacity: 1, y: 0 }
  };

  return (
    <div className="bg-white rounded-lg shadow-md p-6">
      <h2 className="text-2xl font-semibold text-gray-900 mb-6">Skills & Expertise</h2>
      
      <div className="space-y-8">
        {categories.map((category, index) => (
          <div key={category.name}>
            <h3 className="text-lg font-medium text-gray-800 mb-4">{category.name}</h3>
            
            <motion.div 
              className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4"
              variants={container}
              initial="hidden"
              animate="show"
            >
              {category.skills.map((skill) => (
                <motion.div 
                  key={skill.name}
                  className="bg-gray-50 p-4 rounded-lg border border-gray-200"
                  variants={item}
                >
                  <div className="flex justify-between items-center mb-2">
                    <div className="flex items-center">
                      {skill.icon && (
                        <span 
                          className="mr-2 w-5 h-5" 
                          dangerouslySetInnerHTML={{ __html: skill.icon }} 
                        />
                      )}
                      <h4 className="font-medium text-gray-800">{skill.name}</h4>
                    </div>
                  </div>
                  
                  <div className="h-2 bg-gray-200 rounded-full overflow-hidden">
                    <div 
                      className="h-full bg-indigo-600 rounded-full"
                      style={{ width: `${(skill.level / 5) * 100}%` }}
                    />
                  </div>
                </motion.div>
              ))}
            </motion.div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Skills;
