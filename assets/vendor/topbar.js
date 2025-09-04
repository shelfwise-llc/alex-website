/**
 * Topbar 2.0.0 - ES module wrapper
 */
const topbar = (() => {
  let canvas,
    currentProgress = 0,
    showing = false,
    progressTimerId = null,
    fadeTimerId = null,
    delayTimerId = null,
    options = {
      autoRun: true,
      barThickness: 3,
      barColors: {
        0: 'rgba(26, 188, 156, 0.9)',
        0.25: 'rgba(52, 152, 219, 0.9)',
        0.5: 'rgba(241, 196, 15, 0.9)',
        0.75: 'rgba(230, 126, 34, 0.9)',
        1.0: 'rgba(211, 84, 0, 0.9)'
      },
      shadowBlur: 10,
      shadowColor: 'rgba(0, 0, 0, 0.6)',
      className: null
    },
    repaintFunction = () => {
      canvas.width = window.innerWidth
      canvas.height = options.barThickness * 5
      const ctx = canvas.getContext('2d')
      ctx.shadowBlur = options.shadowBlur
      ctx.shadowColor = options.shadowColor
      const lineGradient = ctx.createLinearGradient(0, 0, canvas.width, 0)
      for (const stop in options.barColors) {
        lineGradient.addColorStop(stop, options.barColors[stop])
      }
      ctx.lineWidth = options.barThickness
      ctx.beginPath()
      ctx.moveTo(0, options.barThickness / 2)
      ctx.lineTo(
        Math.ceil(currentProgress * canvas.width),
        options.barThickness / 2
      )
      ctx.strokeStyle = lineGradient
      ctx.stroke()
    }

  const createCanvas = () => {
    canvas = document.createElement('canvas')
    const style = canvas.style
    style.position = 'fixed'
    style.top = style.left = style.right = style.margin = style.padding = 0
    style.zIndex = 100001
    style.display = 'none'
    if (options.className) canvas.className = options.className
    document.body.appendChild(canvas)
    repaintFunction()
  }

  const topbar = {
    config: (opts) => {
      for (const key in opts) {
        if (options.hasOwnProperty(key)) options[key] = opts[key]
      }
    },
    show: (delay) => {
      if (showing) return
      if (delay) {
        if (delayTimerId) return
        delayTimerId = setTimeout(() => topbar.show(), delay)
      } else {
        showing = true
        if (fadeTimerId !== null) window.cancelAnimationFrame(fadeTimerId)
        if (!canvas) createCanvas()
        canvas.style.opacity = 1
        canvas.style.display = 'block'
        topbar.progress(0)
        if (options.autoRun) {
          (() => {
            const frame = () => {
              topbar.progress(
                '+' + 0.05 * Math.pow(1 - Math.sqrt(currentProgress), 2)
              )
              progressTimerId = window.requestAnimationFrame(frame)
            }
            frame()
          })()
        }
      }
    },
    progress: (to) => {
      if (typeof to === 'undefined') return currentProgress
      if (typeof to === 'string') {
        to =
          (to.indexOf('+') >= 0 || to.indexOf('-') >= 0
            ? currentProgress
            : 0) + parseFloat(to)
      }
      currentProgress = to > 1 ? 1 : to
      repaintFunction()
      return currentProgress
    },
    hide: () => {
      if (!showing) return
      showing = false
      if (delayTimerId) {
        clearTimeout(delayTimerId)
        delayTimerId = null
      }
      if (progressTimerId) {
        window.cancelAnimationFrame(progressTimerId)
        progressTimerId = null
      }
      (() => {
        const frame = () => {
          if (topbar.progress('+.1') >= 1) {
            canvas.style.opacity -= 0.05
            if (canvas.style.opacity <= 0.05) {
              canvas.style.display = 'none'
              fadeTimerId = null
              return
            }
          }
          fadeTimerId = window.requestAnimationFrame(frame)
        }
        frame()
      })()
    }
  }

  return topbar
})()

export default topbar;
