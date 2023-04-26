// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../../erc721c/extensions/ERC721CW.sol";
import "../../programmable-royalties/ImmutableMinterRoyalties.sol";

contract ERC721CWWithImmutableMinterRoyalties is ERC721CW, ImmutableMinterRoyalties {

    constructor(
        uint256 royaltyFeeNumerator_,
        address wrappedCollectionAddress_,
        string memory name_,
        string memory symbol_) 
        ERC721CW(wrappedCollectionAddress_, name_, symbol_) 
        ImmutableMinterRoyalties(royaltyFeeNumerator_) {
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721C, ImmutableMinterRoyalties) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _mint(address to, uint256 tokenId) internal virtual override {
        _onMinted(to, tokenId);
        super._mint(to, tokenId);
    }

    function _safeMint(address to, uint256 tokenId) internal virtual override {
        _onMinted(to, tokenId);
        super._safeMint(to, tokenId);
    }

    function _burn(uint256 tokenId) internal virtual override {
        super._burn(tokenId);
        _onBurned(tokenId);
    }
}
