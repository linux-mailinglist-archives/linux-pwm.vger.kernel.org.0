Return-Path: <linux-pwm+bounces-6239-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C34EACC718
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 14:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8853B1892A6B
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 12:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17112230278;
	Tue,  3 Jun 2025 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="UMn3cCcI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0522F389
	for <linux-pwm@vger.kernel.org>; Tue,  3 Jun 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955413; cv=pass; b=VWBpyudgLt5IdRCqrk5+I1s/0nPUmNqEnzLj2YJ0ole7Em/8T7p1TQ8WOlbKY9UUmMb/CxlUc5Gly0/QW6Sakf6Ph0meZM3XL221tokQbh5xi1Zj+L54zT1itUTxly7x7GWS3JsiXyXoTPoSsliNv/M2cCjpM4kqOl4EIjpECa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955413; c=relaxed/simple;
	bh=IO9KyOw3+DX5pVe/A25OU4742Ss9DE3nlol/QI8cPos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZZ5C3iIII7BMhWZ41drNBnQKSaH33r9Of6hVjDx6823buK0brWU/sQ5F0PJLdaygHIBV4uq5Bi2nAdYszl6MuA10avk+uFfw1kcEQN0btw2xz0dEKbvj9U165s0jRaVPI7tDl/HbGdOrcjtiMbarMYcXNXyXKpGbXq3l2qkYSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=UMn3cCcI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1748955349; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RXagZj1fGH6Nojxfk1Rz6J0iOD1MKY34Dj0aWtcpj3YuIqbdJTDuoajVO6MLRPo6aS3OO3Z7pGgpZrtuv5Dmnjfq0GZLVHAFMjWDyfTKrnWyuU52cMOMVVyMPzQTYSDpnxlH8Sv5fdL42vtOchRsMwiiPjnwZlrSrhRtSwshkfI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748955349; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OKOarRGHsL2ajSiin4VcPu5AlkGxReA7dzEybyUZJ50=; 
	b=knWRds/IAEI0iYCI1k4z6jjKzQ6AAhToejvBwUkYsrO70K3vfTjqDgUkqQ9I8vdw+INa0viJssxhmJJ/xwTvGYKyQ3boPQ+yfxc/5mpzg+wIbYqKKjMczvFS+gsfb9J9dg/x06FYOKxQhojRvC82tmJ7tVKSJURvXzdrXk+hW6M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748955349;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=OKOarRGHsL2ajSiin4VcPu5AlkGxReA7dzEybyUZJ50=;
	b=UMn3cCcI0tYg01nC1fITQksGt/2f+wTumyUR6A1pTxQ4ypnWz/CADTD32YOuXmk1
	UjOmUbniXZ/AXnrN4WsuCwct2AsQ6qslqHwW9dW08++dxUgmXlWMmC2ECMC6DjeE4a3
	FApldWwyKi0b18EYN+cUUBZkq/XZ2WpgrGhUSyV8=
Received: by mx.zohomail.com with SMTPS id 1748955347750347.95572855171406;
	Tue, 3 Jun 2025 05:55:47 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 William Breathitt Gray <wbg@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v2 3/7] bitfield: introduce HI16_WE bitfield prep macros
Date: Tue, 03 Jun 2025 14:55:40 +0200
Message-ID: <2525788.jE0xQCEvom@workhorse>
In-Reply-To: <aD4DSz3vs41yMQSv@yury>
References:
 <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
 <20250602-rk3576-pwm-v2-3-a6434b0ce60c@collabora.com> <aD4DSz3vs41yMQSv@yury>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 2 June 2025 22:02:19 Central European Summer Time Yury Norov wrote:
> On Mon, Jun 02, 2025 at 06:19:14PM +0200, Nicolas Frattaroli wrote:
> > Hardware of various vendors, but very notably Rockchip, often uses
> > 32-bit registers where the upper 16-bit half of the register is a
> > write-enable mask for the lower half.
> 
> Can you list them all explicitly please? I grepped myself for the
> 'HIGHWORD_UPDATE' and 'FIELD_PREP_HIGWORD', and found just 4 or 5 in
> addition to the rockchip.

