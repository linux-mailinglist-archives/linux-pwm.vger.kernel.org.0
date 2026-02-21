Return-Path: <linux-pwm+bounces-8138-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENQ4H+OMmWkPVAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8138-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 11:45:55 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A8516CB2A
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 11:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D62E73002D0E
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C7D29C321;
	Sat, 21 Feb 2026 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP/jLBuy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E97478;
	Sat, 21 Feb 2026 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771670747; cv=none; b=YQ1MS7rboxz2rL6ZQesH13yo4cw+mGLm52SWU9DOICWGALP8Xz7ZmgG7VfCN7t0sfWupvG4+DYkQpxb3Mdp9IIDaSk2Bm5sWhwjxsqtBBKEnFbHJYS3D+lcWAR3Jku93sAWOruCi8f7GdeSJvdGVMPgd8RbDEWGKKQXvSpmVI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771670747; c=relaxed/simple;
	bh=6w5AFWGESxVsJxi5o5K/W9EDj8OY0DHZFLXqiDlNzf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDFUNafMuFw00JJhdembI/sVAPUuX9xGNANtuYpkdvcIQ6vtsxSUzlcA4mvECIJdT9MtQBu+aEF5TDd5wXcPkLAWKAgFt74ZSnsFbBPsD9hZGIB3p9IwnSTr0mFCGMKPJRF3euxx5R7tu52mzhHDw8dmK+8cNGswev1VQr9LTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP/jLBuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29944C4CEF7;
	Sat, 21 Feb 2026 10:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771670747;
	bh=6w5AFWGESxVsJxi5o5K/W9EDj8OY0DHZFLXqiDlNzf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kP/jLBuyJ7mG2T8bWHP+cZEt95GmMiQo2WKailkAe3G3+HU5LKNQ3wuRgWZzrIhCf
	 zlzUmJwDLGBV0O4iIplMgFOX/bffpa+cBDAslMcF0Zkf27WA4Y0eSPGl71KytT7ByM
	 NwGRI0fJBEIj/5XbPi4Eh0lQcKtHKtIyRlTjNYGv2xcUWWp/Qaq2yVMGcfy1cDgxbG
	 lagH74t5bJZ5fVP0NML3YuqvyzzRmhEAj9fSdUVDAQ2UbWBYpCZwMU/py7mFKKPmHr
	 rWLD5HdmTbUBgnuuyoile58Zw/wmXm9223jaM08aRf/LzUPO2u4a8grjzhnQjcfjOs
	 WvjauG0d+BvOg==
Date: Sat, 21 Feb 2026 11:45:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: dac: Add binding for AD5706R
Message-ID: <20260221-slick-belligerent-trout-3f897c@quoll>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
 <20260220-dev_ad5706r-v1-1-7253bbd74889@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220-dev_ad5706r-v1-1-7253bbd74889@analog.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8138-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,devicetree.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1A8516CB2A
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 04:02:56PM +0800, Alexis Czezar Torreno wrote:
> Add device tree binding documentation for the Analog Devices
> AD5706R 4-channel 16-bit current output digital-to-analog converter.

A nit, subject: drop second/last, redundant "binding for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..dabaf2195a07d2c66d44f69ca60e32e6bc37cf55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5706r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5706R 4-Channel Current Output DAC
> +
> +maintainers:
> +  - Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> +
> +description: |
> +  The AD5706R is a 16-bit, 4-channel current output digital-to-analog
> +  converter with SPI interface.
> +
> +  The driver supports dynamic SPI clock rate management via an external

So this is DAC or driver? If driver, what does it drive?

> +  clock generator (e.g., AXI CLKGEN) referenced by the 'clocks' property.
> +  This allows separate read and write SPI speeds to be configured at
> +  runtime.

How binding has anything to do with runtime? What are you describing
here?

> +
> +  Datasheet:
> +    https://www.analog.com/en/products/ad5706r.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5706r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:

So that's SPI then you miss $ref and unevaluatedProps. Look at other
bindings.

> +    maximum: 100000000
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Reference clock for SPI clock rate management.
> +
> +  clock-names:
> +    items:
> +      - const: spi_clk

Drop clock names, pretty redundant.

> +
> +  pwms:
> +    maxItems: 1
> +
> +  pwm-names:
> +    items:
> +      - const: ad5706r_ldacb

No point to add device name in the input name.

> +
> +  dac-resetb-gpios:

So reset-gpios?

> +    maxItems: 1
> +    description: GPIO connected to the active-low reset pin.
> +
> +  dac-shdn-gpios:

Please read gpio-consumer-common.yaml

> +    maxItems: 1
> +    description: GPIO connected to the active-high shutdown pin.
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - clocks
> +  - clock-names
> +  - pwms
> +  - pwm-names
> +  - dac-resetb-gpios
> +  - dac-shdn-gpios

No supplies? How does it get power or reference voltage?

> +

Here, missing allOf with ref


> +additionalProperties: false

And that is unevaluated.


Best regards,
Krzysztof


