Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D808143DFD0
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Oct 2021 13:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJ1LSW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Oct 2021 07:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1LSW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Oct 2021 07:18:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC3EC061570
        for <linux-pwm@vger.kernel.org>; Thu, 28 Oct 2021 04:15:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mg3Nl-0006KA-0k; Thu, 28 Oct 2021 13:15:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mg3Ng-0002Rz-44; Thu, 28 Oct 2021 13:15:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mg3Ng-00041g-2p; Thu, 28 Oct 2021 13:15:36 +0200
Date:   Thu, 28 Oct 2021 13:15:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>, lkp@intel.com,
        mchehab@kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
References: <YXlxhpZWf2mxJaMi@fedora>
 <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
 <20211028091442.GA16514@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gairqvahdkp57zyj"
Content-Disposition: inline
In-Reply-To: <20211028091442.GA16514@gofer.mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gairqvahdkp57zyj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Thu, Oct 28, 2021 at 10:14:42AM +0100, Sean Young wrote:
> On Thu, Oct 28, 2021 at 08:45:13AM +0200, Uwe Kleine-K=F6nig wrote:
> > The conversion is right (I think),
>=20
> We still have the problem that the pwm drivers calculate the period
> incorrectly by rounding down (except pwm-bcm2835). So the period is not
> as good as it could be in most cases, but this driver can't do anything
> about that.

Yeah, some time ago I started coding a round_state function
(wip at
https://git.pengutronix.de/cgit/ukl/linux/commit/?h=3Dpwm-wip&id=3Dae348eb6=
a55d6526f30ef4a49819197d9616391e)
but this was pushed down on my todo-list by more important stuff.

If you want to experiment with that ...

> > note this could be optimized a bit
> > further: state.period only depends on carrier which rarely changes, so
> > the calculation could be done in pwm_ir_set_carrier(). Ditto for duty
> > which only depends on state.period and pwm_ir->duty_cycle. (This is for
> > a separate commit though.)
>=20
> I'm not sure what caching this is much of a win. The calculation is a few
> instructions, so you're not winning in the way of speed. On the flip side
> you use more memory since pwm_state has to be kmalloc() rather than exist=
ing

I tested a bit with this patch on top of Ma=EDra's:

	diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
	index 105a9c24f1e3..7585c21775bc 100644
	--- a/drivers/media/rc/pwm-ir-tx.c
	+++ b/drivers/media/rc/pwm-ir-tx.c
	@@ -17,7 +17,7 @@
	=20
	 struct pwm_ir {
		struct pwm_device *pwm;
	-	unsigned int carrier;
	+	struct pwm_state state;
		unsigned int duty_cycle;
	 };
	=20
	@@ -32,6 +32,7 @@ static int pwm_ir_set_duty_cycle(struct rc_dev *dev, u32=
 duty_cycle)
		struct pwm_ir *pwm_ir =3D dev->priv;
	=20
		pwm_ir->duty_cycle =3D duty_cycle;
	+	pwm_set_relative_duty_cycle(&pwm_ir->state, pwm_ir->duty_cycle, 100);
	=20
		return 0;
	 }
	@@ -43,7 +44,8 @@ static int pwm_ir_set_carrier(struct rc_dev *dev, u32 ca=
rrier)
		if (!carrier)
			return -EINVAL;
	=20
	-	pwm_ir->carrier =3D carrier;
	+	pwm_ir->state.period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, carrier);
	+	pwm_set_relative_duty_cycle(&pwm_ir->state, pwm_ir->duty_cycle, 100);
	=20
		return 0;
	 }
	@@ -53,21 +55,15 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int =
*txbuf,
	 {
		struct pwm_ir *pwm_ir =3D dev->priv;
		struct pwm_device *pwm =3D pwm_ir->pwm;
	-	struct pwm_state state;
		int i;
		ktime_t edge;
		long delta;
	=20
	-	pwm_init_state(pwm, &state);
	-
	-	state.period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
	-	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
	-
		edge =3D ktime_get();
	=20
		for (i =3D 0; i < count; i++) {
	-		state.enabled =3D !(i % 2);
	-		pwm_apply_state(pwm, &state);
	+		pwm_ir->state.enabled =3D !(i % 2);
	+		pwm_apply_state(pwm, &pwm_ir->state);
	=20
			edge =3D ktime_add_us(edge, txbuf[i]);
			delta =3D ktime_us_delta(edge, ktime_get());
	@@ -75,8 +71,8 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *t=
xbuf,
				usleep_range(delta, delta + 10);
		}
	=20
	-	state.enabled =3D false;
	-	pwm_apply_state(pwm, &state);
	+	pwm_ir->state.enabled =3D false;
	+	pwm_apply_state(pwm, &pwm_ir->state);
	=20
		return count;
	 }
	@@ -95,8 +91,9 @@ static int pwm_ir_probe(struct platform_device *pdev)
		if (IS_ERR(pwm_ir->pwm))
			return PTR_ERR(pwm_ir->pwm);
	=20
	-	pwm_ir->carrier =3D 38000;
	-	pwm_ir->duty_cycle =3D 50;
	+	pwm_ir->state.duty_cycle =3D 50;
	+	pwm_init_state(pwm_ir->pwm, &pwm_ir->state);
	+	pwm_ir_set_carrier(rcdev, 38000);
	=20
		rcdev =3D devm_rc_allocate_device(&pdev->dev, RC_DRIVER_IR_RAW_TX);
		if (!rcdev)

bloat-o-meter reports (for an arm allmodconfig build)

	add/remove: 0/0 grow/shrink: 3/1 up/down: 644/-396 (248)
	Function                                     old     new   delta
	pwm_ir_probe                                 372     676    +304
	pwm_ir_set_carrier                           108     292    +184
	pwm_ir_set_duty_cycle                         68     224    +156
	pwm_ir_tx                                    908     512    -396
	Total: Before=3D2302, After=3D2550, chg +10.77%

struct pwm_ir increases from 12 bytes to 40 bytes.

The stack space required by pwm_ir_tx decreases from 60 to 36

I don't know exactly how kmalloc works internally. Maybe allocating a
structure of size 40 bytes doesn't need more memory than a structure of
size 12?

I didn't check how runtimes change, but the size decrease of pwm_ir_tx()
is nice and might save a bit of runtime.

Probably it depends on your focus if this change is good for you or not.

> just on the stack, and both ioctl handlers and the probe function need to
> recalculate the period/duty cycle, so there is a slight increase in code =
size.
>=20
> This change does not improve anything measurably and only increases code
> complexity.

You did measure?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gairqvahdkp57zyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF6hlQACgkQwfwUeK3K
7AlKtwf9H5aw8l3EXGUcjZhfwd8EYuoy+PO1ri2AL13Q9N1wUHR7f+qJNX0ltBh1
VFSdscpayWWZD5fcjWYZljPFemWuSN/2j4lw/gTCghoO0Wy6EbyNBX0cSFEcQdm4
Q1RnsbmrJnHdn9U4CiaOxrHI8MwlsbIy5vebdzLBqUTgGAV/yPXhxJ1EOMj2HE3a
xzfWBQJ8V6Mj57iZjWwluoGD4SkfxDQxTz815ZPeQ04E6W3eRDrBY102Ao8lJas7
WR1zN5r2z+vrN0zHWdYmgojaqPw0HfRWWIWVVk9GdxjPkJ2HF8F0h5Se9CzLp9ib
ekSOh4JKwrxxSo9GwN6tpNJc/yqHWg==
=MAUv
-----END PGP SIGNATURE-----

--gairqvahdkp57zyj--
