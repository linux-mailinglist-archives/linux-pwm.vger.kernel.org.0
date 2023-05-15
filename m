Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C830C702F59
	for <lists+linux-pwm@lfdr.de>; Mon, 15 May 2023 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjEOOOk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 May 2023 10:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbjEOOOk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 May 2023 10:14:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E2A19B0
        for <linux-pwm@vger.kernel.org>; Mon, 15 May 2023 07:14:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyYyD-0005lx-6M; Mon, 15 May 2023 16:14:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyYyB-000O7e-Dt; Mon, 15 May 2023 16:14:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyYyA-004iNH-Hl; Mon, 15 May 2023 16:14:34 +0200
Date:   Mon, 15 May 2023 16:14:34 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-pwm@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] pwm: sysfs: Do not apply state to already disabled PWMs
Message-ID: <20230515141434.q46qbmj4dmsnylqp@pengutronix.de>
References: <20230512164736.53615-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxcz5gnny4zhlkaa"
Content-Disposition: inline
In-Reply-To: <20230512164736.53615-1-marex@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--uxcz5gnny4zhlkaa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marek,

On Fri, May 12, 2023 at 06:47:36PM +0200, Marek Vasut wrote:
> If the PWM is exported but not enabled, do not call pwm_class_apply_state=
().
> First of all, in this case, period may still be unconfigured and this wou=
ld
> make pwm_class_apply_state() return -EINVAL, and then suspend would fail.
> Second, it makes little sense to apply state onto PWM that is not enabled
> before suspend.
>=20
> Failing case:
> "
> $ echo 1 > /sys/class/pwm/pwmchip4/export
> $ echo mem > /sys/power/state
> ...
> pwm pwmchip4: PM: dpm_run_callback(): pwm_class_suspend+0x1/0xa8 returns =
-22
> pwm pwmchip4: PM: failed to suspend: error -22
> PM: Some devices failed to suspend, or early wake event detected
> "
>=20
> Working case:
> "
> $ echo 1 > /sys/class/pwm/pwmchip4/export
> $ echo 100 > /sys/class/pwm/pwmchip4/pwm1/period
> $ echo 10 > /sys/class/pwm/pwmchip4/pwm1/duty_cycle
> $ echo mem > /sys/power/state
> ...
> "
>=20
> Do not call pwm_class_apply_state() in case the PWM is disabled
> to fix this issue.
>=20
> Fixes: 7fd4edc57bbae ("pwm: sysfs: Add suspend/resume support")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-pwm@vger.kernel.org
> ---
>  drivers/pwm/sysfs.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 1a106ec329392..8d1254761e4dd 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -424,6 +424,13 @@ static int pwm_class_resume_npwm(struct device *pare=
nt, unsigned int npwm)
>  		if (!export)
>  			continue;
> =20
> +		/* If pwmchip was not enabled before suspend, do nothing. */
> +		if (!export->suspend.enabled) {
> +			/* release lock taken in pwm_class_get_state */
> +			mutex_unlock(&export->lock);
> +			continue;
> +		}
> +
>  		state.enabled =3D export->suspend.enabled;
>  		ret =3D pwm_class_apply_state(export, pwm, &state);
>  		if (ret < 0)
> @@ -448,7 +455,17 @@ static int pwm_class_suspend(struct device *parent)
>  		if (!export)
>  			continue;
> =20
> +		/*
> +		 * If pwmchip was not enabled before suspend, save
> +		 * state for resume time and do nothing else.
> +		 */
>  		export->suspend =3D state;
> +		if (!state.enabled) {
> +			/* release lock taken in pwm_class_get_state */
> +			mutex_unlock(&export->lock);
> +			continue;
> +		}
> +
>  		state.enabled =3D false;
>  		ret =3D pwm_class_apply_state(export, pwm, &state);
>  		if (ret < 0) {

The locking and code flow in these functions is really ugly. I see
several patch opportunities here ...

Anyhow, these are orthogonal to your patch which looks good.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uxcz5gnny4zhlkaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRiPkkACgkQj4D7WH0S
/k4oxgf+LAxzyveeWMQV6hoO2gObPTGv1qkzYHhAgmC/LLdfDxvFPnN9Uz9wuBDx
yhIRKXP7f+dXqXk7Jq88C5VK4eICaKQ1HBDkzXm8hOxk6Ri+FfEuLe7kJQLVngJt
PD8tS/OCY/zGbzH0s5nNpLepOsA5iQKFrU8cYoe3yI0wT1kwYsO201TSq4xlDDof
iTPv7Zf2FVOhC4CfBaDAH1GZudgxlo0NymNMIPRxXMZp9DVLBwGnPiVeP8gj/eMM
9o8iijz7A34amIUvu71zCMZB//4FL56WXrxlhpQfpWM18QagF3SRtH3rzY7migsN
kWOhzrsSzDafEd590DqgY0k3YKMCZQ==
=kEQ+
-----END PGP SIGNATURE-----

--uxcz5gnny4zhlkaa--
