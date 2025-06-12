Return-Path: <linux-pwm+bounces-6315-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A673AD6D3A
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 12:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA000189298B
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 10:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8829222F757;
	Thu, 12 Jun 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O07r+H0j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06BB22DA0A;
	Thu, 12 Jun 2025 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723117; cv=none; b=b0gFe6SZZjOWcfDxd4iZVDHB5SR18Rsko0aQO1SK0jzm+KAn0CxGsXXw4HO/DNCxd9V67Y0fSZVjbSTkg+evSuggXrBH6dWawfDbCqIkKBWORB20PdB2xaGf2JVQebITGIuWOIltr+hu4BBGhWvHb1pQyyRDOLwphBdy6TiI3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723117; c=relaxed/simple;
	bh=kj9FfFdmVqffZwcuU+9zHjczBYVwY6pNvH0oJ0fttd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vvky0L6HEuvwD/l4AAS6kCCdDbDhpg6TpSfNdt2uM9Eo9vzoigd9E3+mqsEwugf7LR79lFHwHruHdRLPAYngIYE7ZaslvtLWWIQlqmvDIC8LKROwTShHrJQC4daxEhETRngB95IfLcDoeSwwgaL9OPsPusAHvzyhMUqucsM0J+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O07r+H0j; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c46611b6so968397b3a.1;
        Thu, 12 Jun 2025 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749723115; x=1750327915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1dV1WkFt8//wQcRbuu/MoLupyoxfpDCIHcenSXkrPrs=;
        b=O07r+H0jZYCSem8fmNWql4rY4zjrrIUpQj6Xiai76MHLSlaTdZxS4WGnZEPlW7fjKP
         evzUO8eTLTGqsM6bfnS5KFBJfCBQtmyohmOhLAkbymC8DD8Iyp7bs7YvYKGgPjqxiXuI
         FPfMYWzSmjfE6Bj7td2LBR+2nwY7yjzcW7yj+Eef+iDEobYpRtaUMQv0Y/zFnnT5JZXm
         QvZ/w0zI68LC+klyymuwD+Tq6LrtgQmUNWAuDYcoHO1yq+r3mb9t/VP2XraA9coOkqra
         S6i1G1vnwg/QvbyqoU3t1Cm0FB/fDQojhkL20q7cox0Y9jvRwdkR9nhZ5Niop6z5B3QB
         4QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749723115; x=1750327915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dV1WkFt8//wQcRbuu/MoLupyoxfpDCIHcenSXkrPrs=;
        b=baJtqIlXyF0KzBJq8YzPMhGUo6zn1puP2jYBNP5W8ffTpAs2bUZuts9Q5Kw1yAgcNe
         PxgBdY0rsbuLGW2EOfoMfXiuRh6tg8ZwdGwVaZ9xnm2aLr9l84q9rG41YyMN/VaM6x1N
         eswl31+Yhie+XgQxVNNsM9EKDGByP9R9xkR03ASmGSFJVp0WvtB+5CRvHgJ1REmeL6CU
         2TbUt3bdGFKNiv4Qqy1nYxWha0ToeZxNO6DLmiiHW6aeWDmMIdJyE/5vF5l71UeOW6Mx
         xBKKA0xdyuabfFHbbOXO3WapI4UPu76jUgDMLRBVHG32gGo2zT8Nh+MUBpMkt8BcptjH
         oaWg==
