Return-Path: <linux-pwm+bounces-6441-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC40AE052E
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99D73BA868
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B5E22E403;
	Thu, 19 Jun 2025 12:10:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC472221F26;
	Thu, 19 Jun 2025 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335053; cv=none; b=Ewu6oKfwiY/QHGnd7LsNcV/S9IdtDTBSZmxspe1Tp1QOh2jaVogsZzzCj0dH6xkdSbeiFwqv65XtwPtuyZT6HEqaLGVD+dmZzbzhSobGR5LXq8w0p7wreg4xPLeZnXYnqktLIy5ejVVQiWo2p0CcVN7+xv9tTvpj/3Bugn+Xt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335053; c=relaxed/simple;
	bh=5oDWHUZd18OQq1CL4ha9noH4a4aaK0KKcofZjfk4ELI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgKShOXvP/d6WiRxwTo4TjrXjLNl4DYy/lhBoSfKhHvFl/T3qydOYhdbGJzB5B3TZw7BAsnTZyQkLmCFPVBPSs9l8d2jlbazGyxncQNA+ZtjEQUYMz9KIzisY440juS9GUmJHZv/xq6Kl6Fjd2NvRvDfUoZUgKKkpZTLWNscG/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2264A106F;
	Thu, 19 Jun 2025 05:10:30 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02EB23F66E;
	Thu, 19 Jun 2025 05:10:46 -0700 (PDT)
Date: Thu, 19 Jun 2025 13:10:44 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Aleksandr Shubin <privatesub2@gmail.com>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Philipp
 Zabel <p.zabel@pengutronix.de>, Cheo Fusi <fusibrandon13@gmail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <20250619131044.20b45d8d@donnerap.manchester.arm.com>
In-Reply-To: <20250619094407c4c849f3@mail.local>
References: <20250427142500.151925-1-privatesub2@gmail.com>
	<20250427142500.151925-2-privatesub2@gmail.com>
	<20250512235619.30cff739@minigeek.lan>
	<20250619094407c4c849f3@mail.local>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 11:44:07 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

Hi Alexandre,

> On 12/05/2025 23:56:19+0100, Andre Przywara wrote:
> > On Sun, 27 Apr 2025 17:24:53 +0300
> > Aleksandr Shubin <privatesub2@gmail.com> wrote:
> > 
> > Hi,
> >   
> > > Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> > > controller witch is different from the previous pwm-sun4i.
> > > 
> > > The D1 and T113 are identical in terms of peripherals,
> > > they differ only in the architecture of the CPU core, and
> > > even share the majority of their DT. Because of that,
> > > using the same compatible makes sense.
> > > The R329 is a different SoC though, and should have
> > > a different compatible string added, especially as there
> > > is a difference in the number of channels.
> > > 
> > > D1 and T113s SoCs have one PWM controller with 8 channels.
> > > R329 SoC has two PWM controllers in both power domains, one of
> > > them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> > > 
> > > Add a device tree binding for them.
> > > 
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> > > ---
> > >  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 84 +++++++++++++++++++
> > >  1 file changed, 84 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > > new file mode 100644
> > > index 000000000000..4b25e94a8e46
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > > @@ -0,0 +1,84 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Allwinner D1, T113-S3 and R329 PWM
> > > +
> > > +maintainers:
> > > +  - Aleksandr Shubin <privatesub2@gmail.com>
> > > +  - Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - const: allwinner,sun20i-d1-pwm
> > > +      - items:
> > > +          - const: allwinner,sun50i-r329-pwm
> > > +          - const: allwinner,sun20i-d1-pwm
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  "#pwm-cells":
> > > +    const: 3
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Bus clock
> > > +      - description: 24 MHz oscillator
> > > +      - description: APB clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: bus
> > > +      - const: hosc
> > > +      - const: apb
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  allwinner,npwms:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: The number of PWM channels configured for this instance
> > > +    enum: [6, 8, 9]  
> > 
> > Do we really need to be so restrictive here? The IP has an
> > "architectural" limit of 16 channels (due to the MMIO register layout
> > and status/control bits usage in some registers), so can't we just leave
> > this value to be anything between 1 and 16 here? If people configure
> > this wrongly, it's their fault, I'd say? Without confining this further
> > based on the respective compatible strings this enum is less useful
> > anyway, I think. The Allwinner A523 uses the same IP, and supports all
> > 16 channels, the V853 implements 12, that's what I quickly found
> > already, and there might be more examples in the future, so I'd rather
> > open this up.
> >   
> 
> Do we really need this property? I feel like the number of PWM channels should be
> something the driver could infer from the compatible string as we are going to
> have one compatible string per SoC anyway.

Well yes, this would work, but I feel like it creates unnecessary churn to
touch the driver every time some new SoC with the same IP pops up, and
where just the number of channels is different - see above for a list of
SoCs we already know about, and there are more in the pipe. It also means
stable kernels would already work.

And after all the code is perfectly able to handle this: the channel
numbers used come from the PWM users in the DT, and using non-existing
channel numbers just would not make sense. I can run some experiments, but
I wonder if programming an out-of-range channel would actually do anything
harmful at all - my hunch is it would just do nothing, so there is no
risk even if the DT specifies a wrong number.

So I wonder if the channel limitation is really needed at all. If the SoC
just implements six channels, there would simply be no pin available for
channel #6 or #7, and no PWM user would ever request those channels.

But regardless of that, I would really like to have just one fallback
compatible string, covering all SoCs that have compatible IP.

Cheers,
Andre


> 
> > > +
> > > +allOf:
> > > +  - $ref: pwm.yaml#
> > > +
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: allwinner,sun50i-r329-pwm
> > > +
> > > +    then:
> > > +      required:
> > > +        - allwinner,npwms  
> > 
> > Can't we just simplify this by always requiring this property? As
> > mentioned, there will be more SoCs with different values, so just
> > omitting this for the D1 seems odd.
> > 
> > Cheers,
> > Andre
> > 
> >   
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#pwm-cells"
> > > +  - clocks
> > > +  - clock-names
> > > +  - resets
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/sun20i-d1-ccu.h>
> > > +    #include <dt-bindings/reset/sun20i-d1-ccu.h>
> > > +
> > > +    pwm: pwm@2000c00 {
> > > +      compatible = "allwinner,sun20i-d1-pwm";
> > > +      reg = <0x02000c00 0x400>;
> > > +      clocks = <&ccu CLK_BUS_PWM>, <&dcxo>, <&ccu CLK_APB0>;
> > > +      clock-names = "bus", "hosc", "apb";
> > > +      resets = <&ccu RST_BUS_PWM>;
> > > +      #pwm-cells = <0x3>;
> > > +    };
> > > +
> > > +...  
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv  
> 


