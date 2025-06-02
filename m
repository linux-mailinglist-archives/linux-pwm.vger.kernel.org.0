Return-Path: <linux-pwm+bounces-6231-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EF4ACBC1B
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 22:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2693A46D3
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 20:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B031A08AB;
	Mon,  2 Jun 2025 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9x2Yae/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4EF1805A;
	Mon,  2 Jun 2025 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748894544; cv=none; b=DlQMNvi1UCEbF9Jmp2jTI1rGVH52JF3GBPmwnesM+A7domtflPg0rRbdr2TQHVSh6jSK3Lj2rZrgRVQ0Vls0q/ap3URsfsc3OHr0SXileY59VdrRo2QdMpicyE6h28lcOtVfScf7+Dg4zBXfAeiysit+9ObUlv1+O5nkm0DdxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748894544; c=relaxed/simple;
	bh=CD+VpRlEBvPbMBCcmd9UPdT+OYRLgtVadV0dAoUnCbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDo1v9HVh+QEDS1rv/NsZkedXwGov4jSrYlQA+1shZjfoL0x91NKrW6YGnMi1RShBU1QO7DsoCi6/6IRHEfk6PqqYto7iEwM2jTLRo3ZB0EuZpvloiC/Ncv6KoDOkydDNMd4bjfK+L1Vl7z0oiDpsRyvuX34903AW57/HccBLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9x2Yae/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso3680739b3a.2;
        Mon, 02 Jun 2025 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748894542; x=1749499342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jU63ySDIkl618RCkVJvCdpB1ntaX6bwZnYArDPbZsgY=;
        b=A9x2Yae/g7ntgs0j4VsYoYAYv3rOe9tmIk8YHSs3kHA+KyhEksRc35Z9TerB3PO3Bh
         I91U8BGk+f1mHD+9373SRv5EHXlFWpCCe7iJDuf6Vs/M/dldTPEP12cgWwMO66B5M0ds
         SWU1D6t1K3H8IMYpVZErLbhVgeZeG3bjWEA0zikrj7KVzCkFR7DvgRRYLiRkNn/xhoT1
         luCLol9hB38t58NUWv6U8XkI4rHrhS4Hf+jfrHVPScD0anOFIVBkYoxOzqQjDRJ/oAcO
         SX8yXx9oA39FxfowU0wxKobfD1Ij4a1ADB7w78mFjtEZ0yfj8yFrA9CLFDRH/H+onCbu
         U73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748894542; x=1749499342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU63ySDIkl618RCkVJvCdpB1ntaX6bwZnYArDPbZsgY=;
        b=ib4WaMarYGEA3DrBthIqBfLz9DkQrFGX4VzWl/Q/gfmoTplGQUec69pobzjrLziB2K
         ZklpX9UXrnEc0a33NAzjWUBkhwcu+tveOluIWjtBQjOn00spcNYAYfB0JDvjykNBmM/v
         Ht6L4kecBt6CYe15M65fQhkO0ZIQgkmE94CzDZ4jEYYA6Gr6CmMvLvGZA/l5PkDO2BiY
         QrXpujlaHVmd4scEuEKrSERA1n1fXhoX47ba/1Q07KC3LM+TiFGq5ZBzdvKKIACNEVzY
         qTkQh6llc2v9+zzXJmsKQHVZKYFONNgbCnQS5Lt4xYQnWtDaQiGh0hfGPitWhig3A4y+
         d6tw==
