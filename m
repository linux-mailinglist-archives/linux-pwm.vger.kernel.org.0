Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25834531008
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiEWMqd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 08:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiEWMqc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 08:46:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47FD4D247
        for <linux-pwm@vger.kernel.org>; Mon, 23 May 2022 05:46:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nt7S0-0007bF-33; Mon, 23 May 2022 14:46:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nt7Rz-0045Ef-Ua; Mon, 23 May 2022 14:46:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nt7Rx-00BbLl-RG; Mon, 23 May 2022 14:46:17 +0200
Date:   Mon, 23 May 2022 14:46:14 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v4 6/6] hwmon: pwm-fan: Remove internal duplicated
 pwm_state
Message-ID: <20220523124614.74hwex5a4eedpitl@pengutronix.de>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com>
 <20220523110513.407516-7-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fw6upfswezr6qibg"
Content-Disposition: inline
In-Reply-To: <20220523110513.407516-7-alexander.stein@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fw6upfswezr6qibg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 23, 2022 at 01:05:13PM +0200, Alexander Stein wrote:
> Each pwm device has already a pwm_state. Use this one instead of
> managing an own copy of it.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/hwmon/pwm-fan.c | 49 +++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index e5d4b3b1cc49..e0ce81cdf5e0 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -40,7 +40,6 @@ struct pwm_fan_ctx {
> =20
>  	struct mutex lock;
>  	struct pwm_device *pwm;
> -	struct pwm_state pwm_state;
>  	struct regulator *reg_en;
>  	enum pwm_fan_enable_mode enable_mode;
>  	bool regulator_enabled;
> @@ -142,7 +141,7 @@ static int pwm_fan_switch_power(struct pwm_fan_ctx *c=
tx, bool on)
> =20
>  static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
>  {
> -	struct pwm_state *state =3D &ctx->pwm_state;
> +	struct pwm_state state;
>  	int ret;
> =20
>  	if (ctx->enabled)
> @@ -154,8 +153,9 @@ static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
>  		return ret;
>  	}
> =20
> -	state->enabled =3D true;
> -	ret =3D pwm_apply_state(ctx->pwm, state);
> +	pwm_get_state(ctx->pwm, &state);
> +	state.enabled =3D true;
> +	ret =3D pwm_apply_state(ctx->pwm, &state);
>  	if (ret) {
>  		dev_err(ctx->dev, "failed to enable PWM\n");
>  		goto disable_regulator;

IMHO this isn't a net win. You trade the overhead of pwm_get_state
against some memory savings. I personally am not a big fan of the
get_state + modify + apply codeflow. The PWM framework does internal
caching of the last applied state, but the details are a bit ugly. (i.e.
pwm_get_state returns the last applied state, unless there was no state
applied before. In that case it returns what .get_state returned during
request time, unless there is no .get_state callback ... not sure if the
device tree stuff somehow goes into that, didn't find it on a quick
glance)

Also there is a (small) danger, that pwm_state contains something that
isn't intended by the driver, e.g. a wrong polarity. So I like the
consumer to fully specify what they intend and not use pwm_get_state().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fw6upfswezr6qibg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKLghMACgkQwfwUeK3K
7AmQswf/dBN4fTeXUIyuivX51ViWGSOoj7SBV6WmVknwIwT55TCOSgqpz+Wbs+2T
7AZvO/fVnNioMt4461OfS0pUNeeifKk8yTCDMr6EdzTZZNhrnPdnHxWxd7zUwmjF
RYqAkflCUVVXG20xETVdG2ywnP47YMw9CnTsRO5iQB7aBnWuGDTl1cHUQTDgODub
WUiLuQpjV173FAVOCoXMy37+yhhbIqH4uVhCUP9QJKHm1hxuJTwXQ8LP4vqHMwRe
PJbVoq4UqZTFujr/1Bks5tA0h/OGUZh0f/y5Spff3R+S0Zz7BmOjykiAXnpQ6L0K
dW4OI9i93eM4kiSnlc8hNpWhMRBi2w==
=XdT6
-----END PGP SIGNATURE-----

--fw6upfswezr6qibg--
