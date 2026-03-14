Return-Path: <linux-pwm+bounces-8260-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDMqJ/Z+tWmK1AAAu9opvQ
	(envelope-from <linux-pwm+bounces-8260-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 16:29:58 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B8F28DAFE
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 16:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C076830094E2
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6D2FE056;
	Sat, 14 Mar 2026 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AmPw74tL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185D2E03F2
	for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773502195; cv=none; b=nSe1TJc8UB4bdDCp8P90ouerG3IhBx+4OazSmVSaAYaD7Ulo/qEaYsRGOi6+bsCTsL08m+T/XMpYS/T4iXd88TIZ15LuZyrhM1Ql1VGAQ8c80/OIurjs0L2Z2X2cKOLZWQqTGSLS6W/KWmYaIQF+RO8mCeyQeyM+kecz5wU5xsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773502195; c=relaxed/simple;
	bh=qx/loJ+nJsLs+1vSgg0MO76kHfZg2hNO2DOfOaemHwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAzmmmgIHQu24I9mKvSYT2bCaw+A9JJcVy9mH3SPa6v5z/bYKir4VGUphON9/+lQgr79nZNWeQ+THG96AMSwJeWfPGI5nbL31/MgSFfiVUSLlZO0d6kYmxiv0NoBB2y446biOO52eroBYf/lfsir2PfA6EGX5QJIM1+aifBbRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AmPw74tL; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40ea36b56b7so2298746fac.3
        for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773502190; x=1774106990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7uFlD08MptP0EXYCAMvyKNjPMZade8ZdNS7/hJcx2vI=;
        b=AmPw74tL1EEmrxKL9jRVvFNQbbeqdOtR+IfwOnp4NeSCy1BaELsJQ08KCZMVCsdvd2
         8kzlMagJY7yuLaN3pdL6L4X+Y4O54LpuFNaALdycHIUdH1pv3LjKvWwx3H5mvYtbY2+S
         sXRzmIvFsd6fDUFDgIqeRP8QM5Z+Fi7JxtuRdKqV9O89BNXu7T+TBDUsNkJF1HWnXjD0
         ojjfPCcuv92LC12L6rpbo7tpmS4cf1OntWgf3YxKlSWCzGVkV1Bsf85NjIxsFo8Hv2K8
         RdkNeAO+54LfhHvuhLAhfOQQZKcJf4DskeXJf6t9eKXVevpOrVkOJ1iIfN4vuPbbZqMX
         7YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773502190; x=1774106990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uFlD08MptP0EXYCAMvyKNjPMZade8ZdNS7/hJcx2vI=;
        b=hu1o01ROAQBW+tX65ZEJQOtBLL0RcBLhzDBEfeYDeMuj+7iYFuMey/3A3i69hHG1kP
         WQokFhV1+6rZXceyYniAmrXGVtRSSokEQJlTUU5uhufCmmQ6WM4immqzR3HSBwTHw7IQ
         hM8Hh+XoIzubq8docZ/SXW/T/KWR8r/oFcKXuV6++Rmdub5XUSG5Val0UNatfuE6iKgc
         p7xoB6ZDatmiWH3HGUybSYbxkZqTC/oB7PM7UlQ6r2q45hkd1E+DNkerObvx98dhGCau
         JvpSzwC1ZhkTvEPhAl6xJKDqNHQDXUcTO+8xoqIBx7Q+UqeWEWygPFHNSQ2LGLuJX5Rv
         Zoiw==
X-Forwarded-Encrypted: i=1; AJvYcCV4bKHFzDai8Ku6oapdgZ8RnhpoiYNjU+k+bdquYiSVcmc7KNu3kk212vK8OwqJcEx9WYOqGvMLKbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3JtUGuVeTonOSO1p2J4S1A/wzoAJ9XW2qm/boALKdOcvo+Dn/
	nu0tK0M/fK3ANoUQVr4SszN+3zESatVFgRgnrx/KyqY1ZO8NiAG0oio2b2quXoD5BfQ=
X-Gm-Gg: ATEYQzwvxdrWKHl+Quhu/Nz419HZgdhfZflVpy36XJxjmKmFoqmgZ3YEg2SZ0KedMbM
	lklJp3q9g0j5OVSx+LZyYBW2zWGLo280ZvU2U84tnr17KCZyQQKcx5blnBklC5kvmw5sxICVoSF
	koKSxqjjv2VvGAjjZS5VZe66V6WPw/olYUtRn6gN+wFYJ7zm4n0Oo7OrSSTKTWXWpGFc1zqk+R5
	4yOCEUchS3QrKnnsxKZ1uK9G+mIZNRiBn63O+XDKsvMOAcsWOdbPuKtbvBNVAWvD219jAEOVPv2
	+D81Su+iFql10jLYutpxtK7LgaA2lifcfcEezJPTHearJwXbKzOuwNGzQbtj6k6xLTsC8oY04iR
	1igkwQEUmo0i7C/MvvoMBNnrW8K/f7XPmYtDRtfMsN90Jlqb7V0FBovEQcAGoHCFtAPLSn8Up8r
	AZq8KdyFYfoNc9euF0mAUmLWBHjaeMZKx+zppxAkuBnq5hCOmr8YP+pr5VxOpSfkNGzxgU50JvN
	3sBLqQyxUMQ
X-Received: by 2002:a05:6870:30a:b0:417:33b7:8c3c with SMTP id 586e51a60fabf-417b93ef429mr3929979fac.36.1773502189651;
        Sat, 14 Mar 2026 08:29:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e94b4sm10487225fac.11.2026.03.14.08.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 08:29:49 -0700 (PDT)
Message-ID: <a1824f39-3925-4e94-ac98-52dcdfbaa0d2@baylibre.com>
Date: Sat, 14 Mar 2026 10:29:48 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8260-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,analog.com:url]
X-Rspamd-Queue-Id: 00B8F28DAFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 5:07 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add DT bindings for the Analog Devices AD4691 family of multichannel
> SAR ADCs (AD4691, AD4692, AD4693, AD4694).
> 
> The binding describes the hardware connections: an optional PWM on
> the CNV pin selects CNV Clock Mode; when absent, Manual Mode is used
> with CNV tied to SPI CS. GPIO pins, voltage supplies, and the
> trigger-source interface for SPI Engine offload operation are also
> described.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4691.yaml    | 180 +++++++++++++++++++++
>  MAINTAINERS                                        |   8 +
>  include/dt-bindings/iio/adc/adi,ad4691.h           |  13 ++
>  3 files changed, 201 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> new file mode 100644
> index 000000000000..a9301e0ca851
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> @@ -0,0 +1,180 @@
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
> +  an SPI-compatible serial interface. The ADC supports CNV Clock Mode,
> +  where an external PWM drives the CNV pin, and Manual Mode, where CNV
> +  is directly tied to the SPI chip-select.
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
> +  vio-supply:
> +    description: I/O voltage supply (1.71V to 1.89V or VDD).
> +

