Return-Path: <linux-pwm+bounces-1528-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF78564F3
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 14:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61B41F28D70
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41C1332BD;
	Thu, 15 Feb 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGJ3CP/j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC195132467;
	Thu, 15 Feb 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005097; cv=none; b=VtuYk+6sz3c1Vg5iR6nnU+zS45VQBOqWaToy4iXiyO6Y25fLbzOAMShcTs0lRRnFh9L6LO7RYqKjCKTLgsMrtlPn66V/mdOITewWkyeV1PYG6lo5JQCwejm4OWil6Lb0Xxu/T2aygVmJYCoUN8Izm3q0XX/15zuOVCaWychAVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005097; c=relaxed/simple;
	bh=RzDVzAMbt/0O8rLENBgNMOIiu2ews2E1U5PQyx+Ji0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=duthAThQ7ST3q+IY+RI12/l/pID7L0Nmhb/kMpJj1MT6zmByzVq7B5SDMxItlbgOcnxPCuti79DYQfuELHiISOzmgiKhs7y/wXpy7QpK36g0g8faMeSDsaTLkhxhBB5wvP2OHOcegKXZUBQke9WW5qKyMLtN8/I9b3PlSb4JNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGJ3CP/j; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4121954d4c0so3306275e9.0;
        Thu, 15 Feb 2024 05:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708005094; x=1708609894; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5t9mkBRSLuX6Whm+p+USkACVg0A1ZTFUPoQmMKDP/ks=;
        b=RGJ3CP/ji8NihQLfupeAHxS66Q+QtNvy5PxhM0MX8ofwzKLRJ4l80YaI8VMzKOg5GP
         yeV1NGk3aArey0SyQXCgwlhmrqAv0hfLYTCOTVNrDZEJbAwDzzPEbMIxlHFgEN/eIyA4
         JOJHqs0eN5WIlUKrz4GYDIMhkRVHSzCOwoWPnt3UjIsE1SQwaAQHlXaIEzya8btY9RhB
         wuZqzdmqbecDlvHn+CqurKcYmfpaAGDjBRIVrY16/qHeb+kbb6zeKQ/hblN/AJ84C8Xr
         fh7a8ThSa6yPtEeAoxs6X0DLuESPX9UGFtD3KV4adDjf56EbJ3GYqp7CF7c/qMURYLis
         C+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005094; x=1708609894;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5t9mkBRSLuX6Whm+p+USkACVg0A1ZTFUPoQmMKDP/ks=;
        b=STzCClyhCCVnz8///Rm3CjUFmeNucHivQqgorFpEp20Jocw/x7NJ4wlLWmxHdkv5PV
         crC+0FBafKGrbwB5jQ7VzAU+2WdHrLwRJhSyheqGAJvPUibYM64ER9guIQc6f+kKRLi3
         WP4KExTIsuWrOcypRsidUtg9lZ29inrt9OTZ/oSQiXjNmhAQbz8TEL0g0gEhc1yLNmmU
         lN4idUYRYl/FTGyrU4I194b1hgmuKVSEULUf0HAVzAY9pRWYPNVEhPOin8muKiYR775F
         mGnd2+htdzUJ8/qCkNRDn+GovbhbbLLwLKdgjjVbW1fwNuf6coAfEjimWqhOrm30tcDP
         XNTw==
X-Forwarded-Encrypted: i=1; AJvYcCXmn5akH/NV/CbhvBGsR8nz7GQhjKNHju9HZgD8xo9MMEeRkwU8BqIz6HaHI8fb7ImsdP/pZ1qkG6wi1HuPNE4OWQrcTEbiEf20gTUTZv90TYYxxF/CffJYF7bCwpo9MuOAshlfMt2hXHXel4CMicUdhF35azYFBFitxt2dAt8mMN7YExbUdxiIW3Ov8DM2fUy5jxant0Dganp0yfTRydanq/M4xXotFwew6BapbvieN4w/168YdOWJul2TcuVHV6v9aB67pgERkpdO+MfzrlHvIKJ67T6zgfYBawbO4KRYRyCunvFq9Vs7w9i2kAQZmcwZQZU4620SE48THXmksUs+mtNRmAmrIs/hkfhxoprlHDxBILx50EAWELuRHZ4=
X-Gm-Message-State: AOJu0Yzk2lHiFiO0I+VmZqZcdn1U8ickzALl9D9GO5DGMmNIjodxFatO
	qJnbKMnlCoLDtwUgfeUb9zYMJU49BbV/4rw2oBK8kBvdAzeDwV5o
