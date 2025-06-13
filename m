Return-Path: <linux-pwm+bounces-6338-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948EEAD8A2D
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 13:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414903BA451
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4288B2D29C5;
	Fri, 13 Jun 2025 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TInompFu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64B1DF258;
	Fri, 13 Jun 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749813482; cv=none; b=G/9TIck3TDWdip8Ogn05QUn0nVukmnUNeyupmoca1hxqdJF4edyoj79HuTicDTXGRHNwe6dlK8YyMFd5ERPj41YoVKRAJB0TI0Hcl4Q7xNoT3Dd8ktsZ2lavW+2kLg04ruoe/pVCfQ30Dg1G8kXaNVMgbDyipD0vqjtJYKHEvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749813482; c=relaxed/simple;
	bh=UoLE9D7xrP5gn3P3RJX/rXwm91ePsvRQn0e7lNV+rvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb2cCfCOxZREGP9CrRBEuUq1TGvRdiHTHYmAriR9pizOYHiE7EXrb6IAXRGip2A4ZsX3Mn2dYulsx8AaE8ZNL6sJKkNY0TaWDig5w1uWCHsEBA8fdWnzuGrwDhQ9XFekq36kAY9+mcmU5KZRWUF2y4SYbtUNbj3eZk8wEuzIRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TInompFu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so1540756a12.2;
        Fri, 13 Jun 2025 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749813479; x=1750418279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIZ4yb2sasHEPApXbhwc8IRh5P8GfHHZQksAbo81mZg=;
        b=TInompFuw7zmdJTBFxE9vaM/DBR/nHn7CIVafe+IZOQmU5R5fwcpdB4MCJPXud4Kcu
         pdyz6xLwgWnMJsY/Eu/A215DgfOX9XInVgVRqKLoJqxUj2J3sKqVSOFAx+XRJGDvMbKb
         J4eSWFwnqodlXAYOZHJKIPoNQeOTvJgsZCAjS7I0vNBzsuQ4t45C/Bd24LYkWZhuQCR4
         tWpUm6VjujU5TmNjLyeRbtTAb6JzBK7v3EGlcsF9CUTRpSpj5hsNWGFqhxbV/MNcFAmj
         ZLfMuEbr7Ao1rRwDS3BS89R6lwXEN5v8W1Xn1z8CmdfiyqFxDT6o3r/raDo85I5zEBbt
         OW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749813479; x=1750418279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIZ4yb2sasHEPApXbhwc8IRh5P8GfHHZQksAbo81mZg=;
        b=RKSmsNhzU4nkCKsLKU1uh3e1tBqlwn0XPFBYnas8lIbfUX7//irds6AvsN6N9/+BiH
         +ddsXEGNn9gvb+Tdy4b5eYMzL9CLC0RahQ+YDrUkH7TS0UE1h83/UaBX3Luof7YbUdXN
         p1+GdsSShEb4P+JP3kCYo+3GjRCFsOFmjPM0r1Z6jfA6e+lKxpIKAZOQSAh+Vdq1z7Qx
         pDjAPUgISB9zRj/tKqX/ZInMn/t+UaLErSDQrNjduqCu4ULz9TXUzy4QhuPYGXbeTPEJ
         YGOYokd6d/umKGVRcv3ZUHzVJ13ydSuUveNzemR9RfaAhBz7fCvaZoLfPaUy9z202xX3
         FrSA==
