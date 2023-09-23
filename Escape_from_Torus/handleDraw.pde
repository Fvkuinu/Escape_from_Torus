public void handleDraw() {
  //debug("handleDraw() " + g + " " + looping + " " + redraw + " valid:" + this.isValid() + " visible:" + this.isVisible());

  // canDraw = g != null && (looping || redraw);
  if (g == null) return;
  if (!looping && !redraw) return;
  //    System.out.println("looping/redraw = " + looping + " " + redraw);

  // no longer in use by any of our renderers
  //    if (!g.canDraw()) {
  //      debug("g.canDraw() is false");
  //      // Don't draw if the renderer is not yet ready.
  //      // (e.g. OpenGL has to wait for a peer to be on screen)
  //      return;
  //    }

  // Store the quality setting in case it's changed during draw and the
  // drawing context needs to be re-built before the next frame.
  //    int pquality = g.smooth;

  if (insideDraw) {
    System.err.println("handleDraw() called before finishing");
    System.exit(1);
  }

  insideDraw = true;
  g.beginDraw();
  if (recorder != null) {
    recorder.beginDraw();
  }

  long now = System.nanoTime();
  //println(frameCount);
  if (frameCount == 0) {
    // 3.0a5 should be no longer needed; handled by PSurface
    //surface.checkDisplaySize();

    //        try {
    //println("Calling setup()");
    SceneDirector.getCurrentScene().setup();
    //println("Done with setup()");

    //        } catch (RendererChangeException e) {
    //          // Give up, instead set the new renderer and re-attempt setup()
    //          return;
    //        }
    //      defaultSize = false;
  } else {  // frameCount > 0, meaning an actual draw()
    // update the current frameRate

    // Calculate frameRate through average frame times, not average fps, e.g.:
    //
    // Alternating 2 ms and 20 ms frames (JavaFX or JOGL sometimes does this)
    // is around 90.91 fps (two frames in 22 ms, one frame 11 ms).
    //
    // However, averaging fps gives us: (500 fps + 50 fps) / 2 = 275 fps.
    // This is because we had 500 fps for 2 ms and 50 fps for 20 ms, but we
    // counted them with equal weight.
    //
    // If we average frame times instead, we get the right result:
    // (2 ms + 20 ms) / 2 = 11 ms per frame, which is 1000/11 = 90.91 fps.
    //
    // The counter below uses exponential moving average. To do the
    // calculation, we first convert the accumulated frame rate to average
    // frame time, then calculate the exponential moving average, and then
    // convert the average frame time back to frame rate.
    {
      // Get the frame time of the last frame
      double frameTimeSecs = (now - frameRateLastNanos) / 1e9;
      // Convert average frames per second to average frame time
      double avgFrameTimeSecs = 1.0 / frameRate;
      // Calculate exponential moving average of frame time
      final double alpha = 0.05;
      avgFrameTimeSecs = (1.0 - alpha) * avgFrameTimeSecs + alpha * frameTimeSecs;
      // Convert frame time back to frames per second
      frameRate = (float) (1.0 / avgFrameTimeSecs);
    }

    if (frameCount != 0) {
      handleMethods("pre");
    }

    // use dmouseX/Y as previous mouse pos, since this is the
    // last position the mouse was in during the previous draw.
    pmouseX = dmouseX;
    pmouseY = dmouseY;

    //println("Calling draw()");
    SceneDirector.getCurrentScene().draw();
    //println("Done calling draw()");

    // dmouseX/Y is updated only once per frame (unlike emouseX/Y)
    dmouseX = mouseX;
    dmouseY = mouseY;

    // these are called *after* loop so that valid
    // drawing commands can be run inside them. it can't
    // be before, since a call to background() would wipe
    // out anything that had been drawn so far.
    dequeueEvents();

    handleMethods("draw");

    redraw = false;  // unset 'redraw' flag in case it was set
    // (only do this once draw() has run, not just setup())
  }
  g.endDraw();

  //    if (pquality != g.smooth) {
  //      surface.setSmooth(g.smooth);
  //    }

  if (recorder != null) {
    recorder.endDraw();
  }
  insideDraw = false;

  if (frameCount != 0) {
    handleMethods("post");
  }

  frameRateLastNanos = now;
  SceneDirector.incrementFrameCount();
  frameCount = SceneDirector.getFrameCount();
}
