Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80AB271CC7
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Sep 2020 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIUIBv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Sep 2020 04:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIUIB2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2020 04:01:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C05C061755
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2020 01:01:28 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKGlJ-0006CM-6Y; Mon, 21 Sep 2020 10:01:25 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKGlH-0004UL-EX; Mon, 21 Sep 2020 10:01:23 +0200
Date:   Mon, 21 Sep 2020 10:01:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, heiko@sntech.de,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] pwm: rockchip: Keep enabled PWMs running while probing
Message-ID: <20200921080123.fvwbd4rdjrgzifr3@pengutronix.de>
References: <20200919193306.1023-1-simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="25hnzogx6ln72w4r"
Content-Disposition: inline
In-Reply-To: <20200919193306.1023-1-simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--25hnzogx6ln72w4r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Sep 19, 2020 at 03:33:06PM -0400, Simon South wrote:
> Following commit cfc4c189bc70 ("pwm: Read initial hardware state at
> request time") the Rockchip PWM driver can no longer assume a device's
> pwm_state structure has been populated after a call to pwmchip_add().
> Consequently, the test in rockchip_pwm_probe() intended to prevent the
> driver from stopping PWM devices already enabled by the bootloader no
> longer functions reliably and this can lead to the kernel hanging
> during startup, particularly on devices like the Pinebook Pro that use
> a PWM-controlled backlight for their display.
>=20
> Avoid this by querying the device directly at probe time to determine
> whether or not it is enabled.
>=20
> Fixes: cfc4c189bc70 ("pwm: Read initial hardware state at request time")
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>  drivers/pwm/pwm-rockchip.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index eb8c9cb645a6..098e94335cb5 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -288,6 +288,7 @@ static int rockchip_pwm_probe(struct platform_device =
*pdev)
>  	const struct of_device_id *id;
>  	struct rockchip_pwm_chip *pc;
>  	struct resource *r;
> +	u32 enable_conf, ctrl;
>  	int ret, count;
> =20
>  	id =3D of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
> @@ -362,7 +363,9 @@ static int rockchip_pwm_probe(struct platform_device =
*pdev)
>  	}
> =20
>  	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
> -	if (!pwm_is_enabled(pc->chip.pwms))
> +	enable_conf =3D pc->data->enable_conf;
> +	ctrl =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
> +	if ((ctrl & enable_conf) !=3D enable_conf)
>  		clk_disable(pc->clk);

In my book a pwm driver should never call pwm_get_state() (or its
wrappers).

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I looked at the other drivers for similar problems. I found a few
issues, but they are all independently of cfc4c189bc70:

 - pwm-lpc18xx-sct.c does some allocation that the .request
   callback depends on. pwm-sti.c does allocation that the irq handler
   depends on quite late.
 - some drivers modify the hardware after pwmchip_add()
   [pwm-fsl-ftm.c, pwm-hibvt.c, pwm-lpc18xx-sct.c, pwm-lpc32xx.c,
   pwm-mtk-disp.c, pwm-mxs.c]
 - pwm-lpss.c, pwm-pca9685.c, pwm-tiehrpwm.c and cpwm-tiecap.c do some
   pm_runtime stuff which should better be done before pwmchip_add()?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--25hnzogx6ln72w4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9oXdAACgkQwfwUeK3K
7AlUoQf/ZJ5MPEOdaNm0UZ0bmGHnJdtHpmVCLh3Y5maRysokpMJv6TzrmMwMqAgc
1ufkN7Yjimh/RqleY6fZRXMocoU7WE08tzqnOFfRvryd+MV+NUkGFh7FfsI6rVnC
ZK6+9PvPLQAdBgNT8HX5eyzOT8fwLqxwDffenXX9ZtTAJ4Lan28q9V+f0b7oRwBV
y53n3B6Unf6MVjFo7d9dgdzj0ObH1QzzV8oMe+Ux+zYkYyfPai9sprXf8rGknbpm
AIm6IrSfshNTLyexusDQBlFuhGjf0UBnlR0DqEcwaE4ZBOPsC1k//cSaMr6kS4Os
ZaXpGdLu0L4/v5oXB2ILttvjG5L7RA==
=+jZM
-----END PGP SIGNATURE-----

--25hnzogx6ln72w4r--
