 T args;⎕IO;⎕USING;l;r;g;m;b;Turn;w;Play;Clic;Comp;Redo;f;_
 ⍝ T 0: No computer
 ⍝ T 1: Human 1p
 ⍝ T 2: Human 2p
 ⎕IO←0
 ⎕USING←,⊂''
 ⎕USING,←⊂'System.Drawing,system.drawing.dll'
 ⎕USING,←⊂'System.Windows.Forms,system.windows.forms.dll'
 l←⎕NEW Label
 l.Location←⎕NEW Point(254 364)
 l.Text←,''
 l.Font←⎕NEW Font('APL385 Unicode' 12)
 r←⎕NEW Button
 r.Location←⎕NEW Point(18 364)
 r.Text←'&Restart'
 r.Font←⎕NEW Font('APL385 Unicode' 12)
 r.Size←⎕NEW Size(120 30)
 r.onClick←'Redo'
 g←(⍳9){
     x←⎕NEW Button
     x.Text←,''
     x.Font←⎕NEW Font('APL385 Unicode' 24)
     x.Size←⎕NEW Size(100 100)
     x.Location←⎕NEW Point ⍵
     x.TabIndex←⍺
     x.onClick←'Clic'
     x
 }¨,⍉∘.,⍨100{+\⍵,⍵+2⍴⍺}18
 m←'OX' ⋄ b←3 3⍴1↓⎕D
 Turn←{>/{≢⍸⍺=⍵}∘⍵¨m}
 w←{⍵,⍥⊆⊖∘⍵¨2 1}3 3⍴1 1 1 0 0 0 0 0 0
 w←{⍵,⍉∘⌽¨⍵}w,⍨⊂3 3⍴1 0 0 0 1 0 0 0 1
 Play←{
     Wins←{∨/3=≢⍤⍸¨2=w+⊂⍺=⍵}
     Full←{~∨/⎕D∊⍵}
     Stop←{l.Text⊢←⍵ ⋄ g.Enabled⊢←0}
     p←m[Turn b]
     g[⍵].Enabled⊢←0
     g[⍵].Text⊢←,p
     b⊢←p@(⊂3 3⊤⍵)⊢b
     p Wins b:1⊣Stop p,' wins'
     p Full b:1⊣Stop'draw' ⋄ 0
 }
 Comp←{
     Four←{{⍉∘⌽⍣⍺⊢⍵}∘⍵¨⍳4}
     c←Four 3 3⍴9↑1 ⋄ s←Four 3 3⍴9↑0 1
     Free←{⍸⎕D∊⍨,⍵}
     Move←{∊{⍵/⍨1=≢¨⍵}⍸⍤,¨1=⍺-⊂⍵}
     (?∘≢⊃⊢){
         f←Free ⍵ ⋄ t←Turn ⍵
         p←t⌷m ⋄ q←t⌷⌽m
         ⍬≢x←f∩w Move p=⍵:x
         ⍬≢x←f∩w Move q=⍵:x
         ⍬≢x←f∩c Move p=⍵:x
         ⍬≢x←f∩s Move p=⍵:x
         ,4
     }b
 }
 Clic←{
     Play ⍵[0].TabIndex:⍬
     0≢args:⍬⊣Play Comp 0
 }
 Redo←{
     b⊢←3 3⍴1↓⎕D
     g.Enabled⊢←1
     g.Text⊢←⊂,''
     l.Text⊢←,''
     2≡args:Play Comp 0 ⋄ 0
 }
 f←⎕NEW Form
 f.Text←'Tic-Tac-Toe'
 f.MinimumSize←⎕NEW Size(390 450)
 f.Controls.Add¨g
 f.Controls.Add¨r l
 _←{2≡args:Play Comp 0 ⋄ 0}0
 Application.Run f
