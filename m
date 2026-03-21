Return-Path: <linux-pwm+bounces-8320-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SElALsusvmmlWQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8320-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 15:35:55 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6962E5D32
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 15:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4B98300F126
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B694379ED1;
	Sat, 21 Mar 2026 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km+laChP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673D28689B;
	Sat, 21 Mar 2026 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774103715; cv=none; b=WqvcUBoF6OBxLgbGCpYJLoOC69iJGU3J65FTQimOrxqedrZtRUGEZjy61ltpxGCM3tHf0VRX5Fn9pZ1sI3OAelovZBr9zluBQP8eQDhzJuM9Yk7zrwOmUm1sGmiJbnKbQ+n6UFa/h53v57vCvPbOOUNVqEevlk4ETA8PGcsxg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774103715; c=relaxed/simple;
	bh=t7eS6BNztXPaIUR0HVv++sV18u11edlOqEYCGLdYT0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTp5T2tFtj2px3ptmJf0/fwbteKZCB+5nwu2zwbKPTBvmc3/HngDFGZeYYSIsyaOxmJ49gzSJTh7XuOooF+/oa7a7LYOMIuBN98fKcgJPMCZ8bOiB+kn0wnpDJwX3TJnBYW3cU0T59AatpEN7uWCHS5BAxw0ObigWALrH8wKoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Km+laChP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FB3C19421;
	Sat, 21 Mar 2026 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774103715;
	bh=t7eS6BNztXPaIUR0HVv++sV18u11edlOqEYCGLdYT0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Km+laChPryEJ07CoN1+1BD0ZI1DQpMdSmmJdoutMfpEcpRAcRFAhKzYk615aWPP6e
	 CINwkkBbSUb3clfKqT6Um9XE9DvsnXIdo3HanSaJvfDzK1kKUoikIXDm5iizEKjYcp
	 fwaCs6p5HXNQDU2HMWPV0TwqDl1K3MmUgg/AGLHazxxqvOX5z90B+XwBKAF3kXW/Cy
	 HKz9r3l3I7fu8pKMKHC6mz7UlwELaQm2J5ZXimHU3F+1zJDcS0nshgyMvut3GS0Zi1
	 KpUBtWhBPBH+d8GkrCtBfHJ0nNVaeqfjO/aZt75BAm/W18gVAxE710ypUJ81+dxwgL
	 rXpgNzal6ioew==
Date: Sat, 21 Mar 2026 14:35:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: iio: adc: add AD4691 family
Message-ID: <20260321143502.4a9cf6b9@jic23-huawei>
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-1-052c1050507a@analog.com>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
	<20260320-ad4692-multichannel-sar-adc-driver-v4-1-052c1050507a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8320-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url,analog.com:email,analog.com:url]
X-Rspamd-Queue-Id: 1A6962E5D32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 13:03:55 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add DT bindings for the Analog Devices AD4691 family of multichannel
> SAR ADCs (AD4691, AD4692, AD4693, AD4694).
> 
> The binding describes the hardware connections:
> 
> - Power domains: avdd-supply (required), vio-supply,

Bit odd to call out avdd-supply as required but not vio-supply


> ref-supply or
>   refin-supply (external reference; the REFIN path enables the
>   internal reference buffer), and an optional ldo-in-supply, that if
>   absent, means the on-chip internal LDO will be used.
> 
> - Optional PWM on the CNV pin selects CNV Burst Mode; when absent,
>   Manual Mode is assumed with CNV tied to SPI CS.
> 
> - An optional reset GPIO (reset-gpios) for hardware reset.
> 
> - Up to four GP pins (gp0..gp3) usable as interrupt sources,
>   identified in firmware via interrupt-names "gp0".."gp3".
> 
> - gpio-controller with #gpio-cells = <2> for GP pin GPIO usage.
> 
> - #trigger-source-cells = <1>: one cell selecting the GP pin number
>   (0-3) used as the SPI offload trigger source.
> 
> Two binding examples are provided: CNV Burst Mode with SPI offload
> (DMA data acquisition driven by DATA_READY on a GP pin), and Manual
> Mode for CPU-driven triggered-buffer or single-shot capture.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4691.yaml    | 173 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 180 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> new file mode 100644
> index 000000000000..def9f32c78af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> @@ -0,0 +1,173 @@
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
> +    * https://www.analog.com/en/products/ad4692.html

Odd ordering.  Put them in numeric order.

> +    * https://www.analog.com/en/products/ad4691.html
> +    * https://www.analog.com/en/products/ad4694.html
> +    * https://www.analog.com/en/products/ad4693.html
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
...

> +
> +  interrupt-names:
> +    description: Names of the interrupt lines, matching the GP pin names.
> +    minItems: 1
> +    maxItems: 4
> +    items:

I think this wants to be an enum.  Generally look for a similar example
and copy it + test the resulting binding with latest version of the
dts-schema.

> +      - const: gp0
> +      - const: gp1
> +      - const: gp2
> +      - const: gp3
> +



