Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEEA326E84
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Feb 2021 18:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhB0R6X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Feb 2021 12:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhB0Rzi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 27 Feb 2021 12:55:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8605DC06174A
        for <linux-pwm@vger.kernel.org>; Sat, 27 Feb 2021 09:46:26 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lG3fX-0000Kf-7b; Sat, 27 Feb 2021 18:46:19 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lG3fW-0007fZ-7D; Sat, 27 Feb 2021 18:46:18 +0100
Date:   Sat, 27 Feb 2021 18:46:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [GIT PULL] pwm: Changes for v5.12-rc1
Message-ID: <20210227174608.p5fha6j33gftt57i@pengutronix.de>
References: <20210225193426.3679817-1-thierry.reding@gmail.com>
 <20210226095936.sc27f3un5vnc5o62@pengutronix.de>
 <YDjhQvv0vYU890Ol@ulmo.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dranukm4pkjhptg4"
Content-Disposition: inline
In-Reply-To: <YDjhQvv0vYU890Ol@ulmo.localdomain>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dranukm4pkjhptg4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2021 at 12:53:38PM +0100, Thierry Reding wrote:
> On Fri, Feb 26, 2021 at 10:59:36AM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello Thierry,
> >=20
> > On Thu, Feb 25, 2021 at 08:34:26PM +0100, Thierry Reding wrote:
> > > ----------------------------------------------------------------
> > > pwm: Changes for v5.12-rc1
> > >=20
> > > The ZTE ZX platform is being removed, so the PWM driver is no longer
> > > needed and removed as well. Other than that this contains a small set=
 of
> > > fixes and cleanups across a couple of drivers.
> >=20
> > patches I'd have liked to be seen additionally in this pull request are:
> >=20
> >   pwm: bcm2835: Improve period and duty cycle calculation
> >    https://patchwork.ozlabs.org/project/linux-pwm/patch/20210114204804.=
143892-1-u.kleine-koenig@pengutronix.de/
>=20
> There was discussion on earlier versions of this, so I was hoping that
> Lino and/or Florian would provide a Reviewed-by/Acked-by/Tested-by on
> this. I'll go ping them to see if we can get a reaction.

Fine.

> >   pwm: get rid of pwmchip_add_with_polarity()
> >    https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D219012
>=20
> From a quick look I'm not sure I understand what this is trying to do.
> The goal of pwmchip_add_with_polarity() was initially to support chips
> that support only PWM_POLARITY_INVERSED (or use inversed polarity by
> default, rather than normal polarity). So without looking at it more
> closely it doesn't seem quite right to drop it.

This is at least not the effect of pwmchip_add_with_polarity. There is
nothing in the core that ensures that apply with the other polarity
fails.

There are two drivers that make use of pwmchip_add_with_polarity(); both
support both polarities.

> >   pwm: add a config symbol for legacy drivers
> >    https://patchwork.ozlabs.org/project/linux-pwm/patch/20200613155742.=
31528-1-uwe@kleine-koenig.org/
>=20
> I think we've discussed this in the past.

If so I don't remember and it wasn't on the list.

> I don't see the point in this because your patch marks 30 out of 58
> drivers as legacy. Calling the majority "legacy" is a bit of a
> stretch. Also, I don't see how this changes anything. It doesn't
> actually simplify the core because legacy code can't be removed. It's
> only "simplified" if we don't actually select the PWM_LEGACY_DRIVERS
> symbol, but that's both not going to happen on most configurations and
> doesn't actually simplify anything from a maintenance point of view.
> If anything it further complicates things because now we have to test
> that everything builds fine with or without PWM_LEGACY_DRIVERS. Also,
> going forward I don't plan on merging any drivers that don't use the
> atomic API, and I don't need a Kconfig option to remind me of that.

My motivation is that it is obvious for people adding new drivers that
they make something wrong when they need this symbol.

> A better way forward would be to start converting some of these drivers
> to the atomic API since there's apparently not enough incentive for the
> driver maintainers to do that themselves.

That's fine, I can work on that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dranukm4pkjhptg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmA6hVwACgkQwfwUeK3K
7AnbaAf/bzgfotKCn1bef9JX0PzQUoU00O3KowODFavjmCFK0BJ2/pvqhN7Ulhqj
OClO/tHVZ8a1Ojyss9gWuV0xe6nMzNVKsm18ZHRgZvi4dKo7jy6on9qZP89ipBVo
EOa7smyIKhaa2lQcwiPUwyv1E3v+7L48qLj0ukgom54vqBV1kBlyLktlQpG1/PdV
nle6y3u9iMLq/gcWeTCLwwUaA5YRF1hfuPN83vax5gEf2IigCHreW73xu1PeDN6n
fYJcEnuN3GQirexjGV3NKTI3iHiV6EnqQXhrdMjY9Tm3yHgCX15Rw6y3hHceu1ZO
pUmel/QCh3Pb6BPS7gefSVCXOKuiGA==
=zct5
-----END PGP SIGNATURE-----

--dranukm4pkjhptg4--