X-Forwarded-Encrypted: i=1; AJvYcCUIQRmgN8rtgBkemZMfXlcg/B6Jk1mihH9ymhnX8VNqz1hL69JGq6/kyoq7os9mr+R8CNII959SGfVf@vger.kernel.org, AJvYcCULAofj4er0RbNL7kgkj9UEo2rQm4kIlDshtVyAbCHdkphuwke0NE8qCkVRTwQ9TqqZFpUKLDKJWMMu@vger.kernel.org, AJvYcCVVGEufJ5zuJMy8dO6GkHWBZvs6NKQJlVCHq88etBGHV7JNwePO+Xn/5mkzFXzNF1+wxa5RIJ3mQRR9@vger.kernel.org, AJvYcCWv3+278wXIWcrcDC9cPNpDY58GXOoCJd4IbheKDKwUAASQ7GB/dv6Kc9R/osGOKrFcItoWXwfHo4VC@vger.kernel.org, AJvYcCXWqtzT9AKyQ5RhTdeyGiFM7WdryZLCn4rhEmnKQsA4HjxZqdJrFFjG9EdMJe82qlblLAHZXNDN44wNtf1/@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3mXiHEpcyXevC5/I+40THQsTsPD+pUdepMjSJtzTD6JMLYsX
	Xw9JO4sdHBSEeod/nIF2B/5KWHic98Zh7x0rMGM2/xFNFwUYDRbazkLD
X-Gm-Gg: ASbGncsVB5wohk6D8pJa+J733iNop7aYtS6jT11onSMxheIoPiDqqCCnlX/mHJxAuL2
	Vx+0neAplm+856wByD2IXpBXJM614NdfHTEaAW8RDEBrTwOV3VmVEAo5lqh7HlkVxPdlpX3QLhA
	Q1QEmN9mTpKe4c8V4xA+j7Hljj92AKPa3GgRd8TjKINi6ukSdF+UYCXoHtlp6X4FPgJmLJ91Ped
	ieyp0iuUdbtXNlS+1buJh+kpDwgYnnupFGq8ytMk2Q/JB5wpaTruy1VFLpaWYkWYd2acfeRlJSz
	2BrXTjtKot4MIQ+Hz/DAbFaGrxJqlXu2Hiv4hYCKYOTfzVnhZrr3BmWutp4TucrQAzpEymtpJG0
	EN/UIoQ==
X-Google-Smtp-Source: AGHT+IHmSaieR8BqpFsfXfxghNOUxzQUeq4pW392aZGXLAFQ7UuANU5To4YQRORsLo7bRL6zZ3DDUg==
X-Received: by 2002:a05:6a20:3d8a:b0:1f5:9330:29fe with SMTP id adf61e73a8af0-21f977a489fmr4924476637.17.1749723114721;
        Thu, 12 Jun 2025 03:11:54 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087e634sm1065629b3a.33.2025.06.12.03.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:11:54 -0700 (PDT)
Date: Thu, 12 Jun 2025 12:11:41 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <xqkr3rq6ikuiz5wcbxmto4gp7wnccmmogklf2ux2edauotufim@pcuhddxdzjxi>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-2-cf1e44c516d4@analog.com>
 <20250611181818.14d147c7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611181818.14d147c7@jic23-huawei>

On Wed, Jun 11, 2025 at 06:18:18PM +0100, Jonathan Cameron wrote:
> On Tue, 10 Jun 2025 09:34:35 +0200
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > Add dt-bindings for AD4052 family, devices AD4050/AD4052/AD4056/AD4058,
> > low-power with monitor capabilities SAR ADCs. Each variant of the family
> > differs in speed and resolution, resulting in different scan types and
> > spi word sizes, that are matched by the compatible with the chip_info.
> 
> The bit about what the drive does with this doesn't really belong in a DT
> binding patch description. Stick to just something like.
> 
> Each variant of the family differs in speed and resolution, reflected
> in word size for SPI messages.
> 
> > The device contains one input (cnv) and two outputs (gp0, gp1).
> > The outputs can be configured for range of options, such as threshold
> > and data ready.
> > The spi-max-frequency refers to the configuration mode maximum access
> > speed. The ADC mode speed depends on the vio input voltage.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad4052.yaml    | 167 +++++++++++++++++++++
> >  MAINTAINERS                                        |   6 +
> >  include/dt-bindings/iio/adc/adi,ad4052.h           |  17 +++
> >  3 files changed, 190 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..2cf197e2d872d9a3d4f7210121a1e38f784f92dc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> > @@ -0,0 +1,167 @@
> > +
> > +  interrupts:
> > +    items:
> > +      - description: Signal coming from the GP0 pin.
> Description would be better in interrupt-names than here.
> > +      - description: Signal coming from the GP1 pin.
> 
> Also minItems should be specified to allow for just one of these
> being wired I think.
> 
Ack, then maxItems is also required, or dt_binding_check complains

  > "interrupts: [[...], [...]] is too long"

