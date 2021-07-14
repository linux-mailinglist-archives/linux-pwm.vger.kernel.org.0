Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41FB3C7E9E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jul 2021 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhGNGmB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Jul 2021 02:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbhGNGmA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Jul 2021 02:42:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43505C061574
        for <linux-pwm@vger.kernel.org>; Tue, 13 Jul 2021 23:39:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3YXx-0002oE-1Y; Wed, 14 Jul 2021 08:39:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3YXv-0007Gu-V5; Wed, 14 Jul 2021 08:39:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3YXv-0003W5-U3; Wed, 14 Jul 2021 08:39:03 +0200
Date:   Wed, 14 Jul 2021 08:39:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Baolin Wang <baolin.wang@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>, kernel@pengutronix.de,
        Orson Zhai <orsonzhai@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/5] pwm: Ensure configuring period and duty_cycle isn't
 wrongly skipped
Message-ID: <20210714063901.5fmsinbhxoxvxhkf@pengutronix.de>
References: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
 <20210708123639.vrck33kc534yrnsq@pengutronix.de>
 <YOcGkoQ4jb0G92Iz@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gur4klcypbpluvmq"
Content-Disposition: inline
In-Reply-To: <YOcGkoQ4jb0G92Iz@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gur4klcypbpluvmq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Jul 08, 2021 at 04:07:14PM +0200, Thierry Reding wrote:
> On Thu, Jul 08, 2021 at 02:36:39PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Thierry,
> >=20
> > On Thu, Jul 01, 2021 at 10:27:50AM +0200, Uwe Kleine-K=F6nig wrote:
> > > Geert Uytterhoeven found a regression in one of my patches. The same
> > > problem exists in several further commits. The respective drivers are
> > > fixed in this series.
> > >=20
> > > The affected commits for the first patch is already in v5.4, so this
> > > patch should maybe backported to stable.
> > > The others are in Thierry's for-next branch only.
> >=20
> > These four broken patches were now included in your pull request to
> > Linus for v5.14-rc1 but these fixes were not. I wonder that the
> > regression Geert reported made you back out the offending commit but you
> > didn't care for the four identical problems in pwm-spear, pwm-tiecap,
> > pwm-berlin and pwm-ep93xx. Did you miss this series?
>=20
> Ugh... this is a nice big mess now. In retrospect I should've just
> backed out all those patches. Or rather not have applied them in the
> first place until they got a Tested-by.
>=20
> I'll pull in this series and will send this as a follow-up pull request.

I saw you applied the series to your for-next branch, so next is fixed
since next-20210709. I wonder what makes you wait sending these to
Linus.

The facts are:

 - Fixes were sent to the list on 2021-07-01
 - next was broken since at least next-20210701 up to next-20210708
 - linus/master is broken since v5.14-rc1~42 (2021-07-08) for ep93xx,
   berlin, tiecap, spear and since v5.4-rc1~27 (2019-09-27) for sprd

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gur4klcypbpluvmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDuhoIACgkQwfwUeK3K
7AlMWQf9HK0BXQjZ6j0dXgvbQpAe63Pj2ddwSQNkXX+OvHMHz1bHwt+XaznPfwJc
hfVhmVhCTLAm050F+u3ADe/whvnydWYNcYc74/je8FjcDKJVGi41f+roBIBl3bvs
zVZ6U7P9Yx/1S0pjCiiu768/ZsPj5gMpxq55mgu2BQjCMAjRfm+h3N08om5e6z00
MOq4wgkcYMp704l1PLO0FhW9iVCDTzoqvdHqB4QRq5Y37u3QS4kyJrnx6VsxAtZ7
pRbmM5IG0PC2Guwr991ciyslBbTilXdpnPUJ9ol7QSt+0w3cceOOnd4V3M5p/Ghu
30UYrZUtutQUAXmEB7J9XJebeFd8oQ==
=jQ+q
-----END PGP SIGNATURE-----

--gur4klcypbpluvmq--