X-Forwarded-Encrypted: i=1; AJvYcCU9fKjgGILgxKOEZNx46Ogn2Rjqy4Hw+GKK4xlgalgqahy5oF8iFZTdESQxCWyjRCiaSB/jrJ7brbEm@vger.kernel.org, AJvYcCWenLB8LWbuCpk9g+HH3cFGpkU3p4Yyj0XXjgoFlSvLRz9f899ky7VC8lue9g++b/RFmSTkGBHhtXNN@vger.kernel.org, AJvYcCXAPlB6k059NBmD/3K1dRm3Y16ecH2rD05152JrdJzX+X3XEwqeefu+QmymsN00Q1XWzV9JkpUxnv2I@vger.kernel.org, AJvYcCXbvN0ae/TDgwwBlXo26J7375MXGZTqw9/7XpCPGsIPMTveOej+B1ORlkC15aV0+ro8KZ3+koCwOO+NHB3K@vger.kernel.org, AJvYcCXq8BqTeUQBweRLAqiyyV49Xk5QRdF61DS0tjJIbOtuLFaudfQ9afNsrfllm0xlaRnKjDWU9FNIciaf@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwtvl6k+Roa+DssYepIm8IsUz50SL2X7WcYOY+jND3KV0At8VX
	OSH3l4bT1LRBF3t2fHUJesIIxz/kQ+0/MEIiKu2WlPJcgMgeOGmEimJi
X-Gm-Gg: ASbGnctFPYo45MVwgpVYLgetkx+uIiVKfnDt+4MSZW1VPptv7uynB7S3G7zX2hZs/ce
	4Z+S66w1+LcMvvooIfaFS8sQDaX6R9cUJ5yjbW5wP5xnud2gDtEmr1ct1MJoC9CZDcDVWJ2g74/
	3R2GzQA0g13y1Aua5Bf5z3mQ7d6on4bqwMeO/Er+mkZyM8Bkzn+ivUnzaU2M2gUVTJbaCvXBdRD
	E6CtDYhYV6uFK/Kk4gj9WLo6SCUE5gVs0Lsb0N8xXTsHeYiDcdEeY7g+mGcclqb3r18cOYePTL7
	Hk+btMlagM5IPDM6OY9aGlW0t3nQYBwuSQZMOcFmFVlkwjq8f83W48vtcpmE4QGlD6Dyzeweq1t
	w0INnCA==
X-Google-Smtp-Source: AGHT+IFt+WiCqJOvLN2PIgXY07/x5DFFDQqvTrem/6Wnd1TEz+xgeAzdAXULm3MkwfITzuU/hOUHVQ==
X-Received: by 2002:a05:6a20:6a08:b0:21c:e488:29fa with SMTP id adf61e73a8af0-21fad027830mr4045255637.29.1749813479363;
        Fri, 13 Jun 2025 04:17:59 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe163ab49sm1425054a12.13.2025.06.13.04.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:17:58 -0700 (PDT)
Date: Fri, 13 Jun 2025 13:17:46 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <5lr5sqwtj52dy5n73ti2jszbybx5dpww33jceehdqehklr2hbm@zxickou2odcb>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-2-cf1e44c516d4@analog.com>
 <20250611181818.14d147c7@jic23-huawei>
 <xqkr3rq6ikuiz5wcbxmto4gp7wnccmmogklf2ux2edauotufim@pcuhddxdzjxi>
 <ef0d4038-b665-4ef0-9e7b-7ad2ce154c50@baylibre.com>
 <zd4fvyjbfurgsp3rpslo2ubpxzxn7bh5b2vh5j4j7outxdrcd7@firxlr6bfkic>
 <5130be5d-b769-41aa-af2f-b1e16a91e569@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5130be5d-b769-41aa-af2f-b1e16a91e569@baylibre.com>

