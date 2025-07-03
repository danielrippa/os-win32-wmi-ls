
  do ->

    { type } = dependency 'reflection.Type'
    { wmi-service } = dependency 'wmi.Wmi'

    wql-query-flags = return-immediately: 0x10, forward-only: 0x20

    wql-query-flags-default = wql-query-flags => ..return-immediately + ..forward-only

    wql-exec = (query, query-flags = wql-query-flags-default , service = wmi-service!) ->

      type '< String >' query ; type '< Number >' query-flags ; type '< Object >' service

      service.ExecQuery query, 'WQL', query-flags

    field-list = -> if (typeof! it) isnt 'Array' then '*' else it * '.'

    predicate = -> if (typeof! it) isnt 'String' then '' else "WHERE #it"

    wql-query = (wmi-class, flags, filter, fields, service) ->

      type '< String >' wmi-class ; type '< String Undefined >' filter
      type '< Array Undefined >' fields

      query = "SELECT #{ field-list fields } FROM #wmi-class #{ predicate filter }"

      wql-exec query, flags, service

    {
      wql-query-flags, wql-exec,
      wql-query
    }