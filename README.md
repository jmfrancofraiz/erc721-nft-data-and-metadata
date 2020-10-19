# ERC721 NFT on-chain data and metadata

This proof of concept explores a way to store attributes along with tokens in their own contract, as well as in events that get inmutably persisted at on-chain logs, which I call data a metadata respectively:

* Data: Custom attributes stored in a mapping at the ERC721 NFT contract.
* Metadata: extra data in the form of a JSON string which is stored as an event emitted at minting time.

Storing token metadata on-chain enhances decetralization, rather than using tokenURI to point to a centralized (off-chain server) JSON endpoint.

The idea behind storing token extra data at logs is to reduce gas costs, as recording data as logs is much cheaper than at contract's own storage. This comes with a drawback, as there is no way to access log data from a function contract, but if there is no such need, it's a good place to store it. This way, you can store attributes that need to be accesible by contracts at the data mapping, and other attributes that don't have that requirement at logs.

## Code example

Minting:
```
// mint parameters: tokenId, name, power, other attributes
myAwesomeNFT.mint(1,'Magic sword',125,'{"color":"red","metal":true}');
```
Access custom attributes (data):
```
const data = myAwesomeNFT.getData(1);
assert.equal(data.name,'Magic sword'); // true
assert.equal(data.power,125); // true
```
Access other attributes (metadata):
```
const events = await myAwesomeNFT.getPastEvents('MetadataEvent',{filter:{tokenId:1}});
const metadata = JSON.parse(events[0].returnValues._metadata);
assert.equal(metadata.color,'red'); // true
assert.equal(metadata.metal,true); // true
```

## Tests

To execute the tests, you need a running ganache instante. Then, You can run the tests with:

```
$ truffle test
```




