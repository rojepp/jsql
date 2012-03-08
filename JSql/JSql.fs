module JSql
   open IronJS
   module IronJS = IronJS.Hosting.FSharp
   
   let private create() = IronJS.createContext()

   ///<summary>Execute a JavaScript string in a new context</summary>
   // TODO: What is the performance drawback of creating a new context every time?
   let Execute s = let ctx = create()
                   IronJS.execute s ctx |> string

