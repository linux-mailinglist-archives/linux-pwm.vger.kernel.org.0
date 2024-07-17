Return-Path: <linux-pwm+bounces-2847-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F29F93450B
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jul 2024 01:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C309F283C3F
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 23:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D120759167;
	Wed, 17 Jul 2024 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/tYahsI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6320018EBF;
	Wed, 17 Jul 2024 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721259217; cv=none; b=fRfYZUcdXXi0t3lLUdiTUHeWEDlggNi7Hj14pp00RH70U4Cd13AvA3dHS3EZVN4HvEPG9U0KvVKkYAPfw7nABuESTbU1pu60TjkhvnStESUqh3bRwvuIFRBCbIXJ61Hcu+uHQbConDKW4gS4qdMrhNxpp19mbIWwBlUJOvptN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721259217; c=relaxed/simple;
	bh=/vntp9yziGCzvLchAgMHXkRgHgytqWIKu6wEIUPrxlQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=I50lv1Kqj5NSMeWUI/RxfLgvaOT/bjzYxs5YFYqh5viv3r2OTB0xp2uxNR1QGTFPnQh/1nkp4ZMZ274iyQ2DzsJFbhzO+AKWXPUp2/irJIIEtZEbnImKhbuiObOlztCb55V1E6FhPbXGWxuJpcQJwRpVpaKf+l0ldX9EKoG8K/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/tYahsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59E2C2BD10;
	Wed, 17 Jul 2024 23:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721259216;
	bh=/vntp9yziGCzvLchAgMHXkRgHgytqWIKu6wEIUPrxlQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=m/tYahsI7GcAsn0eTT4WF3W3BC90QDmQbipyzN62A8EQrxsGjJuDHvLvxJTe9ClPb
	 SxfN7qFIZCngz7gztSRBpz2eEzrUCy4jUV1ydb6l65kKp+wAq1QWNBsZy5KABTYVQR
	 tq+sCrNewY9i6SpEr8eZIOLHRCKt7Ey7NF7M1f0KLVQ+ZcrJeHrDZjeNPd1EsmFr+5
	 4zTlnoxdZoC9fCxuCKnodh5r8fGggVstFE9nygPb3O0rvXh68bBkRq/sZ9W1kFT6Vp
	 PNOejeGFpQtHdc4Q11bbXLpU6fBG4A6iIgpFlB92tbnMPPxy5xVe6T52lr0cg39ZBV
	 sbhS/c+mN45rg==
Message-ID: <1e36b1ba8af3584128550822a70cb072.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240717-of_property_for_each_u32-v2-1-4060990f49c9@bootlin.com>
References: <20240717-of_property_for_each_u32-v2-1-4060990f49c9@bootlin.com>
Subject: Re: [PATCH v2] of: remove internal arguments from of_property_for_each_u32()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Peng Fan (OSS) <peng.fan@oss.nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, patches@opensource.cirrus.com, linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, Andre Przywara <andre.przywara@arm.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Richard Fitzgerald <rf@opensource.cirrus.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Alim Akhtar <alim.akhtar@samsung.com>, Andreas Kemnade <andreas@kemnade.info>, Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Andersson <andersson@kernel.org>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Chen-Yu Tsai <wens@csie.org>, Chester Lin <chester62515@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Damien Le Moal <dlemoal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, Doug Berger <opendmb@gmail.com>, Emilio =?utf-8?q?L=C3=B3pez?= <emilio@elopez.com.ar>, Fabio Estevam <festevam@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jacky Bai <ping.bai@nxp.com>, Jaroslav Kysela <perex@perex.cz>, Jernej Skrabec <jernej.skrabec@gmail.com>, Jiri Slaby
  <jirislaby@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Krzysztof Kozlowski <krzk@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>, Matthias Brugger <mbrugger@suse.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Naveen N. Rao <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Richard Leitner <richard.leitner@linux.dev>, Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, Samuel Holland <samuel@sholland.org>, Saravana Kannan <saravanak@google.com>, Shawn Guo <shawnguo@kernel.org>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner 
 <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Date: Wed, 17 Jul 2024 16:33:34 -0700
User-Agent: alot/0.10

Quoting Luca Ceresoli (2024-07-17 09:16:32)
> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
> index 4ce83c5265b8..d4904f59f83f 100644
> --- a/drivers/clk/clk-si5351.c
> +++ b/drivers/clk/clk-si5351.c
> @@ -1175,8 +1175,8 @@ static int si5351_dt_parse(struct i2c_client *clien=
t,
>  {
>         struct device_node *child, *np =3D client->dev.of_node;
>         struct si5351_platform_data *pdata;
> -       struct property *prop;
> -       const __be32 *p;
> +       u32 array[4];
> +       int sz, i;
>         int num =3D 0;
>         u32 val;
> =20
> @@ -1191,20 +1191,24 @@ static int si5351_dt_parse(struct i2c_client *cli=
ent,
>          * property silabs,pll-source : <num src>, [<..>]
>          * allow to selectively set pll source
>          */
> -       of_property_for_each_u32(np, "silabs,pll-source", prop, p, num) {
> +       sz =3D of_property_read_variable_u32_array(np, "silabs,pll-source=
", array, 2, 4);
> +       sz =3D (sz =3D=3D -EINVAL) ? 0 : sz; /* Missing property is OK */
> +       if (sz < 0)
> +               return dev_err_probe(&client->dev, sz, "invalid pll-sourc=
e");

Needs a newline on the printk message.

> +       if (sz % 2)
> +               return dev_err_probe(&client->dev, -EINVAL,
> +                                    "missing pll-source for pll %d\n", a=
rray[sz - 1]);
> +
> +       for (i =3D 0; i < sz; i +=3D 2) {
> +               num =3D array[i];
> +               val =3D array[i + 1];
> +
>                 if (num >=3D 2) {
>                         dev_err(&client->dev,
>                                 "invalid pll %d on pll-source prop\n", nu=
m);
>                         return -EINVAL;
>                 }
> =20
> -               p =3D of_prop_next_u32(prop, p, &val);
> -               if (!p) {
> -                       dev_err(&client->dev,
> -                               "missing pll-source for pll %d\n", num);
> -                       return -EINVAL;
> -               }
> -
>                 switch (val) {
>                 case 0:
>                         pdata->pll_src[num] =3D SI5351_PLL_SRC_XTAL;
> @@ -1232,19 +1236,24 @@ static int si5351_dt_parse(struct i2c_client *cli=
ent,
>         pdata->pll_reset[0] =3D true;
>         pdata->pll_reset[1] =3D true;
> =20
> -       of_property_for_each_u32(np, "silabs,pll-reset-mode", prop, p, nu=
m) {
> +       sz =3D of_property_read_variable_u32_array(np, "silabs,pll-reset-=
mode", array, 2, 4);
> +       sz =3D (sz =3D=3D -EINVAL) ? 0 : sz; /* Missing property is OK */
> +       if (sz < 0)
> +               return dev_err_probe(&client->dev, sz, "invalid pll-reset=
-mode");

Needs a newline on the printk message.

> +       if (sz % 2)
> +               return dev_err_probe(&client->dev, -EINVAL,
> +                                    "missing pll-reset-mode for pll %d\n=
", array[sz - 1]);
> +

With those fixed

Acked-by: Stephen Boyd <sboyd@kernel.org> # clk

