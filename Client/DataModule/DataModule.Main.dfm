object dmMain: TdmMain
  Height = 179
  Width = 283
  object RESTClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:9000'
    Params = <>
    Left = 72
    Top = 48
  end
  object RESTRequest: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'cep'
        Options = [poAutoCreated]
      end>
    Resource = 'ConsultaCep/{cep}'
    Left = 152
    Top = 48
  end
end