Missing avdd-supply and ldo-in-supply.


> +  vref-supply:
> +    description: External reference voltage supply (2.4V to 5.25V).
> +
> +  vrefin-supply:
> +    description: Internal reference buffer input supply.
> +

It always confuses me when "v" is added to the pin name. Generally, "VREF"
is an internal signal and "REF" is the actual pin name. So it makes more
sense to me to call these ref-supply and refin-supply.

> +  reset-gpios:
> +    description: GPIO connected to the RESET pin (active high).

Datasheet says "Active Low".

> +    maxItems: 1
> +
> +  clocks:
> +    description: Reference clock for PWM timing in CNV Clock Mode.
> +    maxItems: 1

I feel like I asked this already, but which pin is this clock connected to?
It sounds like it is the clock for the PWM, not the ADC. So it does not belong
here.

> +
> +  pwms:
> +    description:
> +      PWM connected to the CNV pin. When present, selects CNV Clock Mode where
> +      the PWM drives the conversion rate. When absent, Manual Mode is used
> +      (CNV tied to SPI CS).
> +    maxItems: 1
> +
> +  pwm-names:
> +    items:
> +      - const: cnv

Usually, we don't have a name when there is only one.

> +
> +  interrupts:
> +    description:
> +      Interrupt line connected to the ADC GP0 pin. GP0 must be physically
> +      wired to an interrupt-capable input on the SoC. The ADC asserts GP0 as
> +      DATA_READY at end of conversion, used both for non-offload CNV Clock Mode
> +      operation and for SPI Engine offload triggering via '#trigger-source-cells'.
> +      Not used in Manual Mode, where CNV is tied to SPI CS and no DATA_READY
> +      signal is generated.
> +    maxItems: 1
> +
> +  '#trigger-source-cells':
> +    description: |
> +      For SPI Engine offload operation, this node acts as a trigger source.

