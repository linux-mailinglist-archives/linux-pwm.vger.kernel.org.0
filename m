Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4F62C8744
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 15:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgK3O6w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 09:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgK3O6v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Nov 2020 09:58:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4E5C0613D4
        for <linux-pwm@vger.kernel.org>; Mon, 30 Nov 2020 06:58:11 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjkcx-00056k-WD; Mon, 30 Nov 2020 15:58:08 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjkcx-0007SA-DN; Mon, 30 Nov 2020 15:58:07 +0100
Date:   Mon, 30 Nov 2020 15:58:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: sl28cpld: fix getting driver data in pwm callbacks
Message-ID: <20201130145805.n5il3xsrsifuomcu@pengutronix.de>
References: <20201124212432.3117322-1-u.kleine-koenig@pengutronix.de>
 <3becef43bd9119c624cf6c3c8ee5b472@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6nv3maa4xecwxb2g"
Content-Disposition: inline
In-Reply-To: <3becef43bd9119c624cf6c3c8ee5b472@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6nv3maa4xecwxb2g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Mon, Nov 30, 2020 at 09:17:52AM +0100, Michael Walle wrote:
> Am 2020-11-24 22:24, schrieb Uwe Kleine-K=F6nig:
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
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > in v4 of the driver Michael still used container_of and then changed to
> > use dev_get_drvdata() as Lee suggested. I didn't notice this suggestion,
> > otherwise I would have expressed my variance about this already earlier.
> >=20
> > I noticed this problem because Michael contacted me via irc and showed
> > me the resulting oops, so I think applying this before 5.10 would be
> > good. It's not entirely clear to me why .get_state() is called that
> > early in his case, but the theory is clear: The callbacks can be called
> > as soon as pwmchip_add() is called.
> >=20
> > Best regards
> > Uwe
>=20
> Ping. Would be nice if this makes it into v5.10.

Yes, fully agreed. @Thierry: Do you care to send it to Linus? Or are you
ok if I do that?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6nv3maa4xecwxb2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/FCHoACgkQwfwUeK3K
7AnxuwgAoJAt0tMa/sOlrAdxBt+1BmzfzVXzoghT7IiHQ9QYtyB0e29fwzxbjUGp
fOZtro6uHJoFIWmzX3DFuLhCuinYMcFgF36av4YxkfGKZSJ4i1E1SyC7WbFkDHtt
Hvkl9M9WyPsD8F0oBpCZMRhWj5whEvfwmi7ncN1A2Fzg9baP5bXDbbBG+K6d59Qy
kHd5351/YkLPoklZcii6T/QpaMzRIgoAXXdb1silH+qlHw2gaXURLb8grBWif6xE
cxc5FgYOm4VT6FFBI3ILuB8WTdx5IxXOSrA8qGweW9P4m8jvQ6TRFaR7lfrpHsVw
SlMWX4bgBemWqe96LVYbUsZjViaa6Q==
=iitq
-----END PGP SIGNATURE-----

--6nv3maa4xecwxb2g--
