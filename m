Return-Path: <linux-pwm+bounces-8538-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNsWBd7P12mrTAgAu9opvQ
	(envelope-from <linux-pwm+bounces-8538-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 18:12:14 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5705F3CD75F
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 776B730160D1
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2026 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09680331209;
	Thu,  9 Apr 2026 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD+Traxk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D462F83A2;
	Thu,  9 Apr 2026 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750232; cv=none; b=crMY1ud/zaoJCbnSx/bAZFJAtrIE6+pcZWIoMIRsd5ncFe1kUtxhM7kgCT17AY1IqxnC4DQJsLZ+yo1GyhZ98EWVyOyPHzyKy6pz844F8g4iY6uThl+gNzMyidPDHOkQrX1CunvcxT0V3RtcrWP0CbXWmU9SkSIEhbBALATG88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750232; c=relaxed/simple;
	bh=WR+qzP41usMsL+U2CHUcv+sT27DtSgM6KltIpwfZcnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMJkXW5qszJ5WEAjzZPsgLI4jcmmayMXNupt+lhNzjXMytmcCgYigQjOPbnmDWzlTNUSLQ+YE8kdmAktT5laiGzWYsLmko8JGs4EeDpw6GZ8fWgH6fvLbzcmE2P+YWtJizWpp3UjMxCo9hrxLdoD5GzZ1tNf6bRwGpvo6E1Z98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tD+Traxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768C0C4CEF7;
	Thu,  9 Apr 2026 15:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775750232;
	bh=WR+qzP41usMsL+U2CHUcv+sT27DtSgM6KltIpwfZcnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tD+TraxkBSWzV1OrvrD/QSp3BLnXIyQ/r5VEw6Ssz3oVkX62k9yBe3TLQioa/1soi
	 pwx5mlxqS6foCBa5LNeuMMUU16bHPdrWEfieNxK+dyyT+lyEaiFtCE2rRc+83+PC5a
	 K/2pOvpJ0ECptyYkObH3plHWEH1NYAkS6HHUESwGZki2P/UqMiwpiIZjucJN39BENx
	 OBo4WsN5BqX+ULmrxtpN3dIJnAgIXmLrFEp5Co2xDwD5ek+foaAd2xxGQHGc7qHwRt
	 Xqb9KwwQypnh1KRJ3vALlj/mwQqaexs+JkfB5teKHDpMco9wLLTzVsA+gA/tSA3FGc
	 FYT/GUmKcq9yQ==
Date: Thu, 9 Apr 2026 16:57:06 +0100
From: Conor Dooley <conor@kernel.org>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 1/6] dt-bindings: iio: adc: add AD4691 family
Message-ID: <20260409-headwear-condense-c119f423095b@spud>
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-1-be375d4df2c5@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6AiVT6msxNHZX0tI"
Content-Disposition: inline
In-Reply-To: <20260409-ad4692-multichannel-sar-adc-driver-v7-1-be375d4df2c5@analog.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8538-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,analog.com:email,analog.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 5705F3CD75F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--6AiVT6msxNHZX0tI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 06:28:22PM +0300, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add DT bindings for the Analog Devices AD4691 family of multichannel
> SAR ADCs (AD4691, AD4692, AD4693, AD4694).
>=20
> The binding describes the hardware connections:
>=20
> - Power domains: avdd-supply (required), vio-supply, ref-supply or
>   refin-supply (external reference; the REFIN path enables the
>   internal reference buffer), and an optional ldo-in-supply, that if
>   absent, means the on-chip internal LDO will be used.
>=20
> - Optional PWM on the CNV pin selects CNV Burst Mode; when absent,
>   Manual Mode is assumed with CNV tied to SPI CS.
>=20
> - An optional reset GPIO (reset-gpios) for hardware reset.
>=20
> - Up to four GP pins (gp0..gp3) usable as interrupt sources,
>   identified in firmware via interrupt-names "gp0".."gp3".
>=20
> - gpio-controller with #gpio-cells =3D <2> for GP pin GPIO usage.
>=20
> - #trigger-source-cells =3D <1>: one cell selecting the GP pin number
>   (0-3) used as the SPI offload trigger source.
>=20
> Two binding examples are provided: CNV Burst Mode with SPI offload
> (DMA data acquisition driven by DATA_READY on a GP pin), and Manual
> Mode for CPU-driven triggered-buffer or single-shot capture.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4691.yaml    | 162 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 169 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> new file mode 100644
> index 000000000000..81d2ca4e0e22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4691.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4691 Family Multichannel SAR ADCs
> +
> +maintainers:
> +  - Radu Sabau <radu.sabau@analog.com>
> +
> +description: |
> +  The AD4691 family are high-speed, low-power, multichannel successive
> +  approximation register (SAR) analog-to-digital converters (ADCs) with
> +  an SPI-compatible serial interface. The ADC supports CNV Burst Mode,
> +  where an external PWM drives the CNV pin, and Manual Mode, where CNV
> +  is directly tied to the SPI chip-select.
> +
> +  Datasheets:
> +    * https://www.analog.com/en/products/ad4691.html
> +    * https://www.analog.com/en/products/ad4692.html
> +    * https://www.analog.com/en/products/ad4693.html
> +    * https://www.analog.com/en/products/ad4694.html
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4691
> +      - adi,ad4692
> +      - adi,ad4693
> +      - adi,ad4694

Please add a note to the commit message about why these devices are not
compatible. With that,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--6AiVT6msxNHZX0tI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadfMUgAKCRB4tDGHoIJi
0g4LAQCDFiL/WYpD2A+CMZGioBuUJdp7MxiycZ1eF9K+aAushQD+K4LkAPI6pd7C
hvPe16l+EF68AU12LiKpOM8XZ7AdZAg=
=it+N
-----END PGP SIGNATURE-----

--6AiVT6msxNHZX0tI--

