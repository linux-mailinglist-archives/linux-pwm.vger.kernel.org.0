Return-Path: <linux-pwm+bounces-1098-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF09983DF8F
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 18:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C251F2413E
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4091EA7C;
	Fri, 26 Jan 2024 17:12:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BEAD53
	for <linux-pwm@vger.kernel.org>; Fri, 26 Jan 2024 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289148; cv=none; b=EdMYzsH6wW1m3pNZTHXXmqsLBjWtvSEpElGZEBiGDQlLg5zLCgCvG4aBrvBoeONJ8vXDfkPGe6llDlEYMlCK87QtNutQba2ocy/fxVB2yO//eZ0qvqn6hZAja7EEYM8YqsHgKhjrW0ofC9DiQaMfuimnoy5hJts3umJsXVO+0Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289148; c=relaxed/simple;
	bh=COb4jLeIk3Yc6EinXHh+ryEulfnYvk9LPJq7bo9yaf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCSbGlpuYXHLWOadJx1MYORSnDw+rtdynrnPfUydDPXYZnNMOtp18i/awBMZUxEj0lYMkXDUd6YXfDHg0Zf32BC78FRLzG5bS0W41gSbVkGM2oVC7j3g6Yt1GV8Tj0fUwuU7ZuH7LqJhoCkMUs0/cMuY0TlNSL1yNXpiK102JBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTPjB-0003h4-L9; Fri, 26 Jan 2024 18:10:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTPiw-002YFi-JY; Fri, 26 Jan 2024 18:10:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTPiw-008oFN-1F;
	Fri, 26 Jan 2024 18:10:38 +0100
Date: Fri, 26 Jan 2024 18:10:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alex Elder <elder@ieee.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	James Clark <james.clark@arm.com>, linux-pwm@vger.kernel.org, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Alexander Shiyan <shc_work@mail.ru>, 
	Benson Leung <bleung@chromium.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Paul Cercueil <paul@crapouillou.net>, 
	Vladimir Zapolskiy <vz@mleia.com>, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Michael Walle <mwalle@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Hammer Hsieh <hammerh0314@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	Sean Anderson <sean.anderson@seco.com>, Michal Simek <michal.simek@amd.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Anjelique Melendez <quic_amelende@quicinc.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Lu Hongfei <luhongfei@vivo.com>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Luca Weiss <luca@z3ntu.xyz>, Johan Hovold <johan@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	platform-driver-x86@vger.kernel.org, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Guenter Roeck <groeck@chromium.org>, 
	linux-riscv@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, 
	linux-stm32@st-md-mailman.stormreply.com, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Jerome Brunet <jbrunet@baylibre.com>, chrome-platform@lists.linux.dev, 
	linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, NXP Linux Team <linux-imx@nxp.com>, linux-leds@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, Jonas Karlman <jonas@kwiboo.se>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, greybus-dev@lists.linaro.org, linux-mips@vger.kernel.org, 
	asahi@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v5 040/111] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <zjt3r6z5ilpffh26qidwp3axpnvfkwcrwanrtjjm2kscpdovuz@ppcrdlhmqiqq>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <f59b1a4a8d6fba65e4d3e8698310c9cb1d4c43ce.1706182805.git.u.kleine-koenig@pengutronix.de>
 <db05fb6a-2ea5-4e00-ac03-adc1897d96de@ieee.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b26sjadvk3fz44v6"
Content-Disposition: inline
In-Reply-To: <db05fb6a-2ea5-4e00-ac03-adc1897d96de@ieee.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--b26sjadvk3fz44v6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alex,

On Fri, Jan 26, 2024 at 08:56:33AM -0600, Alex Elder wrote:
> On 1/25/24 6:09 AM, Uwe Kleine-K=F6nig wrote:
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
> > allocated with devm_pwmchip_alloc().
>=20
> I think this looks good.  Two questions:
> - Should you explicitly align the private data?  Or do you believe
>   the default alignment (currently pointer size aligned) is adequate?

I'm not aware of a requirement for a higher order alignment (but I might
well miss something). I did my tests on arm, nothing exploded there.
Maybe the conservative approach of asserting the same alignment as
kmalloc would be a good idea. I'll think and research about that.

iio uses ARCH_DMA_MINALIGN, net uses 32 (NETDEV_ALIGN).

> - Is there a non-devres version of the allocation function?

Patch #109 introduces a non-devres variant. As it's not used it's a
static function though. Can easily be changed is a use case pops up.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b26sjadvk3fz44v6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWz540ACgkQj4D7WH0S
/k4oQwf+Nnq9bGZWZrbCQsHJYB54zfZt1whu2kQgdRMIQzT8HP7NadKhFCqs3Ob6
5xwIwbIpdczrpzHM25+5ZrTBiH5oSQ/Si0YMzglndL8Tm59GEJxcKoorYpDNplJR
xHL2owB7VgG87fFIvSCe163biS2vI/gIjAGvL9bpzcSH62Eq7EO3APk7Hx+h7d9e
QHLzzUmpN9JlrzYOhKE7Pu7/iVFPNqNb7FQtAOnamXe0kRLs05649mgdJ9q30gS8
imf9reDedsSG7sHM5NjtZpBQpF9H3vulzuGbH2MH2jNDLjtcpvUXUZpfijLN69iQ
GqSwNOqcwcXljLsP1A1wM8snNwzi/A==
=cXfD
-----END PGP SIGNATURE-----

--b26sjadvk3fz44v6--