Most of the ones Heiko brought up[1] just appear to be the clock stuff,
I'm only aware of the drivers/mmc/host/sdhci-of-arasan.c one outside of
Rockchip. For a complete listing I'd have to do a semantic search with
e.g. Coccinelle, which I've never used before and would need to wrap
my head around first. grep is a bad fit for catching them all as some
macros are split across lines, or reverse the operators of the OR.
Weggli[2] is another possibility but it's abandoned and undocumented, and
I've ran into its limitations before fairly quickly.

>  
> > This type of hardware setup allows for more granular concurrent register
> > write access.
> > 
> > Over the years, many drivers have hand-rolled their own version of this
> > macro, usually without any checks, often called something like
> > HIWORD_UPDATE or FIELD_PREP_HIWORD, commonly with slightly different
> > semantics between them.
> > 
> > Clearly there is a demand for such a macro, and thus the demand should
> > be satisfied in a common header file.
> 
> I agree. Nice catch.
> 
> > Add two macros: FIELD_PREP_HI16_WE, and FIELD_PREP_HI16_WE_CONST. The
> > latter is a version that can be used in initializers, like
> > FIELD_PREP_CONST.
> 
> I'm not sure that the name you've chosen reflects the intention. If
> you just give me the name without any background, I'd bet it updates
> the HI16 part of presumably 32-bit field. The 'WE' part here is most
> likely excessive because at this level of abstraction you can't
> guarantee that 'write-enable mask' is the only purpose for the macro.
> 
> > The macro names are chosen to explicitly reference the
> > assumed half-register width, and its function, while not clashing with
> > any potential other macros that drivers may already have implemented
> > themselves.
> >
> > Future drivers should use these macros instead of handrolling their own,
> > and old drivers can be ported to the new macros as time and opportunity
> > allows.
> 
> This is a wrong way to go. Once you introduce a macro that replaces
> functionality of few other arch or driver macros, you should consolidate
> them all in the same series. Otherwise, it will be just another flavor
> of the same, but now living in a core header. 
> 
> Can you please prepare a series that introduces the new macro and
> wires all arch duplications to it?

Okay, I will do that after I learn Coccinelle. Though I suspect the reason
why I'm the first person to address this is because it's much easier to
hide duplicated macros away in drivers than go the long route of fixing up
every single other user. I'm not too miffed about it though, it's cleanup
of technical debt that's long overdue.

>  
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  include/linux/bitfield.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> > index 6d9a53db54b66c0833973c880444bd289d9667b1..2b3e7cb90ccb5d48f510104f61443b06748bb7eb 100644
> > --- a/include/linux/bitfield.h
> > +++ b/include/linux/bitfield.h
> > @@ -8,6 +8,7 @@
> >  #define _LINUX_BITFIELD_H
> >  
> >  #include <linux/build_bug.h>
> > +#include <linux/limits.h>
> >  #include <linux/typecheck.h>
> >  #include <asm/byteorder.h>
> >  
> > @@ -142,6 +143,52 @@
> >  		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
> >  	)
> >  
> > +/**
> > + * FIELD_PREP_HI16_WE() - prepare a bitfield element with a write-enable mask
> > + * @_mask: shifted mask defining the field's length and position
> > + * @_val:  value to put in the field
> > + *
> > + * FIELD_PREP_HI16_WE() masks and shifts up the value, as well as bitwise ORs
> > + * the result with the mask shifted up by 16.
> > + *
> > + * This is useful for a common design of hardware registers where the upper
> > + * 16-bit half of a 32-bit register is used as a write-enable mask. In such a
> > + * register, a bit in the lower half is only updated if the corresponding bit
> > + * in the upper half is high.
> > + */
> > +#define FIELD_PREP_HI16_WE(_mask, _val)					\
> > +	({								\
> > +		__BF_FIELD_CHECK(_mask, ((u16) 0U), _val,		\
> > +				 "FIELD_PREP_HI16_WE: ");		\
> > +		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask) |	\
> > +		((_mask) << 16);					\
> > +	})
> 
> This pretty much is a duplication of the FIELD_PREP(), isn't? Why don't
> you borrow the approach from drivers/clk/clk-sp7021.c:
> 
> 	/* HIWORD_MASK FIELD_PREP */
> 	#define HWM_FIELD_PREP(mask, value)             \
> 	({                                              \
> 	        u64 _m = mask;                          \
> 	        (_m << 16) | FIELD_PREP(_m, value);     \
> 	})
> 
> If you do so, the existing FIELD_PREP() will do all the work without
> copy-pasting.

