Return-Path: <linux-pwm+bounces-6346-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B2EAD9C05
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 12:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC36B7A6164
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13DD23498E;
	Sat, 14 Jun 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czfn4TiI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531C1E7648;
	Sat, 14 Jun 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749896104; cv=none; b=aLMZMz6ZzAX0HIKBMRiZHAafBibsBndGD12DxfQAyY9uoPKg7rlmKZvJJbVcaNqQ4kAOzAPqKg8Tq4YSfOtTTo464jvJtuyR0+nIMXdbl0ZqZt35WlToPKHZPKo30cZABo3rbuCxzFgAtXVcGw8854ms+amC1WxXhODA6XJQ+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749896104; c=relaxed/simple;
	bh=GHTvmES2P7gY68VtoLjCEKKwS3lD28L0xNpH8WBRu4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ON+ppAMnPp9QFIJFmCl52JjGE0Y6PrFsY554qhtyMyODABlSSi7Aak6QMaDEgjBEEMWjAKoFmEr8c0tNRze/09bAzPU4lTI9ouUukFE0H9u7boExE9sWczuzkKEb5NEviNJM5bro5XaUP3MWjOe3RTJmRr1vsxM0zsLQGwFOBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czfn4TiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F91AC4CEEB;
	Sat, 14 Jun 2025 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749896104;
	bh=GHTvmES2P7gY68VtoLjCEKKwS3lD28L0xNpH8WBRu4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=czfn4TiIjdN2/g8LC8p6UzlpBRZ5VwNkn3WBEa+Eoja6+lvGw+fJ4TANNMxwDktXy
	 SoBdqwokvBQyRnXqza2Goxal/s9rjuPnfLcSYOJ3oan+urEpsQcv6h1CTptEeo/dHy
	 aj+qJ4pwZveRqMxQ99WsNaPnfFYnqAQMerhxpXcKT3ngs/pmmyrIu0L+/7xH0+ffWY
	 yV1rn7ppHZnxrlvYI0vUD2I+I7tCcXym2jz8CGGw9nkYzgM1w/sFOV419XljDWkzim
	 EYnORK9uBVdZBOpqwDT+6YxczWQJHIgDcCrMc/Z4iZAikOlXd2c98+k/GMJ2hJTjzQ
	 r6zaAlK0N0NCQ==
Date: Sat, 14 Jun 2025 11:14:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jorge Marques
 <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <20250614111454.25741044@jic23-huawei>
In-Reply-To: <5lr5sqwtj52dy5n73ti2jszbybx5dpww33jceehdqehklr2hbm@zxickou2odcb>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
	<20250610-iio-driver-ad4052-v3-2-cf1e44c516d4@analog.com>
	<20250611181818.14d147c7@jic23-huawei>
	<xqkr3rq6ikuiz5wcbxmto4gp7wnccmmogklf2ux2edauotufim@pcuhddxdzjxi>
	<ef0d4038-b665-4ef0-9e7b-7ad2ce154c50@baylibre.com>
	<zd4fvyjbfurgsp3rpslo2ubpxzxn7bh5b2vh5j4j7outxdrcd7@firxlr6bfkic>
	<5130be5d-b769-41aa-af2f-b1e16a91e569@baylibre.com>
	<5lr5sqwtj52dy5n73ti2jszbybx5dpww33jceehdqehklr2hbm@zxickou2odcb>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 13:17:46 +0200
Jorge Marques <gastmaier@gmail.com> wrote:

> Hi David,
> On Thu, Jun 12, 2025 at 03:20:40PM -0500, David Lechner wrote:
> > On 6/12/25 2:42 PM, Jorge Marques wrote:  
> > > Hi David,
> > > 
> > > thank you for chiming in
> > > 
> > > On Thu, Jun 12, 2025 at 10:03:37AM -0500, David Lechner wrote:  
> > >> On 6/12/25 5:11 AM, Jorge Marques wrote:  
> > >>> On Wed, Jun 11, 2025 at 06:18:18PM +0100, Jonathan Cameron wrote:  
> > >>>> On Tue, 10 Jun 2025 09:34:35 +0200
> > >>>> Jorge Marques <jorge.marques@analog.com> wrote:
> > >>>>  
> > >>
> > >> ...
> > >>  
> > >>>>> +  trigger-sources:
> > >>>>> +    minItems: 1
> > >>>>> +    maxItems: 2
> > >>>>> +    description:
> > >>>>> +      Describes the output pin and event associated.  
> > >>
> > >> trigger-sources would be an input pin connected to an external trigger.
> > >> For example, the CNV pin could be connected to a trigger-source
> > >> provider to trigger a conversion. But there aren't any other digital
> > >> inputs, so I don't know what the 2nd source would be here.
> > >>
> > >> As an example, see [1]. We could potentially use the same gpio
> > >> trigger-source for the conversion pin here. There is already
> > >> a similar binding for pwm triggers, so we could drop the separate
> > >> pwms binding as well an just have a single trigger-sources
> > >> property for the CNV pin that works for both gpio and pwm.
> > >>
> > >> [1]: https://lore.kernel.org/linux-iio/cover.1749569957.git.Jonathan.Santos@analog.com/
> > >>  
> > > 
> > > Quick summary to familiarize myself with this part and driver.
> > > 
> > > On ad7768-1:
> > > ad7768-1.SYNC_OUT is a digital output, ad7768-1.SYNC_IN input, and
> > > ad7768-1.GPIO3 (START) configured as input. ad7768-1.GPIO[0..3] are
> > > configurable GPIO, GPIO3 as START, or in PIN control mode, the input
> > > GPIO[3:0] sets the power mode and modulator freq (MODEx).
> > > 
> > > On that thread:
> > > https://lore.kernel.org/linux-iio/8abca580f43cb31d7088d07a7414b5f7efe91ead.1749569957.git.Jonathan.Santos@analog.com/
> > > exposes GPIO[0..3] through gpio_chip if gpio-controller in dt.
> > > 
> > > https://lore.kernel.org/linux-iio/713fd786010c75858700efaec8bb285274e7057e.1749569957.git.Jonathan.Santos@analog.com/
> > > trigger-sources-cells: the cell define the type of signal but *not* its
> > > origin, because {DRDY, SYNC_OUT, GPIO3(START)} are dedicated pins, *so
> > > there is no need to do so*.
> > >   
> > >>>>> +
> > >>>>> +  "#trigger-source-cells":
> > >>>>> +    const: 2
> > >>>>> +    description: |
> > >>>>> +      Output pins used as trigger source.
> > >>>>> +
> > >>>>> +      Cell 0 defines the event:
> > >>>>> +      * 0 = Data ready
> > >>>>> +      * 1 = Min threshold
> > >>>>> +      * 2 = Max threshold
> > >>>>> +      * 3 = Either threshold
> > >>>>> +      * 4 = CHOP control
> > >>>>> +      * 5 = Device enable
> > >>>>> +      * 6 = Device ready (only GP1)  
> > >>>>
> > >>>> Hmm. I'm a bit dubious on why 'what the offload trigger is'
> > >>>> is a DT thing?  Is that because the IP needs to comprehend
> > >>>> this?  I guess only data ready is actually supported in
> > >>>> practice?   
> > >>>
> > >>> A trigger can be connected to trigger something other than a spi
> > >>> offload, it is in the DT because it describes how the device is
> > >>> connected. When using spi offload, the trigger-source at the spi handle
> > >>> describes which gpio and event is routed to the offload trigger input.
> > >>> At the ADC node, trigger-source-cells describe the source gpio and event
> > >>> for the device driver.
> > >>>
> > >>> In practice, in this series, one gpio is Data ready, triggering offload
> > >>> when buffer enabled, and raw reads, when disabled. And the other is
> > >>> Either threshold, propagated as an IIO event. Fancy logic can be added
> > >>> to the driver in future patches to allow other combinations.
> > >>>
> > >>> It is also worth to mention that the trigger-source is duplicated for
> > >>> each node that uses it, as seen in the second dts example:
> > >>>
> > >>>    &adc AD4052_TRIGGER_EVENT_DATA_READY AD4052_TRIGGER_PIN_GP1
> > >>>
> > >>> Is repeated on both adc and spi node.  
> > >>
> > >> That sounds wrong. This would only make sense if an output of the
> > >> ADC was wired back to itself. 
> > >>  
> > > 
> > > The issue is the lack of way of describing to the driver the function of
> > > each gpio, when configurable. Perhaps it is better to use
> > > trigger-source-cells to only describe the topology at that node
> > > receiving the trigger, e.g.
> > > 
> > >   trigger-sources = <&adc AD4052_TRIGGER_PIN_GP0>;
> > > 
> > > Below I continue the discussion.  
> > >>>
> > >>> One last thing, on the driver, for v3, I should handle -ENOENT:
> > >>>
> > >>>   ret = of_parse_phandle_with_args(np, "trigger-sources",
> > >>>   				   "#trigger-source-cells", i,
> > >>>   				   &trigger_sources);
> > >>>   if (ret)
> > >>>   	return ret == -ENOENT ? 0 : ret;
> > >>>
> > >>> To assert only when present, since the nodes are not required.
> > >>> Or, in the driver,
> > >>> require AD4052_TRIGGER_PIN_GP0 if irq_get_byname finds gp0, and
> > >>> require AD4052_TRIGGER_PIN_GP1 if irq_get_byname finds gp1?
> > >>> (I would go with the first option).  
> > >>>>  
> > >>
> > >> ,,,
> > >>  
> > >>>>> +examples:
> > >>>>> +  - |
> > >>>>> +    #include <dt-bindings/gpio/gpio.h>
> > >>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
> > >>>>> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
> > >>>>> +
> > >>>>> +    spi {
> > >>>>> +        #address-cells = <1>;
> > >>>>> +        #size-cells = <0>;
> > >>>>> +
> > >>>>> +        adc@0 {
> > >>>>> +            compatible = "adi,ad4052";
> > >>>>> +            reg = <0>;
> > >>>>> +            vdd-supply = <&vdd>;
> > >>>>> +            vio-supply = <&vio>;
> > >>>>> +            ref-supply = <&ref>;
> > >>>>> +            spi-max-frequency = <83333333>;
> > >>>>> +
> > >>>>> +            #trigger-source-cells = <2>;
> > >>>>> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
> > >>>>> +                                    AD4052_TRIGGER_PIN_GP0
> > >>>>> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
> > >>>>> +                                    AD4052_TRIGGER_PIN_GP1>;  
> > >>
> > >> This doesn't make sense for the reason given above. These outputs
> > >> aren't wired back to inputs on the ADC. They are wired to interrupts
> > >> on the MCU, which is already described below.
> > >>  
> > > Below.  
> > >>>>> +            interrupt-parent = <&gpio>;
> > >>>>> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> > >>>>> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> > >>>>> +            interrupt-names = "gp0", "gp1";
> > >>>>> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> > >>>>> +        };
> > >>>>> +    };
> > >>>>> +  - |
> > >>>>> +    #include <dt-bindings/gpio/gpio.h>
> > >>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
> > >>>>> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
> > >>>>> +
> > >>>>> +    rx_dma {
> > >>>>> +            #dma-cells = <1>;
> > >>>>> +    };
> > >>>>> +
> > >>>>> +    spi {
> > >>>>> +        #address-cells = <1>;
> > >>>>> +        #size-cells = <0>;
> > >>>>> +
> > >>>>> +        dmas = <&rx_dma 0>;
> > >>>>> +        dma-names = "offload0-rx";  
> > >>
> > >> The dmas aren't related to the ADC, so can be left out of the example.
> > >>  
> > > Ack.  
> > >>>>> +        trigger-sources = <&adc AD4052_TRIGGER_EVENT_DATA_READY
> > >>>>> +                                AD4052_TRIGGER_PIN_GP1>;
> > >>>>> +
> > >>>>> +        adc@0 {
> > >>>>> +            compatible = "adi,ad4052";
> > >>>>> +            reg = <0>;
> > >>>>> +            vdd-supply = <&vdd>;
> > >>>>> +            vio-supply = <&vio>;
> > >>>>> +            spi-max-frequency = <83333333>;
> > >>>>> +            pwms = <&adc_trigger 0 10000 0>;
> > >>>>> +
> > >>>>> +            #trigger-source-cells = <2>;
> > >>>>> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
> > >>>>> +                                    AD4052_TRIGGER_PIN_GP0
> > >>>>> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
> > >>>>> +                                    AD4052_TRIGGER_PIN_GP1>;  
> > >>
> > >> Same as above - the GP pins aren't wired back to the ADC itself.
> > >>  
> > >>>>> +            interrupt-parent = <&gpio>;
> > >>>>> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> > >>>>> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> > >>>>> +            interrupt-names = "gp0", "gp1";
> > >>>>> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> > >>>>> +        };
> > >>>>> +    };  
> > > 
> > > Considering the discussion above. As is, in this series GP0 is event
> > > Either threshold and GP1 Data ready. A future series would aim to make
> > > it truly configurable.
> > > 
> > > For this series then, do we then drop the second cell of trigger cell
> > > and do not provide a way of describing the function of each gpio? e.g.  
> > 
> > The bindings can't be changed later, so no, don't drop the 2nd cell
> > if we are going to add it back later.
> > 
> > But considering Jonathan's feedback, I am now questioning if we need
> > the 2nd cell at all. The way trigger-source consumers work currently
> > is that they request a trigger of a certain generic type, like "data
> > ready". So this information could be used to determine what function
> > needs to be assigned to the pin without having to define that in the
> > devicetree.
> >   
> Useful for assertion. It is odd to be used for requesting of a certain
> type (gpio role) instead of telling how things are wired.
> > > 
> > >   - |
> > >     #include <dt-bindings/gpio/gpio.h>
> > >     #include <dt-bindings/interrupt-controller/irq.h>
> > >     #include <dt-bindings/iio/adc/adi,ad4052.h>
> > >   
> > >     rx_dma {
> > >             #dma-cells = <1>;
> > >     };
> > >   
> > >     spi {
> > >         #address-cells = <1>;
> > >         #size-cells = <0>;
> > >   
> > >         trigger-sources = <&adc AD4052_TRIGGER_PIN_GP0>;
> > >   
> > >         adc@0 {
> > >             compatible = "adi,ad4052";
> > >             reg = <0>;
> > >             vdd-supply = <&vdd>;
> > >             vio-supply = <&vio>;
> > >             spi-max-frequency = <83333333>;
> > >             pwms = <&adc_trigger 0 10000 0>;
> > >   
> > >             // --- Other thought ------
> > >             //adi,gpio-role = <AD4052_TRIGGER_EVENT_EITHER_THRESH
> > >             //                 AD4052_TRIGGER_EVENT_DATA_READY>;
> > >             // ------------------------
> > >             interrupt-parent =  <&gpio>;
> > >             interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> > >                          <0 1 IRQ_TYPE_EDGE_FALLING>;
> > >             interrupt-names = "gp0", "gp1";
> > >             cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> > >         };
> > >     };
> > > 
> > > Other thought is to add an "adi,gpio-role" property to define gpio
> > > function (as commented in the example above, matched with index of
> > > interrupts-names). If no interrupt-name.gp0 but trigger-source.GP0,
> > > assume role Data ready (no irq for raw read, only buffer offload).
> > > 
> > > What is your opinion on this?  
> > 
> > 
> > Usually, we just have the devicetree describe how things are wired up.
> > Then the driver looks at how things are wired up and decides how to
> > best make use of the available resources. I.e. in the driver add some
> > variables in the driver state struct that keeps track of the function
> > assigned to each GP pin and use that to make decisions.
> > 
> > In the driver, we would want to make sure to handle triggers first
> > since those are less flexible (so set up SPI offload first). This
> > would cause one of the GP pins to be assigned to the /RDY function.
> > It doesn't matter which one.
> >   
> I will default drdy_gp to g0, until offload request overwrites it,
> either gp0 or gp1.
> > Then later, parse the interrupts property. If we see that one of
> > the GP pins is already assigned to /RDY, then we know we have to
> > use that pin for the /RDY interrupt as well. If both pins are still
> > available, then an arbitrary one can be assigned for /RDY.  
> based on drdy_gp, set that gp as drdy, and the remaining is threshold
> either. the interrupt is optional, but setup device gp regardless, since
> the irq may be consumed by other device.
> > 
> > Then if there is still an unused GP pin left that is actually
> > wired up to an interrupt, that can be used for the events interrupt.
> > 
> > Or we could even consider to have everything on one pin since the
> > /RDY signal would never be needed at the same time as events as long
> > as the events are only ever used in monitor mode.
> >  
> 
> The threshold event occurs on the rising edge, the data ready on the
> falling edge (it is actually BUSY). Mixing both has a lot of nuances
> involved.

Ok. Mixing them might not make sense - but overall the decision on what
to do with any line that is just wired device to host interrupt is
a driver problem.   If it's also wired to another device (including
offload engine) and that requires a specific setting (e.g. data ready)
then that is fair enough to have in DT.

I think that's roughly where this discussion ended up but just wanted
to confirm that.

Jonathan

> > If we find that there is some case though where the driver really
> > can't figure out what to do with the available information, then
> > we could probably justify adding a property like you suggested.
> > It seems like we could possibly do without it at this point though.  
> 
> With the proposed above, I don't need the cell 0 of trigger-sources. But
> I will keep for assertion since we are inferring
> has?trigger-sources-> -then-> drdy.
> 
> Best regards,
> Jorge


