document.addEventListener('DOMContentLoaded', function(){
    const mainSection = document.getElementById('main-section');
    const notesContainer = document.querySelector('.musical-notes-container');

    mainSection.addEventListener('click', function(event){
        for (let i = 0; i < 20; i++) {
      const note = document.createElement('div');
      note.className = 'musical-note';
      note.style.left = `${event.clientX}px`;
      note.style.top = `${event.clientY}px`;
      notesContainer.appendChild(note);

      setTimeout(() => {
        notesContainer.removeChild(note);
      }, 3000);
    }
    });
}

)