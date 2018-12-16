unit URequestCreate;

interface

uses Forms, UInterface;

type
  TRequestCreate = class(TInterfacedObject, TInterfaceMenuCreate)
  public
    constructor create(AOwner: TForm);virtual;abstract;
    procedure destroy;virtual;abstract;
  end;

implementation

end.
