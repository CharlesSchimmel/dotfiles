{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
--------------------------------------------------------------------------------
-- | Example.hs
--
-- Example configuration file for xmonad using the latest recommended
-- features (e.g., 'desktopConfig').
module Main
    ( main
    ) where

import           Data.Foldable
import qualified Data.Map                      as M
import           Data.Maybe

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
    [ "~/.local/bin/xmobar"
    , "syndaemon -i 1 -t"
    , "pgrep mpd || mpd"
    , "pgrep mpdscribble || mpdscribble"
    , "pgrep compton || compton --xrender-sync-fence" -- 20191221 seems to be causing issues
    , "pgrep syncthing || syncthing -no-browser"
    , "feh --randomize --bg-fill ~/pics/walls2/*"
    , "pgrep redshift || redshift -l 41.6195:-93.5980 -t 6500:4000"
    ]

trayApps = ["stalonetray", "keepassxc", "nm-applet"]

--------------------------------------------------------------------------------
main = do
    traverse_ spawn $ startupCmds <> trayApps
    -- Start xmonad using the main desktop configuration with a few
    -- simple overrides:
    xmobarH <- spawnPipe "~/.local/bin/xmobar"
    xmonad
        . docks
        $ desktopConfig { modMask            = mod4Mask -- Use the "Win" key for the mod key
                        , manageHook = myManageHook <+> manageHook desktopConfig
                        , layoutHook = avoidStruts . mySpacing $ myLayouts
                        , logHook            = myLogHook xmobarH
                        , borderWidth        = 1
                        , focusFollowsMouse  = False
                        , workspaces         = myWorkspaces
                        , focusedBorderColor = darkCyanHex
                        , normalBorderColor  = xmobarBG
                        }
        `additionalKeys` keybindings

keybindings :: [((KeyMask, KeySym), X ())]
keybindings = mapMaybe fromBinding bindings_
bindings_ =
    [ win @> sft @> xK_q @> (pure () :: X ()) -- override
    , win @> xK_0 @> (windows . W.view $ myWorkspaces !! 10)
    , win @> xK_l @> windows W.focusDown
    , win @> xK_h @> windows W.focusUp
    , win @> sft @> xK_l @> windows W.swapDown
    , win @> sft @> xK_h @> windows W.swapUp
    , win @> xK_Left @> windows W.focusUp
    , win @> xK_Right @> windows W.focusDown
    , win @> sft @> xK_Left @> windows W.swapUp
    , win @> sft @> xK_Right @> windows W.swapDown
    , win @> sft @> xK_Escape @> spawn_
        "sleep 1; xset dpms force off && i3lock -n && xset dpms force on"
    , win @> sft @> xK_p @> shellPrompt myXPConfig
    , win @> xK_f @> sendMessage (Toggle "Full")
    , win @> xK_p @> shellPrompt myXPConfig
    , win @> xK_z @> withFocused toggleFloat
    , win @> ctl @> xK_l @> sendMessage Expand
    , win @> ctl @> xK_h @> sendMessage Shrink
    , win @> ctl @> xK_Escape @> confirmPrompt myXPConfig
                                               "exit"
                                               (io exitSuccess)
    , win @> xK_Return @> spawn_ "kitty"
    , win @> xK_grave @> namedScratchpadAction scratchpads "ncmpcpp"
    , alt @> xK_w @> spawn_ "feh --randomize --bg-fill ~/pics/walls2/*"
    , alt @> xK_s @> spawnOn "5" "steam"
    , alt @> xK_q @> spawn_ "qutebrowser"
    , alt @> xK_f @> spawn_ "firefox"
    , alt @> xK_d @> spawn_ "rofi -show drun"
    , alt @> xK_n @> spawn_ "thunar"
    {-# OPTIONS_GHC -Wno-deprecations #-}
    , xF86XK_AudioPlay @> spawn_ "mpc toggle"
    , xF86XK_AudioPrev @> spawn_ "mpc prev"
    , xF86XK_AudioNext @> spawn_ "mpc next"
    , xF86XK_AudioMute @> spawn_ "pactl set-sink-mute 0 toggle"
    , xF86XK_AudioRaiseVolume @> spawn_ "pactl set-sink-volume 0 +10%"
    , xF86XK_AudioLowerVolume @> spawn_ "pactl set-sink-volume 0 -10%"
    , ctl @> xF86XK_AudioRaiseVolume @> spawn_ "pactl set-sink-volume 0 +5%"
    , ctl @> xF86XK_AudioLowerVolume @> spawn_ "pactl set-sink-volume 0 -5%"
    , xF86XK_MonBrightnessUp @> spawn_ "xbacklight -inc 5"
    , xF86XK_MonBrightnessDown @> spawn_ "xbacklight -dec 5"
    , ctl @> xF86XK_MonBrightnessUp @> spawn_ "xbacklight -set 100"
    , ctl @> xF86XK_MonBrightnessDown @> spawn_ "xbacklight -set 10"
    , win @> xF86XK_MonBrightnessUp @> spawn_
        "xrandr --output eDP-1 --off && xrandr --output eDP-1 --auto"
    , win @> ctl @> xF86XK_MonBrightnessUp @> spawn_
        "xrandr --output eDP-1 --off && xrandr --output eDP-1 --auto"
    ]

spawn_ :: String -> X ()
spawn_ = spawn

fromBinding :: Binding -> Maybe ((KeyMask, KeySym), X ())
fromBinding (Binding mask sym action) = do
    sym_    <- sym
    action_ <- action
    pure ((mask, sym_), action_)

instance Semigroup KeyMask where
    (<>) = (.|.)

data Binding = Binding
    { modifiers :: KeyMask
    , key       :: Maybe KeySym
    , action    :: Maybe (X ())
    }
    deriving Show

instance Show (X ()) where
    show _ = "X ()"

type XAction = X ()

emptyBinding = Binding noModMask Nothing Nothing

class Bindable a where
  mkBind :: a -> Binding

infixl 5 @>
(@>) :: (Bindable a, Bindable b) => b -> a -> Binding
b @> a = mkBind a <> mkBind b

instance Bindable Binding where
    mkBind = id

instance Bindable (X ()) where
    mkBind x = emptyBinding { action = Just x }

instance Bindable KeyMask where
    mkBind km = emptyBinding { modifiers = km }

instance Bindable KeySym where
    mkBind a = emptyBinding { key = Just a }

instance Semigroup Binding where
    (Binding maskA symA actionA) <> (Binding maskB symB actionB) =
        Binding (maskA .|. maskB) (accJust symA symB) (accJust actionA actionB)

accJust :: Maybe a -> Maybe a -> Maybe a
accJust _        (Just a) = Just a
accJust (Just a) Nothing  = Just a
accJust _        _        = Nothing

ctl = controlMask
win = mod4Mask
alt = mod1Mask
sft = shiftMask
nomod = noModMask

toggleFloat :: Window -> X ()
toggleFloat w = windows
    (\s -> if M.member w (W.floating s)
        then W.sink w s
        else (W.float w (W.RationalRect (1 / 3) (1 / 4) (1 / 2) (1 / 2)) s)
    )

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

myLogHook xmobarH =
    -- namedScratchpadFilterOutWorkspacePP <$>
    workspaceNamesPP (customPP xmobarH)
        >>= dynamicLogString
        >>= xmonadPropLog
        -- >>  fadeInactiveLogHook 0.85

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

customPP xmobarH = (def :: PP) { ppCurrent          = darkCyan
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
              -- , ppOutput           = putStrLn . ("   " <>)
              -- , ppOutput           = hPutStrLn xmobarH
              }
