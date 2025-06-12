Return-Path: <linux-pwm+bounces-6323-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E2AD7539
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 17:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6FD18816F3
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC86A273D7E;
	Thu, 12 Jun 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wKtI/wGf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAB24A07A
	for <linux-pwm@vger.kernel.org>; Thu, 12 Jun 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740623; cv=none; b=Tq3fZPa4yo2bO6gkebGqOLKZegx02RqpyzJ24rhNg8eM1ve+UPToLDVUW508/FN968RlJAXWpF5ZSyYZ5T7IjlZaCa5dXWPPpm5weERj4x8Ruhom/sQqoZTBNIIyUBoYlfw/0ZzgWynEoWcsc8oGhILROWZr6jwdbmQ/qYVmtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740623; c=relaxed/simple;
	bh=HT0OPOWngJLYGraue4dv+E8G+K+QgCbixj7ubRpcOTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJsuIShyha2b44fiG3J6xt2aNloARkdLQM1lxRjQnyTZZMpy5yWhbQnlxJoGCEgPnMa8+o51JJGVz40Sk01mvMQmlkeBGZ0LPG6LJ2zjouKNCPCuaAnuCLkFKtZiSmUjGXv9EAjVNLbP9Dl6HDYqZFmrGeXynW/6IjiVRca4P2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wKtI/wGf; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-60634f82d1aso329562eaf.3
        for <linux-pwm@vger.kernel.org>; Thu, 12 Jun 2025 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749740621; x=1750345421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CWX5K7cUh5q7+ZKZX3fft9+sBWTbcloK0NCvH6AyF8=;
        b=wKtI/wGfQ4n1DeeG2Z00cUSVW7upOwHN9Z3esgRFY1ny6kibGIw5gKGZJbzgMZWLQH
         riAasdI3mbxtIeWAtbjKqgCcKfXe5wGeKftX6dXSOl6bQdrmS2MnvdM/DiyGmZAV2+yX
         buXG/A2DCBR5qqL3Sh1auh4VARG3Mr3ehtX3WcjCq0Sdd0PXa8NXagJTeNmfao/RmEC2
         mZEYnwml946pUTI+3X5ZwGZUdbYRPQ08yNuBZHyXtdVQUNG0Q3q2A+AVN5OYInU+BzIe
         aPLfdHFrlRFaOvgS2cWLQ++MiY2KPWYjfHt6LvMb84GhZKXhTO7PB2/flkXP3W2fHdno
         Hc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749740621; x=1750345421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CWX5K7cUh5q7+ZKZX3fft9+sBWTbcloK0NCvH6AyF8=;
        b=RewDi5jbeZIwgWQuBo9vLmwqDs93eFZ+R0osPukWZOTzzU15bzNa4hRTfF03yckDlf
         7DpwEzeVbY5g6A3QtZTZqWXnlveffU7PTF1LDw1vzWVD5NUFUG8GeJJQE8/NjFi9BPoD
         p7pRBYvRh2orrUHI0DGHRGnplrgYyFAt1j4VI2vTVCY6trlwOltn3ki/CSWXZMIXlg2L
         pC3H5eiD4Fj5spGv1OgE92/HRuR0Jg8UA7PxXwOe4KKhUiP3CjJGuie1/cUzICO3xj3U
         r8mXWSY0R9PGTn+9PR3E323a/pJOVIFIekvjVYdXey56Gkrw7oxvpa0ZYUjyYPoSg9Ey
         AP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSsI3MNNaZkZqK6r69gKVFt/9fCmii+aV8Z9UoRIntHHqiaezN2XF7hfmcJuEBQW0sZGBMHCHwRSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiD9BxfJCnILMWJ7u9Idb2H2G7NcEe9NT6V3XxjZcEhjGBZl37
	iwKjHvRSIB5MqNKEJtqoY6FX0k5RNEiY8iGzzCwhrTk8BWOCyAsmLJ4sqOyGjree7XU=
X-Gm-Gg: ASbGncs//blb0k65rYUS7krGMqOjhCOeqppKml7euxQNJewhx020muyaAVSoVb6Ew2y
	hrp4+cXATee7fm2lYgLiZZsVPc4JgSdXTTg6rxl2LZiPh0Z98+H2ORUzWuiyAjPI+lr0xK0o7BP
	truXriXEu2On1su70uu+YKf7FKPvSieOhfkVNdYKIGgqD3SZ6TI/wl7aLr+tAHJdYCqU8yqOjN7
	MoU9kjlJI6pH1hQDSxKFpQcaLQDoNURlW0946wj3NbnwHYmMo177vNylI06sv3PzSSeNqz1qE00
	yve2DUy2n10J/aXP5grrrn6DRjCeGKeR/W722SOKUcqSwlFLh0uaCDpgdxKZvJvQuggmvlLXYcP
	xHji3YePmxe4tVzpN6dmebXU2qZPCaF6+4P7UX8E=
X-Google-Smtp-Source: AGHT+IHPsllSyEnOVWrSdTMtSNh/JbEncApgsNcq4KhwIS/LyDsZLEXq3MJMsM7IZl//e0XvwhL3zw==
X-Received: by 2002:a05:6820:216:b0:610:fbf2:bd7d with SMTP id 006d021491bc7-610fbf2c05emr2541424eaf.6.1749740620626;
        Thu, 12 Jun 2025 08:03:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4753:719f:673f:547c? ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-610fd4fbe3asm207044eaf.28.2025.06.12.08.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 08:03:39 -0700 (PDT)
