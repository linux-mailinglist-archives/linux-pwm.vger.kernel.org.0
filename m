Return-Path: <linux-pwm+bounces-6265-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EB3AD2932
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 00:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742633AF172
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Jun 2025 22:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386C722539F;
	Mon,  9 Jun 2025 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="Vln5kUvI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66F224896
	for <linux-pwm@vger.kernel.org>; Mon,  9 Jun 2025 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749506991; cv=none; b=hqxmVMhkfsj7GdxzYgPkxi9aG5XIZFBmTUVNlkHjwbbEn4zsSij2eoguiJ2ObmOUXMC9ZT9S5fLASUWr5VIE7KVSXDQYYQFXk1vV0qw2jFfwqxvNlY0dK41/RwvPJDSGJtNO0xuvHQW9KtzIChOFpgSs5uJ5mcLTzPnOsyMLo9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749506991; c=relaxed/simple;
	bh=FNpQEWBDwyXEagWhUdVdgd4CDdreeQKyCibBUA0RLwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8QVYq+bFmJUDdGN1XfP8AKHagUCmfjxArBIgGAaJyunj88CmOZ/jIFpRiXRh6cajHdZZcy5Dz+iUfe/PsJCwwFdMw6JWxQfG++QqjE862BKSv1NHyha+JI00Mqzbd4YppbvPpf4TU3JBnB9DRvVj/CfyWgreKKM3tLICYfdvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=Vln5kUvI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235a3dd4f0dso33159675ad.0
        for <linux-pwm@vger.kernel.org>; Mon, 09 Jun 2025 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1749506987; x=1750111787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aXUrxDWDE1rz5GW1/FGYZyrQqnRIMW5wSQ+qWnYbv8k=;
        b=Vln5kUvIPrZdzjaks/7fN/NQHnZl41fDDD0sqlbHFHdhLx8kpfxnY7F2rTCuK/3JeZ
         eNdKwuuTgauR5Tgm7hFB2B0RecEXSyvBKNcd8irZkt9oC4XLNLawVUvjaQo66ZuOf8a9
         oI4Ks0n1gLfAuhGTtTWcjEkFH//4w1F8CbtzfByrbY5uZGd7RbgA6ew2Jl/u7RGq2saE
         ukfx5vtvGZjn6CJPlm6ncJG0nYFdpMudjSV/0dNPQWPkpw3mf6XZU7ht0cCK0x1GrYUX
         dBV4x1NvT3n9jC6VPG0Jguoj30KDM2JwzgK0EgfVmv1NnQfb/maWg9jrCQbrMYj1H2St
         6fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749506987; x=1750111787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXUrxDWDE1rz5GW1/FGYZyrQqnRIMW5wSQ+qWnYbv8k=;
        b=lg705ZiaMH7OTGskb7nKm0N92107vlSBFnqYaFk4ZYddc9k0IjyrATyhYn9d8C9rge
         TyGsGsJ/jnhDpEhBJPMDMyrvzNCf7ZuC1HvEcL7bVsedEzZFge7vv7vJW3AeE1EFYQSm
         dgF3WGpmXRSOsHnDJ7fLr6+nezrZX3qoWcOO5zuI+Onrt2xfxlYLB0byn9WzxA8og+Lh
         907Q55J45FIjnK+jdVm0+dXZ9CpVu5P5yz53d9kVdJ24/W/dbQZBB4TmepBP/KaLh8WG
         buQfZAr+96NxaMhki27krgkNLen7odoRcwUm7uxjgki/h0Vqveyq2Cz51tD7TPju0t4a
         /esw==
X-Forwarded-Encrypted: i=1; AJvYcCXPSjxdC/IhQALD3TchoSaWgS+KNTRGLDDOq7ODJhmcwVarDn00WlaZKv8tPtN1V3WhihYueCXRoTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCiULmDRI3769VFP9D3BbIbzhsBXsn3SmTRR8YVeWFJ55eJUO3
	sH6HFt1ovkU/qqdmTwX90pfjO8/iCIKylV9P3y4FmcGlsGOLjU3HA1P39WuFMT6W2nQ=
