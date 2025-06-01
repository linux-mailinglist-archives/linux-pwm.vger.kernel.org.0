Return-Path: <linux-pwm+bounces-6204-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A590AC9FA9
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Jun 2025 19:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E4A3B543C
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Jun 2025 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0A51EFF94;
	Sun,  1 Jun 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="2+a295+D"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4457A13AA2E
	for <linux-pwm@vger.kernel.org>; Sun,  1 Jun 2025 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748799182; cv=none; b=RadouPITFlNX71YU2mty3f6TRvTStFTMjf/JnXKGQrzA6be3RbqXOOgnRxsACLwJa2siUz+J+gBR7HzAxCc76v82VV0+nFazR/x0lCoDoZ55rfAwl84r8pac5vDk4K9tVJThVbUWQVgXrngfoKCCGm0tPiKcP7YHHryauJmiokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748799182; c=relaxed/simple;
	bh=Tf6XZkcBqvxDyqizynEKPAXVxWTJTm0KhepyjlqrXQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ndm5UaM6cyFpU16OKcpKrH+Uea3yGAArMHm1mhP7AgFjNRLA+SO1C0Ae7VIgoJuUl7lYXUOwVo3Y5R/GJrb7uQ3uzsQupscHugkEGA5VQIifMH6RkDgdDgp/b/BtD4Zveds3hh7hGx5V78lH6ptlf6Pm7D7dbvzqaF42jtK9+V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=2+a295+D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234fcadde3eso43959535ad.0
        for <linux-pwm@vger.kernel.org>; Sun, 01 Jun 2025 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1748799180; x=1749403980; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KwxqXGlyR2Fx/nGgiKLqYKrCCGLZKVDH93SX+seqRzQ=;
        b=2+a295+DSIjAVvgCaNDx2Xu7HiTlY5SDhPGGNHmli0QYMz9NCzJFipbQ2y22gUirwh
         gX5FUAX+jqRDNepWW9FhsBXUsHXyUAu3BlVO0sJI0JmNVT6InBPx+nEPHiIhNz3p5hXn
         61TuhljiZn71B2NiaB4Dee+5MQ+pXJ6ik3UE5j1LOyQ9NiUIV6fO1+0R1Ubr1enbaCMi
         nXrTBmo3dcFOMfxv3T+LTlXBukSLoT2Dr5haSNuhjW06ti3JSzVgBpxcdpvfNZAS+1N7
         wvjnZlEM4PfOXgOq8bjL6PegjrlrgDjW8SyWCL1S92jWKiACQgpkXBvBcmrIncs6S5vU
         xJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748799180; x=1749403980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwxqXGlyR2Fx/nGgiKLqYKrCCGLZKVDH93SX+seqRzQ=;
        b=BN8ooIFbjhtBe7+6Vq/ivGKzV4yGgTMHPh73xDwcEFU4I7dn6KAkI4PbuBP7fPnD2A
         70ntekUzw7AjR0OUcO5HDu66+rT7U+j2yA0SZTIftOzKlex5/77Pr6RZVkFRSsJw/ehd
         BUyUDb2+XgJtTMNlFOm+W/xhxMdd0d4Kk5q83Mb7ahUrX8lo7bba0GLdSl8gN87ndxFc
         8DEypqUqTDaX5DxNHMqYfHETiDwpbQI3OnkK6zNNMguGSvwcxdL5/FD1/2ev4hjvtVF0
         /V2oELd86Mf/WGP6vOr/XOs+3wV1mmXjbXhUd1iW7nYWWEGYCXPlRcJbuCyivr+JkitB
         GpVw==
X-Forwarded-Encrypted: i=1; AJvYcCVRg40cXaFsktWmKkb4IGGr/fn4Yz8fjN+nMDL+cSNbyoA7sKNSwPci5leevnyXpJ+DUrhELoJCdcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9LOhxmtCy0I0Zq3rcB3gbo0fB4tLZP3NFLU8EjxsBxd277r9l
	oTzLO3T/Js8av5kCLzX3L8bTI+BvN66fsCRqVcnwSGIp5EVjkNAB4wbf3rLVz/pAqIg=
X-Gm-Gg: ASbGnct47dWq6Gv6dUNUgl+kJzZugkXnfztokcejGU8KRtcslsuJC05bpOdwX/t60+u
	CKZEx6C5tHSWsEZTFBu63qoI31rOHz0HZiHQqvH6Bdsd4eDZZ80XjBYNjHL0QUJtDSrXj5ZS6gd
	MP5aLskMLAAB9KT2c+aT7S9Nt62taOQYnYB5OmkvPtCsWgzaHDKVV0KnsH4TR/HF3SOcdxxodyd
	5xcYCrnZwZp4HRralb/IHt+Iv/VF0SFhm8CJgU0G4gIhR79dWaNDfdvPnCA4ziqIs8/e2jGtF2+
	nJ5hPrhU9WpgcvZzHz4bitFAPWJmWEq79XHi49C9NsU=
