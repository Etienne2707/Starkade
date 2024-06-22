import { AccountInterface } from "starknet";
import { Entity, getComponentValue } from "@dojoengine/recs";
import { uuid } from "@latticexyz/utils";
import { ClientComponents } from "./createClientComponents";
import { GameState } from "../utils";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { ContractComponents } from "./generated/contractComponents";
import type { IWorld } from "./generated/generated";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls(
  { client }: { client: IWorld },
  _contractComponents: ContractComponents,
  {}: ClientComponents
) {
  const create_player = async (account: AccountInterface) => {
    try {
      const { transaction_hash } = await client.actions.create_player({
        account,
      });

      await account.waitForTransaction(transaction_hash, {
        retryInterval: 100,
      });

      console.log(
        await account.waitForTransaction(transaction_hash, {
          retryInterval: 100,
        })
      );

      await new Promise((resolve) => setTimeout(resolve, 1000));
    } catch (e) {
      console.log(e);
    }
  };

  const create_game = async (account: AccountInterface) => {
    try {
      const { transaction_hash } = await client.actions.create_game({
        account,
      });

      await account.waitForTransaction(transaction_hash, {
        retryInterval: 100,
      });

      console.log(
        await account.waitForTransaction(transaction_hash, {
          retryInterval: 100,
        })
      );

      await new Promise((resolve) => setTimeout(resolve, 1000));
    } catch (e) {
      console.log(e);
    }
  };

  const join = async ({
    account,
    game_id,
  }: {
    account: AccountInterface;
    game_id: number;
  }) => {
    try {
      const { transaction_hash } = await client.actions.join({
        account,
        game_id,
      });

      await account.waitForTransaction(transaction_hash, {
        retryInterval: 100,
      });

      console.log(
        await account.waitForTransaction(transaction_hash, {
          retryInterval: 100,
        })
      );

      await new Promise((resolve) => setTimeout(resolve, 1000));
    } catch (e) {
      console.log(e);
    }
  };

  const leave = async ({
    account,
    game_id,
  }: {
    account: AccountInterface;
    game_id: number;
  }) => {
    try {
      const { transaction_hash } = await client.actions.leave({
        account,
        game_id,
      });

      await account.waitForTransaction(transaction_hash, {
        retryInterval: 100,
      });

      console.log(
        await account.waitForTransaction(transaction_hash, {
          retryInterval: 100,
        })
      );

      await new Promise((resolve) => setTimeout(resolve, 1000));
    } catch (e) {
      console.log(e);
    }
  };


  return {
    create_player,
    create_game,
    join,
    leave,
  };
}