Hi David,
On Thu, Jun 12, 2025 at 03:20:40PM -0500, David Lechner wrote:
> On 6/12/25 2:42 PM, Jorge Marques wrote:
> > Hi David,
> > 
> > thank you for chiming in
> > 
> > On Thu, Jun 12, 2025 at 10:03:37AM -0500, David Lechner wrote:
> >> On 6/12/25 5:11 AM, Jorge Marques wrote:
> >>> On Wed, Jun 11, 2025 at 06:18:18PM +0100, Jonathan Cameron wrote:
> >>>> On Tue, 10 Jun 2025 09:34:35 +0200
> >>>> Jorge Marques <jorge.marques@analog.com> wrote:
> >>>>
> >>
> >> ...
> >>
> >>>>> +  trigger-sources:
> >>>>> +    minItems: 1
> >>>>> +    maxItems: 2
> >>>>> +    description:
> >>>>> +      Describes the output pin and event associated.
> >>
> >> trigger-sources would be an input pin connected to an external trigger.
> >> For example, the CNV pin could be connected to a trigger-source
> >> provider to trigger a conversion. But there aren't any other digital
> >> inputs, so I don't know what the 2nd source would be here.
> >>
> >> As an example, see [1]. We could potentially use the same gpio
> >> trigger-source for the conversion pin here. There is already
> >> a similar binding for pwm triggers, so we could drop the separate
> >> pwms binding as well an just have a single trigger-sources
> >> property for the CNV pin that works for both gpio and pwm.
> >>
> >> [1]: https://lore.kernel.org/linux-iio/cover.1749569957.git.Jonathan.Santos@analog.com/
> >>
> > 
> > Quick summary to familiarize myself with this part and driver.
> > 
> > On ad7768-1:
> > ad7768-1.SYNC_OUT is a digital output, ad7768-1.SYNC_IN input, and
> > ad7768-1.GPIO3 (START) configured as input. ad7768-1.GPIO[0..3] are
> > configurable GPIO, GPIO3 as START, or in PIN control mode, the input
> > GPIO[3:0] sets the power mode and modulator freq (MODEx).
> > 
> > On that thread:
> > https://lore.kernel.org/linux-iio/8abca580f43cb31d7088d07a7414b5f7efe91ead.1749569957.git.Jonathan.Santos@analog.com/
> > exposes GPIO[0..3] through gpio_chip if gpio-controller in dt.
> > 
> > https://lore.kernel.org/linux-iio/713fd786010c75858700efaec8bb285274e7057e.1749569957.git.Jonathan.Santos@analog.com/
> > trigger-sources-cells: the cell define the type of signal but *not* its
> > origin, because {DRDY, SYNC_OUT, GPIO3(START)} are dedicated pins, *so
> > there is no need to do so*.
> > 
> >>>>> +
> >>>>> +  "#trigger-source-cells":
> >>>>> +    const: 2
> >>>>> +    description: |
> >>>>> +      Output pins used as trigger source.
> >>>>> +
> >>>>> +      Cell 0 defines the event:
> >>>>> +      * 0 = Data ready
> >>>>> +      * 1 = Min threshold
> >>>>> +      * 2 = Max threshold
> >>>>> +      * 3 = Either threshold
> >>>>> +      * 4 = CHOP control
> >>>>> +      * 5 = Device enable
> >>>>> +      * 6 = Device ready (only GP1)
> >>>>
> >>>> Hmm. I'm a bit dubious on why 'what the offload trigger is'
> >>>> is a DT thing?  Is that because the IP needs to comprehend
> >>>> this?  I guess only data ready is actually supported in
> >>>> practice? 
> >>>
> >>> A trigger can be connected to trigger something other than a spi
> >>> offload, it is in the DT because it describes how the device is
> >>> connected. When using spi offload, the trigger-source at the spi handle
> >>> describes which gpio and event is routed to the offload trigger input.
> >>> At the ADC node, trigger-source-cells describe the source gpio and event
> >>> for the device driver.
> >>>
> >>> In practice, in this series, one gpio is Data ready, triggering offload
> >>> when buffer enabled, and raw reads, when disabled. And the other is
> >>> Either threshold, propagated as an IIO event. Fancy logic can be added
> >>> to the driver in future patches to allow other combinations.
> >>>
> >>> It is also worth to mention that the trigger-source is duplicated for
> >>> each node that uses it, as seen in the second dts example:
> >>>
> >>>    &adc AD4052_TRIGGER_EVENT_DATA_READY AD4052_TRIGGER_PIN_GP1
> >>>
> >>> Is repeated on both adc and spi node.
> >>
> >> That sounds wrong. This would only make sense if an output of the
> >> ADC was wired back to itself. 
> >>
> > 
> > The issue is the lack of way of describing to the driver the function of
> > each gpio, when configurable. Perhaps it is better to use
> > trigger-source-cells to only describe the topology at that node
> > receiving the trigger, e.g.
> > 
> >   trigger-sources = <&adc AD4052_TRIGGER_PIN_GP0>;
> > 
> > Below I continue the discussion.
> >>>
> >>> One last thing, on the driver, for v3, I should handle -ENOENT:
> >>>
> >>>   ret = of_parse_phandle_with_args(np, "trigger-sources",
> >>>   				   "#trigger-source-cells", i,
> >>>   				   &trigger_sources);
> >>>   if (ret)
> >>>   	return ret == -ENOENT ? 0 : ret;
> >>>
> >>> To assert only when present, since the nodes are not required.
> >>> Or, in the driver,
> >>> require AD4052_TRIGGER_PIN_GP0 if irq_get_byname finds gp0, and
> >>> require AD4052_TRIGGER_PIN_GP1 if irq_get_byname finds gp1?
> >>> (I would go with the first option).
> >>>>
> >>
> >> ,,,
> >>
> >>>>> +examples:
> >>>>> +  - |
> >>>>> +    #include <dt-bindings/gpio/gpio.h>
> >>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>>>> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
> >>>>> +
> >>>>> +    spi {
> >>>>> +        #address-cells = <1>;
> >>>>> +        #size-cells = <0>;
> >>>>> +
> >>>>> +        adc@0 {
> >>>>> +            compatible = "adi,ad4052";
> >>>>> +            reg = <0>;
> >>>>> +            vdd-supply = <&vdd>;
> >>>>> +            vio-supply = <&vio>;
> >>>>> +            ref-supply = <&ref>;
> >>>>> +            spi-max-frequency = <83333333>;
> >>>>> +
> >>>>> +            #trigger-source-cells = <2>;
> >>>>> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
> >>>>> +                                    AD4052_TRIGGER_PIN_GP0
> >>>>> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
> >>>>> +                                    AD4052_TRIGGER_PIN_GP1>;
> >>
> >> This doesn't make sense for the reason given above. These outputs
> >> aren't wired back to inputs on the ADC. They are wired to interrupts
> >> on the MCU, which is already described below.
> >>
> > Below.
> >>>>> +            interrupt-parent = <&gpio>;
> >>>>> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> >>>>> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> >>>>> +            interrupt-names = "gp0", "gp1";
> >>>>> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> >>>>> +        };
> >>>>> +    };
> >>>>> +  - |
> >>>>> +    #include <dt-bindings/gpio/gpio.h>
> >>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>>>> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
> >>>>> +
> >>>>> +    rx_dma {
> >>>>> +            #dma-cells = <1>;
> >>>>> +    };
> >>>>> +
> >>>>> +    spi {
> >>>>> +        #address-cells = <1>;
> >>>>> +        #size-cells = <0>;
> >>>>> +
> >>>>> +        dmas = <&rx_dma 0>;
> >>>>> +        dma-names = "offload0-rx";
> >>
> >> The dmas aren't related to the ADC, so can be left out of the example.
> >>
> > Ack.
> >>>>> +        trigger-sources = <&adc AD4052_TRIGGER_EVENT_DATA_READY
> >>>>> +                                AD4052_TRIGGER_PIN_GP1>;
> >>>>> +
> >>>>> +        adc@0 {
> >>>>> +            compatible = "adi,ad4052";
> >>>>> +            reg = <0>;
> >>>>> +            vdd-supply = <&vdd>;
> >>>>> +            vio-supply = <&vio>;
> >>>>> +            spi-max-frequency = <83333333>;
> >>>>> +            pwms = <&adc_trigger 0 10000 0>;
> >>>>> +
> >>>>> +            #trigger-source-cells = <2>;
> >>>>> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
> >>>>> +                                    AD4052_TRIGGER_PIN_GP0
> >>>>> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
> >>>>> +                                    AD4052_TRIGGER_PIN_GP1>;
> >>
> >> Same as above - the GP pins aren't wired back to the ADC itself.
> >>
> >>>>> +            interrupt-parent = <&gpio>;
> >>>>> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> >>>>> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> >>>>> +            interrupt-names = "gp0", "gp1";
> >>>>> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> >>>>> +        };
> >>>>> +    };
> > 
> > Considering the discussion above. As is, in this series GP0 is event
> > Either threshold and GP1 Data ready. A future series would aim to make
> > it truly configurable.
> > 
> > For this series then, do we then drop the second cell of trigger cell
> > and do not provide a way of describing the function of each gpio? e.g.
> 
> The bindings can't be changed later, so no, don't drop the 2nd cell
> if we are going to add it back later.
> 
> But considering Jonathan's feedback, I am now questioning if we need
> the 2nd cell at all. The way trigger-source consumers work currently
> is that they request a trigger of a certain generic type, like "data
> ready". So this information could be used to determine what function
> needs to be assigned to the pin without having to define that in the
> devicetree.
> 
Useful for assertion. It is odd to be used for requesting of a certain
type (gpio role) instead of telling how things are wired.
> > 
> >   - |
> >     #include <dt-bindings/gpio/gpio.h>
> >     #include <dt-bindings/interrupt-controller/irq.h>
> >     #include <dt-bindings/iio/adc/adi,ad4052.h>
> >   
> >     rx_dma {
> >             #dma-cells = <1>;
> >     };
> >   
> >     spi {
> >         #address-cells = <1>;
> >         #size-cells = <0>;
> >   
> >         trigger-sources = <&adc AD4052_TRIGGER_PIN_GP0>;
> >   
> >         adc@0 {
> >             compatible = "adi,ad4052";
> >             reg = <0>;
> >             vdd-supply = <&vdd>;
> >             vio-supply = <&vio>;
> >             spi-max-frequency = <83333333>;
> >             pwms = <&adc_trigger 0 10000 0>;
> >   
> >             // --- Other thought ------
> >             //adi,gpio-role = <AD4052_TRIGGER_EVENT_EITHER_THRESH
> >             //                 AD4052_TRIGGER_EVENT_DATA_READY>;
> >             // ------------------------
> >             interrupt-parent =  <&gpio>;
> >             interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> >                          <0 1 IRQ_TYPE_EDGE_FALLING>;
> >             interrupt-names = "gp0", "gp1";
> >             cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> >         };
> >     };
> > 
> > Other thought is to add an "adi,gpio-role" property to define gpio
> > function (as commented in the example above, matched with index of
> > interrupts-names). If no interrupt-name.gp0 but trigger-source.GP0,
> > assume role Data ready (no irq for raw read, only buffer offload).
> > 
> > What is your opinion on this?
> 
> 
> Usually, we just have the devicetree describe how things are wired up.
> Then the driver looks at how things are wired up and decides how to
> best make use of the available resources. I.e. in the driver add some
> variables in the driver state struct that keeps track of the function
> assigned to each GP pin and use that to make decisions.
> 
> In the driver, we would want to make sure to handle triggers first
> since those are less flexible (so set up SPI offload first). This
> would cause one of the GP pins to be assigned to the /RDY function.
> It doesn't matter which one.
> 
I will default drdy_gp to g0, until offload request overwrites it,
either gp0 or gp1.
> Then later, parse the interrupts property. If we see that one of
> the GP pins is already assigned to /RDY, then we know we have to
> use that pin for the /RDY interrupt as well. If both pins are still
> available, then an arbitrary one can be assigned for /RDY.
based on drdy_gp, set that gp as drdy, and the remaining is threshold
either. the interrupt is optional, but setup device gp regardless, since
the irq may be consumed by other device.
> 
> Then if there is still an unused GP pin left that is actually
> wired up to an interrupt, that can be used for the events interrupt.
> 
> Or we could even consider to have everything on one pin since the
> /RDY signal would never be needed at the same time as events as long
> as the events are only ever used in monitor mode.
>

The threshold event occurs on the rising edge, the data ready on the
falling edge (it is actually BUSY). Mixing both has a lot of nuances
involved.
> If we find that there is some case though where the driver really
> can't figure out what to do with the available information, then
> we could probably justify adding a property like you suggested.
> It seems like we could possibly do without it at this point though.

With the proposed above, I don't need the cell 0 of trigger-sources. But
I will keep for assertion since we are inferring
has?trigger-sources-> -then-> drdy.

Best regards,
Jorge

