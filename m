Return-Path: <linux-pwm+bounces-3349-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F333B983904
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 23:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FD4B2148B
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22C06F2F2;
	Mon, 23 Sep 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwmeCcrJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2617BA9;
	Mon, 23 Sep 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126432; cv=none; b=gAa06B0gZvzY5Oho3IEUhvKdbR5BGGt0AVo0BQhzoonkmNmzrf51+HH5cwod83qrr8PPHVnPNApv/6vkamgmtrzcRKO8H5sZulRYWJCuLbdVyq5Jad5zI3XL98zMZQH191Ivlw0zjKe2au3lUPcazEGoqXrM5x16nT/HBGC3mBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126432; c=relaxed/simple;
	bh=6vjF9h6w0iEBpOGjYebX1Lq37GOam2h0x4QliCpQwrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBv/RSFZDd67mGQKojsoS+TRPo5RhBb2BOxRZvimg91BczERdR7Xr3jvqqSsF8czu4toHVmnV8Nze+EEUuI02519PT9KgrLRFxNinBWRdZs4/OlL9SEIpRc11RCuDwQ+vmiUoHic29KZtnbr4MDUHPlQ8XafXfBidprflyg2k/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwmeCcrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72FCC4CEC4;
	Mon, 23 Sep 2024 21:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727126432;
	bh=6vjF9h6w0iEBpOGjYebX1Lq37GOam2h0x4QliCpQwrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwmeCcrJMyYBKFdoe86A3XvkH7w61IryBRX8M2uIqrA4Zcm0yf4vQYgIv7VTm568P
	 SXug/ALW0a1tAL634B7PzGii72GpabjqI3Cj6b9cVcbkycyAF55OwCuNTOhvfU311v
	 FxQZE9L9XuZIQ65RuDMGBEPPqEctMd0DPrlkDZSljb173zSy17hjIoIiiWmA45uaGh
	 6ivcVl6u2NAQb7bNh2tHy/i5oBWLcnN2upwJAqlY7wtG31/ukbAwkj2kamdIPzzR2E
	 euxON1ae4M9OobqRdxuQkjBJTcrlxHTnA7kaiNlowzEJoSDt53EzE+arxxGSHFivps
	 JTFFfL2Szq7dA==
Date: Mon, 23 Sep 2024 22:20:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Marius Cristea <marius.cristea@microchip.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: iio: adc: add ad458x
Message-ID: <20240923-yippee-symptom-77aaab7d99da@spud>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-6-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RKWl+KWZ2pFNeJy9"
Content-Disposition: inline
In-Reply-To: <20240923101206.3753-6-antoniu.miclaus@analog.com>


--RKWl+KWZ2pFNeJy9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 01:10:22PM +0300, Antoniu Miclaus wrote:
> Add devicetree bindings for ad458x DAS family.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad485x.yaml          | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad485x.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
> new file mode 100644
> index 000000000000..5f5bdfa9522b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad485x.yaml#

The filename should match one of the compatibles.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD485X DAS family device driver
> +
> +maintainers:
> +  - Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  Analog Devices AD485X DAS family
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
4858.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4858
> +      - adi,ad4857
> +      - adi,ad4856
> +      - adi,ad4855
> +      - adi,ad4854
> +      - adi,ad4853
> +      - adi,ad4852
> +      - adi,ad4851
> +      - adi,ad4858i

I take it that all of these devices have some differences between them?

Everything else here seems pretty okay.

--RKWl+KWZ2pFNeJy9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvHbmQAKCRB4tDGHoIJi
0uihAPsFIAcwaj9rm40O2Lclx/waGRS3P/spBRg1rFcbejwerQD/XCxmG3zGzKIf
P9268UDee4q7qdLW6O/r6SYrQgUxiQY=
=P/EX
-----END PGP SIGNATURE-----

--RKWl+KWZ2pFNeJy9--

