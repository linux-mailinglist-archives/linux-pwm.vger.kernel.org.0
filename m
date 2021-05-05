Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED73734AC
	for <lists+linux-pwm@lfdr.de>; Wed,  5 May 2021 07:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhEEFW6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 May 2021 01:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhEEFW6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 May 2021 01:22:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B35C061761
        for <linux-pwm@vger.kernel.org>; Tue,  4 May 2021 22:22:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1le9ys-0005HJ-1e; Wed, 05 May 2021 07:21:54 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1le9yr-00047w-6W; Wed, 05 May 2021 07:21:53 +0200
Date:   Wed, 5 May 2021 07:21:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Message-ID: <20210505052153.syhptme4pfrbw73v@pengutronix.de>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
 <20201029181357.GE26053@duo.ucw.cz>
 <YIn50NW+Pimqfsih@builder.lan>
 <20210429211223.GA5480@amd>
 <20210429212920.GB2484@yoga>
 <YJFridMwwMV1K98m@mobian>
 <20210504161327.GF2484@yoga>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twdyeagubu6upt4z"
Content-Disposition: inline
In-Reply-To: <20210504161327.GF2484@yoga>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--twdyeagubu6upt4z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 04, 2021 at 11:13:27AM -0500, Bjorn Andersson wrote:
> On Tue 04 May 10:43 CDT 2021, Pavel Machek wrote:
> > > So downstream they have (last time I looked at the code) an addition =
in
> > > the PWM API where the LED driver can inform the PWM driver part about
> > > the indices to use. Naturally I don't think that's a good idea.
> >=20
> > Dunno. Is it bad idea?
> >=20
> > pattern support for other PWMs (vibration?) seems useful, too. Yes, it
> > means more discussion and extending PWMs properly..
> >=20
>=20
> @Thierry, @Lee, @Uwe, are you interested in extending the PWM api with
> some sort of support for specifying an array of "duty_cycle" and some
> property for how fast the hardware should cycle through those duty
> cycles? (And I need a bit/bool to indicate if the pattern should run
> once of be repeated)
>=20
> The (current) use case relates to being able to alter the duty cycle
> over time to create "effects" such as pulsing an LED.

My personal opinion here is that this is too special to be worth the
generalisation.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--twdyeagubu6upt4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCSK20ACgkQwfwUeK3K
7AnbuQf9FCB0PpgSA/lR/qkTwcyn5aszc/HWkQpesYZyNI/WCfvWF9/stR+usSRk
+nGaH75A/vzYqc91kOyGIxxBdAXF/6nwuaVlf7bqAnv7ik7fsBDNxdB8TGRlxaMe
BqEn9OGkicUoKce8jEdXnvtWHNEydIyIwnddviu9XXuuuzyeoW4rLqViWDRfTxSc
3lpyxoTyylKO+giIoB3LIdfAu7N+zs61WBpwaUgH/hdDJ0ZAI5Nyluqkui4gcsht
02x0bxWbl/wbpXPWTz/Sx3BW9zrZk3k/uKZSFPYNxm3rZmOF4I+HhbMA5/FrkSub
LBDp5Vds0xUF2QtsuDfPv3JWexGoJQ==
=v6gl
-----END PGP SIGNATURE-----

--twdyeagubu6upt4z--
