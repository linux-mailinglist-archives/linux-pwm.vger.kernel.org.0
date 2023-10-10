Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46907BF53E
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 10:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjJJIFT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 04:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjJJIFS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 04:05:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B20194
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 01:05:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7jr-0002ki-PY; Tue, 10 Oct 2023 10:05:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7jo-000bnS-TB; Tue, 10 Oct 2023 10:05:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7jo-00CwKl-I1; Tue, 10 Oct 2023 10:05:08 +0200
Date:   Tue, 10 Oct 2023 10:05:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     linux-pwm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <20231010080508.7ssnroaefyaeeedd@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
 <ZLeX4UbFaY592HIa@orome>
 <20230725211004.peqxxb4y3j62gmnp@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2v7573bgeyansjlt"
Content-Disposition: inline
In-Reply-To: <20230725211004.peqxxb4y3j62gmnp@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2v7573bgeyansjlt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Saravana,

you were pointed out to me as the expert for device links. I found a
problem with these.

On Tue, Jul 25, 2023 at 11:10:04PM +0200, Uwe Kleine-K=F6nig wrote:
> Today I managed to trigger the problem I intend to address with this
> series. My machine to test this on is an stm32mp157. To be able to
> trigger the problem reliably I applied the following patches on top of
> v6.5-rc1:
>=20
>  - pwm: stm32: Don't modify HW state in .remove() callback
>    This is a cleanup that I already sent out.
>    https://lore.kernel.org/r/20230713155142.2454010-2-u.kleine-koenig@pen=
gutronix.de
>    The purpose for reproducing the problem is to not trigger further
>    calls to the apply callback.
>=20
>  - The following patch:
>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 687967d3265f..c7fc02b0fa3c 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -451,6 +451,10 @@ static int stm32_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
>  	int ret;
> =20
> +	dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> +	msleep(5000);
> +	dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> +
>  	enabled =3D pwm->state.enabled;
> =20
>  	if (enabled && !state->enabled) {
> @@ -650,7 +654,11 @@ static void stm32_pwm_remove(struct platform_device =
*pdev)
>  {
>  	struct stm32_pwm *priv =3D platform_get_drvdata(pdev);
> =20
> +	dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
>  	pwmchip_remove(&priv->chip);
> +	dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> +
> +	priv->regmap =3D NULL;
>  }
> =20
>  static int __maybe_unused stm32_pwm_suspend(struct device *dev)
>=20
> The first hunk is only there to widen the race window. The second is to
> give some diagnostics and make stm32_pwm_apply() crash if it continues
> to run after the msleep. (Without it it didn't crash reproducibly, don't
> understand why. *shrug*)
>=20
> The device tree contains a pwm-fan device making use of one of the PWMs.
>=20
> Now I do the following:
>=20
> 	echo fan > /sys/bus/platform/drivers/pwm-fan/unbind & sleep 1; echo 4000=
7000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unbind
>=20
> Unbinding the fan device has two effects:
>=20
>  - The device link between fan and pwm looses its property to unbind fan
>    when pwm gets unbound.
>    (Its .status changes from DL_STATE_ACTIVE to DL_STATE_AVAILABLE)
>  - It calls pwm_fan_cleanup() which triggers a call to
>    pwm_apply_state().
>=20
> So when the pwm device gets unbound the first thread is sleeping in
> stm32_pwm_apply(). The driver calls pwmchip_remove() and sets
> priv->regmap to NULL. Then a few seconds later the first thread wakes up
> in stm32_pwm_apply() with the chip freed and priv->regmap =3D NULL. Bang!
>=20
> This looks as follows:
>=20
> root@crown:~# echo fan > /sys/bus/platform/drivers/pwm-fan/unbind & sleep=
 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unbind
> [  187.182113] stm32-pwm 40007000.timer:pwm: stm32_pwm_apply:454
> [  188.164769] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:657
> [  188.184555] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:659
> root@crown:~# [  192.236423] platform 40007000.timer:pwm: stm32_pwm_apply=
:456
> [  192.240727] 8<--- cut here ---
> [  192.243759] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000001c when read
> ...
>=20
> Even without the crash you can see that stm32_pwm_apply() is still
> running after pwmchip_remove() completed.
>=20
> I'm unsure if the device link could be improved here to ensure that the
> fan is completely unbound even if it started unbinding already before
> the pwm device gets unbound. (And if it could, would this fit the device
> links purpose and so be a sensible improvement?)

While I think that there is something to be done in the pwm core that
this doesn't explode (i.e. do proper lifetime tracking such that a
pwm_chip doesn't disappear while still being used---and I'm working on
that) I expected that the device links between pwm consumer and provider
would prevent the above described oops, too. But somehow the fan already
going away (but still using the PWM) when the PWM is unbound, results in
the PWM disappearing before the fan is completely gone.

Is this expected, or a problem that can (and should?) be fixed?

If you need more context or a tester, don't hesitate to ask.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2v7573bgeyansjlt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUlBbMACgkQj4D7WH0S
/k6NEQgArmewhE1zHKqUoOYsBk/kRX7lq2dvOfjV/K2syo52ANXYP6jPVnYXE0C8
eAdZ9O9CxIeY6pMoSPVVtck7ykTHn3n3Umrm4Ifeopi4b/KbbVpmtVTH0hswNYtC
0PDtVsCmWiCd97a+2p5HDwP880vYoxOc2Lc5zVG8QyAq0zHdEa2M4tCKCHLWaiF2
otovwT5mhE3CJc3IUDldYXt7laNldLxlkPoRmYU3TXXbLfw5E3PJO4QV9GkECOV3
j2LkhB8dT5Wx0Nyq6QYdNSVxwwrq0JZJ9ALCWJ2WHNSk7/V5V5y6wxZYRtvjeDzA
Jn9xPT09+0bctPCqfCwQzNn2c7dDRQ==
=gOEm
-----END PGP SIGNATURE-----

--2v7573bgeyansjlt--
