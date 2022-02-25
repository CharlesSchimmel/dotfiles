--------------------------------------------------------------------------------
-- | Example.hs
--
-- Example configuration file for xmonad using the latest recommended
-- features (e.g., 'desktopConfig').
module Main
    ( main
    ) where

import           Data.Foldable

--------------------------------------------------------------------------------
import           System.Exit
import           XMonad
import           XMonad.Actions.SpawnOn
import           XMonad.Actions.WorkspaceNames
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.FadeInactive
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Layout.BinarySpacePartition
                                                ( emptyBSP )
import           XMonad.Layout.Fullscreen
import           XMonad.Layout.Gaps
import           XMonad.Layout.NoBorders        ( noBorders
                                                , smartBorders
                                                , withBorder
                                                )
import           XMonad.Layout.ResizableTile    ( ResizableTall(..) )
import           XMonad.Layout.Spacing
import           XMonad.Layout.Spiral           ( spiral )
import           XMonad.Layout.ToggleLayouts    ( ToggleLayout(..)
                                                , toggleLayouts
                                                )
import           XMonad.ManageHook
import           XMonad.Prompt
import           XMonad.Prompt.ConfirmPrompt
import           XMonad.Prompt.Shell
import qualified XMonad.StackSet               as W
import           XMonad.Util.EZConfig
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run
import           XMonad.Util.WorkspaceCompare

import           Graphics.X11.ExtraTypes

mySpacing = spacingRaw False (Border 5 5 5 5) True (Border 5 5 5 5) True

myGaps = gaps [(U, 5), (D, 5), (R, 5), (L, 5)]

startupCmds =
    [ "~/.cabal/bin/xmobar"
        , "syndaemon -i 1 -t"
        , "pgrep mpd || mpd"
        , "pgrep mpdscribble || mpdscribble"
            -- , "pgrep compton || compton --xrender-sync-fence" -- 20191221 seems to be causing issues
        , "pgrep syncthing || syncthing -no-browser"
        , "feh --randomize --bg-fill ~/pics/walls2/*"
        , "pgrep redshift || redshift -l 41.6195:-93.5980 -t 6500:4000"
        ]
        <> trayApps

trayApps = ["stalonetray", "keepassxc", "nm-applet"]

--------------------------------------------------------------------------------
main = do
    traverse_ spawn startupCmds
    -- Start xmonad using the main desktop configuration with a few
    -- simple overrides:
    xmonad
        . docks
        $ desktopConfig { modMask            = mod4Mask -- Use the "Win" key for the mod key
                        , manageHook = myManageHook <+> manageHook desktopConfig
                        , layoutHook = avoidStruts . mySpacing $ myLayouts
                        , logHook            = myLogHook
                        , borderWidth        = 1
                        , focusFollowsMouse  = False
                        , workspaces         = myWorkspaces
                        , focusedBorderColor = darkCyanHex
                        , normalBorderColor  = xmobarBG
                        }
        `additionalKeys` -- Add some extra key bindings:
                         [ m_s xK_q $ pure () -- override
        -- , ((m_s,  xK_q),             pure ())
                         , (meta xK_0, windows . W.view $ myWorkspaces !! 10)
                         , ((m_c, xK_l), sendMessage Expand)
                         , ((m_c, xK_h), sendMessage Shrink)
                         , ( (m_c, xK_Escape)
                           , confirmPrompt myXPConfig "exit" (io exitSuccess)
                           )
                         , m_s xK_Escape
                             $ spawn
                                   "sleep 1; xset dpms force off && i3lock -n && xset dpms force on"
                         , m_s xK_p $ shellPrompt myXPConfig
                         , m xK_l $ windows W.focusDown
                         , m xK_h $ windows W.focusUp
                         , m_s xK_l $ windows W.swapDown
                         , m_s xK_h $ windows W.swapUp
                         , m xK_Left $ windows W.focusUp
                         , m xK_Right $ windows W.focusDown
                         , m_s xK_Left $ windows W.swapUp
                         , m_s xK_Right $ windows W.swapDown
                         , m xK_p $ shellPrompt myXPConfig
                         , m xK_f $ sendMessage (Toggle "Full")
                         , m xK_Return $ spawn "kitty"
                         , ( (altl, xK_w)
                           , spawn "feh --randomize --bg-fill ~/pics/walls2/*"
                           )
                         , ((altl, xK_s), spawnOn "5" "steam")
                         , ((altl, xK_q), spawn "qutebrowser")
                         , ((altl, xK_f), spawn "firefox")
                         , ( (altl, xK_d)
                           , spawn "rofi -show run -location 2 -yoffset 18"
                           )
                         , ((altl, xK_n), spawn "thunar")
                         , ( (winl, xK_grave)
                           , namedScratchpadAction scratchpads "ncmpcpp"
                           )
                         , (x xF86XK_AudioPlay, spawn "mpc toggle")
                         , (x xF86XK_AudioPrev, spawn "mpc prev")
                         , (x xF86XK_AudioNext, spawn "mpc next")
                         , ( x xF86XK_AudioMute
                           , spawn "pactl set-sink-mute 0 toggle"
                           )
                         , ( x xF86XK_AudioRaiseVolume
                           , spawn "pactl set-sink-volume 0 +10%"
                           )
                         , ( x xF86XK_AudioLowerVolume
                           , spawn "pactl set-sink-volume 0 -10%"
                           )
                         , ( (ctl, xF86XK_AudioRaiseVolume)
                           , spawn "pactl set-sink-volume 0 +5%"
                           )
                         , ( (ctl, xF86XK_AudioLowerVolume)
                           , spawn "pactl set-sink-volume 0 -5%"
                           )
                         , x_ xF86XK_MonBrightnessUp $ spawn "xbacklight -inc 5"
                         , x_ xF86XK_MonBrightnessDown
                             $ spawn "xbacklight -dec 5"
                         , ( (ctl, xF86XK_MonBrightnessUp)
                           , spawn "xbacklight -set 100"
                           )
                         , ( (ctl, xF86XK_MonBrightnessDown)
                           , spawn "xbacklight -set 10"
                           )
                         ]
  where
    ctl      = controlMask
    winl     = mod4Mask
    altl     = mod1Mask
    nmm      = noModMask
    winShift = winl .|. shiftMask
    m_c      = winl .|. controlMask
    c        = (,) controlMask
    meta     = (,) mod4Mask -- meta/win key
    a        = (,) mod1Mask -- alt key
    x        = (,) noModMask
    x_ a b = ((noModMask, a), b)
    m x y = ((mod4Mask, x), y) -- win + key
    m_s x y = ((winShift, x), y) -- win + shift + key
    mediaKeys = []


