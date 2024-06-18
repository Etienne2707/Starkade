import Image from "next/image";
import Link from "next/link";

const App = () => {
  const games = [
    {
      link: "games/wip",
      image:
        "/wip.jpg",
      name: `DOS`,
    },
    {
      link: "games/wip",
      image:
        "/wip.jpg",
      name: `Rock\, Paper\, Scissors`,
    },
    {
      link: "games/wip",
      image:
        "/wip.jpg",
      name: `Market Brawl`,
    },
    {
      link: "games/test_game",
      image:
        "/wip.jpg",
      name: `Sample Game 1`,
    },
    {
      link: "games/wip",
      image:
        "/wip.jpg",
      name: `Sample Game 2`,
    },
    {
      link: "games/wip",
      image:
        "/wip.jpg",
      name: `Sample Game 3`,
    },
  ];
  return (
    <>
      <div className="">
        <div className="p-6 container mx-auto">
          <div className="py-2">
            <h2>Onchain games made easy</h2>
            <p className="text-center text-xl text-pink">Explore our collection of simple onchain games and start playing right away!</p>
          </div>
          <ul className="grid sm:grid-cols-1 sm:gap-2 md:gap-x-2 md:grid-cols-2 lg:grid-cols-3 mb-12">
            {games.map((game) => {
              return (
                <>
                  <li
                    key={game.name}
                    className="p-4 group rounded-2xl cursor-pointer"
                  >
                    <div className="relative rounded-2xl">
                      <Link href={game.link}>
                        <Image
                          width={400}
                          height={400}
                          className="max-h-80 rounded-2xl w-full object-cover duration-300 group-hover:scale-105 hover:shadow-2xl"
                          src={game.image}
                          alt=""
                        />
                        <p
                        className="bg-black bg-opacity-70 absolute bottom-0 left-0 p-1 ml-2 mb-2 text-white rounded-lg duration-300 text-xl group-hover:bg-opacity-55"
                        >
                          {game.name}
                        </p>
                      </Link>
                    </div>
                  </li>
                </>
              );
            })}
          </ul>
        </div>
      </div>
    </>
  );
};

export default App;
