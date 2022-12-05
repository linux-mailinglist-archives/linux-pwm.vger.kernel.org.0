Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A94364381F
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Dec 2022 23:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiLEWao (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Dec 2022 17:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiLEWak (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Dec 2022 17:30:40 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5024562C1;
        Mon,  5 Dec 2022 14:30:39 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 73F5F1C09F4; Mon,  5 Dec 2022 23:30:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670279436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0beeeN3x4oja6CoA48n0dgddbavIjL+s5ouQp7TTWtU=;
        b=Glfr3eDW908ut8l8ZtyxnivFsAwFhKrd91OZ8Hn4B5DsYqkFacSwVHpMdO+0ZJbEke3io+
        rZJ6H6RfHZXL+x1iQ654lTF809RKZz+X/69jMIvQbgjOVGWGx/4uVo747OBUmRhyZzWmxv
        I6Gh8EjJUSygmU/FfosMXAkJOwmFGvg=
Date:   Mon, 5 Dec 2022 23:30:35 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Douglas Anderson <dianders@chromium.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 01/11] pwm: Make .get_state() callback return an error
 code
Message-ID: <Y45xC/Gwhrr+fctN@duo.ucw.cz>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZBm0pYJnT4srarSL"
Content-Disposition: inline
In-Reply-To: <20221130152148.2769768-2-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ZBm0pYJnT4srarSL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> .get_state() might fail in some cases. To make it possible that a driver
> signals such a failure change the prototype of .get_state() to return an
> error code.
>=20
> This patch was created using coccinelle and the following semantic patch:
>=20
> @p1@
> identifier getstatefunc;
> identifier driver;
> @@
>  struct pwm_ops driver =3D {
>         ...,
>         .get_state =3D getstatefunc
>         ,...
>  };
>=20
> @p2@
> identifier p1.getstatefunc;
> identifier chip, pwm, state;
> @@
> -void
> +int
>  getstatefunc(struct pwm_chip *chip, struct pwm_device *pwm, struct pwm_s=
tate *state)
>  {
>    ...
> -  return;
> +  return 0;
>    ...
>  }
>=20
> plus the actual change of the prototype in include/linux/pwm.h (plus some
> manual fixing of indentions and empty lines).
>=20
> So for now all drivers return success unconditionally. They are adapted
> in the following patches to make the changes easier reviewable.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

LED part:

Acked-by: Pavel Machek <pavel@ucw.cz>

Best regards,
							Pavel

>  static const struct pwm_ops ti_sn_pwm_ops =3D {
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qco=
m-lpg.c
> index 02f51cc61837..741cc2fd817d 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -968,8 +968,8 @@ static int lpg_pwm_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
>  	return ret;
>  }
> =20
> -static void lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *=
pwm,
> -			      struct pwm_state *state)
> +static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     struct pwm_state *state)
>  {
>  	struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
>  	struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> @@ -982,20 +982,20 @@ static void lpg_pwm_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
> =20
>  	ret =3D regmap_read(lpg->map, chan->base + LPG_SIZE_CLK_REG, &val);
>  	if (ret)
> -		return;
> +		return 0;
> =20
>  	refclk =3D lpg_clk_rates[val & PWM_CLK_SELECT_MASK];
>  	if (refclk) {
>  		ret =3D regmap_read(lpg->map, chan->base + LPG_PREDIV_CLK_REG, &val);
>  		if (ret)
> -			return;
> +			return 0;
> =20
>  		pre_div =3D lpg_pre_divs[FIELD_GET(PWM_FREQ_PRE_DIV_MASK, val)];
>  		m =3D FIELD_GET(PWM_FREQ_EXP_MASK, val);
> =20
>  		ret =3D regmap_bulk_read(lpg->map, chan->base + PWM_VALUE_REG, &pwm_va=
lue, sizeof(pwm_value));
>  		if (ret)
> -			return;
> +			return 0;
> =20
>  		state->period =3D DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * LPG_RESOLUTION =
* pre_div * (1 << m), refclk);
>  		state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value *=
 pre_div * (1 << m), refclk);
> @@ -1006,13 +1006,15 @@ static void lpg_pwm_get_state(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> =20
>  	ret =3D regmap_read(lpg->map, chan->base + PWM_ENABLE_CONTROL_REG, &val=
);
>  	if (ret)
> -		return;
> +		return 0;
> =20
>  	state->enabled =3D FIELD_GET(LPG_ENABLE_CONTROL_OUTPUT, val);
>  	state->polarity =3D PWM_POLARITY_NORMAL;
> =20
>  	if (state->duty_cycle > state->period)
>  		state->duty_cycle =3D state->period;
> +
> +	return 0;
>  }

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ZBm0pYJnT4srarSL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY45xCwAKCRAw5/Bqldv6
8qEdAKCcIFDwtp8cJpPtW1EpTb0IJOYYKwCdGtyKdQYCFKVLwV+BGw7lryK0MC8=
=gb+Q
-----END PGP SIGNATURE-----

--ZBm0pYJnT4srarSL--
