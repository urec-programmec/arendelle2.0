function intersects (event1, event2) {
  let s1 = event1.start
  let e1 = event1.end
  let s2 = event2.start
  let e2 = event2.end
  if (!e2 || !e1) { // it's not span
    return false
  }
  if ((s2 < s1 && s1 < e2) || (s1 < s2 && s2 < e1)) {
    return true
  }
  return false
}

export default {
  generate (data) {
    data.forEach((e) => {
      e.duration = e.end ? e.end - e.start : 0
    })
    data.sort((a, b) => b.duration - a.duration)

    let placed = []
    data.forEach((e) => {
      e.level = 0
      placed.forEach((p) => {
        if (intersects(e, p)) {
          e.level++
        }
      })
      placed.push(e)
    })
    // let maxLevel = 11
    data.forEach((e) => { e.position = e.level + 1 })
  }
}
