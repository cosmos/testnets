import * as fs from 'fs';
import * as util from 'util';
import {BigNumber} from "bignumber.js"
import * as bech32 from "bech32"

// Convert fs.readFile into Promise version of same    
const readFile = util.promisify(fs.readFile);

function parseFraction(fraction: string):string{
    let parts = fraction.split("/")

    if( parts.length == 2){
        return new BigNumber(parts[0]).div(new BigNumber(parts[1])).toFixed(2)
    }
    return fraction

}

function fractionToDecimal(fraction: string):string{
    return parseFraction(fraction)
}


function convertBech32(encoded:string):string{
    let data = bech32.decode(encoded)
    return bech32.encode("cosmos",data.words)
}

async function getStuff() {
    return await readFile('../gaia8001.json');
  }



  getStuff().then(data => {
    let genesis = JSON.parse(data.toString()); 
    let validators = genesis.app_state.stake.validators;
    for (let val of validators){
        val.tokens = fractionToDecimal(val.tokens)
        val.delegator_shares = fractionToDecimal(val.delegator_shares)
        val.jailed = val.revoked
        delete val.revoked
    }
    let accounts = genesis.app_state.accounts
    for (let account of accounts){
        account.address = convertBech32(account.address)
    }
    console.log(accounts)


  }
  )