import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (topicId) => {
  let channel = socket.channel(`comments:${topicId}`, {})
  channel.join()
  .receive("ok", resp => {
    renderComments(resp.comments) 
  })
  .receive("error", resp => { console.log("Unable to join", resp) })

  channel.on(`comments:${topicId}:new`, renderComment)

  document.querySelector("#post").addEventListener("click",() => {
    let content = document.querySelector("#comment").value
    channel.push("comment:add", {content: content})
  })
}

function renderComments(comments) {
  const renderedComment = comments.map(comments => {
    return commentTemplate(comments)
  })

  document.querySelector("#collection").innerHTML = renderedComment.join(" ")
}

function renderComment(payload) {
  const renderedComment = commentTemplate(payload.comment)

  document.querySelector("#collection").innerHTML += renderedComment
}

function commentTemplate(comments) {
  let name = "Anonymous"

  if (comments.user) {
    name = comments.user.name
  }

  return `
    <div class="mt-4">
    <ol class="collection-item flex flex-row justify-between border-b border-gray-200">
        <div class="text-gray-800">
          ${comments.comments}
        </div>
        <div class="mt-2 text-sm text-gray-500">
          ${name}
        </div>
      </ol>
    </div>
      
  `
}

window.createSocket = createSocket
