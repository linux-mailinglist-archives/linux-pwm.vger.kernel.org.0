Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E761F6FC1
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2020 00:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgFKWM5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 Jun 2020 18:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKWM5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 Jun 2020 18:12:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD81C03E96F
        for <linux-pwm@vger.kernel.org>; Thu, 11 Jun 2020 15:12:56 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jjVRF-0000vZ-JC; Fri, 12 Jun 2020 00:12:45 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jjVRE-0007M8-Nk; Fri, 12 Jun 2020 00:12:44 +0200
Date:   Fri, 12 Jun 2020 00:12:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 03/15] pwm: lpss: Add range limit check for the
 base_unit register value
Message-ID: <20200611221242.3bjqvnhcwwxaocxy@taurus.defre.kleine-koenig.org>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-4-hdegoede@redhat.com>
 <20200608035023.GZ2428291@smile.fi.intel.com>
 <90769dc0-3174-195b-34e0-ef4bb9d9b982@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hp7kq6gze6fyafh7"
Content-Disposition: inline
In-Reply-To: <90769dc0-3174-195b-34e0-ef4bb9d9b982@redhat.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hp7kq6gze6fyafh7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2020 at 01:07:12PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 6/8/20 5:50 AM, Andy Shevchenko wrote:
> > On Sun, Jun 07, 2020 at 08:18:28PM +0200, Hans de Goede wrote:
> > > When the user requests a high enough period ns value, then the
> > > calculations in pwm_lpss_prepare() might result in a base_unit value =
of 0.
> > >=20
> > > But according to the data-sheet the way the PWM controller works is t=
hat
> > > each input clock-cycle the base_unit gets added to a N bit counter and
> > > that counter overflowing determines the PWM output frequency. Adding 0
> > > to the counter is a no-op. The data-sheet even explicitly states that
> > > writing 0 to the base_unit bits will result in the PWM outputting a
> > > continuous 0 signal.
> >=20
> > So, and why it's a problem?
>=20
> Lets sya the user requests a PWM output frequency of 100Hz on Cherry Trail
> which has a 19200000 Hz clock this will result in 100 * 65536 / 19200000 =
=3D
> 0.3 -> 0 as base-unit value. So instead of getting 100 Hz the user will
> now get a pin which is always outputting low.

I didn't follow the complete discussion but note that the general rule
is:

	round period down to the next possible implementable period
	round duty_cycle down to the next possible implementable duty_cycle

so if a small enough period (and so a small duty_cycle) is requested it
is expected that duty_cycle will be zero.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hp7kq6gze6fyafh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7irFUACgkQwfwUeK3K
7AnMUQf/aHewf+zp0iswwki725rW1yDFIDBTEXn8BJGshdgTgK7jVxnmeAnp68jL
GrJUDVL2PD9tInqZkJmgQXpXDKJ2hToPm3qePnpFWRKsZX+wxIg5fJ/lOOnDzwYU
xeh6Y5vp2nhtK7e9u+YhN9C77/SqmjOW9hYPuwlFSs5jTxFQZruS8AHnGw+//F5V
KC2HwNoHwfUpiBIiUdITW3ZYHLotXRcqwI0wPZLCuOTIMAEqEWNH6WAtrHGU1BTn
KMmpuHs8Q5Z+hM+pcZGiL09cI4wEhatYCPCFhik1wXOAwwAtxsowNnIpbFgftPFS
e3MUGd4aKKhhexrR4pk5ODSfs2zhzA==
=p0QV
-----END PGP SIGNATURE-----

--hp7kq6gze6fyafh7--
