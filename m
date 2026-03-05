Return-Path: <linux-pwm+bounces-8190-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B4FJ9N7qWkg8gAAu9opvQ
	(envelope-from <linux-pwm+bounces-8190-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:49:23 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E46212106
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D5F5306A324
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4C739E6F0;
	Thu,  5 Mar 2026 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDxIZTHJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A639B4A9;
	Thu,  5 Mar 2026 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714668; cv=none; b=rYCIaF0iWB2jJLB34MX8Leaij/+QFhcG4wk59dhb35BycVKNcIwCS+FKIHtYnq1heJswqdLza3FgR5Nlrd51e++Ew+ryR/7BYdtO2K/Tu5dw2oYqkZc8NdmwBseGocdxbjwTruii3YilqhYiQm4p2/UegYquLTXjfh4bcUgCgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714668; c=relaxed/simple;
	bh=1w1RB447ldnhlv8Hxu9zjeDMNtNYv/NPl51WMASJdHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGcSQVLaLf6PoU9KSijosV1RXLeVCHeDXSmeD8EPGnyu2VCi2urciYYPhYHp5PSDKWDwzr1VJi/Vb+OH6ZGtsjfbM49TS2TVW8wag2Nib2yJ3qns3e1XDyLgJqLkBtYzV5o5iQ1OHSS2zz5V0NNevmviXCrLrIjpEOjtrCKf+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDxIZTHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB4FC116C6;
	Thu,  5 Mar 2026 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772714668;
	bh=1w1RB447ldnhlv8Hxu9zjeDMNtNYv/NPl51WMASJdHA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LDxIZTHJ2mYAqUYUpM4rqzZqtOy9udLdU1nPT/u3StPVOAxHfd1HkkpzQVNBSMNCH
	 tHAAbXHXvchUiXKghhZ/gTWDIczkMPjXTj5SXEg2l6KA5uZ9T7SNE2pTHnkOPGiC/N
	 R+jvYfQZkT5R0zYOrUApdyIuMpJE2gaQKcjZiWS0aIapVW/Gl7pvBkItwBaJNBWaqY
	 DspG8lnPxmxXQfJlwIaAI4BIe1+2wKsNdNXPNfblQVleHP6DcEQPVv0LznMOrZKC6L
	 i1iJ3VLPsiU1NRIuHz9lNYrs/PLJjveniEzGFvjojTShf9jVCLI39Fudl1ICZ2sB7K
	 1RYQ3uYn/pX2A==
Message-ID: <d77de930-d988-40ad-9b29-9bfe8f4584df@kernel.org>
Date: Thu, 5 Mar 2026 13:44:22 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add bindings for AD4691 family
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
 <20260305-ad4692-multichannel-sar-adc-driver-v1-1-336229a8dcc7@analog.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260305-ad4692-multichannel-sar-adc-driver-v1-1-336229a8dcc7@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 12E46212106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8190-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,baylibre.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 05/03/2026 13:23, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add YAML bindings and dt-bindings header for the Analog Devices AD4691

There are no such thing as YAML bindings. DT bindings.


> family of multichannel SAR ADCs (AD4691, AD4692, AD4693, AD4694).
> 
> The binding describes five operating modes selectable via the

No, describe the hardware, not binding.


A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18


> adi,spi-mode property, optional PWM/clock for CNV Clock and CNV Burst
> modes, GPIO pins, voltage supplies and the trigger-source interface for
> SPI Engine offload operation.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4691.yaml    | 278 +++++++++++++++++++++
>  MAINTAINERS                                        |   8 +
>  include/dt-bindings/iio/adc/adi,ad4691.h           |  13 +
>  3 files changed, 299 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> new file mode 100644
> index 000000000000..b0d8036184b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> @@ -0,0 +1,278 @@
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
> +  an SPI-compatible serial interface. The family supports multiple operating
> +  modes including CNV Clock Mode, CNV Burst Mode, Autonomous Mode, SPI Burst
> +  Mode, and Manual Mode.
> +
> +  The driver supports both standard SPI and SPI Engine (offload) operation.

Driver is irrelevant. If you change mode, you change bindings?

> +
> +  Datasheets:
> +    * https://www.analog.com/en/products/ad4692.html
> +    * https://www.analog.com/en/products/ad4691.html
> +    * https://www.analog.com/en/products/ad4694.html
> +    * https://www.analog.com/en/products/ad4693.html
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
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 40000000
> +
> +  spi-cpol: true
> +  spi-cpha: true
> +
> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Nope. You already have such property, so you cannot redefine it. Look at
other sources.

...


> +  clocks:
> +    description: Reference clock for PWM timing in CNV Clock and CNV Burst modes.
> +    maxItems: 1
> +
> +  clock-names:

Drop clock-names. Not useful if you call it just ref.

> +    items:
> +      - const: ref_clk
> +
> +  pwms:
> +    description:
> +      PWM connected to the CNV pin. Required for CNV Clock Mode and CNV Burst
> +      Mode to control conversion timing.
> +    maxItems: 1
> +
> +  pwm-names:
> +    items:
> +      - const: cnv
> +
> +  interrupts:
> +    description:
> +      Interrupt from the GP0 pin configured as DATA_READY or BUSY. Required
> +      for non-offload operation in all modes except Manual Mode (mode 4),
> +      where CNV is tied to CS and no DATA_READY signal is generated.
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: DRDY

Lowercase. Or actually drop names...

> +
> +  '#trigger-source-cells':
> +    description: |
> +      For SPI Engine offload operation, this node acts as a trigger source.
> +      Two cells are required:
> +        - First cell: Trigger event type (0 = BUSY, 1 = DATA_READY)
> +        - Second cell: GPIO pin number (only 0 = GP0 is supported)
> +
> +      Macros are available in dt-bindings/iio/adc/adi,ad4691.h:
> +        AD4691_TRIGGER_EVENT_BUSY, AD4691_TRIGGER_EVENT_DATA_READY
> +        AD4691_TRIGGER_PIN_GP0
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - adi,spi-mode
> +  - vio-supply
> +  - reset-gpios
> +
> +allOf:
> +  # vref-supply and vrefin-supply are mutually exclusive, one is required
> +  - oneOf:
> +      - required:
> +          - vref-supply
> +      - required:
> +          - vrefin-supply
> +
> +  # AD4694 (20-bit) does not support Manual Mode
> +  - if:
> +      properties:
> +        compatible:
> +          const: adi,ad4694
> +    then:
> +      properties:
> +        adi,spi-mode:
> +          enum: [0, 1, 2, 3]
> +
> +  # CNV Clock Mode and CNV Burst Mode require PWM and clock
> +  - if:
> +      properties:
> +        adi,spi-mode:
> +          enum: [0, 1]
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +        - pwms
> +        - pwm-names
> +
> +  # Non-Manual modes (0-3) without SPI offload require a DRDY interrupt.
> +  # Offload configurations expose '#trigger-source-cells' instead.
> +  - if:
> +      properties:
> +        adi,spi-mode:
> +          enum: [0, 1, 2, 3]
> +      not:
> +        required:
> +          - '#trigger-source-cells'
> +    then:
> +      required:
> +        - interrupts
> +        - interrupt-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/iio/adc/adi,ad4691.h>
> +
> +    /* Example: AD4692 in CNV Clock Mode with standard SPI */
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad4692";
> +            reg = <0>;
> +            spi-cpol;
> +            spi-cpha;
> +            spi-max-frequency = <40000000>;
> +
> +            adi,spi-mode = <0>; /* CNV Clock Mode */
> +
> +            vio-supply = <&vio_supply>;
> +            vref-supply = <&vref_5v>;
> +
> +            reset-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
> +            gp0-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
> +
> +            clocks = <&ref_clk>;
> +            clock-names = "ref_clk";
> +
> +            pwms = <&pwm_gen 0 0>;
> +            pwm-names = "cnv";
> +
> +            interrupts = <12 4>;
> +            interrupt-names = "DRDY";
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/iio/adc/adi,ad4691.h>
> +
> +    /* Example: AD4692 in Manual Mode with SPI Engine offload */
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad4692";
> +            reg = <0>;
> +            spi-cpol;
> +            spi-cpha;
> +            spi-max-frequency = <31250000>;
> +
> +            adi,spi-mode = <4>; /* Manual Mode */
> +
> +            vio-supply = <&vio_supply>;
> +            vrefin-supply = <&vrefin_supply>;
> +
> +            reset-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/iio/adc/adi,ad4691.h>

Where do you use the header?

Anyway, drop example, two are enough.


Best regards,
Krzysztof

