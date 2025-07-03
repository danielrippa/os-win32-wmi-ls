
  do ->

    { create-wmi-security-descriptor: wmi-security } = dependency 'os.win32.wmi.Security'
    { wmi-namespaces } = dependency 'os.win32.wmi.Namespace'
    { build-path } = dependency 'os.filesystem.Path'
    { keep-array-items: keep, map-array-items: map } = dependency 'unsafe.Array'
    { object-member-pairs } = dependency 'unsafe.Object'
    { value-as-string } = dependency 'reflection.Value'

    wmi-scheme = 'winmgmts'

    as-unc = -> build-path [ '' '' it ]

    create-wmi-class-moniker = (classname, host = '.', namespace = wmi-namespaces.cim, security = wmi-security!) ->

      WScript.Echo classname

      to-string = ->

        connection = build-path [ (as-unc @host), @namespace ]

        classpath = [ connection, @classname ] * ':'

        string = [ @security, classpath ] |> keep _ , (-> it isnt void) |> (* '!')

        [ wmi-scheme, string ] * ':'

      { classname, host, namespace, security, to-string }

    key-equals-value = ([ key, value ]) -> [ key, single-quotes value ] * '='

    keys-or-singleton = -> if it is '' then '=@' else ".#it"

    keys-as-string = -> it |> object-member-pairs |> map _ , key-equals-value |> (* ',') |> keys-or-singleton

    create-wmi-object-moniker = (classname, keys = {}, host, namespace, security) ->

      to-string = -> "#{ create-wmi-class-moniker "#{ @classname }#{ keys-as-string @keys }", @host, @namespace, @security }"

      { classname, keys, host, namespace, security, to-string }

    {
      create-wmi-class-moniker,
      create-wmi-object-moniker
    }