since I don't have the items to infer length, that means, the updated
yaml is:

  interrupts:
    minItems: 1
    maxItems: 2

  interrupt-names:
    items:
      - const: gp0
        description: Signal coming from the GP0 pin.
      - const: gp1
        description: Signal coming from the GP1 pin.

> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: gp0
> > +      - const: gp1
> > +
> > +  cnv-gpios:
> > +    description: The Convert Input (CNV). If omitted, CNV is tied to SPI CS.
> > +    maxItems: 1
> > +
> > +  pwms:
> > +    maxItems: 1
> > +    description: PWM connected to the CNV pin.
> > +
> > +  trigger-sources:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description:
> > +      Describes the output pin and event associated.
> > +
> > +  "#trigger-source-cells":
> > +    const: 2
> > +    description: |
> > +      Output pins used as trigger source.
> > +
> > +      Cell 0 defines the event:
> > +      * 0 = Data ready
> > +      * 1 = Min threshold
> > +      * 2 = Max threshold
> > +      * 3 = Either threshold
> > +      * 4 = CHOP control
> > +      * 5 = Device enable
> > +      * 6 = Device ready (only GP1)
> 
> Hmm. I'm a bit dubious on why 'what the offload trigger is'
> is a DT thing?  Is that because the IP needs to comprehend
> this?  I guess only data ready is actually supported in
> practice? 

A trigger can be connected to trigger something other than a spi
offload, it is in the DT because it describes how the device is
connected. When using spi offload, the trigger-source at the spi handle
describes which gpio and event is routed to the offload trigger input.
At the ADC node, trigger-source-cells describe the source gpio and event
for the device driver.

In practice, in this series, one gpio is Data ready, triggering offload
when buffer enabled, and raw reads, when disabled. And the other is
Either threshold, propagated as an IIO event. Fancy logic can be added
to the driver in future patches to allow other combinations.

It is also worth to mention that the trigger-source is duplicated for
each node that uses it, as seen in the second dts example:

   &adc AD4052_TRIGGER_EVENT_DATA_READY AD4052_TRIGGER_PIN_GP1

Is repeated on both adc and spi node.

One last thing, on the driver, for v3, I should handle -ENOENT:

  ret = of_parse_phandle_with_args(np, "trigger-sources",
  				   "#trigger-source-cells", i,
  				   &trigger_sources);
  if (ret)
  	return ret == -ENOENT ? 0 : ret;

To assert only when present, since the nodes are not required.
Or, in the driver,
require AD4052_TRIGGER_PIN_GP0 if irq_get_byname finds gp0, and
require AD4052_TRIGGER_PIN_GP1 if irq_get_byname finds gp1?
(I would go with the first option).
> 
> What would the use of Device enable or device ready or chop
> control actually be?
> 
Device enable is the default register value, it could signal the
conclusion of the reset or exit of low power mode. The CHOP signal is
used to synchronize an auto-zero amplifier's chopping and the adc's
sampling and is an example of when the trigger is connected to something
other than spi. In that particular topology, the user would then set at
the devicetree to use the gpio for that, at the hypothetical chop
consumer node. Still, in the driver of this series, only the Data ready
and Either threshold is supported.

Best regards,
Jorge

