Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978562F73BA
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Jan 2021 08:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbhAOHdW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Jan 2021 02:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbhAOHdW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Jan 2021 02:33:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA11C061757
        for <linux-pwm@vger.kernel.org>; Thu, 14 Jan 2021 23:32:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0Jb6-0006l5-Oi; Fri, 15 Jan 2021 08:32:40 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0Jb5-0001H1-Vu; Fri, 15 Jan 2021 08:32:39 +0100
Date:   Fri, 15 Jan 2021 08:32:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: [PATCH v4] pwm: iqs620a: Fix overflow and optimize calculations
Message-ID: <20210115073239.2tnf5o4j7ushfpsz@pengutronix.de>
References: <20210114215026.163424-1-u.kleine-koenig@pengutronix.de>
 <20210115040720.GC27243@labundy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d5mlyuysqgc6vb35"
Content-Disposition: inline
In-Reply-To: <20210115040720.GC27243@labundy.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d5mlyuysqgc6vb35
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If state->duty_cycle is 0x100000000000000, the previous calculation of
duty_scale overflows and yields a duty cycle ratio of 0% instead of
100%. Fix this by clamping the requested duty cycle to the maximal
possible duty cycle first. This way it is possible to use a native
integer division instead of a (depending on the architecture) more
expensive 64bit division.

With this change in place duty_scale cannot be bigger than 256 which
allows to simplify the calculation of duty_val.

Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")
Tested-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---

Hi Jeff,

On Thu, Jan 14, 2021 at 10:07:20PM -0600, Jeff LaBundy wrote:
> Thank you for your work here; it's coming together quite nicely.

Thank you for your prompt feedback, it adds much to the fun to be able
to rely on someone who cares and looks into patches.

> On Thu, Jan 14, 2021 at 10:50:26PM +0100, Uwe Kleine-K=F6nig wrote:
> >  	struct iqs620_pwm_private *iqs620_pwm;
> >  	struct iqs62x_core *iqs62x;
> > -	u64 duty_scale;
> > +	unsigned duty_cycle;
> > +	unsigned duty_scale;
> > +
> >  	int ret;
> > =20
>=20
> Nit: there is a rogue newline here. I'm also not such a fan of mixing
> shorthand 'unsigned' with existing 'unsigned int' (as in probe).

full ack. checkpatch even warns about unsigned without int. *sigh*

> > [...]
>=20
> That being said, the patch is functionally correct and I validated all
> corner cases with actual hardware. Feel free to add to future cosmetic
> revisions:
>=20
> Tested-by: Jeff LaBundy <jeff@labundy.com>

done, thanks

These are the only changes since v3 (i.e.

 - use unsigned int instead of unsigned
 - remove empty line
 - add Tested-by

)

Best regards
Uwe

 drivers/pwm/pwm-iqs620a.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 5ede8255926e..14b18fb4f527 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -46,7 +46,8 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct=
 pwm_device *pwm,
 {
 	struct iqs620_pwm_private *iqs620_pwm;
 	struct iqs62x_core *iqs62x;
-	u64 duty_scale;
+	unsigned int duty_cycle;
+	unsigned int duty_scale;
 	int ret;
=20
 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
@@ -70,7 +71,8 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct=
 pwm_device *pwm,
 	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
 	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
 	 */
-	duty_scale =3D div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
+	duty_cycle =3D min_t(u64, state->duty_cycle, IQS620_PWM_PERIOD_NS);
+	duty_scale =3D duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
=20
 	mutex_lock(&iqs620_pwm->lock);
=20
@@ -82,7 +84,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct=
 pwm_device *pwm,
 	}
=20
 	if (duty_scale) {
-		u8 duty_val =3D min_t(u64, duty_scale - 1, 0xff);
+		u8 duty_val =3D duty_scale - 1;
=20
 		ret =3D regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
 				   duty_val);
--=20
2.29.2

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d5mlyuysqgc6vb35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmABRRQACgkQwfwUeK3K
7AmzEwgAoJ8PNQ6GQlQj8s/44c2qDJvTC08W/F/Tk1KsKD7vMptyU048nRVpp7sK
tLdPKrazuA4H9PwR14zZdvVyo9JQSNFehIpzV3JOrcFrOMr0mCgLIpcxLQgNN6Y1
UsWV2IITVTi+cMdrUDUHGs5aaEQ7vP8UITls8LiTzu8wz9hx7J0Ah8LFJQB773Ik
iCj22KB5WszzgT66nlrLx2X4rV/tSeUoNJ7MvJm1dBZ/wFm+CtEiUXY0biDAO4UM
lYWzVtX/YYo//O8CtLVnvuIap8xWge0VEz8z7xKV8itdvor1rg+pxWTZiBwoQpl+
nxpdgC0ZeOJ+jTaAuxJbs6BYjVSCvw==
=SvNF
-----END PGP SIGNATURE-----

--d5mlyuysqgc6vb35--
