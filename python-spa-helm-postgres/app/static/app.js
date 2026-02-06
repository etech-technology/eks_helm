async function loadNotes() {
  const res = await fetch("/api/notes");
  const notes = await res.json();
  const ul = document.getElementById("notes");
  ul.innerHTML = "";
  for (const n of notes) {
    const li = document.createElement("li");
    li.textContent = `${n.text}  (${new Date(n.created_at).toLocaleString()})`;
    ul.appendChild(li);
  }
}

async function addNote() {
  const input = document.getElementById("noteText");
  const status = document.getElementById("status");
  const text = input.value.trim();
  if (!text) return;

  status.textContent = "Saving...";
  const res = await fetch("/api/notes", {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({ text })
  });

  if (!res.ok) {
    const err = await res.json().catch(() => ({}));
    status.textContent = `Error: ${err.detail || res.statusText}`;
    return;
  }

  input.value = "";
  status.textContent = "Saved.";
  await loadNotes();
  setTimeout(() => (status.textContent = ""), 1500);
}

document.getElementById("addBtn").addEventListener("click", addNote);
document.getElementById("noteText").addEventListener("keydown", (e) => {
  if (e.key === "Enter") addNote();
});

loadNotes().catch((e) => {
  document.getElementById("status").textContent = "Failed to load notes: " + e;
});
