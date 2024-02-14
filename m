Return-Path: <linux-pwm+bounces-1489-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04864854987
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 13:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759D01F24823
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F152F78;
	Wed, 14 Feb 2024 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftZDfTaH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB8D487BC;
	Wed, 14 Feb 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914993; cv=none; b=sznRwNKpdWHU4MOVBbYd9sKgD4wiT1gnxEsK6dw7jqvRc/3nbXhkquDifGVw5jFfWIwfUFyXG3chcnqtx5tDKNLVqs9t+IdBXbP6FA7l+xsERw7nJi/d9lrXkpDChLdNfkZqh2wu5cMfiBprDNyYjnpp4/Ybs+QAWf7yLJeYwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914993; c=relaxed/simple;
	bh=VfFo/DkZzmeQyKntjmarBqvTj2pcgH+G7HGM6HxEwSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLoMgMKggPVpNVEWOoPGh0YusOOXDoCQaiiTBAqOAsk9P21tN1uBrOpGl/KclCOnS4QHK/SHxR44eMLRFOdFbgenk3IVjxOjnLovlkfGP7BtHzUShJO4nPX6m9o0zPXtIUGPrbLVBNXt1tBUWOcFaAc6b/yjORCsk2gs6ROMSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftZDfTaH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707914992; x=1739450992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VfFo/DkZzmeQyKntjmarBqvTj2pcgH+G7HGM6HxEwSk=;
  b=ftZDfTaHFwuNYapG9zcQMfaEbMidnt86i57VyyY2Y9kt6SPLzoxSDEw2
   6JyCbYr4zBAxANqTOH69T1gLxpurXOE9BIeLTTlIuuNs4ecBgs6HBqEz9
   Dz0P8f88A53ujj8v8O5JsZFpsmOtFKvKEeoO9bTuw7p6YWuvzkKNhft4D
   tCVu1IX2EomsWb9E4GQAYNMqQz86Z6SRJ0JSUzydTC1xTb3Q2ufLnxQ9V
   x2gJxBxsJnEX99RgYHCnaZl+GCi60AG2V00Dl4QpJ2oYbndm14XdY7Mgt
   lx+N7U/h0irJmnOt1csds3r3h3qcQTF76MtoRxB0g/DexXpcvy7ddHA94
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1809717"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1809717"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:49:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="912083870"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="912083870"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:49:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raEhb-00000004UXT-0JCa;
	Wed, 14 Feb 2024 14:49:27 +0200
Date: Wed, 14 Feb 2024 14:49:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	James Clark <james.clark@arm.com>, Mark Brown <broonie@kernel.org>,
	linux-pwm@vger.kernel.org, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Alexander Shiyan <shc_work@mail.ru>,
	Benson Leung <bleung@chromium.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Michael Walle <mwalle@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hammer Hsieh <hammerh0314@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Sean Anderson <sean.anderson@seco.com>,
	Michal Simek <michal.simek@amd.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>,
	linux-doc@vger.kernel.org, kernel@pengutronix.de,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-mips@vger.kernel.org,
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 003/164] pwm: Provide pwmchip_alloc() function and a
 devm variant of it
Message-ID: <Zcy21tsntcK80hef@smile.fi.intel.com>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <9577d6053a5a52536057dc8654ff567181c2da82.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9577d6053a5a52536057dc8654ff567181c2da82.1707900770.git.u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 10:30:50AM +0100, Uwe Kleine-König wrote:
> This function allocates a struct pwm_chip and driver data. Compared to
> the status quo the split into pwm_chip and driver data is new, otherwise
> it doesn't change anything relevant (yet).
> 
> The intention is that after all drivers are switched to use this
> allocation function, its possible to add a struct device to struct
> pwm_chip to properly track the latter's lifetime without touching all
> drivers again. Proper lifetime tracking is a necessary precondition to
> introduce character device support for PWMs (that implements atomic
> setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
> userspace support).
> 
> The new function pwmchip_priv() (obviously?) only works for chips
> allocated with pwmchip_alloc().

...

> +#define PWMCHIP_ALIGN ARCH_DMA_MINALIGN
> +
> +static void *pwmchip_priv(struct pwm_chip *chip)
> +{
> +	return (void *)chip + ALIGN(sizeof(*chip), PWMCHIP_ALIGN);
> +}

Why not use dma_get_cache_alignment() ?

...

> +/* This is the counterpart to pwmchip_alloc */

pwmchip_alloc()

...

> +EXPORT_SYMBOL_GPL(pwmchip_put);

> +EXPORT_SYMBOL_GPL(pwmchip_alloc);

> +EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);

Are these exported via namespace? If no, can they be from day 1?

...

> +static inline void pwmchip_put(struct pwm_chip *chip)
> +{
> +}

Can be one line, but it's up to the present style in this header.

-- 
With Best Regards,
Andy Shevchenko



