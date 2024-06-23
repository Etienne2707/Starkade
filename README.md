# Starkade

Introducing **Starkade**, the ultimate onchain gaming platform. Say goodbye to complicated rules and lengthy setups, with Starkade you can jump right into the action and start having fun.

## Built to last

Starkade is fully open source, allowing anyone to review, modify or expand the platform!

Starkade is built on the **[Starknet](https://starknet.io)** ecosystem with the **[Dojo](https://dojoengine.org)** engine, fully leveraging all its advantages : *Scalability*, *Low fees* and *Security*.

## Build the host application

Deploying your local copy is made easy with containers. Here's how you can get started in just a few minutes :

1. Clone the repository and move into it

`git clone https://github.com/Etienne2707/Starkade.git && cd Starkade`

2. Install the dependencies

`make install`

3. Start the project

`make dev`

That's it, now simply open [http://localhost:3000](http://localhost:3000) and have fun!

## Build the individual games

Sadly automated builds for the individual games aren't yet fully working, due to some few variables set in stone in some of the modules we use. Fixing it would require some investigation, which will be done in due time. In the meanwhile, here are the steps needed to build them manually :

1. Start katana

`katana --disable-fee --allowed-origins="*"`

2. Build and apply migration for the project

`sozo build && sozo migrate apply`

3. Start torii with the default world

`torii --world  0x6457e5a40e8d0faf6996d8d0213d6ba2f44760606e110e03e3d239c5f769e87 --allowed-origins "*"`

4. Build and start the frontend for the app

`pnpm i && pnpm run dev`

That's it, you can now access the game at [http://localhost:5173](http://localhost:5173)

## Automated single game deployement

While now fully working yet, a Makefile is still provided alongside each single game to help deploying it. Here are the steps to get it right :

1. Build your dojo toolchain image at the root of the main project

`Make build_dojo`

2. Run the sozo steps at the root of your individual game

`Make dev`

3. Start torri at the root of your individual game

`Make torii`

4. The frontend can now be built and deployed normally

`pnpm i && pnpm run dev`
