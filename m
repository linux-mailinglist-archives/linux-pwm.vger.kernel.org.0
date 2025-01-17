Return-Path: <linux-pwm+bounces-4669-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B492A1565F
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 19:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9340E188B9A8
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 18:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D31A2557;
	Fri, 17 Jan 2025 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdUL0ShK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4BA185B72;
	Fri, 17 Jan 2025 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137901; cv=none; b=oTffIcndv0mIz7CudQ6KY9U7IQCcMCrqU/aTo/hm973KBuJTgeyTNEccoo1tkJDusGefLRTnQO1/OKrIpG15yZskup1u4dUGsOF1sNEnvGW/g2aEwoFS8K3Ht6lLazkw5BnnY8QEsZqUkpCptTRngD7Nm0ZCW/4G1RJcraDIykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137901; c=relaxed/simple;
	bh=IkDrbW9Xz/Rj76jRBnX2g1l/gxWSPyrI6vR3EVGn+zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB9aKb0znhPzjYI/XhRAqiEExoQoVFlNvzUNeXwd7HRtp/qU0WmnwNObZnCNPZQ++DaFITDcanlSXmYObnmNOmk1sQIK4zJ5HioD5XiRCsX54zUfwSoWPtTt7w2n2PNwhevmoAvf26UrVoPAH/18gCN2OETB60m4mQIJUaqTd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdUL0ShK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32ABC4CEDD;
	Fri, 17 Jan 2025 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737137901;
	bh=IkDrbW9Xz/Rj76jRBnX2g1l/gxWSPyrI6vR3EVGn+zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdUL0ShKBeuRvdhL09obg5RFon7+j8JxfEBcRWSe+irS3EKpG0dWeNt+aPw+Dp7wv
	 KA21YGkEzYeyukvt8hU9UyvZdtyXPdW/b1x/0iPWDGv+6auVaKiSYMGKcxWqs7VKY3
	 tk/yv5JGPpQvKFHSehMLIp+615PLcbkk4QeMuVFCdSZc19TgODXgyB2CxMLfKrHZ1h
	 Ww8Wuw9G+gS5+ZSLUwcCCvZ1nFdrG/j9InybcWU/6sNLCA5ruyVbgQSLaXTNYXfjqF
	 AfFBOJdh961MYvF8l0Rn40FQ2AoUgtNqJd/mU3TooKYsSfCptWfBHOyyRHm4pyrVzZ
	 2yYPQr6ciVJPg==
Date: Fri, 17 Jan 2025 18:18:14 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 14/17] iio: adc: ad4695: Add support for SPI offload
Message-ID: <6458a3e4-594a-44bc-9593-94d115013c1d@sirena.org.uk>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
 <20250113-dlech-mainline-spi-engine-offload-2-v7-14-e0860c81caae@baylibre.com>
 <ls32gl5a7nsihmmpfabxhm6ilg7idyxdhyrhbkay6e2fiokoah@o5ujfxlsq3s3>
 <67dc52c4-5252-40c3-b89e-8e46e3c2df27@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0t/j82dteYeqOTeG"
Content-Disposition: inline
In-Reply-To: <67dc52c4-5252-40c3-b89e-8e46e3c2df27@baylibre.com>
X-Cookie: Q:	Are we not men?


--0t/j82dteYeqOTeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 17, 2025 at 11:09:03AM -0600, David Lechner wrote:

> Indeed, thanks! Hopefully we won't need a v8 and Jonathan can fix while
> applying. :-)

FWIW I need to do another proper pass through but from a quick scan and
my review of previous versions unless anyone else raises something my
plan is to apply the SPI bits at -rc1.

--0t/j82dteYeqOTeG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeKnuUACgkQJNaLcl1U
h9CY/gf/U/y5XETmsc/euck9OFgyb09Z+PAf44fGbTLf8T0ZqU71zkvv1jDwGolH
yQFKL0xZ+cGjIpCgPq1KE2K9tbiQrJzm4FoYBcvF34oNQ0XUL4aXhYf/LrDX82Df
vMEGG8+zg1EhJianijXsJmANEcCd0s2yAeJ7AyXanIvYd0b660tVKJiprbH7cjAe
Hfvy19d1ztyWwhmfC3dC4oCBD4mx7/UY9vCFVIRs0qiL05szjWycenV3jRtDIpbJ
/gMMeS+xwezQTvMPBXyzOpDZhHaJjousulYKS3wARPrZNT/keY/h2fVOTWPFBDId
IkMuJoXK5Cxi3rubqugFlOvPzmP5Nw==
=VwEQ
-----END PGP SIGNATURE-----

--0t/j82dteYeqOTeG--

