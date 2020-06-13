Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188521F8538
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jun 2020 22:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgFMUud (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 13 Jun 2020 16:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgFMUuc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 13 Jun 2020 16:50:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A8AC08C5C2
        for <linux-pwm@vger.kernel.org>; Sat, 13 Jun 2020 13:50:32 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jkD6S-0007ba-LW; Sat, 13 Jun 2020 22:50:12 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jkD6R-0001u5-Ib; Sat, 13 Jun 2020 22:50:11 +0200
Date:   Sat, 13 Jun 2020 22:50:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
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
Message-ID: <20200613205008.l2gxw6pm2ywmj3gz@taurus.defre.kleine-koenig.org>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-4-hdegoede@redhat.com>
 <20200608035023.GZ2428291@smile.fi.intel.com>
 <90769dc0-3174-195b-34e0-ef4bb9d9b982@redhat.com>
 <20200611221242.3bjqvnhcwwxaocxy@taurus.defre.kleine-koenig.org>
 <20200612115732.GC2428291@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d3zhknjlycgiygbu"
Content-Disposition: inline
In-Reply-To: <20200612115732.GC2428291@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d3zhknjlycgiygbu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Fri, Jun 12, 2020 at 02:57:32PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 12, 2020 at 12:12:42AM +0200, Uwe Kleine-K=F6nig wrote:
> > I didn't follow the complete discussion but note that the general rule
> > is:
> >=20
> > 	round period down to the next possible implementable period
> > 	round duty_cycle down to the next possible implementable duty_cycle
> >=20
> > so if a small enough period (and so a small duty_cycle) is requested it
> > is expected that duty_cycle will be zero.
>=20
> ...which brings me an idea that PWM framework should expose API to get a
> capabilities, like DMA Engine has.
>=20
> In such capabilities, in particular, caller can get ranges of the correct
> frequencies of the underneath hardware.

my idea is to introduce a function pwm_round_state() that has a similar
semantic to clk_round_rate(). But this is only one of several thoughts I
have for the pwm framework. And as there is (AFAIK) no user who would
benefit from pwm_round_state() this is further down on my todo list.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d3zhknjlycgiygbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7lO/0ACgkQwfwUeK3K
7AmcWAf+NJKiXM9OZNgwpiVJ90hrVSpaBnIzIyOD9JrkPpA//Wpzt6+DP3jIW4gh
awT8Pn1q+S/BywtKGkspRruxRPMB+/xhcbFixZkhwnVHtDrTsNBmWa6tmNgJn5ay
2kksDM69380g/qndu8N1BIkziJ0M04IThxt4Rem7qETymFUIttJP/urLfPEbCNz5
agQVK0L/G6AktL5F/I68w6dwUkfOnt7bN+sQ3B6H6F38YY3boQJICjKLcHnN7nq8
mgmaF/jnGuuv3uPrPhm9K9zGy8W+XBmGZjdHQH1aU94+TMhK8AFQOR7N42Aj2VwA
/pNKs5SAoPGvfcEAUPd6w4sE4pKgTA==
=dz1/
-----END PGP SIGNATURE-----

--d3zhknjlycgiygbu--
