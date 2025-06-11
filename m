Return-Path: <linux-pwm+bounces-6293-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6774AD5A21
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5F4178534
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339D188CC9;
	Wed, 11 Jun 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ihUI4pic"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEBF1AA1FE
	for <linux-pwm@vger.kernel.org>; Wed, 11 Jun 2025 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654886; cv=none; b=IqqH//PMeohSG0sphwu9J5d1dfMS71SiK23Qxv9UtENyyO460jUWMP3cHklSrNT5Cl6vuIrGY2s7iqh9S27ZwFmNK0N2fxuwuq+X1hW6l4Hf+MRdkrO8AydMUwcYu+ubMJhKmfqarL+lgFHNuGSTt8rB/RL37ReXKEXPPt13DwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654886; c=relaxed/simple;
	bh=pb1NQueabVI9wQkdaC+YDQL17yZ/J3cirFxX0Ib+CQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=FkSN7fzljxtVeWy75HaCDYKm1C8zESYD9He7itUE76QHFPVTckyhKHJhBRK3nbvMsD8gieyKPpBKyFqTPu6srO08w9yFiQiDV9b8vp3o5HgP7HSD6oQJZ74Jt/pJN4ecHNUPNKjvXwH/xUdTEJIDnFPa7mzf6a2lZCZtftBvd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ihUI4pic; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250611151442euoutp01bc75537ab649ab82fc9e4ec06994d7f9~IBdiCYKbG0254102541euoutp01D
	for <linux-pwm@vger.kernel.org>; Wed, 11 Jun 2025 15:14:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250611151442euoutp01bc75537ab649ab82fc9e4ec06994d7f9~IBdiCYKbG0254102541euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749654882;
	bh=/aG3yXc2EucpbW7sa9J+WzUETPZ1G5/7AvZ60LGbpt8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ihUI4picgtqUec1YrsKY2X8y+lZtQi5PEzaMdY1POhzjEGEKAYKdwrIPJowunk9ho
	 McMbITHYYQQRjiqckByAn6RcHEdimhnM9Ieyp+MhmKyNYPlmxMJ9cYHkMutsHLsxM/
	 jYGC2BBusGkTjcJqayLlYd3mMorqFK1VDaKlb0y8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250611151441eucas1p1c5b30da3e0bd7484b27c9ad78a91f678~IBdhUjG441932119321eucas1p1c;
	Wed, 11 Jun 2025 15:14:41 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250611151440eusmtip2d72d1b30d77ba1ed35d675241db8b411~IBdgIHHGO2985829858eusmtip2g;
	Wed, 11 Jun 2025 15:14:40 +0000 (GMT)
Message-ID: <6ca6016e-3b17-48a0-ad8d-bb05317aa100@samsung.com>
Date: Wed, 11 Jun 2025 17:14:40 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: Drew Fustini <drew@pdp7.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
	Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, Benno
	Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <aEifXZnLxKd2wa0w@x1>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250611151441eucas1p1c5b30da3e0bd7484b27c9ad78a91f678
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9
X-EPHeader: CA
X-CMS-RootMailID: 20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9
References: <CGME20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9@eucas1p2.samsung.com>
	<20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
	<aEifXZnLxKd2wa0w@x1>



