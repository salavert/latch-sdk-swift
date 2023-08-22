import LatchSDK
import Foundation

let appId = "nRtj8te3quNZKWeCmJZq"
let latchSDK = LatchSDK(
    appId: appId,
    appSecret: "9kzpD6xhP3JFLBm2YdqYk9rRrgAdtVGV3uXGazsi",
    apiUserId: "p4p2tnZfajgfMVbxBx8Q",
    apiUserSecret: "NgZJVKwPtMPgTsCxBkM6BECfcLJyPYppEA4gdYpz"
)

let accountId = "c8pV6Ks8428MrUthf696EP4BcYmYedx9fnH9NXbMJPBYyxMjEWTihxZDzZjN2Mqz"

// MARK: Pair a Latch application
let (data, response) = try await latchSDK.pair(token: "tTiYvn")
// App push: Servicio pareado
// {"data":{"accountId":"c8pV6Ks8428MrUthf696EP4BcYmYedx9fnH9NXbMJPBYyxMjEWTihxZDzZjN2Mqz"}}

// MARK: Pair a Latch application Web3
//let (data, response) = try await latchSDK.pair(token: "NAecGP", web3Wallet: "any-wallet", web3Signature: "any-signature")

// MARK: Unpair a Latch application
//let (data, response) = try await latchSDK.unpair(accountId: accountId)
// App push: Servicio despareado

// MARK: Status of an application
//let (data, response) = try await latchSDK.status(accountId: accountId)
// App push: Acceso al servicio
// {"data":{"operations":{"nRtj8te3quNZKWeCmJZq":{"status":"on"}}}}

// MARK: Locks an application
//let (data, response) = try await latchSDK.lock(accountId: accountId)
// App push: Latch modificado

// MARK: Unlocks an application
//let (data, response) = try await latchSDK.unlock(accountId: accountId)
// App push: Latch modificado

// MARK: History
//let (data, response) = try await latchSDK.history(accountId: accountId)
// App push: Latch modificado

// MARK: User Applications
//let (data, response) = try await latchSDK.getUserApplications()
// {"data":{"operations":{"nRtj8te3quNZKWeCmJZq":{"name":"Test App","two_factor":"DISABLED","lock_on_request":"DISABLED","secret":"9kzpD6xhP3JFLBm2YdqYk9rRrgAdtVGV3uXGazsi","contactPhone":"","contactEmail":"","imageUrl":"https://latchstorage.blob.core.windows.net/pro-custom-images/avatar8.jpg","operations":{}}}}}

// MARK: Operation

//let (data, response) = try await latchSDK.addOperation(
//    parentId: appId,
//    details: .init(
//        name: "Playground Operation",
//        twoFactor: .mandatory,
//        lockOnRequest: .optional
//    ))
// {"data":{"operationId":"ftFnNiK2daN948hVA8U7"}}

//let (data, response) = try await latchSDK.operation(operationId: "CKBcijpiMyCb6PvmAKnb")
//{"data":{"operations":{"operationId":{"name":"...","two_factor":"...","lock_on_request":"...","operations":{...}}}}}


//let (data, response) = try await latchSDK.modifyOperation(
//    operationId: "ftFnNiK2daN948hVA8U7",
//    details: .init(
//        name: "Playground Operation 2",
//        twoFactor: .mandatory,
//        lockOnRequest: .optional
//    ))

//let (data, response) = try await latchSDK.deleteOperation(operationId: "ftFnNiK2daN948hVA8U7")

// MARK: User Applications

//let (data, response) = try await latchSDK.addUserApplication(details: .init(
//    name: "PlaygroundApp",
//    contactEmail: "salavert@gmail.com",
//    contactPhone: "626051331",
//    twoFactor: .mandatory,
//    lockOnRequest: .optional
//))
// {"data":{"applicationId":"y79q42qcm6WixFWBsnhq","secret":"T3fcG66BwAW6XkR4rMvDNhBxt4zTxyp7CCYFs28L"}}

//let (data, response) = try await latchSDK.modifyUserApplication(
//    appId: "y79q42qcm6WixFWBsnhq",
//    details: .init(
//        name: "Playground App 3",
//        contactEmail: "salavert@gmail.com",
//        contactPhone: "626051331",
//        twoFactor: .mandatory,
//        lockOnRequest: .optional
//    ))

//let (data, response) = try await latchSDK.deleteUserApplication(
//    appId: "y79q42qcm6WixFWBsnhq"
//)

//let (data, response) = try await latchSDK.subscription()

print("\nRESPONSE BODY")
print(String(data: data, encoding: String.Encoding.utf8)!)
// {"data":{"subscription":{"id":"vip","applications":{"inUse":1,"limit":-1},"operations":{"Test App":{"inUse":0,"limit":-1}},"users":{"inUse":1,"limit":-1}}}}

//print("\nRESPONSE")
//print(response)