Message-ID: <ef0d4038-b665-4ef0-9e7b-7ad2ce154c50@baylibre.com>
Date: Thu, 12 Jun 2025 10:03:37 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] dt-bindings: iio: adc: Add adi,ad4052
To: Jorge Marques <gastmaier@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>,
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <xqkr3rq6ikuiz5wcbxmto4gp7wnccmmogklf2ux2edauotufim@pcuhddxdzjxi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 5:11 AM, Jorge Marques wrote:
> On Wed, Jun 11, 2025 at 06:18:18PM +0100, Jonathan Cameron wrote:
>> On Tue, 10 Jun 2025 09:34:35 +0200
>> Jorge Marques <jorge.marques@analog.com> wrote:
>>

...

>>> +  trigger-sources:
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +    description:
>>> +      Describes the output pin and event associated.

trigger-sources would be an input pin connected to an external trigger.
For example, the CNV pin could be connected to a trigger-source
provider to trigger a conversion. But there aren't any other digital
inputs, so I don't know what the 2nd source would be here.

As an example, see [1]. We could potentially use the same gpio
trigger-source for the conversion pin here. There is already
a similar binding for pwm triggers, so we could drop the separate
pwms binding as well an just have a single trigger-sources
property for the CNV pin that works for both gpio and pwm.

[1]: https://lore.kernel.org/linux-iio/cover.1749569957.git.Jonathan.Santos@analog.com/

>>> +
>>> +  "#trigger-source-cells":
>>> +    const: 2
>>> +    description: |
>>> +      Output pins used as trigger source.
>>> +
>>> +      Cell 0 defines the event:
>>> +      * 0 = Data ready
>>> +      * 1 = Min threshold
>>> +      * 2 = Max threshold
>>> +      * 3 = Either threshold
>>> +      * 4 = CHOP control
>>> +      * 5 = Device enable
>>> +      * 6 = Device ready (only GP1)
>>
>> Hmm. I'm a bit dubious on why 'what the offload trigger is'
>> is a DT thing?  Is that because the IP needs to comprehend
>> this?  I guess only data ready is actually supported in
>> practice? 
> 
> A trigger can be connected to trigger something other than a spi
> offload, it is in the DT because it describes how the device is
> connected. When using spi offload, the trigger-source at the spi handle
> describes which gpio and event is routed to the offload trigger input.
> At the ADC node, trigger-source-cells describe the source gpio and event
> for the device driver.
> 
> In practice, in this series, one gpio is Data ready, triggering offload
> when buffer enabled, and raw reads, when disabled. And the other is
> Either threshold, propagated as an IIO event. Fancy logic can be added
> to the driver in future patches to allow other combinations.
> 
> It is also worth to mention that the trigger-source is duplicated for
> each node that uses it, as seen in the second dts example:
> 
>    &adc AD4052_TRIGGER_EVENT_DATA_READY AD4052_TRIGGER_PIN_GP1
> 
> Is repeated on both adc and spi node.

That sounds wrong. This would only make sense if an output of the
ADC was wired back to itself. 

> 
> One last thing, on the driver, for v3, I should handle -ENOENT:
> 
>   ret = of_parse_phandle_with_args(np, "trigger-sources",
>   				   "#trigger-source-cells", i,
>   				   &trigger_sources);
>   if (ret)
>   	return ret == -ENOENT ? 0 : ret;
> 
> To assert only when present, since the nodes are not required.
> Or, in the driver,
> require AD4052_TRIGGER_PIN_GP0 if irq_get_byname finds gp0, and
> require AD4052_TRIGGER_PIN_GP1 if irq_get_byname finds gp1?
> (I would go with the first option).
>>

,,,

>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
>>> +
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        adc@0 {
>>> +            compatible = "adi,ad4052";
>>> +            reg = <0>;
>>> +            vdd-supply = <&vdd>;
>>> +            vio-supply = <&vio>;
>>> +            ref-supply = <&ref>;
>>> +            spi-max-frequency = <83333333>;
>>> +
>>> +            #trigger-source-cells = <2>;
>>> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
>>> +                                    AD4052_TRIGGER_PIN_GP0
>>> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
>>> +                                    AD4052_TRIGGER_PIN_GP1>;

This doesn't make sense for the reason given above. These outputs
aren't wired back to inputs on the ADC. They are wired to interrupts
on the MCU, which is already described below.

>>> +            interrupt-parent = <&gpio>;
>>> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
>>> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
>>> +            interrupt-names = "gp0", "gp1";
>>> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
>>> +        };
>>> +    };
>>> +  - |
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    #include <dt-bindings/iio/adc/adi,ad4052.h>
>>> +
>>> +    rx_dma {
>>> +            #dma-cells = <1>;
>>> +    };
>>> +
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        dmas = <&rx_dma 0>;
>>> +        dma-names = "offload0-rx";

The dmas aren't related to the ADC, so can be left out of the example.

>>> +        trigger-sources = <&adc AD4052_TRIGGER_EVENT_DATA_READY
>>> +                                AD4052_TRIGGER_PIN_GP1>;
>>> +
>>> +        adc@0 {
>>> +            compatible = "adi,ad4052";
>>> +            reg = <0>;
>>> +            vdd-supply = <&vdd>;
>>> +            vio-supply = <&vio>;
>>> +            spi-max-frequency = <83333333>;
>>> +            pwms = <&adc_trigger 0 10000 0>;
>>> +
>>> +            #trigger-source-cells = <2>;
>>> +            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
>>> +                                    AD4052_TRIGGER_PIN_GP0
>>> +                               &adc AD4052_TRIGGER_EVENT_DATA_READY
>>> +                                    AD4052_TRIGGER_PIN_GP1>;

Same as above - the GP pins aren't wired back to the ADC itself.

>>> +            interrupt-parent = <&gpio>;
>>> +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
>>> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
>>> +            interrupt-names = "gp0", "gp1";
>>> +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
>>> +        };
>>> +    };