On 6/10/25 23:10, Drew Fustini wrote:
> On Tue, Jun 10, 2025 at 02:52:48PM +0200, Michal Wilczynski wrote:
>> This patch series introduces Rust support for the T-HEAD TH1520 PWM
>> controller and demonstrates its use for fan control on the Sipeed Lichee
>> Pi 4A board.
>>
>> The primary goal of this patch series is to introduce a basic set of
>> Rust abstractions for the Linux PWM subsystem. As a first user and
>> practical demonstration of these abstractions, the series also provides
>> a functional PWM driver for the T-HEAD TH1520 SoC. This allows control
>> of its PWM channels and ultimately enables temperature controlled fan
>> support for the Lichee Pi 4A board. This work aims to explore the use of
>> Rust for PWM drivers and lay a foundation for potential future
>> Rust based PWM drivers.
>>
>> The core of this series is a new rust/kernel/pwm.rs module that provides
>> abstractions for writing PWM chip provider drivers in Rust. This has
>> been significantly reworked from v1 based on extensive feedback. The key
>> features of the new abstraction layer include:
>>
>>  - Ownership and Lifetime Management: The pwm::Chip wrapper is managed
>>    by ARef, correctly tying its lifetime to its embedded struct device
>>    reference counter. Chip registration is handled by a pwm::Registration
>>    RAII guard, which guarantees that pwmchip_add is always paired with
>>    pwmchip_remove, preventing resource leaks.
>>
>>  - Modern and Safe API: The PwmOps trait is now based on the modern
>>    waveform API (round_waveform_tohw, write_waveform, etc.) as recommended
>>    by the subsystem maintainer. It is generic over a driver's
>>    hardware specific data structure, moving all unsafe serialization logic
>>    into the abstraction layer and allowing drivers to be written in 100%
>>    safe Rust.
>>
>>  - Ergonomics: The API provides safe, idiomatic wrappers for other PWM
>>    types (State, Args, Device, etc.) and uses standard kernel error
>>    handling patterns.
>>
>> The series is structured as follows:
>>  - Rust PWM Abstractions: The new safe abstraction layer.
>>  - TH1520 PWM Driver: A new Rust driver for the TH1520 SoC, built on
>>    top of the new abstractions.
>>  - Clock Fix: A necessary fix to the TH1520 clock driver to ensure bus
>>    clocks remain enabled.
>>  - Device Tree Bindings & Nodes: The remaining patches add the necessary
>>    DT bindings and nodes for the TH1520 PWM controller, a thermal
>>    sensor, and the PWM fan configuration for the Lichee Pi 4A board.
>>
>> Testing:
>> Tested on the TH1520 SoC. The fan works correctly. The duty/period
>> calculaties are correct. Fan starts slow when the chip is not hot and
>> gradually increases the speed when PVT reports higher temperatures.
>>
>> The patches are based on mainline, with some dependencies which are not
>> merged yet - platform Io support [1] and math wrapper [2].
>>
>> Reference repository with all the patches together can be found on
>> github [3].
> 
> I'm trying to build your rust-next-pwm-working-fan-for-sending-v4 branch
> but I get this error:
> 
> $ make W=1 LLVM=1 ARCH=riscv -j16
>   CALL    scripts/checksyscalls.sh
> .pylintrc: warning: ignored by one of the .gitignore files
>   UPD     include/generated/utsversion.h
>   CC      init/version-timestamp.o
>   KSYMS   .tmp_vmlinux0.kallsyms.S
>   AS      .tmp_vmlinux0.kallsyms.o
>   LD      .tmp_vmlinux1
> ld.lld: error: undefined symbol: rust_build_error
>     referenced by pwm_th1520.4789668fc0b4e501-cgu.0
>                   drivers/pwm/pwm_th1520.o:(<pwm_th1520::Th1520PwmDriverData as kernel::pwm::PwmOps>::get_state) in archive vmlinux.a
>     referenced by pwm_th1520.4789668fc0b4e501-cgu.0
>                   drivers/pwm/pwm_th1520.o:(<pwm_th1520::Th1520PwmDriverData as kernel::pwm::PwmOps>::write_waveform) in archive vmlinux.a
>     referenced by pwm_th1520.4789668fc0b4e501-cgu.0
>                   drivers/pwm/pwm_th1520.o:(<pwm_th1520::Th1520PwmDriverData as kernel::pwm::PwmOps>::write_waveform) in archive vmlinux.a
> make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux] Error 1
> make[1]: *** [/home/pdp7/linux/Makefile:1241: vmlinux] Error 2
> make: *** [Makefile:248: __sub-make] Error 2

Hi,

Thanks for testing !
I can reproduce the issue with your config.

The root of the problem was a failing compile time assertion
(build_assert!) in the underlying Rust abstracions, I think IoMem since
get_state and write_waveform functions are impacted. My development
configuration was accidentally hiding this issue, but your configuration
correctly exposed it.

The kernel config option that is different on my setup is:
CONFIG_RUST_BUILD_ASSERT_ALLOW=y

Now I have to take a look at the IoMem abstractions, I think there is
a new revision [1]. Will apply it and check why exactly compile
assertions are triggering.

[1] - https://lore.kernel.org/all/20250603-topics-tyr-platform_iomem-v9-0-a27e04157e3e@collabora.com/

> 
> I've uploaded the config to:
> https://protect2.fireeye.com/v1/url?k=0cc1a518-535a9c14-0cc02e57-000babff3563-8df2dfc535042c2a&q=1&e=eaf92127-0b5a-4559-9796-3264da753ae3&u=https%3A%2F%2Fgist.github.com%2Fpdp7%2Fe2c34dd7e4349a54bd67b53254bd3a22
> 
> Thanks,
> Drew
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

