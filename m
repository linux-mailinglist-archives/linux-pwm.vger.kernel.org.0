Return-Path: <linux-pwm+bounces-6332-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4649AD7B41
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 21:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB8F3A8888
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57AF2D5419;
	Thu, 12 Jun 2025 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH1l5dLc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C52D5415;
	Thu, 12 Jun 2025 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757371; cv=none; b=focQ2xWwJYwE812DMDOIBco7ZC9zfES+fh55M4vT79aXMjnFKoYLisnFE58j4xqVbkh6m5Jc8nAYaL2AzNGUY1o8OV3HGMOryvA2Uif4+oHUbCmLtzQ3WQMAohiVbPp8Up56SWw2RMOfam7oHHTz9VKiaGRpt1Ye27Lef2dfG+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757371; c=relaxed/simple;
	bh=upuBjbx9NrnGIk/P9FEvjMzN5Q+XJ5GD/CvBl71z6lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahiWLMCFhC2xixhEADuWRbXYMfrJhDnIaYg9HxsMLQ+nDEEokeRKGmA84xB4qxpVhIIqTq7sEZmxaqyxpcO2FwhcsCGjlr7ZLPBcD2R09eS527KNcaFmpGo4NQXcS3BbJQtusSCjKW/3+BvuHvq9Pb0Ye8MzJ4yqWeEY1SG5OEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH1l5dLc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4532ff4331cso3438015e9.1;
        Thu, 12 Jun 2025 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749757368; x=1750362168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=38p+3HSbBFGNqBDCFsDIvFXbaElV5+omS1AX/dXYJTU=;
        b=jH1l5dLcUoA6S2pVCcsWGHRt11XfFK2VhNz9SCqatRa1Nm4MMRPAQ0uMLDYLQQYw1r
         b2cjWFZGs03aIk/njrUGSvG9ZQRf7N7yUXCyQ5mtT6jmfiyYCGLh5/Jgj5EUr1WL1PZS
         p5RBLwp/3ZvS+fG4KXEa03OiMw76IBwgxWFSBM9MRr+jCebFVegp50Z1hXqlVk0fJurB
         VYLT82xrF6YoSCWWhEqTWgz2TUHhXMrEzOBGIdEweQqsURNjdgYXYGSsT2qK3bLwdK24
         GH2q6ol2CMZJb8qPndJ14ERppALVooVKo1wdCFbFgXypbuIwFQxK3YdYcuF4Ani1OGz9
         CUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757368; x=1750362168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38p+3HSbBFGNqBDCFsDIvFXbaElV5+omS1AX/dXYJTU=;
        b=gSdsuK1Kk5oGQ7p1duAq5opv5sKItBmgZrQpHVRgrJ3TQ/vle+ZGgCLw4pyet7MKmo
         gl+hactmhXC74fGl/YlZ5B8g+8Z9BWauMl8rIxDOdWCUFR0JMJpu4oC/P1WyPI8hbWYw
         Vo98G+Beu8Y5/AvzDoMwKn8lN/f5yOqIboMtkH4COkdvurwEnlLjqAOPeSJfKyXU+8xC
         BhgV6A1lw0HsO7JEWZLqjit6pr0ioW/pbOWE38yRgqIVOO4HMNdXIxafs8ytdYmgPeaR
         NhPpchCU8y2ZX2VnnpNCaQpBJgPcMOA5FDPPtknpfB6JN6rasgdoNinJt2YEAB+Lp0nQ
         qITA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Cnq8An8VgL2p8NaqOmXAKnqi6qFJM8whB/aYFS8rtj5R0wKr1M69QXzCRXbunAX/TOVFtGG6zdWu@vger.kernel.org, AJvYcCVcy2jKLjnDz15LAVqE+UIZKVroRoWIVw+0dXJOUms+13RAz0uFcnT0dexQymqJ8PudH7UPolOgKDat@vger.kernel.org, AJvYcCXAgl36mmLwhVP7wK8NOFVsQjY67hgj3mXuWBgJEVGlQcR13OqPiYsk84JHbVKrpIZJIz0IbIH91SVp@vger.kernel.org, AJvYcCXI/e2/Pf4javwuT/mYPsDZ7kwoosMJRs9stXmo88oW6lsYc1+HlCcIbYDp/E5c6tYEaU4teIB8vWlxwDlg@vger.kernel.org, AJvYcCXhg33oRWR92WwrzYGJInTbHpKs3o6plzW9A+IkTcLrs5o/LgSRTB0vdO8DkDT7AdxIHUly0wGqzTCU@vger.kernel.org
