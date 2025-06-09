Return-Path: <linux-pwm+bounces-6264-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD6CAD2608
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Jun 2025 20:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5AA18869D9
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Jun 2025 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B24421D58F;
	Mon,  9 Jun 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CnSEZOH5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6D21D3CA
	for <linux-pwm@vger.kernel.org>; Mon,  9 Jun 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495009; cv=none; b=UHdCIE6rocYeyzR1qV8Xmvh9xP871K9a+g1aQA6HeknQaYuN9N5CF7XbkkTr5CLUq1rIgsYc0z7NjJYhYHjbC75ox14bsrDxTjOQqw0ohRKp34g7v3qry2BCVaTjFUHJcticL6gbbou6Cbbijo5bmgJGL//irzj4qaOOj1M+fDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495009; c=relaxed/simple;
	bh=dlB/izkdaB1ozoX7/2o/IAFt5/gOoG9WnvZcUvg5Fbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=C+PLFWy8+q4UFt1dESslmKjt8kZADB8Mx0PUIUWjyg7LVWwVE2BC44/6LNZY+pgjsbTRdJ1iuweBJKrtpwGi1n5X2I5QDGFbMHXvEIwAaOYeaHaI4U8n/k0tk/Nadw25IF5kZIrcXAECh87y3/cJZRg9LHxuormq1IcBD5zM3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CnSEZOH5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250609185000euoutp022cb479023ad295571540cc07f9b5ec24~HdG8QvzSB1461414614euoutp02R
	for <linux-pwm@vger.kernel.org>; Mon,  9 Jun 2025 18:50:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250609185000euoutp022cb479023ad295571540cc07f9b5ec24~HdG8QvzSB1461414614euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749495000;
	bh=D3EwerJDP3/oe+lpK7aG+PkHixXXb/9NDy3mgdvJFy0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=CnSEZOH5OhpnceUvwFY1EbrdFJRLtcez/h2usFjBAY+rFD/xHRx+wJMhVhSKcTL+e
	 3UeuHM88PyfCmoLYICDhRath6GwL/8f/8wXP07sW6EmF3BcNswgDlft+bl8qASQUOr
	 FsbGWY2gX352WKe2Ur4sjl09tp1RXJGs6D+CqnDg=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250609184959eucas1p19815e72a3491891985d9793e0d144818~HdG6-FGOr2469924699eucas1p1W;
	Mon,  9 Jun 2025 18:49:59 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250609184958eusmtip1b172ca4c99c57fffacd869a372c9d211~HdG59PY_L1659816598eusmtip1V;
	Mon,  9 Jun 2025 18:49:58 +0000 (GMT)
Message-ID: <9e8a12db-236d-474c-b110-b3be96edf057@samsung.com>
Date: Mon, 9 Jun 2025 20:49:57 +0200
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
In-Reply-To: <aDyOyg6eqDEFg2ua@x1>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250609184959eucas1p19815e72a3491891985d9793e0d144818
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01
X-EPHeader: CA
X-CMS-RootMailID: 20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
	<CGME20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01@eucas1p2.samsung.com>
	<20250524-rust-next-pwm-working-fan-for-sending-v1-5-bdd2d5094ff7@samsung.com>
	<aDVxDJi0KkWXiPCK@x1> <61eecafb-8ad1-4306-88cb-a032eefb2e48@samsung.com>
	<aDyOyg6eqDEFg2ua@x1>