X-Gm-Gg: ASbGncuRVV9gzDttIi+gHi++WFDjH2qncMfjWkadoem9dmxphIbLOw2PzMnLrMijSYY
	Whbrc+KNvINYv958Q0XkNZjfJd6pfoDDSVggEVZba1Ked7aym4OqreNZ1svU3dz3H4CPErHJB+N
	eCAcfR/Q9dgg1xEFzGaI8vAUlEPEAmj/Nr3VX6Oj07CCqm6xOOrxsONLt0soy3ij1h94d08QyIA
	JWiY2XPUBaV/HEgQgOYcT7ybe3sN0WELZ8ZjiXX6VYNfevzNB/nXL4s4gIyHFkuSluk8yd3vHQ8
	N9EuDSQEEFHlSIYzXO5/dWYroZ0SyXfOC8db60C7lPm8ATQOUbPmNe0Yxlt1da6l+iSWMyg5rw=
	=
X-Google-Smtp-Source: AGHT+IEmC2cH56sY2Qaxupk/vYIkWpD0/7VSc7N28TaMH7rVO1PkIEtaUHkk3Y4nHUVSyRzLwMzWGg==
X-Received: by 2002:a17:902:e888:b0:234:8a4a:ada5 with SMTP id d9443c01a7336-23638390915mr2466705ad.37.1749506987465;
        Mon, 09 Jun 2025 15:09:47 -0700 (PDT)
