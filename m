Return-Path: <linux-pwm+bounces-6241-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6756BACCB22
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 18:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDA7188F3BA
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE9823E226;
	Tue,  3 Jun 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipuklz+i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F7227E80;
	Tue,  3 Jun 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967692; cv=none; b=mA7F6OLEYESlAzQXWMJsXhS7QA2H41SKXbIf+H8fEMP/suJpWuWq9nXO6f3kkeTTnr+X49MGibCUn9Gc0rbRtsP1oyVvtkXabneeabFi//ykhfsuXCkbPjB4Z3UsX1jkIeaV2slX/DgCERlJh44op/bqUSLVXRDLYsdp8xEoa7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967692; c=relaxed/simple;
	bh=Fzge4z9mpLiTPnWpZY1S7wfWo2iY5QTX5em6d3V24+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDBBtFqJDkjbHz4I9VopCCQmhS7B6xIkOUBJ91Etdu6E3NR3w1qJqTyPjES9JFKYNGSFBghEpVEvlsFzeT1nEPLRn2nK1u7UCwGhqBgVZdDT0c/5NpUigOlo7+QUcGfHvyDRwxJwI1nea0sIi8/wEad090B4mMzfaDzj51zBP20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipuklz+i; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2301ac32320so54608855ad.1;
        Tue, 03 Jun 2025 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748967690; x=1749572490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyM97ZqplBFeYxTzqGSXBQxiPc6c/u7cZVlPywBv4fY=;
        b=ipuklz+irOElCFfrOSiEokVthMvpZZt0FN84il3erzQpzHug3jMULUFWG467V804NW
         Y3q2OY5TR5Eu21957iuuv8UebvleI3gwpQqZ8ekFRX9Cx7go8qwI9CHLXHV1c6jf9T+N
         2l5y150uKklByu+czFfkJaC7SFB/3F2slUQL57dsA8jAmZydj2mGJgUutJeK9W3SejXR
         Zpo6KVGCatL4ece6ZK4ZJXvo3MMsI1LHB+17+ilmuXbC3RoLQT4Dz2dblIS0J94YMSc/
         WM1PPi/xPVXjRCRxnfFs0YSPieNp5XDgLwyCx33uEjf7GBJ8y8s4vj1qQJSt3s5Rl7iu
         2Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748967690; x=1749572490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyM97ZqplBFeYxTzqGSXBQxiPc6c/u7cZVlPywBv4fY=;
        b=c3oJi6imU6luvIXzVmCYr3EU7R4FuvGrf20PRrk6Jjmi+3swEvM22c5tdVRP5MwzYp
         x838R0F25D8CE1avuC0SvAfNrlZQJDM0voqEYWjz2ScRVz7hmmNB8tU+CU69t4ZkG6T7
         QIQJinMYdp8MkCrRPnHFaoMV6wg/H6FmezRt2DkIZSilRJWaV8RiU7ULkdO9TrB/UTrQ
         YDQCdt4hHF1DaW/vEzdLQuSwFQRE4spv5sSrIYvWtF/srdYFLvjHy7xtU/rhI4EOtTW4
         kk4NdzJpVHIoa6xrIQToE7fWCLDePWqM+WHYJao8KeTEQXiPcvZcJXV0RH1ccfFevVKh
         wTjA==
