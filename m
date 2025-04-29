Return-Path: <linux-pwm+bounces-5768-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3053AA0DCA
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 15:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5A81B601D4
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEBF2C2593;
	Tue, 29 Apr 2025 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT1solDx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF1258CE9;
	Tue, 29 Apr 2025 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934531; cv=none; b=fQslkrp4KSTTGm1JXtzqCO+Ra00k1xJCjvb3JGOx3uTNc5IXvM163QvksefGVIu2LnqLRA1QXMpk7qdEx5ewKmBYXsnwk0WCRq5eOqBWdTrauEcF6wjAT1IOKdzXVPc34LwRchjzCKPL9NglOYO927qXYilNbdt75pKhtZX+MWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934531; c=relaxed/simple;
	bh=RL4pBm1cegtTnNFmla69qaRvYU/AIYfVr2iGuyY0c5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw4/67Lq12hwpRY4taK2BekhYHNxboqKK+6xEHBugR/B3qS1QVunf4dDXCn4A2KXe92N5RxL7ePQ4nzfyh8zcWUS9WEEZNoJJ0JIj+i3IBJH75gaR2Bfwq4GqP00WNVBr2LQe/JIrjursOWZ5O+fChD8oZfh5j/FoKRqXnheTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT1solDx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1019482766b.3;
        Tue, 29 Apr 2025 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745934527; x=1746539327; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f5d+tJOcKTV65cbkHDncvGvsDNRLN8qU/T6XEqI3xig=;
        b=PT1solDxWuxWEhUuejblU+2igH/d+LdtSUeZ8cbfXX4xspiKkAfwf8K8jtu14TRb0w
         9GKH4YO1ApsXRTnJ0up5mRtccSzrAvCcUF5WW31JjB2Etx1ty6ajCTfWeDi0cWnKzydF
         0TDyL8HpmjZ+Z7l1clLthqXDwspkfLy3zI3HqSY3ag7cTrAUe0GsOt6XPQktVYdB3Z/4
         +fda+BTXjDFasCSkghU5UHc94G/9rAE1vPycEJzelUAXivF8FB4MU9c3gBgcOmZNSW3E
         cEwDqO0HosUvdWSAdaaBuJ/Xb1jFkfpO3FV3KU3DWpdzLuRjRNzrksu2splj58vP2pDe
         JTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934527; x=1746539327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5d+tJOcKTV65cbkHDncvGvsDNRLN8qU/T6XEqI3xig=;
        b=s0GroTiH6efS5FBWPJ8QvJNbURd9lxfZP1NAZC2pA9JxdrX0+vyxU0Zu4n2LzdzYCI
         CtyrqsOe2t0WZkZrENMdyYpJYBh9HgC8Cknjq8fLN9BHI1FZE4lOIzZi+T9/JpdLqOH9
         gSkY8on3CzLNlNB+osQQuKE2I9/2+yu0hzOSf0KMcluJd8J/MiZoo1j8IylmtL1CL7nP
         JfJX+7Tja0JdbIFhAP7D9V9eNGRp5k2rlhTtwLWSJr17xiDNVowLVYYyq3B0YL3HQjvd
         fO+5pn4EVOfc63zCf7NzlQrbGfxDJ76YxJMfwgg2mQR9cPVaBwXqqe61igsh8W1M/gl8
         KRmw==
X-Forwarded-Encrypted: i=1; AJvYcCU/WE2JgaN1ZiluM6C6RRvMU7JGVMLLeHUyaIl0S6M4CFpUX5E0ajjaqdBOJ98o4SIeepYr+aHGM9Uv@vger.kernel.org, AJvYcCU3m6CK26A+CuCt/2z2c8MrNqcYlGhJcmVxbFsnNg10yKcf9HhPOmmCvD0UBOivazl1yRJyvHroTX3J@vger.kernel.org, AJvYcCWUKaC3WECweSfPinq1geADuxxofs+PDBuMi/9aapVSsnrTDj7Kv1v0U8HcWVbzUq7XQQwOLRt97nj48Dy3@vger.kernel.org, AJvYcCX45NxJovP40swSXYsOgB3oUh1Xrb5mOAjO0l3MI2pmoVlyQDpQEzJfkBG0TKlgpArNwlquLANp6SG4@vger.kernel.org, AJvYcCXwRlX4pGDVw2/vCqyUovqUHzxscJATO3k6op04NZKLQIrJEgM61XoS0SKQKLE8qKYU41UBCxCT+9uz@vger.kernel.org
X-Gm-Message-State: AOJu0YxuO1z0OtXAE+KmuT+PTPBSNI4+MkEPnJ+DZnLCPOOiiY2oDLp7
	r7+T6Dv/VUqzr5yK7daEk+gKIYRmzTBR4IyNlXr5L3eyJ/ugYEUY
