Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C778762425
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jul 2023 23:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGYVK3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jul 2023 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjGYVK2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jul 2023 17:10:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFB919A4
        for <linux-pwm@vger.kernel.org>; Tue, 25 Jul 2023 14:10:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOPIN-0003un-TK; Tue, 25 Jul 2023 23:10:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOPII-0025cV-IU; Tue, 25 Jul 2023 23:10:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOPIH-007lq2-O2; Tue, 25 Jul 2023 23:10:09 +0200
Date:   Tue, 25 Jul 2023 23:10:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <20230725211004.peqxxb4y3j62gmnp@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
 <ZLeX4UbFaY592HIa@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lbja7j2q6q4txaou"
Content-Disposition: inline
In-Reply-To: <ZLeX4UbFaY592HIa@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lbja7j2q6q4txaou
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 09:59:29AM +0200, Thierry Reding wrote:
> On Tue, Jul 18, 2023 at 08:18:32PM +0200, Uwe Kleine-K=F6nig wrote:
> > This function allocates a struct pwm_chip and driver data. Compared to
> > the status quo the split into pwm_chip and driver data is new, otherwise
> > it doesn't change anything relevant (yet).
> >=20
> > The intention is that after all drivers are switched to use this
> > allocation function, its possible to add a struct device to struct
> > pwm_chip to properly track the latter's lifetime without touching all
> > drivers again. Proper lifetime tracking is a necessary precondition to
> > introduce character device support for PWMs (that implements atomic
> > setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
> > userspace support).
> >=20
> > The new function pwmchip_priv() (obviously?) only works for chips
> > allocated with devm_pwmchip_alloc().
>=20
> If this is supposed to be similar to the GPIO chardev, why doesn't GPIO
> require this way of allocating a struct gpio_chip? I'm not a fan of
> doing all this upfront work without seeing where this is ultimately
> headed. Please hold off on reworking everything until you have a
> complete proposal that can be reviewed in full.

I'm working on that and already have a patch stack with more than 100
patches, many of them are cleanups that I found while working on each
PWM driver (most of these are already posted to the linux-pwm list). The
biggest part is to convert each of the 50+ pwm drivers to
pwmchip_alloc().

Today I managed to trigger the problem I intend to address with this
series. My machine to test this on is an stm32mp157. To be able to
trigger the problem reliably I applied the following patches on top of
v6.5-rc1:

 - pwm: stm32: Don't modify HW state in .remove() callback
   This is a cleanup that I already sent out.
   https://lore.kernel.org/r/20230713155142.2454010-2-u.kleine-koenig@pengu=
tronix.de
   The purpose for reproducing the problem is to not trigger further
   calls to the apply callback.

 - The following patch:

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 687967d3265f..c7fc02b0fa3c 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -451,6 +451,10 @@ static int stm32_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 	struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
 	int ret;
=20
+	dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
+	msleep(5000);
+	dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
+
 	enabled =3D pwm->state.enabled;