X-Google-Smtp-Source: AGHT+IHrFx7wYIOsRR7w+nhhaUaBjBPFlogADiEeijaQ54Eff3trva8IRdJ651TwtDaee4aD84OUNA==
X-Received: by 2002:a17:902:c952:b0:235:2799:634 with SMTP id d9443c01a7336-2355f763a5amr61139085ad.8.1748799180449;
        Sun, 01 Jun 2025 10:33:00 -0700 (PDT)
Received: from x1 ([97.120.245.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd372esm57224935ad.128.2025.06.01.10.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:33:00 -0700 (PDT)
Date: Sun, 1 Jun 2025 10:32:58 -0700
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
Message-ID: <aDyOyg6eqDEFg2ua@x1>
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <CGME20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01@eucas1p2.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-5-bdd2d5094ff7@samsung.com>
 <aDVxDJi0KkWXiPCK@x1>
 <61eecafb-8ad1-4306-88cb-a032eefb2e48@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61eecafb-8ad1-4306-88cb-a032eefb2e48@samsung.com>

On Sun, Jun 01, 2025 at 09:50:52AM +0200, Michal Wilczynski wrote:
> 
> 
> On 5/27/25 10:00, Drew Fustini wrote:
> > On Sat, May 24, 2025 at 11:14:59PM +0200, Michal Wilczynski wrote:
> >> Add PVT DT node for thermal sensor.
> >>
> >> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> >> ---
> >>  arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> >> index f24e12d7259fabcfbdc2dfa966d759db06684ab4..faf5c3aaf209b24cd99ddc377a88e08a8cce24fe 100644
> >> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> >> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> >> @@ -648,6 +648,17 @@ padctrl_aosys: pinctrl@fffff4a000 {
> >>  			thead,pad-group = <1>;
> >>  		};
> >>  
> >> +		pvt: pvt@fffff4e000 {
> >> +			compatible = "moortec,mr75203";
> >> +			reg = <0xff 0xfff4e000 0x0 0x80>,
> >> +			      <0xff 0xfff4e080 0x0 0x100>,
> >> +			      <0xff 0xfff4e180 0x0 0x680>,
> >> +			      <0xff 0xfff4e800 0x0 0x600>;
> >> +			reg-names = "common", "ts", "pd", "vm";
> >> +			clocks = <&aonsys_clk>;
> >> +			#thermal-sensor-cells = <1>;
> >> +		};
> >> +
> >>  		gpio@fffff52000 {
> >>  			compatible = "snps,dw-apb-gpio";
> >>  			reg = <0xff 0xfff52000 0x0 0x1000>;
> >>
> >> -- 
> >> 2.34.1
> >>
> > 
> > I found that on my lpi4a that boot while hang after applying this patch.
> > I think that it is related to clocks as boot finished okay when using
> > clk_ignore_unused on the kernel cmdline. Do you happen have that in your
> > kernel cmdline?
> > 
> > I need to investigate further to understand which clocks are causing the
> > problem.
> > 
> > Thanks,
> > Drew
> > 
> 
> Thanks for your earlier message. I've investigated, and you were right
> about the clocks – the specific one causing the hang is CLK_CPU2AON_X2H.

Thanks for tracking down the clk causing the hang. I can confirm that
this fixes the boot hang:

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index ebfb1d59401d..4d0179b8c17c 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -792,7 +792,7 @@ static CCU_GATE(CLK_AON2CPU_A2X, aon2cpu_a2x_clk, "aon2cpu-a2x", axi4_cpusys2_ac
                0x134, BIT(8), 0);
 static CCU_GATE(CLK_X2X_CPUSYS, x2x_cpusys_clk, "x2x-cpusys", axi4_cpusys2_aclk_pd,
                0x134, BIT(7), 0);
-static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd, 0x138, BIT(8), 0);
+static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd, 0x138, BIT(8), CLK_IGNORE_UNUSED);
 static CCU_GATE(CLK_CPU2PERI_X2H, cpu2peri_x2h_clk, "cpu2peri-x2h", axi4_cpusys2_aclk_pd,
                0x140, BIT(9), CLK_IGNORE_UNUSED);
 static CCU_GATE(CLK_PERISYS_APB1_HCLK, perisys_apb1_hclk, "perisys-apb1-hclk", perisys_ahb_hclk_pd,

> 
> This appears to be an AHB bus clock required for CPU access to the AON
> domain. My proposed solution is to make the pvt node a child of a new
> parent bus node in the Device Tree. This new "AON bus" node would then
> explicitly request and manage CLK_CPU2AON_X2H, ensuring it's enabled
> when its children are accessed.
> 
> What are your thoughts on this approach?

I think that is a good approach. The alternative would be to just add
CLK_IGNORE_UNUSED like above. I've done it before but it is a bit of a
hack.

Thanks,
Drew

