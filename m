Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E7618AA8
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Nov 2022 22:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKCVf5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Nov 2022 17:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKCVf5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Nov 2022 17:35:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640BD1EEFE
        for <linux-pwm@vger.kernel.org>; Thu,  3 Nov 2022 14:35:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oqhsO-00029v-W0; Thu, 03 Nov 2022 22:35:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oqhsO-002948-RS; Thu, 03 Nov 2022 22:35:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oqhsN-00ED6u-7O; Thu, 03 Nov 2022 22:35:51 +0100
Date:   Thu, 3 Nov 2022 22:35:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2 2/2] pwm: tegra: Ensure the clock rate is not less
 than needed
Message-ID: <20221103213551.vmzzthnrv5anbdqx@pengutronix.de>
References: <20221028123356.133796-1-jonathanh@nvidia.com>
 <20221028123356.133796-2-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rxuvcnaa3ksdnfkz"
Content-Disposition: inline
In-Reply-To: <20221028123356.133796-2-jonathanh@nvidia.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rxuvcnaa3ksdnfkz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 01:33:56PM +0100, Jon Hunter wrote:
> When dynamically scaling the PWM clock, the function
> dev_pm_opp_set_rate() may set the PWM clock to a rate that is lower than
> what is required. The clock rate requested when calling
> dev_pm_opp_set_rate() is the minimum clock rate that is needed to drive
> the PWM to achieve the required period. Hence, if the actual clock
> rate is less than the requested clock rate, then the required period
> cannot be achieved and configuring the PWM fails. Fix this by
> calling clk_round_rate() to check if the clock rate that will be provided
> is sufficient and if not, double the required clock rate to ensure the
> required period can be attained.
>=20
> Fixes: 8c193f4714df ("pwm: tegra: Optimize period calculation")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V1:
> - Multiplied the required_clk_rate by 2 instead of adding 1 to the
>   PWM_DUTY_WIDTH and recalculating the rate. Overall rate should be
>   similar.
> - Updated comment based upon Uwe's feedback.
>=20
>  drivers/pwm/pwm-tegra.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index b05ea2e8accc..6fc4b69a3ba7 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -148,6 +148,17 @@ static int tegra_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  		required_clk_rate =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC << PWM_DUTY_WIDTH,
>  						     period_ns);
> =20
> +		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
> +			/*
> +			 * required_clk_rate is a lower bound for the input
> +			 * rate; for lower rates there is no value for PWM_SCALE
> +			 * that yields a period less than or equal to the
> +			 * requested period. Hence, for lower rates, double the
> +			 * required_clk_rate to get a clock rate that can meet
> +			 * the requested period.
> +			 */
> +			required_clk_rate *=3D 2;

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

> +
>  		err =3D dev_pm_opp_set_rate(pc->dev, required_clk_rate);
>  		if (err < 0)
>  			return -EINVAL;
> --=20
> 2.25.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rxuvcnaa3ksdnfkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNkNDQACgkQwfwUeK3K
7Akv+Qf/Y+YEicwDSPuhZRAp+fjlVppNhhHADYuoWNBiRauJZjhLeUouqCb0XENM
63ehlTupXllb2xyZaZBKUzJT3EWoTDP93mO/Dv+Y16EmL2tWQeOdsF/idDTilP/p
+AZazWMF60zUKgT4hHNsRB0//HgHE30PLOv5BOVyWaQtyPcfY7wtCNBhmam8BNyT
t16l79KVzpJU/5kKDqN4YSM2X2c9BZN/sDDTrwxwZ/1j1hw+HDQo+fgLd24N/326
Hgn1vRFNJnCDD4D8IFLK/ZvFfdt7RCtOixiDKAypw+Yrbi+M8PdCJj1kEmQls8xh
A+d2pX6XE9icdmU/9S2ej8t5z9p1cw==
=vEGo
-----END PGP SIGNATURE-----

--rxuvcnaa3ksdnfkz--