X-Google-Smtp-Source: AGHT+IH7k9jN1LEPjklm49kSSJGmdKPhxpWNQecPQqPdKhvRMqEI/U195h3M4bWUY8DUrcLpEFVYaQ==
X-Received: by 2002:a05:600c:3503:b0:412:7d0:d83 with SMTP id h3-20020a05600c350300b0041207d00d83mr1601111wmq.16.1708005093670;
        Thu, 15 Feb 2024 05:51:33 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b00410add3af79sm5061337wmd.23.2024.02.15.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:51:33 -0800 (PST)
Message-ID: <63b248efcbd62a121610cbf37ea0339bd87c99e7.camel@gmail.com>
Subject: Re: [PATCH v6 003/164] pwm: Provide pwmchip_alloc() function and a
 devm variant of it
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Michael Walle
 <mwalle@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 linux-doc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Paul Cercueil <paul@crapouillou.net>, 
 linux-tegra@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Thierry Reding <thierry.reding@gmail.com>, James Clark
 <james.clark@arm.com>, Pavel Machek <pavel@ucw.cz>,  Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Guenter Roeck
 <groeck@chromium.org>,  chrome-platform@lists.linux.dev, Nobuhiro Iwamatsu
 <nobuhiro1.iwamatsu@toshiba.co.jp>, Fabio Estevam <festevam@gmail.com>, 
 linux-riscv@lists.infradead.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>, Samuel
 Holland <samuel@sholland.org>,  linux-samsung-soc@vger.kernel.org, Bjorn
 Andersson <quic_bjorande@quicinc.com>,  Florian Fainelli
 <florian.fainelli@broadcom.com>, Jonathan Corbet <corbet@lwn.net>, Sean
 Anderson <sean.anderson@seco.com>, Benson Leung <bleung@chromium.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>,  Jonathan Hunter
 <jonathanh@nvidia.com>, Hammer Hsieh <hammerh0314@gmail.com>,
 linux-rockchip@lists.infradead.org,  Chen-Yu Tsai <wens@csie.org>, Michal
 Simek <michal.simek@amd.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-leds@vger.kernel.org, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 linux-mips@vger.kernel.org,  linux-sunxi@lists.linux.dev,
 platform-driver-x86@vger.kernel.org,  linux-pwm@vger.kernel.org, Kees Cook
 <keescook@chromium.org>, Sven Peter <sven@svenpeter.dev>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  Ray Jui
 <rjui@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Jonathan
 =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>, Vladimir Zapolskiy
 <vz@mleia.com>, Hans de Goede <hdegoede@redhat.com>, Mark Brown
 <broonie@kernel.org>,  linux-mediatek@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org,  Baolin Wang
 <baolin.wang@linux.alibaba.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-amlogic@lists.infradead.org, Orson Zhai <orsonzhai@gmail.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>,  kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Neil Armstrong
 <neil.armstrong@linaro.org>,  Alexander Shiyan <shc_work@mail.ru>, Scott
 Branden <sbranden@broadcom.com>,  linux-gpio@vger.kernel.org, Daire
 McNamara <daire.mcnamara@microchip.com>,  Chunyan Zhang
 <zhang.lyra@gmail.com>, Hector Martin <marcan@marcan.st>, 
 linux-stm32@st-md-mailman.stormreply.com, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>,  Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 asahi@lists.linux.dev,  Maxime Coquelin <mcoquelin.stm32@gmail.com>, Kevin
 Hilman <khilman@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,  Anjelique
 Melendez <quic_amelende@quicinc.com>
