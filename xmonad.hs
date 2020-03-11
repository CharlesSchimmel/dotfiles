--------------------------------------------------------------------------------
-- | Example.hs
--
-- Example configuration file for xmonad using the latest recommended
-- features (e.g., 'desktopConfig').
module Main (main) where

--------------------------------------------------------------------------------
import System.Exit
import System.IO
import Data.Char
import Data.Foldable
import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Actions.WorkspaceNames
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.BinarySpacePartition (emptyBSP)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Shell
import XMonad.Util.Run
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W

import Graphics.X11.ExtraTypes


mySpacing = spacingRaw False (Border 5 5 5 5) True (Border 5 5 5 5) True
myGaps = gaps [ (U, 5)
              , (D, 5)
              , (R, 5)
              , (L, 5)
              ]

startupCmds =
      [ "~/.cabal/bin/xmobar"
      , "syndaemon -i 1 -t"
      , "nm-applet"
      , "pgrep mpd || mpd"
      , "pgrep mpdscribble || mpdscribble"
      , "pgrep compton || compton --xrender-sync-fence"
      , "feh --randomize --bg-fill ~/pics/walls2/*"
      , "keepassxc"
      , "syncthing -no-browser"
      , "stalonetray"
      ]

--------------------------------------------------------------------------------
main = do
  traverse_ spawn startupCmds

  -- Start xmonad using the main desktop configuration with a few
  -- simple overrides:
  xmonad . docks $ desktopConfig
    { modMask           = mod4Mask -- Use the "Win" key for the mod key
    , manageHook        = myManageHook <+> manageHook desktopConfig
    , layoutHook        = avoidStruts . mySpacing $ myLayouts
    , logHook           = myLogHook
    , borderWidth       = 0
    , focusFollowsMouse = False
    }

    `additionalKeys` -- Add some extra key bindings:
      [ ((m_s,  xK_q),             pure ()) -- override
      , ((m_s,  xK_q),             pure ())
      , ((m_c,  xK_l),             sendMessage Expand)
      , ((m_c,  xK_h),             sendMessage Shrink)
      , ((m_s,  xK_l),             windows W.swapDown)
      , ((m_s,  xK_h),             windows W.swapUp)
      , ((m_c,  xK_Escape),        confirmPrompt myXPConfig "exit" (io exitSuccess))
      , ((m_s,  xK_Escape),        spawn "sleep 1; xset dpms force off && i3lock -n && xset dpms force on")
      , ((m_s,  xK_p),             shellPrompt myXPConfig)

      , ((winl, xK_l),             windows W.focusDown)
      , ((winl, xK_h),             windows W.focusUp)
      , ((winl, xK_p),             shellPrompt myXPConfig)
      , ((winl, xK_f),             sendMessage (Toggle "Full"))

      , ((winl, xK_Return),        spawn "kitty")
      , ((altl, xK_s),             spawnOn "5" "steam")
      , ((altl, xK_q),             spawn "qutebrowser")
      , ((altl, xK_d),             spawn "rofi -show run -location 2 -yoffset 18")
      , ((altl, xK_n),             spawn "thunar")

      , ((nmm,  xF86XK_AudioPlay), spawn "mpc toggle")
      , ((nmm,  xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle")
      , ((nmm,  xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +10%")
      , ((nmm,  xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -10%")
      , ((ctl,  xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +5%")
      , ((ctl,  xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -5%")
      ]
        where ctl = controlMask
              winl = mod4Mask
              altl = mod1Mask
              nmm = noModMask
              m_s = winl .|. shiftMask
              m_c = winl .|. controlMask

--------------------------------------------------------------------------------
-- | Customize layouts.
--
-- This layout configuration uses two primary layouts, 'ResizableTall'
-- and 'BinarySpacePartition'.  You can also use the 'M-<Esc>' key
-- binding defined above to toggle between the current layout and a
-- full screen layout.
myLayouts = toggleLayouts (noBorders Full) others
  where
    others = ResizableTall 1 (1.5/100) (2/3) [] ||| emptyBSP

--------------------------------------------------------------------------------
-- | Customize the way 'XMonad.Prompt' looks and behaves.  It's a
-- great replacement for dzen.
myXPConfig = def
  { position          = Top
  , alwaysHighlight   = True
  , promptBorderWidth = 0
  , font              = "xft:overpass:size=9"
  }

--------------------------------------------------------------------------------
-- | Manipulate windows as they are created.  The list given to
-- @composeOne@ is processed from top to bottom.  The first matching
-- rule wins.
--
-- Use the `xprop' tool to get the info you need for these matches.
-- For className, use the second value that xprop gives you.
myManageHook = composeOne
  [ className =? "Pidgin" -?> doFloat
  , className =? "XCalc"  -?> doFloat
  , className =? "mpv"    -?> doFloat
  , isDialog              -?> doCenterFloat

    -- Move transient windows to their parent:
  , transience
  ]

myLogHook = workspaceNamesPP customPP
              >>= dynamicLogString
              >>= xmonadPropLog
              >> fadeInactiveLogHook 0.85

scratchpads = [
              ]

customPP = PP
      { ppCurrent = wrap "[" "]"
      , ppVisible = id
      , ppHidden = id
      , ppVisibleNoWindows = Just show
      , ppHiddenNoWindows = const ""
      , ppUrgent = show
      , ppSep = " : "
      , ppWsSep = "  "
      , ppTitle = shorten 40
      , ppTitleSanitize = id
      , ppLayout = const ""
      , ppOrder = id
      , ppSort = pure id
      , ppExtras = []
      , ppOutput = putStrLn
      }
