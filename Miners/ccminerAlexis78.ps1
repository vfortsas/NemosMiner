. .\Include.ps1

$Path = ".\Bin\NVIDIA-Alexis78\ccminer.exe"
$Uri = "https://github.com/nemosminer/ccminerAlexis78/releases/download/3%2F3%2F2018/ccminer-Alexis78.zip"

$Commands = [PSCustomObject]@{
    "c11" = " -i 21 -d $SelGPUCC --api-remote" #C11
    "lbry" = " -d $SelGPUCC --api-remote" #Lbry
    "lyra2v2" = " -d $SelGPUCC --api-remote" #Lyra2RE2
    "veltor" = " -i 23 -d $SelGPUCC --api-remote" #Veltor
    #"blake2s" = " -d $SelGPUCC --api-remote" #Blake2s
    #"hsr" = " -d $SelGPUCC --api-remote" #Hsr
    #"keccak" = " -m 2 -i 29 -d $SelGPUCC" #Keccak
    #"nist5" = " -d $SelGPUCC --api-remote" #Nist5
    #"sib" = " -i 21 -d $SelGPUCC --api-remote" #Sib
    #"x17" = " -i 20 -d $SelGPUCC --api-remote" #X17
    #"bitcore" = "" #Bitcore
    #"blakecoin" = " -d $SelGPUCC --api-remote" #Blakecoin
    #"vanilla" = "" #BlakeVanilla
    #"cryptonight" = "" #Cryptonight
    #"decred" = "" #Decred
    #"equihash" = "" #Equihash
    #"ethash" = "" #Ethash
    #"groestl" = "" #Groestl
    #"hmq1725" = "" #hmq1725
    #"lyra2z" = "" #Lyra2z
    #"myr-gr" = " -d $SelGPUCC --api-remote" #MyriadGroestl
    #"neoscrypt" = " -i 15 -d $SelGPUCC" #NeoScrypt
    #"pascal" = "" #Pascal
    #"qubit" = "" #Qubit
    #"scrypt" = "" #Scrypt
    #"sia" = "" #Sia
    #"skein" = " -d $SelGPUCC --api-remote" #Skein
    #"timetravel" = "" #Timetravel
    #"x11evo" = "" #X11evo
    #"x11gost" = " -i 21 -d $SelGPUCC --api-remote" #X11gost
    #"yescrypt" = "" #Yescrypt
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "-b $($Variables.MinerAPITCPPort) -a $_ -o stratum+tcp://$($Pools.(Get-Algorithm($_)).Host):$($Pools.(Get-Algorithm($_)).Port) -u $($Pools.(Get-Algorithm($_)).User) -p $($Pools.(Get-Algorithm($_)).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Week}
        API = "Ccminer"
        Port = $Variables.MinerAPITCPPort #4068
        Wrap = $false
        URI = $Uri
		User = $Pools.(Get-Algorithm($_)).User
    }
}
