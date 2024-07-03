Return-Path: <linux-pwm+bounces-2690-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 922F7926043
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 14:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCD6B23CB6
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C64D174EF0;
	Wed,  3 Jul 2024 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCbVUmnt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9313B5B2;
	Wed,  3 Jul 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009105; cv=none; b=kaYdWvJLFZH0hyFWDmZKPoaWcfFFxnpFkt0S3wJiR4AKJZf1vOeNZfZc2S5AX4UQGwr6vnZrSXDgqgJ3hO6swwQGseKoh5U7nr8VjD/p8GHSucMRsUUh6Flew54XvhoSPATcJ7lxKF5KgO7FsvkX+wt0ccRSbvv9k3p1j4y/HS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009105; c=relaxed/simple;
	bh=Xz7XmnRcHbAH6WxQfIQCBQ5wwm0Koi8PJNYau32jfTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNNMDOBvdjiHMhZLj66w5UNwRWceYeu+8bzgXnjNTMTIflhwOGZANT49CYmnPn1GPtNUY6MWP/wRz08i/0F8+1FSA8gWYUxm7PlPjMqGQHI6EUQrmEeQYKgzQVEk+B/QLKhfVElueJraSzCTmKtWQTUPj78jtnd7oS1OvB1ZDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCbVUmnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F95C32781;
	Wed,  3 Jul 2024 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720009104;
	bh=Xz7XmnRcHbAH6WxQfIQCBQ5wwm0Koi8PJNYau32jfTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCbVUmnt6oKYedEVrXZokdmKNt/p56purKTjCPdu0I8notvhvSyIsFOxSIKsFqou5
	 15hwrXirnYeswH2fOKq4ePLXX/YqLrncJb+P2lL+FSGeV+lT+Ugb7jGGB8N/GemJUs
	 +s6AUvm4uXUiUubO2m8SRwgfVqiVI3bvHoZti8n9IfR1YWhDri+qAhR2D7CazE1WSi
	 DYXxisSjZuUy2EQgUJ11OqsC/jJ7WgMnwY5ys4wyKQgby7dbRQmA+Q6M3Sd7ECpY3T
	 6Yqt2c9ssuH177wbJ9Lx55K8mWXoPJt5OCcSCJr0+WBF71zu9mH49RClhXFAnHdpSc
	 2Pv2Acp8/4HDQ==
Date: Wed, 3 Jul 2024 13:18:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Richard Leitner <richard.leitner@linux.dev>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	llvm@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 17/20] ASoC: arizona: convert to
 of_property_for_each_u32_new()
Message-ID: <7f057c8b-9b76-4e31-a3cf-b82e52618529@sirena.org.uk>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
 <20240703-of_property_for_each_u32-v1-17-42c1fc0b82aa@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NvGtanZygkHeLcw1"
Content-Disposition: inline
In-Reply-To: <20240703-of_property_for_each_u32-v1-17-42c1fc0b82aa@bootlin.com>
X-Cookie: There is a fly on your nose.


--NvGtanZygkHeLcw1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2024 at 12:37:01PM +0200, Luca Ceresoli wrote:
> Simplify code using of_property_for_each_u32_new() as the two additional
> parameters in of_property_for_each_u32() are not used here.

Acked-by: Mark Brown <broonie@kernel.org>

--NvGtanZygkHeLcw1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaFQYAACgkQJNaLcl1U
h9AylQf9G8/SGzOMtUK0KB/AFXzHYIfp3WpSO5hnxcx+E5C7ZK4bjWCUH/uunXlj
F4Jf8unGlljKf05YliMJQdU+V6rteVrAjhbODBpOyO3KgNcahTjDSsdel5a8kNxy
xs3TjgeAoSA6aWSldnG9epfMTrso4U2krM6J7EpllETpHMhVEr19Tk/DczdltAFA
mqPoVSFfTNlYtiXK1/0dRLf9DiwVXVKh0Pg13G8lYTkxUb51nVwvoBAxCQ0kLhYc
whKK5upczFTpJCDEyHz17yMu3fWXyZaYCDCzPbqLkycwsy6u21KKM5tAvMr8o2Xd
zlsu2XFciX4F1nPtsj9mR7UcMVjyRw==
=W6f6
-----END PGP SIGNATURE-----

--NvGtanZygkHeLcw1--

