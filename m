Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA52CEF54
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 15:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgLDOEZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 09:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgLDOEZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 09:04:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA0C0613D1
        for <linux-pwm@vger.kernel.org>; Fri,  4 Dec 2020 06:03:44 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klBgT-0007qa-SV; Fri, 04 Dec 2020 15:03:41 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klBgT-0005FI-7m; Fri, 04 Dec 2020 15:03:41 +0100
Date:   Fri, 4 Dec 2020 15:03:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>, kernel@pengutronix.de,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RESEND for 5.10] pwm: sl28cpld: fix getting driver data
 in pwm callbacks
Message-ID: <20201204140336.jkemihnqqwozu45x@pengutronix.de>
References: <20201203084142.3810204-1-u.kleine-koenig@pengutronix.de>
 <X8oubGP9CvoOQKtF@ulmo>
 <20201204132436.GO4801@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6qdq4ny3jrifkzby"
Content-Disposition: inline
In-Reply-To: <20201204132436.GO4801@dell>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6qdq4ny3jrifkzby
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Fri, Dec 04, 2020 at 01:24:36PM +0000, Lee Jones wrote:
> On Fri, 04 Dec 2020, Thierry Reding wrote:
> > Now, I can no longer find a link to the discussion that I recall, so it
> > was either on IRC (where I don't have any logs) or I'm loosing my mind.
>=20
> Don't worry, you are (probably!) still quite sane.
>=20
> The discussion happened over IRC.

FTR, the conversation was as follows (with lag =3D Lee, tags =3D Thierry and
ukleinek =3D me):

1606741876 < ukleinek> tagr, lag: would you mind if I send 20201124212432.3=
117322-1-u.kleine-koenig@pengutronix.de to Linus?
1606741894 < ukleinek> tagr: or if you do mind, can you please send it?
[...]
1606742364 < lag> ukleinek: I assume this is the container_of() patch?
1606742370 < ukleinek> lag: right
1606742402 < lag> ukleinek: It seems very wrong that a leaf controller driv=
er's ops would be called before it has probed
1606742410 < lag> ukleinek: How is that a thing?
1606742428 < ukleinek> lag: the ops can be called as soon as pwmchip_add co=
mpletes
1606742443 < lag> ukleinek: Where is pwmchip_add() called
1606742470 < lag> I guess I can grep that myself
1606742480 < ukleinek> lag: just before platform_set_drvdata(pdev, priv) in=
 sl28cpld_pwm_probe()
1606742755 < lag> ukleinek: What about moving pwmchip_add() after platform_=
set_drvdata() or vice versa?
1606742789 < ukleinek> lag: did you read the commit log?
1606742845 < lag> ukleinek: I did
1606742981 < ukleinek> lag: then I don't get your question
1606743049 < lag> ukleinek: Why is using container_of, which is generally h=
orrible and only used if there is no other way to obtain data, better than =
changing order of the calls such that the dependencies are met
1606743127 < ukleinek> container_of is a well understood concept and it's c=
heaper than dev_get_drvdata
1606743198 < ukleinek> and conceptually it's easier too. (But that might on=
ly be me)
1606743241 < ukleinek> for one thing it cannot happen that I get a wrong po=
inter because platform_set_drvdata was called too late
1606743281 < ukleinek> also it makes use of the fact that platform_set_drvd=
ata sets the driver's driver data and not something in the platform device

> I highlighted my concerns, but Uwe didn't respond to them.  This patch
> was the next time I saw anything on the subject.

So I did respond and if you didn't see it the problem is on your end.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6qdq4ny3jrifkzby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/KQbUACgkQwfwUeK3K
7Al5dAf+KPhOCIV6qY1UnYHozlCainhVo1LpKDWeEFNaXNH4PFlIDG3vJEVqhWbI
7TZOFG/J6zPr9c3wItzPsd09zVHqWtjrEj9TX4Ux+xM3iSmZf2W1YMMTRx0LQzNG
f0alrCiI6tm7kndiI1FLbYMV3brcGJJUvuBwcILUA9kbi4AMyDbG94QVAxGAvB85
gCQDhJmpuIJbtPVoRwC6xNKkQ5sdpHQQHvB27wMrt4IW9cFHkZah0LWbYLYCzPxe
XtNu6QeML3GebVH48+/6EgCcW6a0YSkaeNNMsEDdwzGLwx/LfH4I6an1D57rhDrY
BeYk62zKtSCFwUXqpjVcbFC3DMTqxg==
=rtCp
-----END PGP SIGNATURE-----

--6qdq4ny3jrifkzby--
