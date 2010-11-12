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

using Gee;

/**
 * Tracker picture item factory.
 */
public class Rygel.Tracker.PictureItemFactory : ItemFactory {
    private enum PictureMetadata {
        HEIGHT = Metadata.LAST_KEY,
        WIDTH,

        LAST_KEY
    }

    private const string CATEGORY = "nmm:Photo";

    public PictureItemFactory () {
        base (CATEGORY,
              PhotoItem.UPNP_CLASS,
              Environment.get_user_special_dir (UserDirectory.PICTURES));

        for (var i = this.key_chains.size; i < PictureMetadata.LAST_KEY; i++) {
            this.key_chains.add (new ArrayList<string> ());
        }

        this.key_chains[PictureMetadata.WIDTH].add ("nfo:width");
        this.key_chains[PictureMetadata.HEIGHT].add ("nfo:height");
    }

    public override MediaItem create (string          id,
                                      string          uri,
                                      SearchContainer parent,
                                      string[]        metadata)
                                      throws GLib.Error {
        var item = new PhotoItem (id, parent, "");

        this.set_metadata (item, uri, metadata);

        return item;
    }

    protected override void set_metadata (MediaItem item,
                                          string    uri,
                                          string[]  metadata)
                                          throws GLib.Error {
        base.set_metadata (item, uri, metadata);

        var photo = item as PhotoItem;

        if (metadata[PictureMetadata.WIDTH] != "") {
            photo.width = metadata[PictureMetadata.WIDTH].to_int ();
        }

        if (metadata[PictureMetadata.HEIGHT] != "") {
            photo.height = metadata[PictureMetadata.HEIGHT].to_int ();
        }
    }
}