Date: Thu, 15 Feb 2024 14:51:31 +0100
In-Reply-To: <ws4ybgtvfxqz53vk3i67suipzyqpy5y5fqeee5uf3ua6ow222n@i4ktjuorq3nl>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
	 <9577d6053a5a52536057dc8654ff567181c2da82.1707900770.git.u.kleine-koenig@pengutronix.de>
	 <Zcy21tsntcK80hef@smile.fi.intel.com>
	 <ws4ybgtvfxqz53vk3i67suipzyqpy5y5fqeee5uf3ua6ow222n@i4ktjuorq3nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-15 at 13:01 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Feb 14, 2024 at 02:49:26PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 14, 2024 at 10:30:50AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > This function allocates a struct pwm_chip and driver data. Compared t=
o
> > > the status quo the split into pwm_chip and driver data is new, otherw=
ise
> > > it doesn't change anything relevant (yet).
> > >=20
> > > The intention is that after all drivers are switched to use this
> > > allocation function, its possible to add a struct device to struct
> > > pwm_chip to properly track the latter's lifetime without touching all
> > > drivers again. Proper lifetime tracking is a necessary precondition t=
o
> > > introduce character device support for PWMs (that implements atomic
> > > setting and doesn't suffer from the sysfs overhead of the /sys/class/=
pwm
> > > userspace support).
> > >=20
> > > The new function pwmchip_priv() (obviously?) only works for chips
> > > allocated with pwmchip_alloc().
> >=20
> > ...
> >=20
> > > +#define PWMCHIP_ALIGN ARCH_DMA_MINALIGN
> > > +
> > > +static void *pwmchip_priv(struct pwm_chip *chip)
> > > +{
> > > +	return (void *)chip + ALIGN(sizeof(*chip), PWMCHIP_ALIGN);
> > > +}
> >=20
> > Why not use dma_get_cache_alignment() ?
>=20
> Hmm, that function returns 1 if ARCH_HAS_DMA_MINALIGN isn't defined. The
> idea of using ARCH_DMA_MINALIGN was to ensure that the priv data has the
> same minimal alignment as kmalloc(). Took my inspriration from
> https://lore.kernel.org/r/20240209-counter-align-fix-v2-1-5777ea0a2722@an=
alog.com
> . The implementation of dma_get_cache_alignment suggests that not all
> archs provide ARCH_DMA_MINALIGN? Also there is ARCH_KMALLOC_MINALIGN.
> Hmm, don't know yet what to do here.

Here it goes my 2 cents... AFAIK, ARCH_DMA_MINALIGN gives you the same alig=
nment
guarantees than devm_kmalloc() for instance. In some archs it will effectiv=
ely be the
same as ARCH_KMALLOC_MINALIGN. Now, I think it only matters if the owners o=
f private
data intend to have a DMA safe buffer in their structs. If that is the case=
, we need
to ensure a proper alignment for that structure. In IIO for example, the co=
nstruct is
like this:

https://elixir.bootlin.com/linux/latest/source/drivers/iio/dac/ltc2688.c#L9=
6

The buffers should come last in the struct so they are alone in the line. I=
n IIO,
Jonathan has a strict policy for this. Like, even if you just want to trans=
fer 2/4
bytes via spi, we need to make the buffer safe (apparently there are some c=
ontrollers
only doing DMA - even for small transfers).

I would say that if unsure, go with ARCH_DMA_MINALIGN. You just might waste=
 some
space in some archs. OTOH, if you think DMA is not really a thing for pwm c=
hips, you
might go ARCH_KMALLOC_MINALIGN. And since you already have your own PWMCHIP=
_ALIGN, it
should be easy to change the requirements down the road (if needed).

That said, I'm not familiar with dma_get_cache_alignment().

- Nuno S=C3=A1


