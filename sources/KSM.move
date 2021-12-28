/// KSM (Kusama) native coin.
module PontemFramework::KSM {
    use PontemFramework::CoreAddresses;
    use PontemFramework::Pontem;
    use PontemFramework::PontTimestamp;

    struct KSM has key, store {}

    struct Drop has key {
        mint_cap: Pontem::MintCapability<KSM>,
        burn_cap: Pontem::BurnCapability<KSM>,
    }

    /// Registers the `KSM` cointype. This can only be called from genesis.
    public fun initialize(
        root_account: &signer,
    ) {
        PontTimestamp::assert_genesis();
        CoreAddresses::assert_root(root_account);

        let (mint_cap, burn_cap) = Pontem::register_native_currency<KSM>(
            root_account,
            12,
            b"KSM",
            b"KSM",
        );

        move_to(root_account, Drop {mint_cap, burn_cap});
    }
}
