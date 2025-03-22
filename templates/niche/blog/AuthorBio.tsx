import React from 'react';
import Image from 'next/image';
import Link from 'next/link';
import { motion } from 'framer-motion';

type SocialLink = {
  platform: string;
  url: string;
  icon: string;
};

type AuthorBioProps = {
  name: string;
  avatar?: string;
  image?: string;
  bio: string;
  role?: string;
  socialLinks?: SocialLink[];
};

const AuthorBio = ({ 
  name, 
  avatar, 
  image,
  bio, 
  role, 
  socialLinks = [] 
}: AuthorBioProps) => {
  const avatarSrc = avatar || image || '';
  
  return (
    <motion.div 
      className="bg-white rounded-lg shadow-md p-6 flex flex-col md:flex-row items-center text-center md:text-left"
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.3 }}
    >
      <div className="h-24 w-24 md:h-32 md:w-32 relative rounded-full overflow-hidden mb-4 md:mb-0 md:mr-6 flex-shrink-0 border-2 border-gray-100">
        <Image
          src={avatarSrc}
          alt={name}
          fill
          sizes="(max-width: 768px) 96px, 128px"
          className="object-cover"
        />
      </div>
      
      <div>
        <h3 className="text-xl font-semibold text-gray-900">{name}</h3>
        {role && <p className="text-indigo-600 mb-2">{role}</p>}
        <p className="text-gray-600 mb-4">{bio}</p>
        
        {socialLinks.length > 0 && (
          <div className="flex justify-center md:justify-start space-x-4">
            {socialLinks.map((link) => (
              <Link 
                key={link.platform} 
                href={link.url}
                className="text-gray-500 hover:text-indigo-600 transition-colors"
                target="_blank"
                rel="noopener noreferrer"
              >
                <span className="sr-only">{link.platform}</span>
                <span className="w-5 h-5" dangerouslySetInnerHTML={{ __html: link.icon }} />
              </Link>
            ))}
          </div>
        )}
      </div>
    </motion.div>
  );
};

export default AuthorBio;
