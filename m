Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E514C6C8C88
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Mar 2023 09:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCYIUN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 Mar 2023 04:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCYIUM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Mar 2023 04:20:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6221316AD9
        for <linux-pwm@vger.kernel.org>; Sat, 25 Mar 2023 01:20:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfz8A-0005n5-VZ; Sat, 25 Mar 2023 09:20:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfz8A-006ZY1-AM; Sat, 25 Mar 2023 09:20:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfz89-007phI-Fs; Sat, 25 Mar 2023 09:20:05 +0100
Date:   Sat, 25 Mar 2023 09:20:04 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH] pwm: meson: add support for S4 chip family
Message-ID: <20230325082004.q7suqrt2udzgq4mb@pengutronix.de>
References: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cbcddztjwsr2blmi"
Content-Disposition: inline
In-Reply-To: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cbcddztjwsr2blmi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 24, 2023 at 11:23:09PM +0100, Heiner Kallweit wrote:
> This adds pwm support for (at least) the s4 chip family. The extension
> is based on the vendor driver that can be found at [0]. There the
> version with the new clock handling is called meson-v2-pwm.
> Central change is that the clock is now fully provided by the SoC clock
> core. The multiplexer isn't any longer part of the pwm block.
>=20
> This was tested on a sc2-based system that uses the same pwm block.
>=20
> [0] https://github.com/khadas/linux/blob/khadas-vims-5.4.y/drivers/pwm/pw=
m-meson.c
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> Adding the amlogic,meson-s4-pwm compatible to the documentation was part
> of the yaml conversion already.

This refers to
https://lore.kernel.org/linux-pwm/3edc5ba6-bf3d-e45b-377a-9e7ece7642a7@gmai=
l.com

Does the external mux clk behave in the same way as the internal ones
before? (I.e. it can select one of a few parents and has a single
divider?)

> ---
>  drivers/pwm/pwm-meson.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 16d79ca5d..7a93fdada 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -98,6 +98,7 @@ struct meson_pwm_channel {
>  struct meson_pwm_data {
>  	const char * const *parent_names;
>  	unsigned int num_parents;
> +	unsigned int ext_clk:1;
>  };
> =20
>  struct meson_pwm {
> @@ -158,6 +159,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, st=
ruct pwm_device *pwm,
>  	struct meson_pwm_channel *channel =3D &meson->channels[pwm->hwpwm];
>  	unsigned int duty, period, pre_div, cnt, duty_cnt;
>  	unsigned long fin_freq;
> +	int err;
> =20
>  	duty =3D state->duty_cycle;
>  	period =3D state->period;
> @@ -165,6 +167,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, s=
truct pwm_device *pwm,
>  	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
>  		duty =3D period - duty;
> =20
> +	if (meson->data->ext_clk) {

err could be local to this block.

> +		err =3D clk_set_rate(channel->clk, 0xffffUL * NSEC_PER_SEC / period);
> +		if (err) {
> +			dev_err(meson->chip.dev, "failed to set pwm clock rate\n");
> +			return err;
> +		}
> +	}
> +
>  	fin_freq =3D clk_get_rate(channel->clk);
>  	if (fin_freq =3D=3D 0) {
>  		dev_err(meson->chip.dev, "invalid source clock frequency\n");
> @@ -173,10 +183,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, =
struct pwm_device *pwm,
> =20
>  	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
> =20
> -	pre_div =3D div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
> -	if (pre_div > MISC_CLK_DIV_MASK) {
> -		dev_err(meson->chip.dev, "unable to get period pre_div\n");
> -		return -EINVAL;
> +	if (meson->data->ext_clk) {
> +		pre_div =3D 0;
> +	} else {
> +		pre_div =3D div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
> +		if (pre_div > MISC_CLK_DIV_MASK) {
> +			dev_err(meson->chip.dev, "unable to get period pre_div\n");
> +			return -EINVAL;
> +		}
>  	}
> =20
>  	cnt =3D div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
> @@ -445,6 +459,10 @@ static const struct meson_pwm_data pwm_g12a_ee_data =
=3D {
>  	.num_parents =3D ARRAY_SIZE(pwm_g12a_ee_parent_names),
>  };
> =20
> +static const struct meson_pwm_data pwm_s4_data =3D {
> +	.ext_clk =3D 1,
> +};
> +
>  static const struct of_device_id meson_pwm_matches[] =3D {
>  	{
>  		.compatible =3D "amlogic,meson8b-pwm",
> @@ -478,6 +496,10 @@ static const struct of_device_id meson_pwm_matches[]=
 =3D {
>  		.compatible =3D "amlogic,meson-g12a-ao-pwm-cd",
>  		.data =3D &pwm_g12a_ao_cd_data
>  	},
> +	{
> +		.compatible =3D "amlogic,meson-s4-pwm",
> +		.data =3D &pwm_s4_data
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> @@ -493,6 +515,14 @@ static int meson_pwm_init_channels(struct meson_pwm =
*meson)
>  	for (i =3D 0; i < meson->chip.npwm; i++) {
>  		struct meson_pwm_channel *channel =3D &meson->channels[i];
> =20
> +		if (meson->data->ext_clk) {
> +			snprintf(name, sizeof(name), "clkin%u", i);
> +			channel->clk =3D devm_clk_get(dev, name);
> +			if (IS_ERR(channel->clk))
> +				return PTR_ERR(channel->clk);
> +			continue;
> +		}
> +

This requires a binding change, right? Would it make sense to drop the
ext_clk flag and determine that by trying to get the clk and if it's
there, assume ext_clk would have been set?

Also I wonder if it would make sense to use the same name as used when
the mux clk is internal, i.e. reuse name from the line below.

>  		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cbcddztjwsr2blmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQerrQACgkQj4D7WH0S
/k4vTwf/UkaodtBVn/0ZrwQmJxej9+0HFUE32MQH+p0jK3sidIhmwnLsvA7BHfnc
nXL8sysq+nTYhOC9mvCLiaNwzI0Hmt84dal3bhxGvqRMq1MdbABsKzIfqWObSKXm
UuBq2H7WLdBPWV99NzrLsDs3tOQkMPLZ3/ukYJHTne710GYhz4lVnRQrvArBUtUz
JaKohK5e8x/cRHfTQ8R/Qb6V2P3fsXyXW2n5NY+Zt2tLbV2qTiStH5Jf6/JVlAi0
aX+5WkNcw9d7u9UdLjOBc1gbSQYKg6n/h2+vvw8KFmzk7ovWbHGCUGWWg8muDDya
0oLwU2aBT7GPaeEfcNPnKoNfQWJ6Bg==
=YDLT
-----END PGP SIGNATURE-----

--cbcddztjwsr2blmi--