=20
 	if (enabled && !state->enabled) {
@@ -650,7 +654,11 @@ static void stm32_pwm_remove(struct platform_device *p=
dev)
 {
 	struct stm32_pwm *priv =3D platform_get_drvdata(pdev);
=20
+	dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
 	pwmchip_remove(&priv->chip);
+	dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
+
+	priv->regmap =3D NULL;
 }
=20
 static int __maybe_unused stm32_pwm_suspend(struct device *dev)

The first hunk is only there to widen the race window. The second is to
give some diagnostics and make stm32_pwm_apply() crash if it continues
to run after the msleep. (Without it it didn't crash reproducibly, don't
understand why. *shrug*)

The device tree contains a pwm-fan device making use of one of the PWMs.

Now I do the following:

	echo fan > /sys/bus/platform/drivers/pwm-fan/unbind & sleep 1; echo 400070=
00.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unbind

Unbinding the fan device has two effects:

 - The device link between fan and pwm looses its property to unbind fan
   when pwm gets unbound.
   (Its .status changes from DL_STATE_ACTIVE to DL_STATE_AVAILABLE)
 - It calls pwm_fan_cleanup() which triggers a call to
   pwm_apply_state().

So when the pwm device gets unbound the first thread is sleeping in
stm32_pwm_apply(). The driver calls pwmchip_remove() and sets
priv->regmap to NULL. Then a few seconds later the first thread wakes up
in stm32_pwm_apply() with the chip freed and priv->regmap =3D NULL. Bang!

This looks as follows:

root@crown:~# echo fan > /sys/bus/platform/drivers/pwm-fan/unbind & sleep 1=
; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unbind
[  187.182113] stm32-pwm 40007000.timer:pwm: stm32_pwm_apply:454
[  188.164769] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:657
[  188.184555] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:659
root@crown:~# [  192.236423] platform 40007000.timer:pwm: stm32_pwm_apply:4=
56
[  192.240727] 8<--- cut here ---
[  192.243759] Unable to handle kernel NULL pointer dereference at virtual =
address 0000001c when read
=2E..

Even without the crash you can see that stm32_pwm_apply() is still
running after pwmchip_remove() completed.

I'm unsure if the device link could be improved here to ensure that the
fan is completely unbound even if it started unbinding already before
the pwm device gets unbound. (And if it could, would this fit the device
links purpose and so be a sensible improvement?)

If not, the only possible other fix is to make sure that the pwm
callbacks are serialized with pwmchip_remove() and stop calling the
driver callbacks when pwmchip_remove() was called. For that the
pwm_chip struct must stay around until all consumers are really gone. So
the pwm_chip must not be allocated using devm_kzalloc for the pwm's
parent device.

Am I missing something? Is this good enough to convince you that we need
the concept of devm_pwmchip_alloc() from this thread?

My preferred way to continue fixing that would be to get all the
preparing cleanups into next soon to keep my patch stack smaller.
Another pre-condition to serializing the pwm callbacks is (I think) that
all low-level drivers must be fixed to not call pwm-API functions[1].

Then I'll prepare switching all drivers based on this series plus some
more patches to introduce a struct device in struct gpio_chip to track
the lifetime and eventually fix the issue demonstrated above.

While addressing this issue isn't a hard requirement for my final plan
to introduce /dev/pwmchip character devices, fixing it now before the
pwm core is complicated with the character device code should be easier
at least. (Also these character devices introduce another "user" of
pwm_chips and so another reason that these shouldn't be allocated using
devm_kzalloc.)

Best regards
Uwe

[1] first approximation:

	$ git grep -Ew 'pwm_(apply|get_state|is_enabled|set_period|get_period|[sg]=
et_duty_cycle|get_polarity|enable|disable)' v6.5-rc1 -- drivers/pwm/pwm-*.c=
 | wc -l
	43

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lbja7j2q6q4txaou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTAOiwACgkQj4D7WH0S
/k58Fgf7BWV6pk5FT045rf4yFD4sn1UYpbD3qoPthfdP7GyKsRcef6m7GOXTR/bP
k1oF2x45Wv4OTeIg9mFBW3WXG01hOBcMDHyJcuJZ0sWot2fmlJ6EYrqTE5AKiIk6
I42C2/nzGS4UZZrgQy9I7tmcHBHnGRSSWVYRXGAx2qurJ8bg6C3YI/bWLXBOUsq3
d0rCQ8J0nmJfESXTBxxXyeZW21q4Zi4Q9cV4PsgMYnwCAZJrRwkLni56qTOMtvki
CkS+r4g/6uAEeigOcmIcc0ZbWvBZbtVHzCEvBJjI8/6SpvYqe9KyceX+MXbgAEAV
UaDNpeRqPxOYSnmtyulC5+cdf8bFTw==
=7ktW
-----END PGP SIGNATURE-----

--lbja7j2q6q4txaou--