bind :: Monad m => Mod -> KeySym -> m () -> ((KeyMask, KeySym), m ())
bind mod key thing = ((unMod mod, key), thing)

ctl = Mod controlMask
win = Mod mod4Mask
alt = Mod mod1Mask
shift = Mod shiftMask
plain = Mod noModMask

newtype Mod = Mod { unMod :: KeyMask }

instance Semigroup Mod where
    (Mod m1) <> (Mod m2) = Mod (m1 .|. m2)

instance Monoid Mod where
    mappend = (<>)
    mempty  = Mod noModMask

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- | Customize layouts.
--
-- This layout configuration uses two primary layouts, 'ResizableTall'
-- and 'BinarySpacePartition'.  You can also use the 'M-<Esc>' key
-- binding defined above to toggle between the current layout and a
-- full screen layout.
myLayouts = toggleLayouts (noBorders Full) others
  where
    others =
        smartBorders
            $   (ResizableTall 1 (1.5 / 100) (2 / 3) [])
            ||| (smartBorders emptyBSP)
                  -- ||| (smartBorders $ spiral (2 / 3))

--------------------------------------------------------------------------------
-- | Customize the way 'XMonad.Prompt' looks and behaves.  It's a
-- great replacement for dzen.
myXPConfig = def { position          = Top
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
myManageHook =
    composeOne
            [ className =? "Pidgin" -?> doFloat
            , className =? "XCalc" -?> doFloat
    -- , className =? "mpv" -?> doFloat
            , isDialog -?> doCenterFloat
    -- Move transient windows to their parent:
            , transience
            ]
        <+> namedScratchpadManageHook scratchpads

myLogHook =
    namedScratchpadFilterOutWorkspacePP
        <$> workspaceNamesPP customPP
        >>= dynamicLogString
        >>= xmonadPropLog
        >>  fadeInactiveLogHook 0.85

lilFloater = customFloating $ W.RationalRect (1 / 4) (1 / 4) (1 / 2) (2 / 3)

scratchpads =
    [ NS "ncmpcpp"
         "kitty --class=ncmpcpp ncmpcpp"
         (className =? "ncmpcpp")
         lilFloater
    ]

myWorkspaces = map show' [1 .. 10 :: Int] <> ["_"]
  where
    show' 10 = "0"
    show' x  = show x

xmobarFG = "#e7e8eb"

xmobarBG = "#253043"

darkCyanHex = "#5AB4F6"

darkCyan = xmofg "#5AB4F6"

darkRed = xmofg "#C5395A"

xmofg = flip xmobarColor xmobarBG

customPP = PP { ppCurrent          = darkCyan
              , ppVisible          = id
              , ppHidden           = id
              , ppVisibleNoWindows = Just show
              , ppHiddenNoWindows  = const ""
              , ppUrgent           = darkRed
              , ppSep              = " : "
              , ppWsSep            = "   "
              , ppTitle            = const ""
              , ppTitleSanitize    = id
              , ppLayout           = const ""
              , ppOrder            = id
              , ppSort             = getSortByIndex
              , ppExtras           = []
              , ppOutput           = putStrLn . ("   " <>)
              }
