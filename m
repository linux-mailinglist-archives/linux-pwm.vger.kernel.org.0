Return-Path: <linux-pwm+bounces-261-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCF07FE927
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 07:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6653B28224D
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C2720DCE;
	Thu, 30 Nov 2023 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B3A0
	for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 22:32:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8abB-0005CD-5s; Thu, 30 Nov 2023 07:32:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8abA-00CZSk-IN; Thu, 30 Nov 2023 07:32:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8abA-00BLXd-8y; Thu, 30 Nov 2023 07:32:32 +0100
Date: Thu, 30 Nov 2023 07:32:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Stop referencing pwm->chip
Message-ID: <20231130063232.lecvjijmflxrwzlm@pengutronix.de>
References: <20231129162847.568780-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gf4q4qiivz3qliv4"
Content-Disposition: inline
In-Reply-To: <20231129162847.568780-1-thierry.reding@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--gf4q4qiivz3qliv4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 05:28:47PM +0100, Thierry Reding wrote:
> Drivers have access to the chip via a function argument already, so
> there is no need to reference it via the PWM device.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Nice cleanup. Applied on top of 53a2eaaf19c4 (i.e. your current for-next
branch) there is one instance you missed:

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 73f96cef1662..80dcff237a15 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -123,7 +123,7 @@ static void jz4740_pwm_disable(struct pwm_chip *chip, s=
truct pwm_device *pwm)
 static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
-	struct jz4740_pwm_chip *jz =3D to_jz4740(pwm->chip);
+	struct jz4740_pwm_chip *jz =3D to_jz4740(chip);
 	unsigned long long tmp =3D 0xffffull * NSEC_PER_SEC;
 	struct clk *clk =3D jz->clk[pwm->hwpwm];
 	unsigned long period, duty;

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gf4q4qiivz3qliv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVoLH8ACgkQj4D7WH0S
/k6cfAf+K499p761f/HtTe9HFiAXzlaZwmMi8Z6OplmgsEdIOCzI0GeyKIWSQpzK
wBzoy9pXU6OVNldIhT1zvlJyJldjhXYLW4x3lymtvBRe5bzXp/iDLaRqIXBJm2co
gXonSWP2Wy1/OmrF6CsuhMVohOb9xCKnGJoFG/dO+/mgunyPrqIRjJebAFicsceO
EXnhhsYx291ZqTmqmo239y1tx022c/CyhUttnPFMGzJiJKLeU2obAE7kBO7FaSvF
pWXjXWj0f/ofjUhNR4RL+1SDKHroHZRyx99531x6kocWVr6bS20u8C77HJTuHX/X
M9ynLGYBn/mpW32CFAQSe1IIysI40w==
=JIAg
-----END PGP SIGNATURE-----

--gf4q4qiivz3qliv4--

