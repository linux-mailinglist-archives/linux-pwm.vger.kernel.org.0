Return-Path: <linux-pwm+bounces-6305-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E9FAD5CF0
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 19:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6630C1BC2878
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1489202C5A;
	Wed, 11 Jun 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvFSriKg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690941DF965;
	Wed, 11 Jun 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662308; cv=none; b=XlYrx/ZrjslIknRs8WCJ/e0Ho6ZO+ginbkSKEMJBzc+1j5ZMiPLcc2EHJx5BAuxE+PIDnLyf9QYFknqsNFEeS9rbi9utdljtl8bOaFdC/jMVfCCc3UE9tgEK6EB6wAsQFboTZ/AxLVGdyPp7YsMJb+svo9v4f+dLEFg0uowtxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662308; c=relaxed/simple;
	bh=AI6nwtL91L7/jbebmz0uQyJ2i4b8lfSibUAPx0RCDSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGgZHDOTIDHWYV//Er08v3lBUzfR8uK66t7lSpSD5ZAunZRvIk1sVVw9fkY9XIx5J+uA1DXBKjBysZMzCi2+oIHlBb9zPJguRMYmOm+ea1Q/KsdEFSLSRhBoHK3clOuV2Z8x8o4f0cuWwtrD4pAYwXvt0sUNrx03dV4IKlMpDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvFSriKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3245C4CEE3;
	Wed, 11 Jun 2025 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749662307;
	bh=AI6nwtL91L7/jbebmz0uQyJ2i4b8lfSibUAPx0RCDSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SvFSriKgALRpcmHblJGnGEF0ZVNoMSYVj0v1I6A8ru8pd9KOSXA7ryrOvHmuQjFTV
	 fTX4g5w/c45kT/VIYdRB5wW1yeF8M6/9R/mS34GYw+7aLFhHulbNOfuaZ/slg8rfDu
	 qQfJZMCuNSEolPYTai+Sq8uRzZPT/SGQePcICiuQiE4pe6ljNSyrZBeug1psfdp/yO
	 OkBswwxWcUOtjNcqVW3hrx1vGZKM4IlYtwm88P2P20Evep9qD6fv8fE7UxowZPqoKY
	 OpQAwe0xotdn5hBCVgZJvR+iuyD1XIb/QWIg9+vNskGXhEzumCVO44f1ioHZv9EmDF
	 VLIW9sJkQDi6Q==
Date: Wed, 11 Jun 2025 18:18:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <20250611181818.14d147c7@jic23-huawei>
In-Reply-To: <20250610-iio-driver-ad4052-v3-2-cf1e44c516d4@analog.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
	<20250610-iio-driver-ad4052-v3-2-cf1e44c516d4@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 09:34:35 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

> Add dt-bindings for AD4052 family, devices AD4050/AD4052/AD4056/AD4058,
> low-power with monitor capabilities SAR ADCs. Each variant of the family
> differs in speed and resolution, resulting in different scan types and
> spi word sizes, that are matched by the compatible with the chip_info.

The bit about what the drive does with this doesn't really belong in a DT
binding patch description. Stick to just something like.

Each variant of the family differs in speed and resolution, reflected
in word size for SPI messages.

> The device contains one input (cnv) and two outputs (gp0, gp1).
> The outputs can be configured for range of options, such as threshold
> and data ready.
> The spi-max-frequency refers to the configuration mode maximum access
> speed. The ADC mode speed depends on the vio input voltage.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4052.yaml    | 167 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  include/dt-bindings/iio/adc/adi,ad4052.h           |  17 +++
>  3 files changed, 190 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..2cf197e2d872d9a3d4f7210121a1e38f784f92dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> @@ -0,0 +1,167 @@
> +
> +  interrupts:
> +    items:
> +      - description: Signal coming from the GP0 pin.
Description would be better in interrupt-names than here.
> +      - description: Signal coming from the GP1 pin.

Also minItems should be specified to allow for just one of these
being wired I think.

