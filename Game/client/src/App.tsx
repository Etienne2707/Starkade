import { useMemo, useState, useEffect } from "react";
import "./App.css";
import { useDojo } from "./dojo/useDojo";
import { useComponentValue, useEntityQuery } from "@dojoengine/react";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { shortString } from "starknet";
import { Has, HasValue } from "@dojoengine/recs";
import { BigNumber } from "ethers";


function App() {
  const {
    setup: {
      client,
      clientComponents: { Player },
    },
    account: { account },
  } = useDojo();

  const playerQuery = useEntityQuery([
    Has(Player),
    HasValue(Player, { address: BigInt(account.address) }),
  ]);

  const player = useComponentValue(Player, playerQuery[0]);

  
  // [get] player with recs query
  return (
    <div className="container mx-auto">
      <h1 className="text-3xl text-center">Dojo PrivateRoom</h1>
      <div className="text-xl py-3">
        {player?.address ? (
          <div>player = {player.name.toString()} address = {player?.address.toString()}</div>
        ) : (
          <button
            onClick={async () => {
              await client.actions.create_player({ account });
            }}
          >
            create_player
          </button>
        )}
      </div>
    </div>
  );
}

export default App;