X-Forwarded-Encrypted: i=1; AJvYcCUgovfI/KcbdiEHD85yf3PrrMVMvcsLrXHwuGn7V2YW6gziK2sBiD2ZGW7UK/wqqi7JYMOyKMFuYxDk@vger.kernel.org, AJvYcCUxtAPjE3jFRka3dFsCfa2iMjU5Gh6eYPb+kcQuxUsEz+E6pJAxc5Z+Bq3TkD6+Q///PgEKOMySsxgzHQ==@vger.kernel.org, AJvYcCWnJJ6McVqNRSEshZEiH+WnLasq4dp7GI57A6Cm44UfuTXAbaly9F+rACwZCcMrrKHTjh2PHyJSAmqB@vger.kernel.org, AJvYcCWs/P/f7eZ2oqp5EtTAkQWbeCltgfgRBhaQkPjgIGvoZ/iKO9Y9AGea6ruleKuOBkEUtOiXWJbPEI210XeG@vger.kernel.org, AJvYcCXQFXMXATTm1blzYSue20C8H+oDYwmRAvnJL/PAO0SB9pp6V7BhKab5vN04f3igvZo4fO5qg4N5VjPA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TX5ptZTv0xWVoJBM13PLGvU2paKnnwZNpfqWZeaTOmW2DJ4S
	4lJr2MUMChZ+CdhS1GE2Vv30hpV1eKoilp97PB2uiE67QDlgmeFMos/Z
X-Gm-Gg: ASbGncuSImwrAcfDJVd4X8h1vqxKC4z0V44t+hxxmRy1wQMls3comcpJ2sgVSOGtBod
	9zZCGV2QkjpNw9iwrLUuJrrDN6NXKIcOoLKQpkDfRvQbZgw7WOeAghS+IM2UiNppe7D6tCqfAah
	NoW/HeA0o3xYm4xGwSYVSTubhMAfyRG1Y3I5qTpeBLN/4pwRnKIyoOURmpeaMNMl6TowsZ5lzRi
	5FIp1rK40QKu3wrGLty1Id9uuI7KrFb86W39zGeoFYR7yobI6MQIHzNIItpDphIZiBnXvrRTzQJ
	185aMceAZKrIETk7PPZR7VVRi770DKsss/Yu5eNZR/XM4esLtltVKK0cgQsrZA==
X-Google-Smtp-Source: AGHT+IHiKEZikH+lsGl+d9vzWR5H5Ojhm2iixpRZnhUz2v7NVH3lkWkzU4DjA/Dyx6fG350q0SLnpA==
X-Received: by 2002:a05:6300:189:b0:1f5:7710:fd18 with SMTP id adf61e73a8af0-21adff7da26mr17104549637.17.1748894542390;
        Mon, 02 Jun 2025 13:02:22 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafaebsm8042682b3a.87.2025.06.02.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 13:02:21 -0700 (PDT)
Date: Mon, 2 Jun 2025 16:02:19 -0400
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
Message-ID: <aD4DSz3vs41yMQSv@yury>
References: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
 <20250602-rk3576-pwm-v2-3-a6434b0ce60c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-rk3576-pwm-v2-3-a6434b0ce60c@collabora.com>

On Mon, Jun 02, 2025 at 06:19:14PM +0200, Nicolas Frattaroli wrote:
> Hardware of various vendors, but very notably Rockchip, often uses
> 32-bit registers where the upper 16-bit half of the register is a
> write-enable mask for the lower half.

Can you list them all explicitly please? I grepped myself for the
'HIGHWORD_UPDATE' and 'FIELD_PREP_HIGWORD', and found just 4 or 5 in
addition to the rockchip.
 
> This type of hardware setup allows for more granular concurrent register
> write access.
> 
> Over the years, many drivers have hand-rolled their own version of this
> macro, usually without any checks, often called something like
> HIWORD_UPDATE or FIELD_PREP_HIWORD, commonly with slightly different
> semantics between them.
> 
> Clearly there is a demand for such a macro, and thus the demand should
> be satisfied in a common header file.

I agree. Nice catch.

> Add two macros: FIELD_PREP_HI16_WE, and FIELD_PREP_HI16_WE_CONST. The
> latter is a version that can be used in initializers, like
> FIELD_PREP_CONST.

I'm not sure that the name you've chosen reflects the intention. If
you just give me the name without any background, I'd bet it updates
the HI16 part of presumably 32-bit field. The 'WE' part here is most
likely excessive because at this level of abstraction you can't
guarantee that 'write-enable mask' is the only purpose for the macro.

> The macro names are chosen to explicitly reference the
> assumed half-register width, and its function, while not clashing with
> any potential other macros that drivers may already have implemented
> themselves.
>
> Future drivers should use these macros instead of handrolling their own,
> and old drivers can be ported to the new macros as time and opportunity
> allows.