On 6/1/25 19:32, Drew Fustini wrote:
> On Sun, Jun 01, 2025 at 09:50:52AM +0200, Michal Wilczynski wrote:
>>
>>
>> On 5/27/25 10:00, Drew Fustini wrote:
>>> On Sat, May 24, 2025 at 11:14:59PM +0200, Michal Wilczynski wrote:
>>>> Add PVT DT node for thermal sensor.
>>>>
>>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>>> ---
>>>>  arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
>>>> index f24e12d7259fabcfbdc2dfa966d759db06684ab4..faf5c3aaf209b24cd99ddc377a88e08a8cce24fe 100644
>>>> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
>>>> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
>>>> @@ -648,6 +648,17 @@ padctrl_aosys: pinctrl@fffff4a000 {
>>>>  			thead,pad-group = <1>;
>>>>  		};
>>>>  
>>>> +		pvt: pvt@fffff4e000 {
>>>> +			compatible = "moortec,mr75203";
>>>> +			reg = <0xff 0xfff4e000 0x0 0x80>,
>>>> +			      <0xff 0xfff4e080 0x0 0x100>,
>>>> +			      <0xff 0xfff4e180 0x0 0x680>,
>>>> +			      <0xff 0xfff4e800 0x0 0x600>;
>>>> +			reg-names = "common", "ts", "pd", "vm";
>>>> +			clocks = <&aonsys_clk>;
>>>> +			#thermal-sensor-cells = <1>;
>>>> +		};
>>>> +
>>>>  		gpio@fffff52000 {
>>>>  			compatible = "snps,dw-apb-gpio";
>>>>  			reg = <0xff 0xfff52000 0x0 0x1000>;
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>> I found that on my lpi4a that boot while hang after applying this patch.
>>> I think that it is related to clocks as boot finished okay when using
>>> clk_ignore_unused on the kernel cmdline. Do you happen have that in your
>>> kernel cmdline?
>>>
>>> I need to investigate further to understand which clocks are causing the
>>> problem.
>>>
>>> Thanks,
>>> Drew
>>>
>>
>> Thanks for your earlier message. I've investigated, and you were right
>> about the clocks – the specific one causing the hang is CLK_CPU2AON_X2H.
> 
> Thanks for tracking down the clk causing the hang. I can confirm that
> this fixes the boot hang:
> 
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> index ebfb1d59401d..4d0179b8c17c 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -792,7 +792,7 @@ static CCU_GATE(CLK_AON2CPU_A2X, aon2cpu_a2x_clk, "aon2cpu-a2x", axi4_cpusys2_ac
>                 0x134, BIT(8), 0);
>  static CCU_GATE(CLK_X2X_CPUSYS, x2x_cpusys_clk, "x2x-cpusys", axi4_cpusys2_aclk_pd,
>                 0x134, BIT(7), 0);
> -static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd, 0x138, BIT(8), 0);
> +static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd, 0x138, BIT(8), CLK_IGNORE_UNUSED);
>  static CCU_GATE(CLK_CPU2PERI_X2H, cpu2peri_x2h_clk, "cpu2peri-x2h", axi4_cpusys2_aclk_pd,
>                 0x140, BIT(9), CLK_IGNORE_UNUSED);
>  static CCU_GATE(CLK_PERISYS_APB1_HCLK, perisys_apb1_hclk, "perisys-apb1-hclk", perisys_ahb_hclk_pd,
> 
>>
>> This appears to be an AHB bus clock required for CPU access to the AON
>> domain. My proposed solution is to make the pvt node a child of a new
>> parent bus node in the Device Tree. This new "AON bus" node would then
>> explicitly request and manage CLK_CPU2AON_X2H, ensuring it's enabled
>> when its children are accessed.
>>
>> What are your thoughts on this approach?
> 
> I think that is a good approach. The alternative would be to just add
> CLK_IGNORE_UNUSED like above. I've done it before but it is a bit of a
> hack.

I've followed up on the idea of creating a parent bus node. My attempt
using simple-pm-bus ran into a couple of significant issues that suggest
it's not the correct path.

First, the TRM doesn't seem to specify an address range for this bus.
The range I used in my test was only for the PVT controller itself,
which would be an incorrect abstraction in the device tree.

Second, simple-pm-bus requires its child nodes to use the PM runtime API
(pm_runtime_resume_and_get, etc.). Forcing this on consumer drivers like
the PVT sensor seems like an inappropriate dependency.

Additionally, I discovered that the PWM driver has a similar problem,
silently failing because another clock, CLK_PERISYS_APB1_HCLK, is not
enabled.

The most correct solution likely involves refactoring the clock parent
relationships in clk-th1520-ap.c. However, as a more immediate and less
invasive fix, I propose we apply the CLK_IGNORE_UNUSED flag for both
CLK_CPU2AON_X2H and CLK_PERISYS_APB1_HCLK in the v2 patch. This will fix
the boot hang and the PWM issue while we consider the larger clock
driver changes separately.

Does that sound like a reasonable plan for the v2 series?

> 
> Thanks,
> Drew
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