X-Gm-Gg: ASbGncucuHOutrHFeEDHNwVZS9RSvmoSu+LGxleX9eb0QaDxAW0pKMZMG7BLB/8CpDI
	JlYgG00DX8uzW2mzFiGO2Rjqs0ErUXajK+zIAruLciSRsOYw7dTGo9mb5C9EZJl67/sTv5WHHjl
	q74ZfPZmNiOainc0yUTitZ7AzzjMkwNp9JBtvoy/Qbw/JF8rsDKb9XWd/LpXi8ZlpEIxOCeP0FK
	2ZLe6U9R9Scd/QEJ/I4D+gtjQLk6jggIF6LKtpkHzo2GhCBTVVZiuSovoEMLc2a9FL7eIjs0Ck6
	oTGVwqK11bgzC+r4NQ46y9GUAvvXK6yLJN94l4/RdJxcRqNfpje793HFJHWzyVEHZtM=
X-Google-Smtp-Source: AGHT+IGWrvcV5MoXl3qJayEPUV4KEP+Ys/J4TRcHQJCcgqCYxPh6x1+zE67NPgsrTLAIwVVWO2T3gg==
X-Received: by 2002:a17:907:da6:b0:acb:5ae1:f6c5 with SMTP id a640c23a62f3a-acec692d1f3mr290424066b.3.1745934527135;
        Tue, 29 Apr 2025 06:48:47 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:3033:26c:ba50:9d5c:4d3e:be76:7564])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bbdesm800591366b.11.2025.04.29.06.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:48:46 -0700 (PDT)
Date: Tue, 29 Apr 2025 15:48:43 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <hvexchm2ozsto5s2o6n5j2z3odrkbcamgmg67umd4aehwzmgie@dvtx6anioasq>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-3-638af47e9eb3@analog.com>
 <88a326e7-3910-4e02-b4ba-7afe06402871@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88a326e7-3910-4e02-b4ba-7afe06402871@baylibre.com>

Hi David, 

I didn't went through your's and Jonathan's ad4052.c review yet,
but for the trigger-source-cells I need to dig deeper and make
considerable changes to the driver, as well as hardware tests.
My idea was to have a less customizable driver, but I get that it is
more interesting to make it user-definable.

On Fri, Apr 25, 2025 at 05:50:58PM -0500, David Lechner wrote:
> On 4/22/25 6:34 AM, Jorge Marques wrote:
> > Add dt-bindings for AD4052 family, devices AD4050/AD4052/AD4056/AD4058,
> > low-power with monitor capabilities SAR ADCs.
> > Each variant of the family differs in speed and resolution, resulting
> > in different scan types and spi word sizes, that are matched by the
> > compatible with the chip_info.
> > The device contains one input (cnv) and two outputs (gp0, gp1).
> 
> Don't need line breaks after every period.

Ack.

> 
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> 
> ...
> 
> > +  interrupts:
> > +    items:
> > +      - description: Signal coming from the GP0 pin (threshold).
> > +      - description: Signal coming from the GP1 pin (data ready).
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: gp0
> > +      - const: gp1
> > +
> > +  gpio-controller: true
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +    description: |
> > +      The first cell is the GPn number: 0 to 1.
> > +      The second cell takes standard GPIO flags.
> > +
> > +  cnv-gpios:
> > +    description: The Convert Input (CNV). If omitted, CNV is tied to SPI CS.
> > +    maxItems: 1
> > +
> 
> Assuming the diagram at [1] is correct, for SPI offload use, we are missing:
> 
>   #trigger-source-cells:
>     const: 2
>     description: |
>       Output pins used as trigger source.
> 
>       Cell 0 defines which pin:
>       * 0 = GP0
>       * 1 = GP1
> 
>       Cell 1 defines the event:
>       * 0 = Data ready
>       * 1 = Min threshold
>       * 2 = Max threshold
>       * 3 = Either threshold
>       * 4 = Device ready
>       * 5 = Device enable
>       * 6 = Chop control
> 
> Bonus points for adding a header with macros for the arbitrary event values.

In the sense of describing the device and not what the driver does, I
believe the proper mapping would be:

  Cell 1 defines the event:
  * 0 = Disabled
  * 1 = Data ready
  * 2 = Min threshold
  * 3 = Max threshold
  * 4 = Either threshold
  * 5 = CHOP control
  * 6 = Device enable
  * 7 = Device ready (only GP1)

I will investigate further this.

> 
> And we are missing:
> 
>   pwms:
>     maxItems: 1
>     description: PWM connected to the CNV pin.
> 
> [1]: https://analogdevicesinc.github.io/hdl/projects/ad4052_ardz/index.html
> 
> > +  spi-max-frequency:
> > +    maximum: 62500000
> 
> Datasheet Table 5. SPI Timing—ADC Modes, VIO ≥ 3.0 V says period can be 12 ns.
> 
> So that would make max frequency 83333333.

Ack.

> 
> ...
> 
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@0 {
> > +            compatible = "adi,ad4052";
> > +            reg = <0>;
> > +            vdd-supply = <&adc_vdd>;
> > +            vio-supply = <&adc_vio>;
> > +            spi-max-frequency = <25000000>;
> > +
> > +            interrupt-parent = <&gpio>;
> > +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> > +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-names = "gp0", "gp1";
> > +            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> > +        };
> > +    };
> 
> Could be nice to have a 2nd example showing SPI offload usage.
> .

Will add.


Regards,
Jorge

