/*
 * Copyright (C) 2009 Nokia Corporation.
 *
 * Author: Zeeshan Ali (Khattak) <zeeshanak@gnome.org>
 *                               <zeeshan.ali@nokia.com>
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
 * Container listing Pictures content hierarchy.
 */
public class Rygel.Tracker.Pictures : CategoryContainer {
    private const string[] KEY_CHAIN = { "nie:contentCreated", null };

    public Pictures (string id, MediaContainer parent, string title) {
        base (id, parent, title, new PictureItemFactory ());

        this.add_child (new Tags (this, this.item_factory));
        this.add_child (new Years (this, this.item_factory));
        this.add_child (new Titles (this, this.item_factory));
    }
}