X-Forwarded-Encrypted: i=1; AJvYcCU7hojAYy1+Az4LJT2E4aa3nRcTUvaeRBfD/C2K49D4QDj9Qu0hyQ3wXLMVsT/NEPorqIr5Fkn1mtwJnQ==@vger.kernel.org, AJvYcCVRy4PNjy2eyxh72oze/S7JpUeSjzgpTUQocryj0r7hQNfII26pFXvzB0BUdo7R0901EEtQIQNFicP7@vger.kernel.org, AJvYcCVq6e0B/FjT4MeFiA/fngWmBV5dTGbwlQga6QpUuAkTYOZb6n0ROHke37iPmv3ayCjRKXNMkRszJXI/@vger.kernel.org, AJvYcCWt+WlsexkJ/XmLLqaovzOPJcwnLhrySNjBtt7xRUBYGRFiKkU9lYPjMR+j3u3nQuInWFmRIxxUrG43@vger.kernel.org, AJvYcCXk4gYk5S0NtAIAbmvSfk5+bnNvtnNnoSwqVomAXzGJt1kvT8EYuk9S7drTAtjhitXJVRcZQWhE21ukq2PA@vger.kernel.org
X-Gm-Message-State: AOJu0YzOeycLmDT6G8M+JyZeFodal71lm5SsZO/jIjN5o/m8N1cXJI1s
	ZSuOKLX1CR+Xj++M+OSCTxU/MucMViwvQUC6UflFl3sHkzrUn+5UjTq+
X-Gm-Gg: ASbGnctyQchtM1ZgZrRskHXwIJFHLGnfxyREeOY+HeuK2FxA6qMphxDLrBX/oEjeBov
	5XL1amKmrVITOGCv0QwVt3navtauqMvsNUJhSe37Fqa3YiKK2wXXptYOgIQDtWsqbQ1doJcY+Pu
	PwUXqnnqMqo4U/B6/fkB1LFj06MsO8/DftEY9XgdCDDVzcHtj66qmxGADdY415Xry0r08ZJOizv
	g+UeRg3Tl/rFG3adEQJD1NAwBi0wHuLrmvccWFziIK6MaC4CxhqZifMS1zvj3KsQFEPJAvyId2E
	IRWuUNGB1oIdB9Xe61wnRkrZRuuDbQvsIcGinyo1iLxUno7TKvw=
X-Google-Smtp-Source: AGHT+IHL/yQEZQ8M/N4GhQRHikLMeXiY0d5QIcz0Hymi30PtwkzByDtwLbrV2LTGw1hKZHdR4DW3Cg==
X-Received: by 2002:a17:902:ec84:b0:234:9fed:ccb7 with SMTP id d9443c01a7336-23529904f37mr258003925ad.33.1748967689830;
        Tue, 03 Jun 2025 09:21:29 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3513sm90018585ad.108.2025.06.03.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 09:21:29 -0700 (PDT)
Date: Tue, 3 Jun 2025 12:21:27 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
	kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v2 3/7] bitfield: introduce HI16_WE bitfield prep macros
Message-ID: <aD8hB-qJ4Qm6IFuS@yury>
References: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
 <20250602-rk3576-pwm-v2-3-a6434b0ce60c@collabora.com>
 <aD4DSz3vs41yMQSv@yury>
 <2525788.jE0xQCEvom@workhorse>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2525788.jE0xQCEvom@workhorse>

On Tue, Jun 03, 2025 at 02:55:40PM +0200, Nicolas Frattaroli wrote:
> On Monday, 2 June 2025 22:02:19 Central European Summer Time Yury Norov wrote:
> > On Mon, Jun 02, 2025 at 06:19:14PM +0200, Nicolas Frattaroli wrote:
> > > Hardware of various vendors, but very notably Rockchip, often uses
> > > 32-bit registers where the upper 16-bit half of the register is a
> > > write-enable mask for the lower half.
> > 
> > Can you list them all explicitly please? I grepped myself for the
> > 'HIGHWORD_UPDATE' and 'FIELD_PREP_HIGWORD', and found just 4 or 5 in
> > addition to the rockchip.
> 
> Most of the ones Heiko brought up[1] just appear to be the clock stuff,
> I'm only aware of the drivers/mmc/host/sdhci-of-arasan.c one outside of
> Rockchip. For a complete listing I'd have to do a semantic search with
> e.g. Coccinelle, which I've never used before and would need to wrap
> my head around first. grep is a bad fit for catching them all as some
> macros are split across lines, or reverse the operators of the OR.
> Weggli[2] is another possibility but it's abandoned and undocumented, and
> I've ran into its limitations before fairly quickly.

