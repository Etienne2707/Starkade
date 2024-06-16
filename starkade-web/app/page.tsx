import Image from "next/image";
import Link from "next/link";
import React from "react";

const App = () => {
  const games = [
    {
      link: "games/dos",
      image:
        "/wip.jpg",
      name: `DOS`,
    },
    {
      link: "games/rock_paper_scissors",
      image:
        "/wip.jpg",
      name: `Rock\, Paper\, Scissors`,
    },
    {
      link: "games/market_brawl",
      image:
        "/wip.jpg",
      name: `Market Brawl`,
    },
    {
      link: "games/wip",
      image:
        "/wip.jpg",
      name: `Work in progress`,
    },
    {
      link: "games/wip",
      image:
        "/wip.jpg",
      name: `Work in progress`,
    },
    {
      link: "games/wip",
      image:
        "/wip.jpg",
      name: `Work in progress`,
    },
  ];
  return (
    <>
      <div className="">
        <div className="p-6 container mx-auto">
          <div className="py-2">
            <h1 className="text-center text-4xl">Starkade</h1>
          </div>
          <div className="md:grid md:gap-6 md:grid-cols-2 lg:grid-cols-3 mb-12">
            {games.map((game) => {
              return (
                <>
                  <article
                    key={game.name}
                    className="p-6 mb-6  transition duration-300 group transform hover:-translate-y-2 hover:shadow-2xl rounded-2xl cursor-pointer"
                  >
                    <Link
                      href={game.link}
                      className="absolute opacity-0 top-0 right-0 left-0 bottom-0"
                    />
                    <div className="relative mb-4 rounded-2xl">
                      <Image
                        width={400}
                        height={400}
                        className="max-h-80 rounded-2xl w-full object-cover transition-transform duration-300 transform group-hover:scale-105"
                        src={game.image}
                        alt=""
                      />
                      <Link
                        className="flex justify-center items-center bg-black bg-opacity-60  absolute top-0 left-0 w-full h-full text-white rounded-2xl opacity-0 transition-all duration-300 transform group-hover:scale-105 text-xl group-hover:opacity-100"
                        href={game.link}
                        target="_blank"
                        rel="noopener noreferrer"
                      >
                        Play {game.name}
                      </Link>
                    </div>
                    <h3 className="font-medium text-xl leading-8">
                      <Link
                        href={game.link}
                        className="block relative group-hover:text-purple-500 transition-colors duration-200"
                      >
                        <span dangerouslySetInnerHTML={{ __html: game.name }} />
                      </Link>
                    </h3>
                  </article>
                </>
              );
            })}
          </div>
        </div>
      </div>
    </>
  );
};

export default App;