This is a wrong way to go. Once you introduce a macro that replaces
functionality of few other arch or driver macros, you should consolidate
them all in the same series. Otherwise, it will be just another flavor
of the same, but now living in a core header. 

Can you please prepare a series that introduces the new macro and
wires all arch duplications to it?
 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  include/linux/bitfield.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 6d9a53db54b66c0833973c880444bd289d9667b1..2b3e7cb90ccb5d48f510104f61443b06748bb7eb 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -8,6 +8,7 @@
>  #define _LINUX_BITFIELD_H
>  
>  #include <linux/build_bug.h>
> +#include <linux/limits.h>
>  #include <linux/typecheck.h>
>  #include <asm/byteorder.h>
>  
> @@ -142,6 +143,52 @@
>  		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
>  	)
>  
> +/**
> + * FIELD_PREP_HI16_WE() - prepare a bitfield element with a write-enable mask
> + * @_mask: shifted mask defining the field's length and position
> + * @_val:  value to put in the field
> + *
> + * FIELD_PREP_HI16_WE() masks and shifts up the value, as well as bitwise ORs
> + * the result with the mask shifted up by 16.
> + *
> + * This is useful for a common design of hardware registers where the upper
> + * 16-bit half of a 32-bit register is used as a write-enable mask. In such a
> + * register, a bit in the lower half is only updated if the corresponding bit
> + * in the upper half is high.
> + */
> +#define FIELD_PREP_HI16_WE(_mask, _val)					\
> +	({								\
> +		__BF_FIELD_CHECK(_mask, ((u16) 0U), _val,		\
> +				 "FIELD_PREP_HI16_WE: ");		\
> +		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask) |	\
> +		((_mask) << 16);					\
> +	})

This pretty much is a duplication of the FIELD_PREP(), isn't? Why don't
you borrow the approach from drivers/clk/clk-sp7021.c:

	/* HIWORD_MASK FIELD_PREP */
	#define HWM_FIELD_PREP(mask, value)             \
	({                                              \
	        u64 _m = mask;                          \
	        (_m << 16) | FIELD_PREP(_m, value);     \
	})

If you do so, the existing FIELD_PREP() will do all the work without
copy-pasting. The only questionI have  to the above macro is why '_m'
is u64? Seemingly, it should be u32?

Regarding the name... I can't invent a good one as well, so the best
thing I can suggest is not to invent something that can mislead. The
HWM_FIELD_PREP() is not bad because it tells almost nothing and
encourages one to refer to the documentation. If you want something
self-explaining, maybe MASK_HI_FIELD_LO_PREP_U16(), or something? 

Thanks,
Yury

> +
> +/**
> + * FIELD_PREP_HI16_WE_CONST() - prepare a constant bitfield element with a
> + *                              write-enable mask
> + * @_mask: shifted mask defining the field's length and position
> + * @_val:  value to put in the field
> + *
> + * FIELD_PREP_HI16_WE_CONST() masks and shifts up the value, as well as bitwise
> + * ORs the result with the mask shifted up by 16.
> + *
> + * This is useful for a common design of hardware registers where the upper
> + * 16-bit half of a 32-bit register is used as a write-enable mask. In such a
> + * register, a bit in the lower half is only updated if the corresponding bit
> + * in the upper half is high.
> + *
> + * Unlike FIELD_PREP_HI16_WE(), this is a constant expression and can therefore
> + * be used in initializers. Error checking is less comfortable for this
> + * version, and non-constant masks cannot be used.
> + */
> +#define FIELD_PREP_HI16_WE_CONST(_mask, _val)				 \
> +	(								 \
> +		FIELD_PREP_CONST(_mask, _val) |				 \
> +		(BUILD_BUG_ON_ZERO(const_true((u64) (_mask) > U16_MAX)) + \
> +		 ((_mask) << 16))					 \
> +	)
> +
>  /**
>   * FIELD_GET() - extract a bitfield element
>   * @_mask: shifted mask defining the field's length and position
> 
> -- 
> 2.49.0

