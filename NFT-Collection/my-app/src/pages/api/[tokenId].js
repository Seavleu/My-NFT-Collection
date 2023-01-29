// Next.js API route support: https://nextjs.org/docs/api-routes/introduction

// Base URI
// base URI = https://example.com/
//Token ID = 1
//TokenURI(1) => https://example.com/1

export default function handler(req, res) {
  // make generic end-point: next.js api prameter
  // get the tokenId from the query params
  const tokenId = req.query.tokenId;
  // res.status(200).json({
  //   tokenId: tokenId,
  // });


  // As all the images are uploaded on github, we can extract the images from github directly.
  const image_url =
    "https://raw.githubusercontent.com/LearnWeb3DAO/NFT-Collection/main/my-app/public/cryptodevs/";

  // The api is sending back metadata for a Crypto Dev
  // To make our collection compatible with Opensea, we need to follow some Metadata standards
  // when sending back the response from the api
  // More info can be found here: https://docs.opensea.io/docs/metadata-standards
  
  const name = 'Crypto Dev #${tokenId}';
  const description = "CryptoDevs is an NFT Collection for Web3 Developers";
  return res.json({
    name: "Crypto Dev #" + tokenId,
    description: "Crypto Dev is a collection of developers in crypto",
    image: image_url + tokenId + ".svg",
  });
}
