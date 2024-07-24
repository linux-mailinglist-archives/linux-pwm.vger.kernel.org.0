Return-Path: <linux-pwm+bounces-2906-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 512FC93B20B
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jul 2024 15:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C682C1F217A8
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jul 2024 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179891591E8;
	Wed, 24 Jul 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEaWmgja"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991A158D83;
	Wed, 24 Jul 2024 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829230; cv=none; b=LAfs3o48Sgk0lQARumolfiMgvglTTd9QPesUMzf49+R4CiwxtT0kobXEYxG+S6x/l2At1f6PuQ2S0U/8cPaPWidlhC4abBqHeVRwL4LJB3rvpVRfjL1rI9qZJSay17GFX3n/KA0aAywNjvBihoKWeMzpvmODW3fChqd33h3ZdXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829230; c=relaxed/simple;
	bh=JHsErZ1Ymd3xIUMEC7/hpzB8p/mlL/O9e+IDU+AKN8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eq/4iZNentZKFWOohpADHzL50lzVZwsxliJ5ZwDmLA0u6CmxP4mQqgSf3sXdyNeWM6+AgpJEBwV0nIfUIzQUVXTX4pSe8bFWtb99uwxhO7kOodmW3EF5n9eI5t0bLhJph/XEXH8KeiEgY/fE1Z0dIlrwNPZw2XD7WiCmx2fmavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEaWmgja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33282C4AF14;
	Wed, 24 Jul 2024 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721829229;
	bh=JHsErZ1Ymd3xIUMEC7/hpzB8p/mlL/O9e+IDU+AKN8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SEaWmgjaMdyUPpB+3WNdnu/Gu9TlKShfVaI3kaPtTDUgi1+yOW7Vw3WRWHs1vW6yC
	 Y3vEwLQLJbKWWj7Dx4mkYjG+Fx1/bCL3TcivZM6ZsDaDYvp/z9r7LEiiNnP5NYrZkJ
	 SYAnbs406vjYmOQu2+pBQlU/xloyJFw0x9MXtYErO8Y/t++x+Y1gVMuplBSs0dRN1A
	 aFLBZLP7F5kEjA3DsPqSbJfUS1DcN6ec3Q2ZQcBVKquPBr0eI+0v6rCG5wVA5SqCn8
	 HZaFcNq4Nj/FL+NccJEe0+3FebAjkiI31jd7YbrmcZFhm5ZDnSwVEnGW06SIOREjmw
	 xrF3Btp6K9YPg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso39539251fa.2;
        Wed, 24 Jul 2024 06:53:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaaZbjJYjhHIqupl8vBGkyCEWx3fIX8DGzS1b+8uLkuMt1KfPyzgZ7dpoxC8rJY2vAKrQxjUQtOuV3GonK1AXgrStSN6+jGRdsRnKTe49MQYZgrB3OQKo+ACd48kxwoU7xqBiwWYU8JdQvTm6ju+TfjkaH7nnI7vqnlLAmtSawpQ3LVrNuqFwID2LxJ86iE1yM9ZktYF6hMtUiV+JYCdGeNq1IcHhF8uFG8BBkVgd3CLqtHWEaIijGe8GZpu2FoXEJbZDpe2DWVodGYY8F0ewSmjTtcMrO6O3TF176dny2Ki+cOQ4QsyUiCxoaxMeVHPcSTGnb4UPptXcgD1BfwG8alrSdnrJPn/9ImVSK6k0LzJOB098nA20sdYZaHOeCmf47INa/LL53KokpOdEs9SSy38S0SFqI70+AB2X0OiQ/NV17DNtLdUw3dwZtmFcqmfWwPp2oRxcT0n8IMbleLunhlxOXP/s90LIJMd9zCqXZgWFaOL9OSafFE+xruPbamieQ4FGoP/lM2uE=
X-Gm-Message-State: AOJu0YzFHhNsC/LtZP3P1oBEd4uWCHuaVYueEwGIGMi2cujgF/otLn4x
	0by/UuwcoIcftkZn0Qs9LF3HfQ75uDePSxJnJf3MvBJNb409tNRHQu5zge4YlvQlKBlg2YtJJd5
	sf9fSpzthkKFWqH9VCMI+lVRv/w==
X-Google-Smtp-Source: AGHT+IEk3YhHLLuWHQez8La65BtnRIR9t5/9BONqzEk5mOwWdTbwESXZpTYF2WmMXYwp6gfL+EkMMSd8FeS9sIIdSCk=
X-Received: by 2002:a05:6512:3984:b0:51a:f689:b4df with SMTP id
 2adb3069b0e04-52efb7db65bmr9357884e87.44.1721829216849; Wed, 24 Jul 2024
 06:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717-of_property_for_each_u32-v2-1-4060990f49c9@bootlin.com>
 <1e36b1ba8af3584128550822a70cb072.sboyd@kernel.org> <20240718085651.63ddfb20@booty>
In-Reply-To: <20240718085651.63ddfb20@booty>
From: Rob Herring <robh@kernel.org>
Date: Wed, 24 Jul 2024 08:53:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKtOTgoDgfwq9Guvt_LbtnHHGJ+PDt-wgVRHU=oVzwhHw@mail.gmail.com>
Message-ID: <CAL_JsqKtOTgoDgfwq9Guvt_LbtnHHGJ+PDt-wgVRHU=oVzwhHw@mail.gmail.com>
Subject: Re: [PATCH v2] of: remove internal arguments from of_property_for_each_u32()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Andreas Kemnade <andreas@kemnade.info>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Andersson <andersson@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Chen-Yu Tsai <wens@csie.org>, 
	Chester Lin <chester62515@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Damien Le Moal <dlemoal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
	Doug Berger <opendmb@gmail.com>, =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>, 
	Fabio Estevam <festevam@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jacky Bai <ping.bai@nxp.com>, 
	Jaroslav Kysela <perex@perex.cz>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Matthias Brugger <mbrugger@suse.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Richard Leitner <richard.leitner@linux.dev>, 
	Roger Quadros <rogerq@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	Saravana Kannan <saravanak@google.com>, Shawn Guo <shawnguo@kernel.org>, 
	Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	llvm@lists.linux.dev, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-samsung-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, Andre Przywara <andre.przywara@arm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 1:57=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Stephen,
>
> On Wed, 17 Jul 2024 16:33:34 -0700
> Stephen Boyd <sboyd@kernel.org> wrote:
>
> > > @@ -1191,20 +1191,24 @@ static int si5351_dt_parse(struct i2c_client =
*client,
> > >          * property silabs,pll-source : <num src>, [<..>]
> > >          * allow to selectively set pll source
> > >          */
> > > -       of_property_for_each_u32(np, "silabs,pll-source", prop, p, nu=
m) {
> > > +       sz =3D of_property_read_variable_u32_array(np, "silabs,pll-so=
urce", array, 2, 4);
> > > +       sz =3D (sz =3D=3D -EINVAL) ? 0 : sz; /* Missing property is O=
K */
> > > +       if (sz < 0)
> > > +               return dev_err_probe(&client->dev, sz, "invalid pll-s=
ource");
> >
> > Needs a newline on the printk message.
>
> Ouch! Fix queued for v3.

I need v3 like today if I'm going to send it for rc1.

Rob

