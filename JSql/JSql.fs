module JSql
   open IronJS
   module IronJS = IronJS.Hosting.FSharp
   
   let private create() = IronJS.createContext()
   let mutable private  ctx = create()

   let Execute s = IronJS.execute s ctx |> string

   let Reset () = ctx <- create()
                  true