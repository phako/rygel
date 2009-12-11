/*
 * Copyright (C) 2008 Zeeshan Ali <zeenix@gmail.com>.
 * Copyright (C) 2008 Nokia Corporation.
 *
 * Author: Zeeshan Ali <zeenix@gmail.com>
 *
 * This file is part of Rygel.
 *
 * Rygel is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Rygel is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

using GUPnP;
using DBus;
using Gee;

/**
 * Tracker music item factory.
 */
public class Rygel.TrackerMusicItemFactory : Rygel.TrackerItemFactory {
    private enum MusicMetadata {
        DURATION = Metadata.LAST_KEY,
        AUDIO_ALBUM,
        AUDIO_ARTIST,
        AUDIO_TRACK_NUM,

        LAST_KEY
    }

    private const string CATEGORY = "nmm:MusicPiece";

    public TrackerMusicItemFactory () {
        base (CATEGORY, MediaItem.MUSIC_CLASS);
    }

    public override MediaItem create (string                 id,
                                      string                 uri,
                                      TrackerSearchContainer parent,
                                      string[]               metadata)
                                      throws GLib.Error {
        var item = base.create (id, uri, parent, metadata);

        if (metadata[MusicMetadata.DURATION] != "")
            item.duration = metadata[MusicMetadata.DURATION].to_int ();

        if (metadata[MusicMetadata.AUDIO_TRACK_NUM] != "") {
            var track_number = metadata[MusicMetadata.AUDIO_TRACK_NUM];
            item.track_number = track_number.to_int ();
        }

        item.author = metadata[MusicMetadata.AUDIO_ARTIST];
        item.album = metadata[MusicMetadata.AUDIO_ALBUM];

        return item;
    }

    public override ArrayList<string> get_metadata_keys () {
        var keys = base.get_metadata_keys ();

        keys.add ("nmm:length");      // MusicMetadata.DURATION
        keys.add ("nmm:performer");   // MusicMetadata.AUDIO_ARTIST
        keys.add ("nmm:musicAlbum");  // MusicMetadata.AUDIO_ALBUM
        keys.add ("nmm:trackNumber"); // MusicMetadata.AUDIO_TRACK_NUM

        assert (keys.size == MusicMetadata.LAST_KEY);

        return keys;
    }
}