Because then the __BF_FIELD_CHECK macro will be invoked twice, once without
the proper prefix. Factoring the actual prep-no-check operation out into a
separate macro is macro definition + 1-line invocation * 2, whereas copy-
pasting the implementation that will never change is 1-line invocation*2.

> The only questionI have  to the above macro is why '_m'
> is u64? Seemingly, it should be u32?

I didn't write the HWM_FIELD_PREP macro in clk-sp7021.c, nor am I familiar
with the hardware. It's possible they were trying to prevent an overflow
wraparound here though, but they're not checking if the result ends up
greater than 32 bits so that seems suspect.

> Regarding the name... I can't invent a good one as well, so the best
> thing I can suggest is not to invent something that can mislead. The
> HWM_FIELD_PREP() is not bad because it tells almost nothing and
> encourages one to refer to the documentation. If you want something
> self-explaining, maybe MASK_HI_FIELD_LO_PREP_U16(), or something?

This seems a bit unwieldy, at 25 characters. "FIELD32_HIMASK_LOPREP"
(or FIELD16, depending on which end of the cornet to eat) would be 21
characters but I'm also not in love with it.

I think the name should include the following parts:
1. it's a field
2. the field is halved into two halves of 16 bits
3. the mask is copied into the upper 16 bits

Since we're on the subject of bit widths, I have a somewhat sacrilegious
point to raise: should this be a function-like macro at all, as opposed
to a static __pure inline function? It's not generic with regards to the
data types, as we're always assuming a u16 value and mask input and a
u32 output. The __pure inline definition should let the compiler treat it
essentially similar to what the pre-processor expanded macro does, which
is as not a function call at all but a bunch of code to constant fold away
if possible. What we get in return is type checking and less awful syntax.
Then we could call it something like `himask_field_prep_u32`, which is
also 21 characters but the ambiguity of whether the u32 refers to the mask
or the whole register width is cleared up by the types of the function
arguments.

The const version of the macro may still need to remain though because I'm
not sure C11 can do that for us. With C23 maybe there's a way with
constexpr but I've never used it before.

> 
> Thanks,
> Yury
> 

Kind Regards,
Nicolas Frattaroli

Link: https://lore.kernel.org/linux-rockchip/1895349.atdPhlSkOF@diego/ [1]
Link: https://github.com/weggli-rs/weggli [2]

> > +
> > +/**
> > + * FIELD_PREP_HI16_WE_CONST() - prepare a constant bitfield element with a
> > + *                              write-enable mask
> > + * @_mask: shifted mask defining the field's length and position
> > + * @_val:  value to put in the field
> > + *
> > + * FIELD_PREP_HI16_WE_CONST() masks and shifts up the value, as well as bitwise
> > + * ORs the result with the mask shifted up by 16.
> > + *
> > + * This is useful for a common design of hardware registers where the upper
> > + * 16-bit half of a 32-bit register is used as a write-enable mask. In such a
> > + * register, a bit in the lower half is only updated if the corresponding bit
> > + * in the upper half is high.
> > + *
> > + * Unlike FIELD_PREP_HI16_WE(), this is a constant expression and can therefore
> > + * be used in initializers. Error checking is less comfortable for this
> > + * version, and non-constant masks cannot be used.
> > + */
> > +#define FIELD_PREP_HI16_WE_CONST(_mask, _val)				 \
> > +	(								 \
> > +		FIELD_PREP_CONST(_mask, _val) |				 \
> > +		(BUILD_BUG_ON_ZERO(const_true((u64) (_mask) > U16_MAX)) + \
> > +		 ((_mask) << 16))					 \
> > +	)
> > +
> >  /**
> >   * FIELD_GET() - extract a bitfield element
> >   * @_mask: shifted mask defining the field's length and position
> > 
> 