> +
> +  interrupt-names:
> +    items:
> +      - const: gp0
> +      - const: gp1
> +
> +  cnv-gpios:
> +    description: The Convert Input (CNV). If omitted, CNV is tied to SPI CS.
> +    maxItems: 1
> +
> +  pwms:
> +    maxItems: 1
> +    description: PWM connected to the CNV pin.
> +
> +  trigger-sources:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Describes the output pin and event associated.
> +
> +  "#trigger-source-cells":
> +    const: 2
> +    description: |
> +      Output pins used as trigger source.
> +
> +      Cell 0 defines the event:
> +      * 0 = Data ready
> +      * 1 = Min threshold
> +      * 2 = Max threshold
> +      * 3 = Either threshold
> +      * 4 = CHOP control
> +      * 5 = Device enable
> +      * 6 = Device ready (only GP1)

Hmm. I'm a bit dubious on why 'what the offload trigger is'
is a DT thing?  Is that because the IP needs to comprehend
this?  I guess only data ready is actually supported in
practice? 

What would the use of Device enable or device ready or chop
control actually be?

The thresholds are unusual but those I can sort of understand.

Jonathan

> +
> +      Cell 1 defines which pin:
> +      * 0 = GP0
> +      * 1 = GP1
> +
> +      For convenience, macros for these values are available in
> +      dt-bindings/iio/adc/adi,ad4052.h.
> +
> +  spi-max-frequency:
> +    maximum: 83333333
> +
> +  vdd-supply:
> +    description: Analog power supply.
> +
> +  vio-supply:
> +    description: Digital interface logic power supply.
> +
> +  ref-supply:
> +    description: |

Don't need the | as no need to preserve anything about formatting of
a single paragraph like this.


> +      Reference voltage to set the ADC full-scale range. If not present,
> +      vdd-supply is used as the reference voltage.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vio-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad4052";
> +            reg = <0>;
> +            vdd-supply = <&vdd>;
> +            vio-supply = <&vio>;
> +            ref-supply = <&ref>;
> +            spi-max-frequency = <83333333>;
> +
> +            #trigger-source-cells = <2>;
> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
> +                                    AD4052_TRIGGER_PIN_GP0
> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
> +                                    AD4052_TRIGGER_PIN_GP1>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "gp0", "gp1";
> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
> +
> +    rx_dma {
> +            #dma-cells = <1>;
> +    };
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dmas = <&rx_dma 0>;
> +        dma-names = "offload0-rx";
> +        trigger-sources = <&adc AD4052_TRIGGER_EVENT_DATA_READY
> +                                AD4052_TRIGGER_PIN_GP1>;
> +
> +        adc@0 {
> +            compatible = "adi,ad4052";
> +            reg = <0>;
> +            vdd-supply = <&vdd>;
> +            vio-supply = <&vio>;
> +            spi-max-frequency = <83333333>;
> +            pwms = <&adc_trigger 0 10000 0>;
> +
> +            #trigger-source-cells = <2>;
> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
> +                                    AD4052_TRIGGER_PIN_GP0
> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
> +                                    AD4052_TRIGGER_PIN_GP1>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "gp0", "gp1";
> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c02d83560058f7ea75e24509b4d87ef293df6773..d000c7de7ff9eba390f87593bc2b1847f966f48b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1337,6 +1337,12 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
>  F:	Documentation/iio/ad4030.rst
>  F:	drivers/iio/adc/ad4030.c
>  
> +ANALOG DEVICES INC AD4052 DRIVER
> +M:	Jorge Marques <jorge.marques@analog.com>
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> +
>  ANALOG DEVICES INC AD4080 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
> diff --git a/include/dt-bindings/iio/adc/adi,ad4052.h b/include/dt-bindings/iio/adc/adi,ad4052.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..37db5d9d10e788d5e7fb715c4ba9077e555131d5
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/adi,ad4052.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_ADI_AD4052_H
> +#define _DT_BINDINGS_ADI_AD4052_H
> +
> +#define AD4052_TRIGGER_EVENT_DATA_READY		0
> +#define AD4052_TRIGGER_EVENT_MIN_THRESH		1
> +#define AD4052_TRIGGER_EVENT_MAX_THRESH		2
> +#define AD4052_TRIGGER_EVENT_EITHER_THRESH	3
> +#define AD4052_TRIGGER_EVENT_CHOP		4
> +#define AD4052_TRIGGER_EVENT_DEV_ENABLED	5
> +#define AD4052_TRIGGER_EVENT_DEV_READY		6
> +
> +#define AD4052_TRIGGER_PIN_GP0		0
> +#define AD4052_TRIGGER_PIN_GP1		1
> +
> +#endif /* _DT_BINDINGS_ADI_AD4052_H */
> 


