Return-Path: <linux-pwm+bounces-6333-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A88AD7C49
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 22:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AACB3A09F6
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 20:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE982D540C;
	Thu, 12 Jun 2025 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tm8bH2fA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF3298CDD
	for <linux-pwm@vger.kernel.org>; Thu, 12 Jun 2025 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759644; cv=none; b=YVipq1PlSlZUSg5sQI4KHUMLM5PbMpxmBaKNTioO1kbtCWbuNFpRAS+GBsFEiVzv3rvDv5CBShw9TNKrTPvnbPbU+UpkbDH3alC1M/jGKG/H8jn8dZnN5EdpGqf3pLW8BrQ21BjnrNLQlRT5DAyDYzEL5C5K3oNcsU7XtS6LIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759644; c=relaxed/simple;
	bh=6Q/PGBvknyPShMaTySM+cqmOkNrRnIyJJHTUlyaDcRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjNiG5ZdKISK0Sf/rLtnVhXdbYNvX2tkYet+IgPyzQoFxCqUekHXVmxvUNvPgH/FH/I1GHfcUSyHmxEMxgDcZt7Ck/t/BJ62yE1B1s1YT9Nox2rpCqdOZr9wb9SoYxzO011Xb9VAf3c7+fCbhVV5YhqFi8pwEInFsgKVpRc+BeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tm8bH2fA; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c172f1de1so879333a34.3
        for <linux-pwm@vger.kernel.org>; Thu, 12 Jun 2025 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749759641; x=1750364441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnqQFNNg7S/LY+02Og7P0coplg2HCqvVrychShtmb0Y=;
        b=tm8bH2fAiv5IUInWReklncngSn1Jtoe0JCWTc00pJMs5xwwkSYX9PKVj+XJt51LOyl
         Al51SfNuaOJTrqkCoUJBDRt/6+X449+aRIxNyxOg72EAvu5LfnTwxLuXN3fvs+K/TtLf
         6H+Gok/BevwEBq2bdB1UD5MdXKk9u+Sop/4Y9p1GvPdPQJXyyNo45xYB0UxgExaZHN2L
         JB5qfh5DFb6Y8I/DNYl85HY1DGCd5NuC0zzaoAXLB7B1/Z/RzhGJ5l/B9Yw18wtbulhy
         WmzJzRO6Ro8V/gyvmL00UwITZBUQUZqyxsptVsx7FId5Hf99khtNJY7qq5U4lSvhQsTe
         m6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749759641; x=1750364441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnqQFNNg7S/LY+02Og7P0coplg2HCqvVrychShtmb0Y=;
        b=YRYQs7e1/yv9KOvkxfbJFfbHy5qMSW4mG/WCjr0MyvpOZqQymeLWAf0qcrJr+JngqC
         C3bhYtDmdfTAkBAGZo7V2WsEy6VwegSYLUSwck/wdA7rPkCeZXmYSi5UAUtmsR3v/30c
         EUf/6Pyp9TiPdt5WEcHOTkd9UoePcpqaTM3QmgumWCfzBgk/+BCeIT5TGdk7ke8IPEnq
         Gyua/bIukvSGZVTaGTY//VI7+Wt0jj9a7J7y81jf8pHDR9z0l+elwQqsNqdXfHStGuEv
         G51WS5FpaFhxuzs1ctglH2qg6TTKuDHIZTvMXwALEzI+Q5c7MitCheIN+JKQxPg6MdaW
         uJwg==
X-Forwarded-Encrypted: i=1; AJvYcCXqu7RuHEgouhmL5IAh37HH+qklwEtR2zPpIiKX3DTehHGJS0qqExsZDFYTJFDX8ULidNxOgoBBvAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRDkYQZB3tf5MWk8KmJ+fv2xdVU7r9JwiFvP8VlgPobDGIShP1
	XtwclVVcNeWWlqhjCu4JMcTcpMvYkk1NQjR+Oy38NWuw9Vx4r/pZgaP53d0YVQmPHj8=
X-Gm-Gg: ASbGnctxfm8dVyrvy6cS39+KhnqA6MQntUljF6wY6zvhfOYLtYDJ9ydUJ3tfYBC054o
	iq3uvJKyU6N+Rfx0DZzr3swIgDqANroAsSAeHe1IEfCC3dtYI3v3IXQUkcNg58YMmmG7miAgw8l
	3UG+P+L4Eg0aHX+68/G8E5yUXVdkkAW+hvixaf2qruqh37UaZQQCOdBR8t949aMinSZIU3LhRPa
	udY9s+terYpfBYypw1yuv63zt82NTRehnI9FVRPqti5DfKcdSwzwWzxfFWMrrLv2hUoo54f8qzk
	w85jM9KirimI8EXeqa+c4JXJXWK77wDavdZ26NZm/y+Jg4zsWvDRmomXM6visy3Xt03qzbzIS34
	Jd5jxFxehGy2d72dCIHbcwozVv+yhx2UDDy11
