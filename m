Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB070002F
	for <lists+linux-pwm@lfdr.de>; Fri, 12 May 2023 08:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjELGWe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 May 2023 02:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjELGWe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 May 2023 02:22:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736ED3588
        for <linux-pwm@vger.kernel.org>; Thu, 11 May 2023 23:22:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxMAg-0006Ze-Bf; Fri, 12 May 2023 08:22:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxMAe-002u70-95; Fri, 12 May 2023 08:22:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxMAd-003dMQ-I8; Fri, 12 May 2023 08:22:27 +0200
Date:   Fri, 12 May 2023 08:22:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-pwm@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] pwm: core: Permit unset period when applying
 configuration of disabled PWMs
Message-ID: <20230512062227.5buu6mhgxajvjhqf@pengutronix.de>
References: <20230511181853.185685-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oaui27mfp76xtwk2"
Content-Disposition: inline
In-Reply-To: <20230511181853.185685-1-marex@denx.de>
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


--oaui27mfp76xtwk2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marek,

On Thu, May 11, 2023 at 08:18:53PM +0200, Marek Vasut wrote:
> In case the PWM is not enabled, the period can still be left unconfigured,
> i.e. zero . Currently the pwm_class_apply_state() errors out in such a ca=
se.
> This e.g. makes suspend fail on systems where pwmchip has been exported v=
ia
> sysfs interface, but left unconfigured before suspend occurred.
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
> Permit unset period in pwm_class_apply_state() in case the PWM is disabled
> to fix this issue.
>=20
> Fixes: ef2bf4997f7d ("pwm: Improve args checking in pwm_apply_state()")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-pwm@vger.kernel.org
> ---
>  drivers/pwm/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 3dacceaef4a9b..87252b70f1c81 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -510,8 +510,8 @@ int pwm_apply_state(struct pwm_device *pwm, const str=
uct pwm_state *state)
>  	 */
>  	might_sleep();
> =20
> -	if (!pwm || !state || !state->period ||
> -	    state->duty_cycle > state->period)
> +	if (!pwm || !state || (state->enabled &&
> +	    (!state->period || state->duty_cycle > state->period)))

While I tend to agree that the checks about period and duty_cycle are
(somewhat) irrelevant if enabled =3D=3D false, I fear we'd break assumptions
here as some drivers configure duty_cycle/period in hardware even with
=2Eenabled =3D=3D false, and so proably rely on period > 0 and duty_cycle <=
=3D
period.

Another approach would be to skip pwm_apply_state() in
pwm_class_suspend() if the state is already disabled. That one sounds
safer.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oaui27mfp76xtwk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRd2yIACgkQj4D7WH0S
/k4OOAgAoGpgdOHuUSl+OMzsN/+WGZBnkiLNPn7+8DCF33X3YlGxBolrqoDqSc1G
nJjYyMT6+wGetec/CfP4iyTUtpNUFar0eCCZdhWQ70lhLYXYMoG4gPHMjDY4++cI
OmNyC0U3EOEDghR5r0ObUNiIJ17qThwvPQtGMpdyzwNsuiIiYtsMQWyUFRxBKBhP
ymBbgOqQCCJItixWqccTF1R/Zbo40Y7pNnVa54PBc2rwPxqiO7ma4b1BRgKaHwci
1QED7rzaPmV9x3i1apoHeRJxgOSbi/i+QMXcfDzuFab+NvzLieHfvERgruqokEtE
OwyiSYuHOO7BEOkaSPjqpvIxQzCVtA==
=SOry
-----END PGP SIGNATURE-----

--oaui27mfp76xtwk2--
