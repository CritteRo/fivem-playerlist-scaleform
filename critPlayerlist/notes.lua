--[[
    struct PlayerRow
        {
            public int serverId;
            public string name;
            public string rightText;
            public int color;
            public string iconOverlayText;
            public string jobPointsText;
            public string crewLabelText;
            public enum DisplayType
            {
                NUMBER_ONLY = 0,
                ICON = 1,
                NONE = 2
            };
            public DisplayType jobPointsDisplayType;
            public enum RightIconType
            {
                NONE = 0,
                INACTIVE_HEADSET = 48,
                MUTED_HEADSET = 49,
                ACTIVE_HEADSET = 47,
                RANK_FREEMODE = 65,
                KICK = 64,
                LOBBY_DRIVER = 79,
                LOBBY_CODRIVER = 80,
                SPECTATOR = 66,
                BOUNTY = 115,
                DEAD = 116,
                DPAD_GANG_CEO = 121,
                DPAD_GANG_BIKER = 122,
                DPAD_DOWN_TARGET = 123
            };
            public int rightIcon;
            public string textureString;
            public char friendType;
        }

]]