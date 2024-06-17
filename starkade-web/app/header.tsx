import Link from 'next/link';
import Image from 'next/image';

// Define the Header component
export default function Header() {
  return (
    <header className="bg-gray-900 text-white py-4 sticky top-0 z-50">
      {/* Header container */}
      <div className="container mx-auto px-4 flex justify-between items-center">
        {/* Website title */}
        <Link href="/">
          <h1 className="cursor-pointer text-4xl font-bold hover:text-pink">Starkade</h1>
        </Link>
        {/* Navigation menu */}
        <nav className="hidden md:block">
          <ul className="flex gap-x-6">
            {/* Navigation links */}
            <li>
              <Link href="/about" className="hover:text-pink">
                About us
              </Link>
            </li>
            <li>
              <Link href="/faq" className="hover:text-pink">
                FAQ
              </Link>
            </li>
            <li>
              <Link href="/contact" className="hover:text-pink">
                Contact
              </Link>
            </li>
          </ul>
        </nav>
        {/* Social media icons */}
        <div className="block">
          <SocialIcons />
        </div>
        {/* Add Mobile Navigation Toggle Here */}
        {/*
        <div className="block">
          <DropdownMenu />
        </div>
        */}
      </div>
    </header>
  );
}

// Define the SocialIcons component
function SocialIcons() {
  return (
    <div className="flex gap-x-4">
      {/* GitHub icon */}
      <a
        href="https://github.com/Etienne2707/Starkade"
        target="_blank"
        rel="noopener noreferrer"
      >
        <Image src="/github-mark-white.svg" width={30} height={30} alt="" />
      </a>
      {/* Add more social media icons as needed */}
    </div>
  );
}
