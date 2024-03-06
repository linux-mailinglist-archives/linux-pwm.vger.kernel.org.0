Return-Path: <linux-pwm+bounces-1728-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D089E873080
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Mar 2024 09:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC381C21643
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Mar 2024 08:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4327E5D75A;
	Wed,  6 Mar 2024 08:18:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE25D48F
	for <linux-pwm@vger.kernel.org>; Wed,  6 Mar 2024 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713094; cv=none; b=OEkn+gIk/g7z6FywNue2glBdhYaltBzgJDgivJHr3aJ5f+Qpnmcw/ZKlE2RdM4XLGtgD2PUyVvFYnvy0H66mVivr1NvczXmWvl/fIxzedycQsVL+n8NaeZSRTyut5cC31bSHosWQbnNzgj3bLEcpf6PgMToFw5SLi9tX4jihY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713094; c=relaxed/simple;
	bh=WT212ElBVLEGsEDoYgYczVwqs72WXv8FPxECFA7pKQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1FXS16FyBU9pwObKPDpeSpPFXAvtmZH/EtQyKfujN97CsFsiZYMd/gErTX7DSUoGDmfu3lejRm1BLSpzbTRhzLnj9sTFa/ymVknRqkJ0zVD/sQgCtk3XUBHC7Xqe3R0DnfpImRXi2qWYuo7lv+TSn7HAli1iRcsq17kt1+QeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhmTV-0001Ip-JG; Wed, 06 Mar 2024 09:18:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhmTV-004i1B-13; Wed, 06 Mar 2024 09:18:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhmTU-000Y8G-33;
	Wed, 06 Mar 2024 09:18:04 +0100
Date: Wed, 6 Mar 2024 09:18:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] stm32mp1xx based targets stopped entering suspend
 if pwm-leds exist
Message-ID: <2vbwacjy25z5vekylle3ehwi3be4urm6bssrbg6bxobtdlekt4@mazicwtgf4qb>
References: <5da6cf8a-4250-42f6-8b39-13bff7fcdd9c@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iyqdb55itbghrjyl"
Content-Disposition: inline
In-Reply-To: <5da6cf8a-4250-42f6-8b39-13bff7fcdd9c@leemhuis.info>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--iyqdb55itbghrjyl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Mar 06, 2024 at 08:05:15AM +0100, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
>=20
> Uwe, I noticed a report about a regression in bugzilla.kernel.org that
> apparently is caused by a change of yours. As many (most?) kernel
> developers don't keep an eye on it, I decided to forward it by mail.
>=20
> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> not CCed them in mails like this.
>=20
> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D218559 :
>=20
> > Commit 76fe464c8e64e71b2e4af11edeef0e5d85eeb6aa ("leds: pwm: Don't
> > disable the PWM when the LED should be off") prevents stm32mp1xx based
> > targets from entering suspend if pwm-leds exist, as the stm32 PWM driver
> > refuses to enter suspend if any PWM channels are still active ("PWM 0
> > still in use by consumer" see stm32_pwm_suspend in drivers/pwm/stm32-pw=
m.c).
> >=20
> > Reverting the mentioned commit fixes this behaviour but I'm not
> > certain if this is a problem with stm32-pwm or pwm-leds (what is the
> > usual behaviour for suspend with active PWM channels?).

I'd assume the following patch fixes this report. I didn't test it
though.

Best regards
Uwe

---->8----
=46rom: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] leds: pwm: Disable PWM when going to suspend

On stm32mp1xx based machines (and others) a PWM consumer has to disable
the PWM because an enabled PWM refuses to suspend. So check the
LED_SUSPENDED flag and depending on that set the .enabled property.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218559
Fixes: 76fe464c8e64 ("leds: pwm: Don't disable the PWM when the LED should =
be off")
Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/leds-pwm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 4e3936a39d0e..e1b414b40353 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -53,7 +53,13 @@ static int led_pwm_set(struct led_classdev *led_cdev,
 		duty =3D led_dat->pwmstate.period - duty;
=20
 	led_dat->pwmstate.duty_cycle =3D duty;
-	led_dat->pwmstate.enabled =3D true;
+	/*
+	 * Disabling a PWM doesn't guarantee that it emits the inactive level.
+	 * So keep it on. Only for suspending the PWM should be disabled because
+	 * otherwise it refuses to suspend. The possible downside is that the
+	 * LED might stay (or even go) on.
+	 */
+	led_dat->pwmstate.enabled =3D !(led_cdev->flags & LED_SUSPENDED);
 	return pwm_apply_might_sleep(led_dat->pwm, &led_dat->pwmstate);
 }

base-commit: 15facbd7bd3dbfa04721cb71e69954eb4686cb9e
---->8----

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iyqdb55itbghrjyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXoJrsACgkQj4D7WH0S
/k4dpAf/S1rWn4jV3PACJnwgcKd7Slhc18YY7FMyqrmXXVScL6Geh1ua+HD/rMiE
dAfgvBPgnpuggzm3K8AkyzNmY3ZRIf1poCPiGUhcG1+G1WxqBaqWsY+dnsbh1pFD
eoBKrZW1ssk7n1njzCZGspmI2samHJFHyUR6LVzhqsJZpKlW1fgknJQ4OhoSvDHf
iE3W6I1r9g7960HEFP7q9BrRLFymEo49Qpi+bnpLqGApZx8IA25aA0GTzyvRUBGk
yPd6mTo6heCLL6kbsK2juH5sigLJGEDLUXVYWQA0y15zNb8xgnlMJy+bE5B2vv1b
fHWuQd1kDchYrNeMiAGHytbXM/jQ5g==
=Aflk
-----END PGP SIGNATURE-----

--iyqdb55itbghrjyl--