> The thresholds are unusual but those I can sort of understand.
> 
> Jonathan
> 
> > +
> > +      Cell 1 defines which pin:
> > +      * 0 = GP0
> > +      * 1 = GP1
> > +
> > +      For convenience, macros for these values are available in
> > +      dt-bindings/iio/adc/adi,ad4052.h.
> > +
> > +  spi-max-frequency:
> > +    maximum: 83333333
> > +
> > +  vdd-supply:
> > +    description: Analog power supply.
> > +
> > +  vio-supply:
> > +    description: Digital interface logic power supply.
> > +
> > +  ref-supply:
> > +    description: |
> 
> Don't need the | as no need to preserve anything about formatting of
> a single paragraph like this.
> 
Ack.
> 
> > +      Reference voltage to set the ADC full-scale range. If not present,
> > +      vdd-supply is used as the reference voltage.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +  - vio-supply
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/iio/adc/adi,ad4052.h>
> > +
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@0 {
> > +            compatible = "adi,ad4052";
> > +            reg = <0>;
> > +            vdd-supply = <&vdd>;
> > +            vio-supply = <&vio>;
> > +            ref-supply = <&ref>;
> > +            spi-max-frequency = <83333333>;
> > +
> > +            #trigger-source-cells = <2>;
> > +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
> > +                                    AD4052_TRIGGER_PIN_GP0
> > +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
> > +                                    AD4052_TRIGGER_PIN_GP1>;
> > +            interrupt-parent = <&gpio>;
> > +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> > +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-names = "gp0", "gp1";
> > +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> > +        };
> > +    };
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/iio/adc/adi,ad4052.h>
> > +
> > +    rx_dma {
> > +            #dma-cells = <1>;
> > +    };
> > +
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        dmas = <&rx_dma 0>;
> > +        dma-names = "offload0-rx";
> > +        trigger-sources = <&adc AD4052_TRIGGER_EVENT_DATA_READY
> > +                                AD4052_TRIGGER_PIN_GP1>;
> > +
> > +        adc@0 {
> > +            compatible = "adi,ad4052";
> > +            reg = <0>;
> > +            vdd-supply = <&vdd>;
> > +            vio-supply = <&vio>;
> > +            spi-max-frequency = <83333333>;
> > +            pwms = <&adc_trigger 0 10000 0>;
> > +
> > +            #trigger-source-cells = <2>;
> > +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
> > +                                    AD4052_TRIGGER_PIN_GP0
> > +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
> > +                                    AD4052_TRIGGER_PIN_GP1>;
> > +            interrupt-parent = <&gpio>;
> > +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> > +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-names = "gp0", "gp1";
> > +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c02d83560058f7ea75e24509b4d87ef293df6773..d000c7de7ff9eba390f87593bc2b1847f966f48b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1337,6 +1337,12 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> >  F:	Documentation/iio/ad4030.rst
> >  F:	drivers/iio/adc/ad4030.c
> >  
> > +ANALOG DEVICES INC AD4052 DRIVER
> > +M:	Jorge Marques <jorge.marques@analog.com>
> > +S:	Supported
> > +W:	https://ez.analog.com/linux-software-drivers
> > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> > +
> >  ANALOG DEVICES INC AD4080 DRIVER
> >  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> >  L:	linux-iio@vger.kernel.org
> > diff --git a/include/dt-bindings/iio/adc/adi,ad4052.h b/include/dt-bindings/iio/adc/adi,ad4052.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..37db5d9d10e788d5e7fb715c4ba9077e555131d5
> > --- /dev/null
> > +++ b/include/dt-bindings/iio/adc/adi,ad4052.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +
> > +#ifndef _DT_BINDINGS_ADI_AD4052_H
> > +#define _DT_BINDINGS_ADI_AD4052_H
> > +
> > +#define AD4052_TRIGGER_EVENT_DATA_READY		0
> > +#define AD4052_TRIGGER_EVENT_MIN_THRESH		1
> > +#define AD4052_TRIGGER_EVENT_MAX_THRESH		2
> > +#define AD4052_TRIGGER_EVENT_EITHER_THRESH	3
> > +#define AD4052_TRIGGER_EVENT_CHOP		4
> > +#define AD4052_TRIGGER_EVENT_DEV_ENABLED	5
> > +#define AD4052_TRIGGER_EVENT_DEV_READY		6
> > +
> > +#define AD4052_TRIGGER_PIN_GP0		0
> > +#define AD4052_TRIGGER_PIN_GP1		1
> > +
> > +#endif /* _DT_BINDINGS_ADI_AD4052_H */
> > 
> 