X-Gm-Message-State: AOJu0YzPncvf1vJIvgONrQdo2ORuNNoKvZJCohQk3Zm7f87StN4JmCff
	PU11LmUZefCGLetIW7ps33DCUXqSNMbvp0sEV7+aZ05fUOvDxjQOeYyF
X-Gm-Gg: ASbGncvJscAH1v03o3v2zHY2BFOfukr1PslT1XIEz7QQSIptfJZdzDj9xvcFcmrKF/N
	TOOYCQwSHbi5lQEn0q4+XXM2i0NUwNZvCemtbsMAuHWKzweK/RUjCIXo4AvgwFyK/Wh4SdRJyzU
	IG994Kysj2GqtdT6hVIyjORMkrZQ7reZWHBHKqsLKSal/5ujpcke1Yd5wyYtY5jctgz//Lg86Bc
	1k+B8g+CkhL58VnPBwEq7AKQCcu9peUCLYCgyjrfs/QzPuMgivr3RbcPmSesJsvai41x0Mr4J4n
	Sl0bHGDRZHNb/k1zywWLHGQw5O81be7zqvdZWTDvGTv8aUxfvd/7CsCSmVx+7v7+rtcg7qMwyFl
	UUn27lxTCW2k=
X-Google-Smtp-Source: AGHT+IGUWK2T5KqU8q4LTCb4HmQ5TwkQZ1cGFLU0kWIdtnABjtWlkQMuVJ3hfwoKrJJdqqwQxXlFeQ==
X-Received: by 2002:a05:600c:1c07:b0:450:cfcb:5c9b with SMTP id 5b1f17b1804b1-45334a80686mr3291925e9.1.1749757367628;
        Thu, 12 Jun 2025 12:42:47 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:12c1:8801:3566:5c86:dc57:a79e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a5405asm235382f8f.13.2025.06.12.12.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 12:42:47 -0700 (PDT)
Date: Thu, 12 Jun 2025 21:42:44 +0200
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
Message-ID: <zd4fvyjbfurgsp3rpslo2ubpxzxn7bh5b2vh5j4j7outxdrcd7@firxlr6bfkic>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-2-cf1e44c516d4@analog.com>
 <20250611181818.14d147c7@jic23-huawei>
 <xqkr3rq6ikuiz5wcbxmto4gp7wnccmmogklf2ux2edauotufim@pcuhddxdzjxi>
 <ef0d4038-b665-4ef0-9e7b-7ad2ce154c50@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0d4038-b665-4ef0-9e7b-7ad2ce154c50@baylibre.com>

Hi David,

thank you for chiming in

On Thu, Jun 12, 2025 at 10:03:37AM -0500, David Lechner wrote:
> On 6/12/25 5:11 AM, Jorge Marques wrote:
> > On Wed, Jun 11, 2025 at 06:18:18PM +0100, Jonathan Cameron wrote:
> >> On Tue, 10 Jun 2025 09:34:35 +0200
> >> Jorge Marques <jorge.marques@analog.com> wrote:
> >>
> 
> ...
> 
> >>> +  trigger-sources:
> >>> +    minItems: 1
> >>> +    maxItems: 2
> >>> +    description:
> >>> +      Describes the output pin and event associated.
> 
> trigger-sources would be an input pin connected to an external trigger.
> For example, the CNV pin could be connected to a trigger-source
> provider to trigger a conversion. But there aren't any other digital
> inputs, so I don't know what the 2nd source would be here.
> 
> As an example, see [1]. We could potentially use the same gpio
> trigger-source for the conversion pin here. There is already
> a similar binding for pwm triggers, so we could drop the separate
> pwms binding as well an just have a single trigger-sources
> property for the CNV pin that works for both gpio and pwm.
> 
> [1]: https://lore.kernel.org/linux-iio/cover.1749569957.git.Jonathan.Santos@analog.com/
> 

