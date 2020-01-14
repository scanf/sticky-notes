### css
body {
  margin: 0;
  padding: 0;
}

.container {
  background: #FFF;
}
###

tag sticky-note

  ### css scoped
    .note {
      background: purple;
      background: #FFFF80;
      min-width: 128px;
      min-height: 128px;
      padding: 1rem;
      margin: 0.15rem;
    }
  ###

  def noteChanged
    self.callback(self.id)

  def render
    <self.note id=self.note contentEditable=true
      :keydown.noteChanged() 
      innerHTML=self.body>

tag sticky-notes

  def setup
    @notes = []
    
    let keys = Object.keys(localStorage).filter do |k|
      k.startsWith("note")
    for key in keys
      @notes.push(JSON.parse(localStorage.getItem(key)))

  # TODO: also handle deletion, maybe delete when hitting backspace in an empty
  # note
  # TODO: support pasting into the sticky notes
  def createNew
    let container = document.querySelector(".notes")
    let count = Object.keys(localStorage).length + 1
    let id = "note-{count}"
    let note = {body: '', id: id}
    localStorage.setItem(id, JSON.stringify(note))
    # TODO: touch the DOM

  def noteChanged identifier
    let body = document.querySelector("#{identifier}").innerHTML
    let note = {id: identifier, body: body}
    console.log('persist', note)
    localStorage.setItem(identifier, JSON.stringify(note))

  def render
    ### css scoped
    h1 {
    }
    .notes {
      display: grid;
      grid-template: 1fr / 1fr;
    }
    
    @media (min-width: 640px) {
      .notes {
        grid-template: 1fr / repeat(3, 1fr);
      }
    }

    @media (min-width: 1024px) {
      .notes {
        grid-template: 1fr / repeat(4, 1fr);
      }
    }
    ###
    <self.container>
      <button :click.createNew()> "New"
      <div.notes>
        for note in @notes
          <sticky-note id=note.id body=note.body callback=self.noteChanged>
imba.mount <sticky-notes>
