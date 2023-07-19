Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10746759892
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGSOkB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 10:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGSOkB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 10:40:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C26E1A6
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 07:40:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM8LO-0007YN-Q9; Wed, 19 Jul 2023 16:39:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM8LO-000crz-58; Wed, 19 Jul 2023 16:39:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM8LN-0067an-HB; Wed, 19 Jul 2023 16:39:57 +0200
Date:   Wed, 19 Jul 2023 16:39:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 09/10] pwm: sl28cpld: Consistenly name pwm_chip variables
 "chip"
Message-ID: <20230719143956.6sv3feiroiwrcosb@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
 <20230714205623.2496590-10-u.kleine-koenig@pengutronix.de>
 <bc30d8483cb3eb901feb986ca88a02b9@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g54yg25nairkwc76"
Content-Disposition: inline
In-Reply-To: <bc30d8483cb3eb901feb986ca88a02b9@walle.cc>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--g54yg25nairkwc76
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jul 19, 2023 at 04:17:41PM +0200, Michael Walle wrote:
> Am 2023-07-14 22:56, schrieb Uwe Kleine-K=F6nig:
> > Nearly all pwm drivers use the name "chip" for the member in the driver
> > struct pointing to the pwm_chip. Also all local variables and function
> > parameters with this type use this name. Rename the struct pwm_chip
> > member accordingly for consistency.
> >=20
> > Also rename the parameter of the macro sl28cpld_pwm_from_chip to "chip".
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > ---
>=20
> > -#define sl28cpld_pwm_from_chip(_chip) \
> > -	container_of(_chip, struct sl28cpld_pwm, pwm_chip)
> > +#define sl28cpld_pwm_from_chip(chip) \
> > +	container_of(chip, struct sl28cpld_pwm, chip)
>=20
> This looks strange now. Before only the the first parameter of
> container_of() is a parameter of the macro. After the change
> it's the first and the last. I.e. the name of the member
> comes from the argument of the macro.
>=20
> Was that intended? Looks like it happens to work because
> everything is named "chip", but nevertheless it doesn't look
> correct to me.
>=20
> I'd expect it to be:
> #define sl28cpld_pwm_from_chip(_chip) \
> 	container_of(_chip, struct sl28cpld_pwm, chip)

Indeed, that's bogus. My preference would be to make this a static
inline, i.e.=20

diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 98b0024f9658..c789e934671e 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -84,8 +84,11 @@ struct sl28cpld_pwm {
 	struct regmap *regmap;
 	u32 offset;
 };
-#define sl28cpld_pwm_from_chip(chip) \
-	container_of(chip, struct sl28cpld_pwm, chip)
+
+static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct pwm_chip =
*chip)
+{
+	return container_of(chip, struct sl28cpld_pwm, chip);
+}
=20
 static int sl28cpld_pwm_get_state(struct pwm_chip *chip,
 				  struct pwm_device *pwm,

but I can live with _chip, too.

Best regards and thanks for catching that,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g54yg25nairkwc76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS39boACgkQj4D7WH0S
/k5O/gf/W6zobYt/VGKVpRdyzG2dchimWjU8xnd7PB/y33MurQP5z6tvQFEWYcsm
1PerEjvLMuabNw5GZ6WzbuRWqDvXP29bSY+FV/LVKEwSba3gtDJNU3VqYFuYVcBP
dQ+BoSsggMOJLYQNAu5Yw8SJACzFN0lJLZcwJiPFf02t60M3eOjB+XwW0sBD4hTq
BMeJtgMMgg038wttOfJKyX0v4LwtCVpuQRQlvafQbxDxnoE8vA+p/QQ9gZyCPPV1
y860++yR2Hjt4o03HloBoBMQIR3jtKbTZbNP+2XxvAtDX0v+7liO6WjUqhGHtVzh
wsUg+E1tUtO0PRvDW80CeoqEQemvUw==
=NsMt
-----END PGP SIGNATURE-----

--g54yg25nairkwc76--
