Return-Path: <linux-pwm+bounces-7036-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B282B25567
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 23:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A009886EA3
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 21:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B862FFDDD;
	Wed, 13 Aug 2025 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tW0weATX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32656188715;
	Wed, 13 Aug 2025 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120528; cv=none; b=MUrWzpq/VQ83gThSSOaSPq2EsyiUZ3WXKJdR2OZJ4sXuDRbmpuY/f5tL9UjH9mi0Zyf+EHmMcTHfPDdcZOf5nnYU21AsxBOhsopFiKoFgef0O7oZz8XWgNer8ly8we5ZYTQGTd1jE1AtmxP9stT2YyMLP7zVA79C2kaksmtbMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120528; c=relaxed/simple;
	bh=w6o+Mcmx0kfk0qJVojOnLq3WRRaroXEK6NqPwh8WeEA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XYhyREiK/tvyMHw8zKkd/GmTE6N29YbHwQnyGP8p5dah4Hw96Qu7yS9KmDOclv0wuOuxMwH47DJeoN89gKFIzCxyoF425HNJu70plRPCmmi0Ab7Yvhi4EcaIU1O+x8p+yTZiiFcFYkvotXma12djaFwiencBflh0ghikQMgT5YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tW0weATX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038F0C4CEEB;
	Wed, 13 Aug 2025 21:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755120527;
	bh=w6o+Mcmx0kfk0qJVojOnLq3WRRaroXEK6NqPwh8WeEA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tW0weATX4jZ11jXl3He1Ule5FSJuMatBGd51oT3bMN01eb3cT3/18BB0KpS64oSbV
	 6A4QDHJDbE2i5JqtnfsyVBALsh6Bm5ABrlcwIeEaVVJKF8Ys4lmXD08V4Cf547I5mm
	 6sCZgBGCfMRs6QPVrGxU4nTnD7f31+rWw2qkW80zdobtK+0W0QNMcTpZiJJZuxp3e3
	 f72jB75x9bqVrnObcwmG+vOT476m4B3xoHJM2Tk0dvct2jHtt8v2WNoP/JeukhjYFa
	 P4b7UnXzBQig+oKbLe5NjU5NaUCh5y3uOUysgIl6JhmCWTjHv+RyKuGvEMG/hhDxtg
	 oUrRFt19OPnjQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Andy Shevchenko <andy@kernel.org>, 
 Andy Yan <andy.yan@rock-chips.com>, Avi Fishman <avifishman70@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Benjamin Fair <benjaminfair@google.com>, 
 Bjorn Andersson <andersson@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Airlie <airlied@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Drew Fustini <fustini@kernel.org>, dri-devel@lists.freedesktop.org, 
 Fabio Estevam <festevam@gmail.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Fu Wei <wefu@redhat.com>, 
 Guo Ren <guoren@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, imx@lists.linux.dev, 
 Iwona Winiarska <iwona.winiarska@intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jonathan Cameron <jic23@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-actions@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev, Liu Ying <victor.liu@nxp.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Nancy Yuen <yuenn@google.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, openbmc@lists.ozlabs.org, 
 Patrick Venture <venture@google.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Samuel Holland <samuel@sholland.org>, Sandy Huang <hjc@rock-chips.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Stephen Boyd <sboyd@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Tali Perry <tali.perry1@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Tomer Maimon <tmaimon77@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Vladimir Zapolskiy <vz@mleia.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Yangtao Li <tiny.windzz@gmail.com>, Zhang Rui <rui.zhang@intel.com>
In-Reply-To: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
Subject: Re: (subset) [PATCH 00/21] treewide: remove unneeded 'fast_io'
 parameter in regmap_config
Message-Id: <175512050873.352044.97744864083041762.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 22:28:28 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 13 Aug 2025 18:14:46 +0200, Wolfram Sang wrote:
> While working on a driver using regmap with MMIO, I wondered if I need
> to set 'fast_io' in the config. Turned out I don't need to, so I added
> documentation for it with commit ffc72771ff6e ("regmap: Annotate that
> MMIO implies fast IO").
> 
> This series fixes the existing users in the tree which needlessly set
> the flag. They have been found using this coccinelle script:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[15/21] regulator: remove unneeded 'fast_io' parameter in regmap_config
        commit: 37533933bfe92cd5a99ef4743f31dac62ccc8de0

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


