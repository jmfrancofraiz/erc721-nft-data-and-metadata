const AwesomeNFT = artifacts.require("AwesomeNFT");

contract("AwesomeNFT", () => {

    const _metadata = {
        attr1 : "value1",
        attr2 : 123,
        attr3 : true
    }

    const _data = {
        customDataAttr1 : 1,
        customDataAttr2 : 2,
        customDataAttr3 : "some text"
    }

    const _tokenId = 5;

    let _contract = null;

    before("Mint a token with some metadata", async () => {
        _contract = await AwesomeNFT.deployed();
        const mintTx = await _contract.mint(1,_data.customDataAttr1,_data.customDataAttr2,_data.customDataAttr3,JSON.stringify(_metadata));
    });

    it("Token " + _tokenId + " data should be " + JSON.stringify(_data), async () => {
        const data = await _contract.getData(_tokenId);
        assert.equal(data.attr1,_data.attr1);
        assert.equal(data.attr2,_data.attr2);
        assert.equal(data.attr3,_data.attr3);
    });

    it("Token " + _tokenId + " metadata should be " + JSON.stringify(_metadata), async () => {
        const events = await _contract.getPastEvents('MetadataEvent', {
            filter: { tokenId: _tokenId },
            toBlock: 'latest'
        });
        assert.equal(1,events.length);
        const metadata = JSON.parse(events[0].returnValues._metadata);
        Object.keys(metadata).map(function(key, index) {
            assert.equal(metadata[key],_metadata[key]);
        });
    });

});