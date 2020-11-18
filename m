Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE602B7AEB
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 11:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKRKGm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 05:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKRKGl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 05:06:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D9C0613D4
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2020 02:06:41 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfKMA-0004um-Um; Wed, 18 Nov 2020 11:06:30 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfKM9-00006y-2Q; Wed, 18 Nov 2020 11:06:29 +0100
Date:   Wed, 18 Nov 2020 11:06:27 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
        kernel@pengutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Lai, Poey Seng" <poey.seng.lai@intel.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC] pwm: keembay: Fix build failure with -Os
Message-ID: <20201118100627.chgu3tgpt3kuazsv@pengutronix.de>
References: <202011160303.qi5aRChY-lkp@intel.com>
 <20201116090804.206286-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f3cgvfeuaxl572d5"
Content-Disposition: inline
In-Reply-To: <20201116090804.206286-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--f3cgvfeuaxl572d5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc: +=3D linux-pwm which I forgot for the initial submission]

Hello,

On Mon, Nov 16, 2020 at 10:08:04AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The driver used this construct:
>=20
> 	#define KMB_PWM_LEADIN_MASK             GENMASK(30, 0)
>=20
> 	static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32=
 mask,
> 						   u32 val, u32 offset)
> 	{
> 		u32 buff =3D readl(priv->base + offset);
>=20
> 		buff =3D u32_replace_bits(buff, val, mask);
> 		writel(buff, priv->base + offset);
> 	}
>=20
> 	...
> 	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
> 					KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
>=20
> With CONFIG_CC_OPTIMIZE_FOR_SIZE the compiler (here: gcc 10.2.0) this
> triggers:
>=20
> 	In file included from /home/uwe/gsrc/linux/drivers/pwm/pwm-keembay.c:16:
> 	In function =E2=80=98field_multiplier=E2=80=99,
> 	    inlined from =E2=80=98keembay_pwm_update_bits=E2=80=99 at /home/uwe/=
gsrc/linux/include/linux/bitfield.h:124:17:
> 	/home/uwe/gsrc/linux/include/linux/bitfield.h:119:3: error: call to =E2=
=80=98__bad_mask=E2=80=99 declared with attribute error: bad bitfield mask
> 	  119 |   __bad_mask();
> 	      |   ^~~~~~~~~~~~
> 	In function =E2=80=98field_multiplier=E2=80=99,
> 	    inlined from =E2=80=98keembay_pwm_update_bits=E2=80=99 at /home/uwe/=
gsrc/linux/include/linux/bitfield.h:154:1:
> 	/home/uwe/gsrc/linux/include/linux/bitfield.h:119:3: error: call to =E2=
=80=98__bad_mask=E2=80=99 declared with attribute error: bad bitfield mask
> 	  119 |   __bad_mask();
> 	      |   ^~~~~~~~~~~~
>=20
> The compiler doesn't seem to be able to notice that with field being
> 0x3ffffff the expression
>=20
> 	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
> 		__bad_mask();
>=20
> can be optimized away.
>=20
> So use __always_inline and document the problem in a comment to fix
> this.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> I'm not sure this is the right fix. Maybe the bitfield stuff can be
> changed somehow to make this problem go away, too?

Note, this patch

Fixes: cdbea243f419 ("pwm: Add PWM driver for Intel Keem Bay")

so this isn't critical for v5.10.

@thierry: If this is ok for you and Vijayakannan, you can squash this
into the original commit.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f3cgvfeuaxl572d5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+08iAACgkQwfwUeK3K
7AnUVAf/YxTwE3tU2vULoHk/fnDpS83BzF5RouweYpdkGX2FEu43jWDyFNbFgjGC
8JnequWKEuR4rILG7s63egOqY1y/sI+a2FDYbxjRtiRhki5cHHymhZcF0LeLYz1L
rN5hAXAtI/5Zm7fBN3Kbsqj6UuqNK5D4lKCaNjN2gmFkrKJHPpTImhmycuvDpbFr
L6PuqwXXGchmk/2jG1efnFF5s3wmA0f/pP5DsvqRIpBxz8lQKrBPAzjZNYHHSRk2
+pkdeoU5w2AnFjebUkIoplACMQ8u2bB0DMfBaPJKQKThGq2ORWlw/3F7Tj/L8w23
kugIFzjb/wnc1tZhs2eQNPl+CC3Ztw==
=wStM
-----END PGP SIGNATURE-----

--f3cgvfeuaxl572d5--