Quick summary to familiarize myself with this part and driver.

On ad7768-1:
ad7768-1.SYNC_OUT is a digital output, ad7768-1.SYNC_IN input, and
ad7768-1.GPIO3 (START) configured as input. ad7768-1.GPIO[0..3] are
configurable GPIO, GPIO3 as START, or in PIN control mode, the input
GPIO[3:0] sets the power mode and modulator freq (MODEx).

On that thread:
https://lore.kernel.org/linux-iio/8abca580f43cb31d7088d07a7414b5f7efe91ead.1749569957.git.Jonathan.Santos@analog.com/
exposes GPIO[0..3] through gpio_chip if gpio-controller in dt.

https://lore.kernel.org/linux-iio/713fd786010c75858700efaec8bb285274e7057e.1749569957.git.Jonathan.Santos@analog.com/
trigger-sources-cells: the cell define the type of signal but *not* its
origin, because {DRDY, SYNC_OUT, GPIO3(START)} are dedicated pins, *so
there is no need to do so*.

> >>> +
> >>> +  "#trigger-source-cells":
> >>> +    const: 2
> >>> +    description: |
> >>> +      Output pins used as trigger source.
> >>> +
> >>> +      Cell 0 defines the event:
> >>> +      * 0 = Data ready
> >>> +      * 1 = Min threshold
> >>> +      * 2 = Max threshold
> >>> +      * 3 = Either threshold
> >>> +      * 4 = CHOP control
> >>> +      * 5 = Device enable
> >>> +      * 6 = Device ready (only GP1)
> >>
> >> Hmm. I'm a bit dubious on why 'what the offload trigger is'
> >> is a DT thing?  Is that because the IP needs to comprehend
> >> this?  I guess only data ready is actually supported in
> >> practice? 
> > 
> > A trigger can be connected to trigger something other than a spi
> > offload, it is in the DT because it describes how the device is
> > connected. When using spi offload, the trigger-source at the spi handle
> > describes which gpio and event is routed to the offload trigger input.
> > At the ADC node, trigger-source-cells describe the source gpio and event
> > for the device driver.
> > 
> > In practice, in this series, one gpio is Data ready, triggering offload
> > when buffer enabled, and raw reads, when disabled. And the other is
> > Either threshold, propagated as an IIO event. Fancy logic can be added
> > to the driver in future patches to allow other combinations.
> > 
> > It is also worth to mention that the trigger-source is duplicated for
> > each node that uses it, as seen in the second dts example:
> > 
> >    &adc AD4052_TRIGGER_EVENT_DATA_READY AD4052_TRIGGER_PIN_GP1
> > 
> > Is repeated on both adc and spi node.
> 
> That sounds wrong. This would only make sense if an output of the
> ADC was wired back to itself. 
> 

The issue is the lack of way of describing to the driver the function of
each gpio, when configurable. Perhaps it is better to use
trigger-source-cells to only describe the topology at that node
receiving the trigger, e.g.

  trigger-sources = <&adc AD4052_TRIGGER_PIN_GP0>;