Going Coccinelle way is fine, but I think it's an endless route. :)

What I meant is: you caught this HIWORD_UPDATE() duplication, and it's
great. When people copy-paste a macro implementation and even a name,
their intention is clear: they need this functionality, but the core
headers lack it, so: I'll make another small copy in my small driver,
and nobody cares.

I think your consolidation should at first target the above users.

Those having different names or substantially different implementation,
may also be a target. But they are:
 1. Obviously a minority in terms of LOCs, and
 2. More likely have their reasons to have custom flavors of the same.

...

> > Can you please prepare a series that introduces the new macro and
> > wires all arch duplications to it?
> 
> Okay, I will do that after I learn Coccinelle. Though I suspect the reason
> why I'm the first person to address this is because it's much easier to
> hide duplicated macros away in drivers than go the long route of fixing up
> every single other user. I'm not too miffed about it though, it's cleanup
> of technical debt that's long overdue.
 
I just fired 

        $ git grep "define HIWORD"

and found 27 matches. The relevant 'hiwords' have the following
semantics:

 - HIWORD_UPDATE(val, mask, shift)
 - HIWORD_UPDATE(val, mask)
 - HIWORD_UPDATE(mask, val)
 - HIWORD_UPDATE(v, h, l)
 - HIWORD_UPDATE_BIT(val)
 - HIWORD_DISABLE_BIT(val)

Most of them don't bother doing any static checks at all.

If you will just consolidate the above, and wire those drivers
to generic version with all that checks - it would be a decent
consolidation by any measure.

Something like this:

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 0470d7c175f4..d5e74d555a3d 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -30,7 +30,7 @@

 #define DMC_MAX_CHANNELS       4

-#define HIWORD_UPDATE(val, mask)       ((val) | (mask) << 16)
+#define HIWORD_UPDATE(val, mask)       HWORD_UPDATE(mask, val)

 /* DDRMON_CTRL */
 #define DDRMON_CTRL    0x04

...

> > Regarding the name... I can't invent a good one as well, so the best
> > thing I can suggest is not to invent something that can mislead. The
> > HWM_FIELD_PREP() is not bad because it tells almost nothing and
> > encourages one to refer to the documentation. If you want something
> > self-explaining, maybe MASK_HI_FIELD_LO_PREP_U16(), or something?
> 
> This seems a bit unwieldy, at 25 characters. "FIELD32_HIMASK_LOPREP"
> (or FIELD16, depending on which end of the cornet to eat) would be 21
> characters but I'm also not in love with it.
> 
> I think the name should include the following parts:
> 1. it's a field
> 2. the field is halved into two halves of 16 bits
> 3. the mask is copied into the upper 16 bits

Or just keep the HIWORD_UPDATE name as it already has over 300 users.
If it's commented well, and has an implementation based on FIELD_PREP,
I don't think users will struggle to understand what is actually
happening there.
 
> Since we're on the subject of bit widths, I have a somewhat sacrilegious
> point to raise: should this be a function-like macro at all, as opposed
> to a static __pure inline function? It's not generic with regards to the
> data types, as we're always assuming a u16 value and mask input and a
> u32 output. The __pure inline definition should let the compiler treat it
> essentially similar to what the pre-processor expanded macro does, which
> is as not a function call at all but a bunch of code to constant fold away
> if possible. What we get in return is type checking and less awful syntax.
> Then we could call it something like `himask_field_prep_u32`, which is
> also 21 characters but the ambiguity of whether the u32 refers to the mask
> or the whole register width is cleared up by the types of the function
> arguments.
> 
> The const version of the macro may still need to remain though because I'm
> not sure C11 can do that for us. With C23 maybe there's a way with
> constexpr but I've never used it before.

Inline function will disable parameters compile checks, and will be
too diverged from _CONST counterpart.

Thanks,
Yury

