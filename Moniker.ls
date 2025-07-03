
  do ->

    { create-wmi-security-descriptor } = dependency 'os.win32.wmi.Security'
    { wmi-namespaces } = dependency 'os.win32.wmi.Namespace'
    { build-path } = dependency 'os.filesystem.Path'
    { keep-array-items: keep } = dependency 'unsafe.Array'

    wmi-scheme = 'winmgmts'

    as-unc = -> build-path [ '' '' it ]

    create-wmi-objects-moniker = (classname, host = '.', namespace = wmi-namespaces.cim, security) ->

      to-string = ->

        connection = build-path [ (as-unc @host), @namespace ]

        classpath = [ connection, @classname ] * ':'

        string = [ @security, classpath ] |> keep _ , (-> it isnt void) |> (* '!')

        [ wmi-scheme, string ] * ':'

      { classname, host, namespace, security, to-string }

    create-wmi-object-moniker = ->

    {
      create-wmi-objects-moniker,
      create-wmi-object-moniker
    }