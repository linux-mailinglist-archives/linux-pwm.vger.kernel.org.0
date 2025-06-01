Return-Path: <linux-pwm+bounces-6203-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B57AC9E17
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Jun 2025 09:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535871896B96
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Jun 2025 07:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2803F19F48D;
	Sun,  1 Jun 2025 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UGCFgDVR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248D19DF5B
	for <linux-pwm@vger.kernel.org>; Sun,  1 Jun 2025 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748764265; cv=none; b=etE3b3M9mFrWLanZNYZ57NgHuoKOQfcLtwclh2UCUtAeaenoyDQJRfMzTIV39FfhRhDllqCh/IDqqTXkV8b8c/t4X6SoMQvQUf6OYMFj5+XExOGixeBIQdqk9OoWkSmYImwnBQm4evXR1lLJStRewQp+9o71j2y0x6AaUMGGSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748764265; c=relaxed/simple;
	bh=5+6yz3aoyJHNsZavcO9AiQGNcAcAlecdhe/eFl9wu9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=asLQ45q6Igu/D/iyQJz7dPnijsyRo64/4VnvZSwgiZ4HWlt1AQ6RHTWf1kE8FoiqSxccDAGMaDc4dnQcsIX09St/YiFHsWJPJAmSsKfH3kARStyFIIO6ShUKkKpTvi3vYm89TN9Mg58TaLHfymBFASQfj7C/DHBVlHrbc8WWrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UGCFgDVR; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250601075055euoutp012dec52c8ac0667ba62f9b9b0fd753ce8~E29MhhoVf2651426514euoutp01m
	for <linux-pwm@vger.kernel.org>; Sun,  1 Jun 2025 07:50:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250601075055euoutp012dec52c8ac0667ba62f9b9b0fd753ce8~E29MhhoVf2651426514euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748764255;
	bh=hqMY6JBjFHLi1UGuQGIN1VxhuxOXkbW6BShlkS0Hdbw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=UGCFgDVRJfMsNd/HFXPrc3FxhgoON0esubBU904ELGdFgoc5nag30aAx/Zq6I6Anq
	 wU81Hq0tIJkAqltlzi08+tzT/6bx9zT4Xg5krOQ6NwdpjEagLv6hDb7i0fNyU8I7Bo
	 aJU1ON/FyAqKxKsp6hdOAPnSeEr8mfb6diXcIBC0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250601075053eucas1p1a6f3d7c11210b61ea1d0c62f7f52cabd~E29LH_2j60784107841eucas1p1m;
	Sun,  1 Jun 2025 07:50:53 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250601075052eusmtip272f1587c5683112656d6389dcaa6908e~E29KC_7vN1949419494eusmtip2B;
	Sun,  1 Jun 2025 07:50:52 +0000 (GMT)
Message-ID: <61eecafb-8ad1-4306-88cb-a032eefb2e48@samsung.com>
Date: Sun, 1 Jun 2025 09:50:52 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] riscv: dts: thead: Add PVT node
To: Drew Fustini <drew@pdp7.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
	Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
	Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <aDVxDJi0KkWXiPCK@x1>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250601075053eucas1p1a6f3d7c11210b61ea1d0c62f7f52cabd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01
X-EPHeader: CA
X-CMS-RootMailID: 20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
	<CGME20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01@eucas1p2.samsung.com>
	<20250524-rust-next-pwm-working-fan-for-sending-v1-5-bdd2d5094ff7@samsung.com>
	<aDVxDJi0KkWXiPCK@x1>



On 5/27/25 10:00, Drew Fustini wrote:
> On Sat, May 24, 2025 at 11:14:59PM +0200, Michal Wilczynski wrote:
>> Add PVT DT node for thermal sensor.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
>> index f24e12d7259fabcfbdc2dfa966d759db06684ab4..faf5c3aaf209b24cd99ddc377a88e08a8cce24fe 100644
>> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
>> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
>> @@ -648,6 +648,17 @@ padctrl_aosys: pinctrl@fffff4a000 {
>>  			thead,pad-group = <1>;
>>  		};
>>  
>> +		pvt: pvt@fffff4e000 {
>> +			compatible = "moortec,mr75203";
>> +			reg = <0xff 0xfff4e000 0x0 0x80>,
>> +			      <0xff 0xfff4e080 0x0 0x100>,
>> +			      <0xff 0xfff4e180 0x0 0x680>,
>> +			      <0xff 0xfff4e800 0x0 0x600>;
>> +			reg-names = "common", "ts", "pd", "vm";
>> +			clocks = <&aonsys_clk>;
>> +			#thermal-sensor-cells = <1>;
>> +		};
>> +
>>  		gpio@fffff52000 {
>>  			compatible = "snps,dw-apb-gpio";
>>  			reg = <0xff 0xfff52000 0x0 0x1000>;
>>
>> -- 
>> 2.34.1
>>
> 
> I found that on my lpi4a that boot while hang after applying this patch.
> I think that it is related to clocks as boot finished okay when using
> clk_ignore_unused on the kernel cmdline. Do you happen have that in your
> kernel cmdline?
> 
> I need to investigate further to understand which clocks are causing the
> problem.
> 
> Thanks,
> Drew
> 

Thanks for your earlier message. I've investigated, and you were right
about the clocks – the specific one causing the hang is CLK_CPU2AON_X2H.

This appears to be an AHB bus clock required for CPU access to the AON
domain. My proposed solution is to make the pvt node a child of a new
parent bus node in the Device Tree. This new "AON bus" node would then
explicitly request and manage CLK_CPU2AON_X2H, ensuring it's enabled
when its children are accessed.

What are your thoughts on this approach?

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