X-Google-Smtp-Source: AGHT+IGvy63gbdgYzhxx915nytzJrnbOCs/GabFdn8/B1Ozt4U4/eT429+1bpQ6NvozpwiaByThNIA==
X-Received: by 2002:a05:6830:8009:b0:72a:47ec:12c6 with SMTP id 46e09a7af769-73a2708d702mr121676a34.2.1749759641342;
        Thu, 12 Jun 2025 13:20:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f808:847:b3ae:ff1a? ([2600:8803:e7e4:1d00:f808:847:b3ae:ff1a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a16a57ec5sm392377a34.18.2025.06.12.13.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 13:20:40 -0700 (PDT)
Message-ID: <5130be5d-b769-41aa-af2f-b1e16a91e569@baylibre.com>
Date: Thu, 12 Jun 2025 15:20:40 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] dt-bindings: iio: adc: Add adi,ad4052
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Jorge Marques <jorge.marques@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-2-cf1e44c516d4@analog.com>
 <20250611181818.14d147c7@jic23-huawei>
 <xqkr3rq6ikuiz5wcbxmto4gp7wnccmmogklf2ux2edauotufim@pcuhddxdzjxi>
 <ef0d4038-b665-4ef0-9e7b-7ad2ce154c50@baylibre.com>
 <zd4fvyjbfurgsp3rpslo2ubpxzxn7bh5b2vh5j4j7outxdrcd7@firxlr6bfkic>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <zd4fvyjbfurgsp3rpslo2ubpxzxn7bh5b2vh5j4j7outxdrcd7@firxlr6bfkic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 2:42 PM, Jorge Marques wrote:
> Hi David,
> 
> thank you for chiming in
> 
> On Thu, Jun 12, 2025 at 10:03:37AM -0500, David Lechner wrote:
>> On 6/12/25 5:11 AM, Jorge Marques wrote:
>>> On Wed, Jun 11, 2025 at 06:18:18PM +0100, Jonathan Cameron wrote:
>>>> On Tue, 10 Jun 2025 09:34:35 +0200
>>>> Jorge Marques <jorge.marques@analog.com> wrote:
>>>>
>>
>> ...
>>
>>>>> +  trigger-sources:
>>>>> +    minItems: 1
>>>>> +    maxItems: 2
>>>>> +    description:
>>>>> +      Describes the output pin and event associated.
>>
>> trigger-sources would be an input pin connected to an external trigger.
>> For example, the CNV pin could be connected to a trigger-source
>> provider to trigger a conversion. But there aren't any other digital
>> inputs, so I don't know what the 2nd source would be here.
>>
>> As an example, see [1]. We could potentially use the same gpio
>> trigger-source for the conversion pin here. There is already
>> a similar binding for pwm triggers, so we could drop the separate
>> pwms binding as well an just have a single trigger-sources
>> property for the CNV pin that works for both gpio and pwm.
>>
>> [1]: https://lore.kernel.org/linux-iio/cover.1749569957.git.Jonathan.Santos@analog.com/
>>
> 
> Quick summary to familiarize myself with this part and driver.
> 
> On ad7768-1:
> ad7768-1.SYNC_OUT is a digital output, ad7768-1.SYNC_IN input, and
> ad7768-1.GPIO3 (START) configured as input. ad7768-1.GPIO[0..3] are
> configurable GPIO, GPIO3 as START, or in PIN control mode, the input
> GPIO[3:0] sets the power mode and modulator freq (MODEx).
> 
> On that thread:
> https://lore.kernel.org/linux-iio/8abca580f43cb31d7088d07a7414b5f7efe91ead.1749569957.git.Jonathan.Santos@analog.com/
> exposes GPIO[0..3] through gpio_chip if gpio-controller in dt.
> 
> https://lore.kernel.org/linux-iio/713fd786010c75858700efaec8bb285274e7057e.1749569957.git.Jonathan.Santos@analog.com/
> trigger-sources-cells: the cell define the type of signal but *not* its
> origin, because {DRDY, SYNC_OUT, GPIO3(START)} are dedicated pins, *so
> there is no need to do so*.
> 
>>>>> +
>>>>> +  "#trigger-source-cells":
>>>>> +    const: 2
>>>>> +    description: |
>>>>> +      Output pins used as trigger source.
>>>>> +
>>>>> +      Cell 0 defines the event:
>>>>> +      * 0 = Data ready
>>>>> +      * 1 = Min threshold
>>>>> +      * 2 = Max threshold
>>>>> +      * 3 = Either threshold
>>>>> +      * 4 = CHOP control
>>>>> +      * 5 = Device enable
>>>>> +      * 6 = Device ready (only GP1)
>>>>
>>>> Hmm. I'm a bit dubious on why 'what the offload trigger is'
>>>> is a DT thing?  Is that because the IP needs to comprehend
>>>> this?  I guess only data ready is actually supported in
>>>> practice? 
>>>
>>> A trigger can be connected to trigger something other than a spi
>>> offload, it is in the DT because it describes how the device is
>>> connected. When using spi offload, the trigger-source at the spi handle
>>> describes which gpio and event is routed to the offload trigger input.
>>> At the ADC node, trigger-source-cells describe the source gpio and event
>>> for the device driver.
>>>
>>> In practice, in this series, one gpio is Data ready, triggering offload
>>> when buffer enabled, and raw reads, when disabled. And the other is
>>> Either threshold, propagated as an IIO event. Fancy logic can be added
>>> to the driver in future patches to allow other combinations.
>>>
>>> It is also worth to mention that the trigger-source is duplicated for
>>> each node that uses it, as seen in the second dts example:
>>>
>>>    &adc AD4052_TRIGGER_EVENT_DATA_READY AD4052_TRIGGER_PIN_GP1
>>>
>>> Is repeated on both adc and spi node.
>>
>> That sounds wrong. This would only make sense if an output of the
>> ADC was wired back to itself. 
>>
> 
> The issue is the lack of way of describing to the driver the function of
> each gpio, when configurable. Perhaps it is better to use
> trigger-source-cells to only describe the topology at that node
> receiving the trigger, e.g.
> 
>   trigger-sources = <&adc AD4052_TRIGGER_PIN_GP0>;
> 
> Below I continue the discussion.
>>>
>>> One last thing, on the driver, for v3, I should handle -ENOENT:
>>>
>>>   ret = of_parse_phandle_with_args(np, "trigger-sources",
>>>   				   "#trigger-source-cells", i,
>>>   				   &trigger_sources);
>>>   if (ret)
>>>   	return ret == -ENOENT ? 0 : ret;
>>>
>>> To assert only when present, since the nodes are not required.
>>> Or, in the driver,
>>> require AD4052_TRIGGER_PIN_GP0 if irq_get_byname finds gp0, and
>>> require AD4052_TRIGGER_PIN_GP1 if irq_get_byname finds gp1?
>>> (I would go with the first option).
>>>>
>>
>> ,,,
>>
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/gpio/gpio.h>
>>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>>> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
>>>>> +
>>>>> +    spi {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +
>>>>> +        adc@0 {
>>>>> +            compatible = "adi,ad4052";
>>>>> +            reg = <0>;
>>>>> +            vdd-supply = <&vdd>;
>>>>> +            vio-supply = <&vio>;
>>>>> +            ref-supply = <&ref>;
>>>>> +            spi-max-frequency = <83333333>;
>>>>> +
>>>>> +            #trigger-source-cells = <2>;
>>>>> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
>>>>> +                                    AD4052_TRIGGER_PIN_GP0
>>>>> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
>>>>> +                                    AD4052_TRIGGER_PIN_GP1>;
>>
>> This doesn't make sense for the reason given above. These outputs
>> aren't wired back to inputs on the ADC. They are wired to interrupts
>> on the MCU, which is already described below.
>>
> Below.
>>>>> +            interrupt-parent = <&gpio>;
>>>>> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
>>>>> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
>>>>> +            interrupt-names = "gp0", "gp1";
>>>>> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
>>>>> +        };
>>>>> +    };
>>>>> +  - |
>>>>> +    #include <dt-bindings/gpio/gpio.h>
>>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>>> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
>>>>> +
>>>>> +    rx_dma {
>>>>> +            #dma-cells = <1>;
>>>>> +    };
>>>>> +
>>>>> +    spi {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +
>>>>> +        dmas = <&rx_dma 0>;
>>>>> +        dma-names = "offload0-rx";
>>
>> The dmas aren't related to the ADC, so can be left out of the example.
>>
> Ack.
>>>>> +        trigger-sources = <&adc AD4052_TRIGGER_EVENT_DATA_READY
>>>>> +                                AD4052_TRIGGER_PIN_GP1>;
>>>>> +
>>>>> +        adc@0 {
>>>>> +            compatible = "adi,ad4052";
>>>>> +            reg = <0>;
>>>>> +            vdd-supply = <&vdd>;
>>>>> +            vio-supply = <&vio>;
>>>>> +            spi-max-frequency = <83333333>;
>>>>> +            pwms = <&adc_trigger 0 10000 0>;
>>>>> +
>>>>> +            #trigger-source-cells = <2>;
>>>>> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
>>>>> +                                    AD4052_TRIGGER_PIN_GP0
>>>>> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
>>>>> +                                    AD4052_TRIGGER_PIN_GP1>;
>>
>> Same as above - the GP pins aren't wired back to the ADC itself.
>>
>>>>> +            interrupt-parent = <&gpio>;
>>>>> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
>>>>> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
>>>>> +            interrupt-names = "gp0", "gp1";
>>>>> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
>>>>> +        };
>>>>> +    };
> 
> Considering the discussion above. As is, in this series GP0 is event
> Either threshold and GP1 Data ready. A future series would aim to make
> it truly configurable.
> 
> For this series then, do we then drop the second cell of trigger cell
> and do not provide a way of describing the function of each gpio? e.g.

The bindings can't be changed later, so no, don't drop the 2nd cell
if we are going to add it back later.

But considering Jonathan's feedback, I am now questioning if we need
the 2nd cell at all. The way trigger-source consumers work currently
is that they request a trigger of a certain generic type, like "data
ready". So this information could be used to determine what function
needs to be assigned to the pin without having to define that in the
devicetree.

> 
>   - |
>     #include <dt-bindings/gpio/gpio.h>
>     #include <dt-bindings/interrupt-controller/irq.h>
>     #include <dt-bindings/iio/adc/adi,ad4052.h>
>   
>     rx_dma {
>             #dma-cells = <1>;
>     };
>   
>     spi {
>         #address-cells = <1>;
>         #size-cells = <0>;
>   
>         trigger-sources = <&adc AD4052_TRIGGER_PIN_GP0>;
>   
>         adc@0 {
>             compatible = "adi,ad4052";
>             reg = <0>;
>             vdd-supply = <&vdd>;
>             vio-supply = <&vio>;
>             spi-max-frequency = <83333333>;
>             pwms = <&adc_trigger 0 10000 0>;
>   
>             // --- Other thought ------
>             //adi,gpio-role = <AD4052_TRIGGER_EVENT_EITHER_THRESH
>             //                 AD4052_TRIGGER_EVENT_DATA_READY>;
>             // ------------------------
>             interrupt-parent =  <&gpio>;
>             interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
>                          <0 1 IRQ_TYPE_EDGE_FALLING>;
>             interrupt-names = "gp0", "gp1";
>             cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
>         };
>     };
> 
> Other thought is to add an "adi,gpio-role" property to define gpio
> function (as commented in the example above, matched with index of
> interrupts-names). If no interrupt-name.gp0 but trigger-source.GP0,
> assume role Data ready (no irq for raw read, only buffer offload).
> 
> What is your opinion on this?


Usually, we just have the devicetree describe how things are wired up.
Then the driver looks at how things are wired up and decides how to
best make use of the available resources. I.e. in the driver add some
variables in the driver state struct that keeps track of the function
assigned to each GP pin and use that to make decisions.

In the driver, we would want to make sure to handle triggers first
since those are less flexible (so set up SPI offload first). This
would cause one of the GP pins to be assigned to the /RDY function.
It doesn't matter which one.

Then later, parse the interrupts property. If we see that one of
the GP pins is already assigned to /RDY, then we know we have to
use that pin for the /RDY interrupt as well. If both pins are still
available, then an arbitrary one can be assigned for /RDY.

Then if there is still an unused GP pin left that is actually
wired up to an interrupt, that can be used for the events interrupt.

Or we could even consider to have everything on one pin since the
/RDY signal would never be needed at the same time as events as long
as the events are only ever used in monitor mode.

If we find that there is some case though where the driver really
can't figure out what to do with the available information, then
we could probably justify adding a property like you suggested.
It seems like we could possibly do without it at this point though.