Below I continue the discussion.
> > 
> > One last thing, on the driver, for v3, I should handle -ENOENT:
> > 
> >   ret = of_parse_phandle_with_args(np, "trigger-sources",
> >   				   "#trigger-source-cells", i,
> >   				   &trigger_sources);
> >   if (ret)
> >   	return ret == -ENOENT ? 0 : ret;
> > 
> > To assert only when present, since the nodes are not required.
> > Or, in the driver,
> > require AD4052_TRIGGER_PIN_GP0 if irq_get_byname finds gp0, and
> > require AD4052_TRIGGER_PIN_GP1 if irq_get_byname finds gp1?
> > (I would go with the first option).
> >>
> 
> ,,,
> 
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/gpio/gpio.h>
> >>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
> >>> +
> >>> +    spi {
> >>> +        #address-cells = <1>;
> >>> +        #size-cells = <0>;
> >>> +
> >>> +        adc@0 {
> >>> +            compatible = "adi,ad4052";
> >>> +            reg = <0>;
> >>> +            vdd-supply = <&vdd>;
> >>> +            vio-supply = <&vio>;
> >>> +            ref-supply = <&ref>;
> >>> +            spi-max-frequency = <83333333>;
> >>> +
> >>> +            #trigger-source-cells = <2>;
> >>> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
> >>> +                                    AD4052_TRIGGER_PIN_GP0
> >>> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
> >>> +                                    AD4052_TRIGGER_PIN_GP1>;
> 
> This doesn't make sense for the reason given above. These outputs
> aren't wired back to inputs on the ADC. They are wired to interrupts
> on the MCU, which is already described below.
> 
Below.
> >>> +            interrupt-parent = <&gpio>;
> >>> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> >>> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> >>> +            interrupt-names = "gp0", "gp1";
> >>> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> >>> +        };
> >>> +    };
> >>> +  - |
> >>> +    #include <dt-bindings/gpio/gpio.h>
> >>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
> >>> +
> >>> +    rx_dma {
> >>> +            #dma-cells = <1>;
> >>> +    };
> >>> +
> >>> +    spi {
> >>> +        #address-cells = <1>;
> >>> +        #size-cells = <0>;
> >>> +
> >>> +        dmas = <&rx_dma 0>;
> >>> +        dma-names = "offload0-rx";
> 
> The dmas aren't related to the ADC, so can be left out of the example.
> 
Ack.
> >>> +        trigger-sources = <&adc AD4052_TRIGGER_EVENT_DATA_READY
> >>> +                                AD4052_TRIGGER_PIN_GP1>;
> >>> +
> >>> +        adc@0 {
> >>> +            compatible = "adi,ad4052";
> >>> +            reg = <0>;
> >>> +            vdd-supply = <&vdd>;
> >>> +            vio-supply = <&vio>;
> >>> +            spi-max-frequency = <83333333>;
> >>> +            pwms = <&adc_trigger 0 10000 0>;
> >>> +
> >>> +            #trigger-source-cells = <2>;
> >>> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
> >>> +                                    AD4052_TRIGGER_PIN_GP0
> >>> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
> >>> +                                    AD4052_TRIGGER_PIN_GP1>;
> 
> Same as above - the GP pins aren't wired back to the ADC itself.
> 
> >>> +            interrupt-parent = <&gpio>;
> >>> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> >>> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> >>> +            interrupt-names = "gp0", "gp1";
> >>> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> >>> +        };
> >>> +    };

Considering the discussion above. As is, in this series GP0 is event
Either threshold and GP1 Data ready. A future series would aim to make
it truly configurable.

For this series then, do we then drop the second cell of trigger cell
and do not provide a way of describing the function of each gpio? e.g.

  - |
    #include <dt-bindings/gpio/gpio.h>
    #include <dt-bindings/interrupt-controller/irq.h>
    #include <dt-bindings/iio/adc/adi,ad4052.h>
  
    rx_dma {
            #dma-cells = <1>;
    };
  
    spi {
        #address-cells = <1>;
        #size-cells = <0>;
  
        trigger-sources = <&adc AD4052_TRIGGER_PIN_GP0>;
  
        adc@0 {
            compatible = "adi,ad4052";
            reg = <0>;
            vdd-supply = <&vdd>;
            vio-supply = <&vio>;
            spi-max-frequency = <83333333>;
            pwms = <&adc_trigger 0 10000 0>;
  
            // --- Other thought ------
            //adi,gpio-role = <AD4052_TRIGGER_EVENT_EITHER_THRESH
            //                 AD4052_TRIGGER_EVENT_DATA_READY>;
            // ------------------------
            interrupt-parent =  <&gpio>;
            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
                         <0 1 IRQ_TYPE_EDGE_FALLING>;
            interrupt-names = "gp0", "gp1";
            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
        };
    };

Other thought is to add an "adi,gpio-role" property to define gpio
function (as commented in the example above, matched with index of
interrupts-names). If no interrupt-name.gp0 but trigger-source.GP0,
assume role Data ready (no irq for raw read, only buffer offload).

What is your opinion on this?

Best regards,
Jorge

