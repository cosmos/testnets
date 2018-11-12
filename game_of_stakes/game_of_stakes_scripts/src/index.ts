import * as fs from 'fs';
import * as util from 'util';
import parse from  'csv-parse';

// import {BigNumber} from "bignumber.js"
import * as bech32 from "bech32"

// Convert fs.readFile into Promise version of same    
const readFile = util.promisify(fs.readFile);
// function parseFraction(fraction: string):string{
//     let parts = fraction.split("/")

//     if( parts.length == 2){
//         return new BigNumber(parts[0]).div(new BigNumber(parts[1])).toFixed(10)
//     }
//     return new BigNumber(parts[0]).toFixed(10)

// }

// function fractionToDecimal(fraction: string):string{
//     return parseFraction(fraction)
// }


function convertBech32(encoded:string, new_hrp:string):string{
    let data = bech32.decode(encoded)
    return bech32.encode(new_hrp,data.words)
}

async function getStuff() {
    return await readFile('../addresses.csv');
  }



  getStuff().then(data => {
    
    parse(data.toString(), {}, function(_err, csv_data){

    let accounts = [];

    var written_address = new Map();

    for (let player of csv_data){

        if (player[1].length == 0){
            continue;
        }
        try{
            
        let data = bech32.decode(player[1])


        if (data.prefix == "cosmos" || data.prefix == "cosmosaccaddr" || data.prefix == "cosmosvaloper"){
            let converted = convertBech32(player[1],"cosmos")

            if (written_address.get(converted)){
                continue;
            }
            written_address.set(converted, true)

            let acc = {
                "address":converted,
                "coins":[
                    {
                        "denom":"stake",
                        "amount":"10000"
                    }
                ],
                "sequence_number":"0",
                "account_number":"0"
            }
            accounts.push(acc);          
        }
    }
    catch{
        continue;
    }
    }
    // console.log(JSON.stringify(accounts, null, 4))
    console.log(accounts.length * 10000)
    })



    // let accounts = genesis.app_state.accounts
    // for (let account of accounts){
    //     account.address = convertBech32(account.address, "cosmos")
    //     account.coins = [{
    //         "denom":"steak",
    //         "amount":"50"
    //     }]
    // }
    // let tokens  = accounts.length * 50

    // console.log(JSON.stringify(accounts, null, 4))

    // console.log(tokens)


  }
  )