Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FCD2CEF02
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 14:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgLDNvt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 08:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLDNvt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 08:51:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80A1C0613D1
        for <linux-pwm@vger.kernel.org>; Fri,  4 Dec 2020 05:51:08 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klBUI-0006Yb-GQ; Fri, 04 Dec 2020 14:51:06 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klBUI-0003sX-2f; Fri, 04 Dec 2020 14:51:06 +0100
Date:   Fri, 4 Dec 2020 14:51:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND for 5.10] pwm: sl28cpld: fix getting driver data
 in pwm callbacks
Message-ID: <20201204135102.foq5gvvzfcwbwphh@pengutronix.de>
References: <20201203084142.3810204-1-u.kleine-koenig@pengutronix.de>
 <X8oubGP9CvoOQKtF@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ydwpyur5ap46h5nm"
Content-Disposition: inline
In-Reply-To: <X8oubGP9CvoOQKtF@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ydwpyur5ap46h5nm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Dec 04, 2020 at 01:41:16PM +0100, Thierry Reding wrote:
> On Thu, Dec 03, 2020 at 09:41:42AM +0100, Uwe Kleine-K=F6nig wrote:
> > Currently .get_state() and .apply() use dev_get_drvdata() on the struct
> > device related to the pwm chip. This only works after .probe() called
> > platform_set_drvdata() which in this driver happens only after
> > pwmchip_add() and so comes possibly too late.
> >=20
> > Instead of setting the driver data earlier use the traditional
> > container_of approach as this way the driver data is conceptually and
> > computational nearer.
> >=20
> > Fixes: 9db33d221efc ("pwm: Add support for sl28cpld PWM controller")
> > Tested-by: Michael Walle <michael@walle.cc>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello Linus,
> >=20
> > Thierry (who usually sends PWM patches to you) didn't react to this
> > patch sent to the pwm Mailinglist last week
> > (https://lore.kernel.org/r/20201124212432.3117322-1-u.kleine-koenig@pen=
gutronix.de)
> > yet.
> >=20
> > Given v5.10 isn't far away any more and I don't know when Thierry will
> > take a look and act, I'm sending this directly to you. The affected
> > driver was new in 5.10-rc1 and at least once the unpatched driver
> > created an oops:
> >=20
> > 	https://lavalab.kontron.com/scheduler/job/108#L950
> >=20
> > Michael Walle who tested this patch is the original author of the
> > driver. IMHO it would be good to have this fixed before 5.10.
> >=20
> > If you prefer a pull request, I can setup something (but I don't have
> > access to Thierry's tree, so it will be for a repository that's new to
> > you).
> >=20
> > Best regards
> > Uwe
> >=20
> >  drivers/pwm/pwm-sl28cpld.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> I thought I had seen you discuss this with Lee and gotten the impression
> that you were going to respin this to move the platform_set_drvdata() to
> an earlier point, which I think is the more correct approach.

Lee asked on irc why I didn't move the platform_set_drvdata to an
earlier stage and I told him why. Then the conversation was over.

> container_of() isn't exactly wrong, but it's really just papering over
> the fact that platform_set_drvdata() is in the wrong place, so I'd
> prefer a patch that does that instead.

platfrom_set_drvdata is in a perfectly fine position if you only rely on
it in the platform_driver's remove callback which is the case with my
patch. I wrote in my commit log

| Instead of setting the driver data earlier use the traditional
| container_of approach as this way the driver data is conceptually and
| computational nearer.

which is still think to be true. The main thing I don't like about the
platform_set_drvdata approach is that you have to rely on
dev_get_drvdata() returning the value set with platform_set_drvdata()
which IMHO is an implementation detail of the platform driver code.

> Now, I can no longer find a link to the discussion that I recall, so it
> was either on IRC (where I don't have any logs) or I'm loosing my mind.

It was on IRC but I thought to have written an email about this, too.
But I don't find it either.

> I'll prepare a patch that moves platform_set_drvdata() for Michael to
> test. If that works I'll send a PR with fixes to Linus early next week.

You're late, Linus already merged my patch.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ydwpyur5ap46h5nm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/KPsIACgkQwfwUeK3K
7AkgoQf/YaLvIfCshWZZ2GnWDV7Hdz4CuUCpnjp1JQ3xsCiHm65tSrbYW7K9f7XK
f4SnTbW9TgZCV3SqkoNNuileJITzdAfpqLxRyYr1hEHfnqX3s1y6mo42EXhdrExx
sYM/BDsRPq6ACR3+r06/OrVM2A0YloBdsJ1/mqLSIvK9dXFK8JMpgHtcUygwE5yx
Xaer6MNka0c2DC+b2W2KnDN2uWAjFZj9LMnNeo9ueOCyVp6NHSM7M79Ak4CO7QSz
fwJbFuQC2Pbfqa6mgkJH7Bqao2RXPsT9B5hi2GUx2yzJTZL6FNP/0oZdn2XV8jwd
eNafAgr5P0mBfgSGlrQv0JAGzSdDfw==
=MmaP
-----END PGP SIGNATURE-----

--ydwpyur5ap46h5nm--