I don't think we need to call out SPI offload here. In theory, this could
also also be used for synchronization with something else.

> +      Two cells are required:
> +        - First cell: Trigger event type (0 = BUSY, 1 = DATA_READY)

I'm wondering if we really need to specify the event type. For interrupts,
we we just specify the pin and not the function when the pin has more than
one possible function.

I know that we have done something like this on some of the previous SPI
offload devices. So maybe there was a good reason for it. Or maybe I just
had tunnel vision at the time.

I suggest we try implementing this with just one cell that specifies the
physical pin. In the driver, when SPI_OFFLOAD_TRIGGER_DATA_READY is
requested in the driver, we can use that to program the function of the
pin accordingly. 

> +        - Second cell: GPIO pin number (only 0 = GP0 is supported)

If GP0 is the only possible pin for an output, we should omit the cell. If
there are more possible pins, we should document them (even if the driver
doesn't support it).

> +
> +      Macros are available in dt-bindings/iio/adc/adi,ad4691.h:
> +        AD4691_TRIGGER_EVENT_BUSY, AD4691_TRIGGER_EVENT_DATA_READY
> +        AD4691_TRIGGER_PIN_GP0
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
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
> +  # CNV Clock Mode requires a reference clock.
> +  - if:
> +      required:
> +        - pwms
> +    then:
> +      required:
> +        - clocks
> +
> +  # CNV Clock Mode (pwms present) without SPI offload requires a DRDY interrupt.
> +  # Offload configurations expose '#trigger-source-cells' instead.
> +  - if:
> +      required:
> +        - pwms
> +      not:
> +        required:
> +          - '#trigger-source-cells'
> +    then:
> +      required:
> +        - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    /* Example: AD4692 in CNV Clock Mode (pwms present) with standard SPI */
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
> +            vio-supply = <&vio_supply>;
> +            vref-supply = <&vref_5v>;
> +
> +            reset-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;

I would expect reset to be active low to match the hardware.

> +
> +            clocks = <&ref_clk>;
> +
> +            pwms = <&pwm_gen 0 0>;
> +            pwm-names = "cnv";

Should we also include the trigger in this example?

> +
> +            interrupts = <12 4>;
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    /* Example: AD4692 in Manual Mode (no pwms) with SPI Engine offload */
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
> +            vio-supply = <&vio_supply>;
> +            vrefin-supply = <&vrefin_supply>;
> +
> +            reset-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61bf550fd37c..9994d107d88d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1484,6 +1484,14 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170-4.yaml
>  F:	drivers/iio/adc/ad4170-4.c
>  
> +ANALOG DEVICES INC AD4691 DRIVER
> +M:	Radu Sabau <radu.sabau@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> +F:	include/dt-bindings/iio/adc/adi,ad4691.h
> +
>  ANALOG DEVICES INC AD4695 DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  M:	Nuno Sá <nuno.sa@analog.com>
> diff --git a/include/dt-bindings/iio/adc/adi,ad4691.h b/include/dt-bindings/iio/adc/adi,ad4691.h
> new file mode 100644
> index 000000000000..294b03974f48
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/adi,ad4691.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_ADI_AD4691_H
> +#define _DT_BINDINGS_ADI_AD4691_H
> +
> +/* Trigger event types */
> +#define AD4691_TRIGGER_EVENT_BUSY	0
> +#define AD4691_TRIGGER_EVENT_DATA_READY	1
> +
> +/* Trigger GPIO pin selection */
> +#define AD4691_TRIGGER_PIN_GP0		0

Could probably do without a macro to give GP0/1/2/3 names since
it will be pretty obvious that 0 = GP0, etc.

> +
> +#endif /* _DT_BINDINGS_ADI_AD4691_H */
> 


