module Main where

import qualified Graphics.Rendering.OpenGL as GL
import qualified Graphics.UI.GLUT as GLUT
import Data.IORef (IORef, newIORef, readIORef, writeIORef)

main = do
  (prog, args) <- GLUT.getArgsAndInitialize
  GLUT.initialDisplayMode GLUT.$= [GLUT.WithDepthBuffer,GLUT.DoubleBuffered]
  GLUT.createWindow "Window Title"
  rot <- newIORef 0
  GLUT.displayCallback GLUT.$= display rot
  GLUT.reshapeCallback GLUT.$= Just reshape
  GLUT.depthFunc GLUT.$= Just GLUT.Less
  GLUT.idleCallback GLUT.$= Just (increaseRot rot 0.02)
  GLUT.mainLoop

green = GLUT.Color3 (0::GLUT.GLfloat) 1 0
black = GLUT.Color3 (0::GLUT.GLfloat) 0 0

increaseRot rot rotinc = do
  rot' <- readIORef rot
  writeIORef rot $! rot' + rotinc
  GLUT.postRedisplay Nothing

display rot = do
  GLUT.clear [GLUT.ColorBuffer, GLUT.DepthBuffer]
  GLUT.loadIdentity

  GL.translate (GLUT.Vector3 (0::GLUT.GLfloat) 0 (-6))
  rot' <- readIORef rot
  GL.rotate rot' (GLUT.Vector3 (0.5::GLUT.GLfloat) 1 0.1)

  GLUT.color green
  drawSquare

  GLUT.color black
  drawWireframe

  GLUT.swapBuffers

drawWireframe = GLUT.renderPrimitive GLUT.Lines $ do
    -- Top
    -- ToDo: Remove duplicated lines (copy&paste from quad)
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 (-1) -- top-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 (-1) -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 (-1) -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 1 -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 1 -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 1 -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 1 -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 (-1) -- top-right

    -- Down
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) 1 -- top-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) 1 -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) 1 -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) (-1) -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) (-1) -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) (-1) -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) (-1) -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) 1 -- top-right

    -- Left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 (-1) -- top-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 1 -- top-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 1 -- top-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) 1 -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) 1 -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) (-1) -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) (-1) -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 (-1) -- top-right

    -- Right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 1 -- top-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 (-1) -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 (-1) -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) (-1) -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) (-1) -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) 1 -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) 1 -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 1 -- top-right

    -- Front
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 1 -- top-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 1 -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 1 -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) 1 -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) 1 -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) 1 -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) 1 -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 1 -- top-right

    -- Back
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 (-1) -- top-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 (-1) -- top-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 (-1) -- top-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) (-1) -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) (-1) -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) (-1) -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) (-1) -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 (-1) -- top-right


drawSquare = GLUT.renderPrimitive GLUT.Quads $ do
    -- Top
    GLUT.color $ GLUT.Color3 (1::GLUT.GLfloat) 0 0
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 (-1) -- top-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 (-1) -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 1 -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 1 -- bottom-right

    -- Down
    GLUT.color $ GLUT.Color3 (0::GLUT.GLfloat) 1 0
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) 1 -- top-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) 1 -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) (-1) -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) (-1) -- bottom-right

    -- Right
    GLUT.color $ GLUT.Color3 (0::GLUT.GLfloat) 0 1
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 (-1) -- top-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 1 -- top-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) 1 -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) (-1) -- bottom-right

    -- Left
    GLUT.color $ GLUT.Color3 (1::GLUT.GLfloat) 1 0
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 1 -- top-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 (-1) -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) (-1) -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) 1 -- bottom-right

    -- Front
    GLUT.color $ GLUT.Color3 (1::GLUT.GLfloat) 0 1
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 1 -- top-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 1 -- top-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) 1 -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) 1 -- bottom-right

    -- Back
    GLUT.color $ GLUT.Color3 (0::GLUT.GLfloat) 1 1
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) (-1) (-1) -- bottom-left
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) (-1) (-1) -- bottom-right
    GLUT.vertex $ GLUT.Vertex3 (-1::GLUT.GLfloat) 1 (-1) -- top-right
    GLUT.vertex $ GLUT.Vertex3 (1::GLUT.GLfloat) 1 (-1) -- top-left


reshape s@(GLUT.Size w h) = do
  GLUT.viewport GLUT.$= (GLUT.Position 0 0, s)
  GLUT.matrixMode GLUT.$= GLUT.Projection
  GLUT.loadIdentity
  GLUT.perspective 45 1 ((fromIntegral w)/(fromIntegral h)) 100
  GLUT.matrixMode GLUT.$= GLUT.Modelview 0
  GLUT.loadIdentity
  GLUT.flush
