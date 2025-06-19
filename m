Return-Path: <linux-pwm+bounces-6440-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B830AE01F0
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465BF3A7C6A
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 09:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D07C21D5BA;
	Thu, 19 Jun 2025 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="plQyC+M2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E421D5B0;
	Thu, 19 Jun 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326260; cv=none; b=aY9ahYSJYUgo3AN8CORhDtnCT1mAH2KbNH1fa24PiRyDT++uyhfF4D6D+uyXZjfhw+4wG1BiNIUdE+yzzBUT40yvaaT+bDFdvSHJt56OmTdgEWmsj7n+W6AFbSP7qs/4qErslEa+ZFLuEmSZG6JvAr9Vqt746/6RJa1Rk0YxDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326260; c=relaxed/simple;
	bh=cCQWwvXkYBKj2yDuzsNH38nMWfLHScMgp0lVjz5a9vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+REhslUPeHLUmuvRpkCsEUHeX2msLY6RMm2mdnm8UuLrp1bcwRN0CakKv675ZKx79/5kCPwVPH7QapEfzo3oDsdYzS1ApBosplIDSOOliXUEhmERsNc3kD6FJ2p6KDexrTi+FpQhrDl0iipqXtnHsZCZrlr2v7bi8S3t7Ccw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=plQyC+M2; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D243443B02;
	Thu, 19 Jun 2025 09:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750326250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4Yn1AmvZSHJwnVEX7Q8ZOWNcDOmD6fTQEVrdoy4wnE=;
	b=plQyC+M2KzD70YQbE/E8RIPi+QPaZRyIMMyZmqDdCoNbRKl0cX9fk0BwXTB/JKO1N96KHO
	qLcWINZiAqq25ltHOUAEBoUGvBFuz93SwRDAZNkG92uzBvFBhpwN5hSkYU3QXmQkWGfwxy
	hpb4yQlmi60F/YGqrWb+vZB5MZRFgbBHeAQKASLk6ycJlvydvT2JoOltRbX9gW7zY/ZZTQ
	FTVHX/clQAqrkhFlJvxKpcKdIIKuzHU0KHBAJmHt0Au17KqOdDi/AUKxJzpZR8JWXBmlyH
	Vva3+4TK5YWTKZMvTcAmqHvZXZjjmOQjRtAN8oTyAcfLmreN59KjPjRq0aswtg==
Date: Thu, 19 Jun 2025 11:44:07 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Aleksandr Shubin <privatesub2@gmail.com>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <20250619094407c4c849f3@mail.local>
References: <20250427142500.151925-1-privatesub2@gmail.com>
 <20250427142500.151925-2-privatesub2@gmail.com>
 <20250512235619.30cff739@minigeek.lan>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512235619.30cff739@minigeek.lan>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdekudegleeiteefgfekteevieeuudekfeeiudeiheduleeuueeuudfhffeuudfhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghdpihhnfhhrrgguvggrugdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmedvrggtjeemfhgvgegvmeehiegrugemtgekvgegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmedvrggtjeemfhgvgegvmeehiegrugemtgekvgegpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhgvrdhprhiihiifrghrrgesrghrmhdrtghomhdprhgtphhtthhopehprhhiv
 hgrthgvshhusgdvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdrughoohhlvgihsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

On 12/05/2025 23:56:19+0100, Andre Przywara wrote:
> On Sun, 27 Apr 2025 17:24:53 +0300
> Aleksandr Shubin <privatesub2@gmail.com> wrote:
> 
> Hi,
> 
> > Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> > controller witch is different from the previous pwm-sun4i.
> > 
> > The D1 and T113 are identical in terms of peripherals,
> > they differ only in the architecture of the CPU core, and
> > even share the majority of their DT. Because of that,
> > using the same compatible makes sense.
> > The R329 is a different SoC though, and should have
> > a different compatible string added, especially as there
> > is a difference in the number of channels.
> > 
> > D1 and T113s SoCs have one PWM controller with 8 channels.
> > R329 SoC has two PWM controllers in both power domains, one of
> > them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> > 
> > Add a device tree binding for them.
> > 
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> > ---
> >  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 84 +++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > new file mode 100644
> > index 000000000000..4b25e94a8e46
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > @@ -0,0 +1,84 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner D1, T113-S3 and R329 PWM
> > +
> > +maintainers:
> > +  - Aleksandr Shubin <privatesub2@gmail.com>
> > +  - Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: allwinner,sun20i-d1-pwm
> > +      - items:
> > +          - const: allwinner,sun50i-r329-pwm
> > +          - const: allwinner,sun20i-d1-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +
> > +  clocks:
> > +    items:
> > +      - description: Bus clock
> > +      - description: 24 MHz oscillator
> > +      - description: APB clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: bus
> > +      - const: hosc
> > +      - const: apb
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  allwinner,npwms:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: The number of PWM channels configured for this instance
> > +    enum: [6, 8, 9]
> 
> Do we really need to be so restrictive here? The IP has an
> "architectural" limit of 16 channels (due to the MMIO register layout
> and status/control bits usage in some registers), so can't we just leave
> this value to be anything between 1 and 16 here? If people configure
> this wrongly, it's their fault, I'd say? Without confining this further
> based on the respective compatible strings this enum is less useful
> anyway, I think. The Allwinner A523 uses the same IP, and supports all
> 16 channels, the V853 implements 12, that's what I quickly found
> already, and there might be more examples in the future, so I'd rather
> open this up.
> 

Do we really need this property? I feel like the number of PWM channels should be
something the driver could infer from the compatible string as we are going to
have one compatible string per SoC anyway.

> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: allwinner,sun50i-r329-pwm
> > +
> > +    then:
> > +      required:
> > +        - allwinner,npwms
> 
> Can't we just simplify this by always requiring this property? As
> mentioned, there will be more SoCs with different values, so just
> omitting this for the D1 seems odd.
> 
> Cheers,
> Andre
> 
> 
> > +
> > +unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#pwm-cells"
> > +  - clocks
> > +  - clock-names
> > +  - resets
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/sun20i-d1-ccu.h>
> > +    #include <dt-bindings/reset/sun20i-d1-ccu.h>
> > +
> > +    pwm: pwm@2000c00 {
> > +      compatible = "allwinner,sun20i-d1-pwm";
> > +      reg = <0x02000c00 0x400>;
> > +      clocks = <&ccu CLK_BUS_PWM>, <&dcxo>, <&ccu CLK_APB0>;
> > +      clock-names = "bus", "hosc", "apb";
> > +      resets = <&ccu RST_BUS_PWM>;
> > +      #pwm-cells = <0x3>;
> > +    };
> > +
> > +...
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

