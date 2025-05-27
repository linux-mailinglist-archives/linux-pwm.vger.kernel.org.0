Return-Path: <linux-pwm+bounces-6143-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D54AC4AC5
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 10:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BCE3BBD69
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D7C23FC42;
	Tue, 27 May 2025 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JfWEZ/Dw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775917A2F8
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748336095; cv=none; b=aphZWhGFaNWqDKnTW1eiSmP15/BUyqWqC8n/aONumza1pxVPWW08+xEMFNJ6PWoYxVNox0xAT9bTUX8nYQblyCN/zkw2lQGp76gpl7Nnn5sv+Hm6uFbaSQDX3psDsyPYcQ5MmR4IASjKFzHJ/pfGc2AF2ku4cjoHOCDEmgEXCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748336095; c=relaxed/simple;
	bh=FDhUkvstbN2kfBz+VcptLoIi6UpV5Y68pHLLt3pGpUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=emoh1aZGxI3fzFDh/hEXJx5ZBFXvMMIDhiqHq6dP+sFLpIdFE/1oghk2FPiK2GqvS1jl2pX3aShjWhBy/7Vinc/NCuj2aLArLtDsjnRfkIBtFxLnCJFDW604BI59x3nL1UVRDKq/Q11sU+iMX08ieiKGQfDroypkBbaxj+iSg/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JfWEZ/Dw; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250527085445euoutp019402fc3ad4284557d20c0c039e474558~DVmgrIoly0349203492euoutp01C
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 08:54:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250527085445euoutp019402fc3ad4284557d20c0c039e474558~DVmgrIoly0349203492euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748336085;
	bh=YNWmGS5CMUNgwusCiMiRXuZnmCjMkDyxd0GsI2VazJQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=JfWEZ/DwFr/HpuY6L8CtkXw78pLFB92zehs/NA+Kg5p014u2tgYsbhxhiEFKym5OP
	 eIIweHXnQNBY8TCPT9AI85m99e/LXnt228fF4roIkCyAsUQhvyuGCapDUBhugriBYW
	 BSN7ACs2nsOWCy7UpB52cwLXqD8nAO5fy/mIgpMk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250527085445eucas1p214ecce3d8b8769c58f3eab2b0b73df93~DVmgGT1os0889508895eucas1p28;
	Tue, 27 May 2025 08:54:45 +0000 (GMT)
Received: from [106.210.136.40] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250527085444eusmtip1bab9c1b6732e4f053faaa518fb79ee9b~DVmfOH2Pq0318603186eusmtip1l;
	Tue, 27 May 2025 08:54:44 +0000 (GMT)
Message-ID: <0dc42c81-a082-4fce-a447-32995b75f1c9@samsung.com>
Date: Tue, 27 May 2025 10:54:42 +0200
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
Content-Language: pl
From: "Michal Wilczynski/Kernel (PLT) /SRPOL/Engineer/Samsung Electronics"
	<m.wilczynski@samsung.com>
In-Reply-To: <aDVxDJi0KkWXiPCK@x1>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250527085445eucas1p214ecce3d8b8769c58f3eab2b0b73df93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01
X-EPHeader: CA
X-CMS-RootMailID: 20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
	<CGME20250524211525eucas1p244963b69e0531c95a9052e4a7a1d1e01@eucas1p2.samsung.com>
	<20250524-rust-next-pwm-working-fan-for-sending-v1-5-bdd2d5094ff7@samsung.com>
	<aDVxDJi0KkWXiPCK@x1>


W dniu 27.05.2025 o 10:00, Drew Fustini pisze:
> On Sat, May 24, 2025 at 11:14:59PM +0200, Michal Wilczynski wrote:
>> Add PVT DT node for thermal sensor.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>   arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
>> index f24e12d7259fabcfbdc2dfa966d759db06684ab4..faf5c3aaf209b24cd99ddc377a88e08a8cce24fe 100644
>> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
>> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
>> @@ -648,6 +648,17 @@ padctrl_aosys: pinctrl@fffff4a000 {
>>   			thead,pad-group = <1>;
>>   		};
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
>>   		gpio@fffff52000 {
>>   			compatible = "snps,dw-apb-gpio";
>>   			reg = <0xff 0xfff52000 0x0 0x1000>;
>>
>> -- 
>> 2.34.1
>>
> I found that on my lpi4a that boot while hang after applying this patch.
> I think that it is related to clocks as boot finished okay when using
> clk_ignore_unused on the kernel cmdline. Do you happen have that in your
> kernel cmdline?

Right I had that option enabled, that's why I've missed this. Thanks for

letting me know ! I'll remove this option for future testing.

>
> I need to investigate further to understand which clocks are causing the
> problem.


No problem I can look into that as well, most likely towards the end

of the week as I'm travelling and don't have access to the board.


>
> Thanks,
> Drew
>

