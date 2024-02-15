Return-Path: <linux-pwm+bounces-1519-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984A8562D7
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 13:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904E4B239AF
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E380512B175;
	Thu, 15 Feb 2024 12:02:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7E12AAD6
	for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998575; cv=none; b=YQKoxjpPmhFnmVcOw75e8FuF/0P96lhA+oek68GShL2TwWMf+KVLRWV1bNNzOskZpjIs+xgY+hLeu7YJCTDVWaAkOF4Df54kPIZvyWTqjkRc0yLCXJkH3kEIU0azjSc608WplEGET7Nnvo6apWtMFfgj4Gj1gIN2B5s0L9QaOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998575; c=relaxed/simple;
	bh=3jlg6YeJDDhpum/HJwBRurEn6l6PGW78sxf4+poXyDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUnMtjryW9+SoLV8OkONxPnT0D4fFkMzUJvsliCybyEjKevO+gSCftHm5fuuhZVTYtWxrkgecK2KJGlMUhPejl2sPS4YCHqlX0cyD1xlH4XFBh0zSfN1KBoQBx4opa3s/R0ktVr6sPnIqKxY0x3+N9KTcNm9OP1d1DwUlYpIVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raaRB-0000Gm-6C; Thu, 15 Feb 2024 13:01:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raaR5-000sKN-Ds; Thu, 15 Feb 2024 13:01:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raaR5-005KpH-0o;
	Thu, 15 Feb 2024 13:01:51 +0100
Date: Thu, 15 Feb 2024 13:01:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Michael Walle <mwalle@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Paul Cercueil <paul@crapouillou.net>, linux-tegra@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Thierry Reding <thierry.reding@gmail.com>, 
	James Clark <james.clark@arm.com>, Pavel Machek <pavel@ucw.cz>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	Fabio Estevam <festevam@gmail.com>, linux-riscv@lists.infradead.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Jerome Brunet <jbrunet@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	linux-samsung-soc@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonathan Corbet <corbet@lwn.net>, 
	Sean Anderson <sean.anderson@seco.com>, Benson Leung <bleung@chromium.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Hammer Hsieh <hammerh0314@gmail.com>, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, 
	Michal Simek <michal.simek@amd.com>, NXP Linux Team <linux-imx@nxp.com>, linux-leds@vger.kernel.org, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Sven Peter <sven@svenpeter.dev>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Ray Jui <rjui@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Vladimir Zapolskiy <vz@mleia.com>, 
	Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>, 
	linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-amlogic@lists.infradead.org, 
	Orson Zhai <orsonzhai@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Alexander Shiyan <shc_work@mail.ru>, Scott Branden <sbranden@broadcom.com>, 
	linux-gpio@vger.kernel.org, Daire McNamara <daire.mcnamara@microchip.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Hector Martin <marcan@marcan.st>, 
	linux-stm32@st-md-mailman.stormreply.com, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, asahi@lists.linux.dev, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Shawn Guo <shawnguo@kernel.org>, Anjelique Melendez <quic_amelende@quicinc.com>
Subject: Re: [PATCH v6 003/164] pwm: Provide pwmchip_alloc() function and a
 devm variant of it
Message-ID: <ws4ybgtvfxqz53vk3i67suipzyqpy5y5fqeee5uf3ua6ow222n@i4ktjuorq3nl>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <9577d6053a5a52536057dc8654ff567181c2da82.1707900770.git.u.kleine-koenig@pengutronix.de>
 <Zcy21tsntcK80hef@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eo4pepuhkmuwjzg5"
Content-Disposition: inline
In-Reply-To: <Zcy21tsntcK80hef@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--eo4pepuhkmuwjzg5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 02:49:26PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 10:30:50AM +0100, Uwe Kleine-K=F6nig wrote:
> > This function allocates a struct pwm_chip and driver data. Compared to
> > the status quo the split into pwm_chip and driver data is new, otherwise
> > it doesn't change anything relevant (yet).
> >=20
> > The intention is that after all drivers are switched to use this
> > allocation function, its possible to add a struct device to struct
> > pwm_chip to properly track the latter's lifetime without touching all
> > drivers again. Proper lifetime tracking is a necessary precondition to
> > introduce character device support for PWMs (that implements atomic
> > setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
> > userspace support).
> >=20
> > The new function pwmchip_priv() (obviously?) only works for chips
> > allocated with pwmchip_alloc().
>=20
> ...
>=20
> > +#define PWMCHIP_ALIGN ARCH_DMA_MINALIGN
> > +
> > +static void *pwmchip_priv(struct pwm_chip *chip)
> > +{
> > +	return (void *)chip + ALIGN(sizeof(*chip), PWMCHIP_ALIGN);
> > +}
>=20
> Why not use dma_get_cache_alignment() ?

Hmm, that function returns 1 if ARCH_HAS_DMA_MINALIGN isn't defined. The
idea of using ARCH_DMA_MINALIGN was to ensure that the priv data has the
same minimal alignment as kmalloc(). Took my inspriration from
https://lore.kernel.org/r/20240209-counter-align-fix-v2-1-5777ea0a2722@anal=
og.com
=2E The implementation of dma_get_cache_alignment suggests that not all
archs provide ARCH_DMA_MINALIGN? Also there is ARCH_KMALLOC_MINALIGN.
Hmm, don't know yet what to do here.

> > +/* This is the counterpart to pwmchip_alloc */
>=20
> pwmchip_alloc()

Ack.
=20
> > +EXPORT_SYMBOL_GPL(pwmchip_put);
>=20
> > +EXPORT_SYMBOL_GPL(pwmchip_alloc);
>=20
> > +EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
>=20
> Are these exported via namespace? If no, can they be from day 1?

I added that to my todo list for all pwm functions. Will address that
separately.

Thanks for your feedback
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eo4pepuhkmuwjzg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXN/SUACgkQj4D7WH0S
/k7Wcgf+PH/0QpqNNV4Y2/FkmhtRuwoboRFbLUmPSdsZXmpktX2oCcZmzsdo7ECA
hWfFTUYhOspa5kHVcw+nxqCLWdGrQfQ4C0LtsPicyPjTXPVpP8W09vwdeatCiqVr
GxgvULwRl/HxZXMUXZhJ5ToJRT/yuN1CLjpyjnINyIczC+jZFclxgx43quAbXMIf
SCUAlxTR/Jm/mjCmH2N7Fftk64+hCNWB2gsjkaQsDUwtAelt3/J9u4h2He4NPzPi
GaEZ3tfrkKkBWoolaCIhY1LqXtT3nU+qiP5t/bPD00DRDM2XtKsjvAk526Lx/OAu
y+6AtGBx3n9HzXzyJ+bdew1oAMND9g==
=44B0
-----END PGP SIGNATURE-----

--eo4pepuhkmuwjzg5--

