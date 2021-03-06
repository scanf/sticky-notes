tag sticky-note
	prop note
	@isDragging = false

	def dragstart event
		console.log('dragstart', event)
		self.isDragging = true

	def dragend event
		console.log('dragend', event)
		self.isDragging = false

	def focusOnNote
		const element = self.children[0]
		element.focus()

	def render
		### css scoped
		.note {
			background: purple;
			background: #FFFF80;
			min-width: 128px;
			min-height: 128px;
			padding: 1rem;
			margin: 0.15rem;
			border: 0.1rem solid black;

			display: flex;
			justify-content: space-between;
			flex-direction: column;
		}

		.color-picker {
			align-self: flex-end;
		}

		.dragged {
			opacity: 0.6;
			border-color: white;
		}
		###
		<self.note css:background=@note.color .dragged=(self.isDragging) draggable=true 
		:click.focusOnNote()
		ondragstart=self.dragstart ondragend=self.dragend>
			<div id=self.note.id contentEditable='true' 
			:keydown.trigger('notechanged', self.note) innerHTML=self.note.body>
			<input[@note.color] .color-picker type="color">