Received: from x1 (97-120-245-201.ptld.qwest.net. [97.120.245.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b13ba47sm6079708a91.40.2025.06.09.15.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:09:46 -0700 (PDT)
Date: Mon, 9 Jun 2025 15:09:45 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 5/6] riscv: dts: thead: Add PVT node
Message-ID: <aEdbqSjpHyHx54UF@x1>
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <CGME20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01@eucas1p2.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-5-bdd2d5094ff7@samsung.com>
 <aDVxDJi0KkWXiPCK@x1>
 <61eecafb-8ad1-4306-88cb-a032eefb2e48@samsung.com>
 <aDyOyg6eqDEFg2ua@x1>
 <9e8a12db-236d-474c-b110-b3be96edf057@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e8a12db-236d-474c-b110-b3be96edf057@samsung.com>

On Mon, Jun 09, 2025 at 08:49:57PM +0200, Michal Wilczynski wrote:
> 
> 
> On 6/1/25 19:32, Drew Fustini wrote:
> > On Sun, Jun 01, 2025 at 09:50:52AM +0200, Michal Wilczynski wrote:
> >>
> >>
> >> On 5/27/25 10:00, Drew Fustini wrote:
> >>> On Sat, May 24, 2025 at 11:14:59PM +0200, Michal Wilczynski wrote:
> >>>> Add PVT DT node for thermal sensor.
> >>>>
> >>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> >>>> ---
> >>>>  arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
> >>>>  1 file changed, 11 insertions(+)
> >>>>
> >>>> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> >>>> index f24e12d7259fabcfbdc2dfa966d759db06684ab4..faf5c3aaf209b24cd99ddc377a88e08a8cce24fe 100644
> >>>> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> >>>> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> >>>> @@ -648,6 +648,17 @@ padctrl_aosys: pinctrl@fffff4a000 {
> >>>>  			thead,pad-group = <1>;
> >>>>  		};
> >>>>  
> >>>> +		pvt: pvt@fffff4e000 {
> >>>> +			compatible = "moortec,mr75203";
> >>>> +			reg = <0xff 0xfff4e000 0x0 0x80>,
> >>>> +			      <0xff 0xfff4e080 0x0 0x100>,
> >>>> +			      <0xff 0xfff4e180 0x0 0x680>,
> >>>> +			      <0xff 0xfff4e800 0x0 0x600>;
> >>>> +			reg-names = "common", "ts", "pd", "vm";
> >>>> +			clocks = <&aonsys_clk>;
> >>>> +			#thermal-sensor-cells = <1>;
> >>>> +		};
> >>>> +
> >>>>  		gpio@fffff52000 {
> >>>>  			compatible = "snps,dw-apb-gpio";
> >>>>  			reg = <0xff 0xfff52000 0x0 0x1000>;
> >>>>
> >>>> -- 
> >>>> 2.34.1
> >>>>
> >>>
> >>> I found that on my lpi4a that boot while hang after applying this patch.
> >>> I think that it is related to clocks as boot finished okay when using
> >>> clk_ignore_unused on the kernel cmdline. Do you happen have that in your
> >>> kernel cmdline?
> >>>
> >>> I need to investigate further to understand which clocks are causing the
> >>> problem.
> >>>
> >>> Thanks,
> >>> Drew
> >>>
> >>
> >> Thanks for your earlier message. I've investigated, and you were right
> >> about the clocks – the specific one causing the hang is CLK_CPU2AON_X2H.
> > 
> > Thanks for tracking down the clk causing the hang. I can confirm that
> > this fixes the boot hang:
> > 
> > diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> > index ebfb1d59401d..4d0179b8c17c 100644
> > --- a/drivers/clk/thead/clk-th1520-ap.c
> > +++ b/drivers/clk/thead/clk-th1520-ap.c
> > @@ -792,7 +792,7 @@ static CCU_GATE(CLK_AON2CPU_A2X, aon2cpu_a2x_clk, "aon2cpu-a2x", axi4_cpusys2_ac
> >                 0x134, BIT(8), 0);
> >  static CCU_GATE(CLK_X2X_CPUSYS, x2x_cpusys_clk, "x2x-cpusys", axi4_cpusys2_aclk_pd,
> >                 0x134, BIT(7), 0);
> > -static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd, 0x138, BIT(8), 0);
> > +static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd, 0x138, BIT(8), CLK_IGNORE_UNUSED);
> >  static CCU_GATE(CLK_CPU2PERI_X2H, cpu2peri_x2h_clk, "cpu2peri-x2h", axi4_cpusys2_aclk_pd,
> >                 0x140, BIT(9), CLK_IGNORE_UNUSED);
> >  static CCU_GATE(CLK_PERISYS_APB1_HCLK, perisys_apb1_hclk, "perisys-apb1-hclk", perisys_ahb_hclk_pd,
> > 
> >>
> >> This appears to be an AHB bus clock required for CPU access to the AON
> >> domain. My proposed solution is to make the pvt node a child of a new
> >> parent bus node in the Device Tree. This new "AON bus" node would then
> >> explicitly request and manage CLK_CPU2AON_X2H, ensuring it's enabled
> >> when its children are accessed.
> >>
> >> What are your thoughts on this approach?
> > 
> > I think that is a good approach. The alternative would be to just add
> > CLK_IGNORE_UNUSED like above. I've done it before but it is a bit of a
> > hack.
> 
> I've followed up on the idea of creating a parent bus node. My attempt
> using simple-pm-bus ran into a couple of significant issues that suggest
> it's not the correct path.
> 
> First, the TRM doesn't seem to specify an address range for this bus.
> The range I used in my test was only for the PVT controller itself,
> which would be an incorrect abstraction in the device tree.
> 
> Second, simple-pm-bus requires its child nodes to use the PM runtime API
> (pm_runtime_resume_and_get, etc.). Forcing this on consumer drivers like
> the PVT sensor seems like an inappropriate dependency.
> 
> Additionally, I discovered that the PWM driver has a similar problem,
> silently failing because another clock, CLK_PERISYS_APB1_HCLK, is not
> enabled.
> 
> The most correct solution likely involves refactoring the clock parent
> relationships in clk-th1520-ap.c. However, as a more immediate and less
> invasive fix, I propose we apply the CLK_IGNORE_UNUSED flag for both
> CLK_CPU2AON_X2H and CLK_PERISYS_APB1_HCLK in the v2 patch. This will fix
> the boot hang and the PWM issue while we consider the larger clock
> driver changes separately.
> 
> Does that sound like a reasonable plan for the v2 series?

Yes, I think that sounds like a good plan. I am okay with adding
CLK_IGNORE_UNUSED for CLK_CPU2AON_X2H and CLK_PERISYS_APB1_HCLK until a
better solution is found.

I like the idea of revisting the parent relationships in the driver. I
added CLK_IGNORE_UNUSED to several clocks in order to fix boot hangs
when I removed clk_ignore_unused from the kernel cmdline. However, I
don't think that I addressed the root cause.

Thanks,
Drew
.

