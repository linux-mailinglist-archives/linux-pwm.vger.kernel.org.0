Return-Path: <linux-pwm+bounces-6812-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF711B0044E
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975BE3AF0D1
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C32737FC;
	Thu, 10 Jul 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LFunBg3x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94D2701D8
	for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155295; cv=none; b=H7nkZDiQsbmJRacb8DXLxQD2G2RCr5Wddhy5ZyD6OJqNwZPqS2NDJ6goxWcCqglIp2dCTB93c7wcWzeUm166sAf5BDaZYxfGUPJ0fd52kUbnWQKoI7qmKCw+GnrkH967fX9vSSLbsg/9qQ1cUxPyVP53JkFQfJqTCBQQfzfE/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155295; c=relaxed/simple;
	bh=1ZW3MqjZaMgOtKWUO/LxCXb3/ulicqxcrz3lwu3uL4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=AhEdd1XppoZDSZWUWhu2eXtFRlUzPdASYOHSMcg7zAcpFuqhRv3WEls8m6SYOHQnCfZ7PVq/tcW63/138OiZZDVEzzyMhWE+3Bk//r/QFJ/yyqQdxA+ECBKeJHtmotaXnTAuvc5KVFjqk1Qxye2n3w5oUeq+17p6983DNVIjzWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LFunBg3x; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250710134811euoutp01e0920eff07b58caadb6c79c4822c8f15~Q5-Q4xCGq1270612706euoutp01G
	for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 13:48:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250710134811euoutp01e0920eff07b58caadb6c79c4822c8f15~Q5-Q4xCGq1270612706euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752155291;
	bh=qof0UEyR6MVY9Cn3QFVnN+PDP639AM1RqOrHFdqti58=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LFunBg3xphRh+aCUluj/5GU2B+SeEI5E/qrbGOj2r1oo/YniDiHpxWabUsuKip/rZ
	 W4hKIXuHO1Xgu9+ihIWRVj1ABv4g9v9PAjgftprDDu1HlUUJrxzzAWkG4jfyP1A7jB
	 cGZFumfSpZOBixH50nciW7Ix1Zpe+LsXRgQ4Y2EQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250710134810eucas1p21ca161349642ca2b95dfe5e745fb1885~Q5-QIYOLg0461404614eucas1p2j;
	Thu, 10 Jul 2025 13:48:10 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250710134809eusmtip2bd7a654106a2f602f2b69084e6c1e4eb~Q5-PCv6xU1045810458eusmtip2T;
	Thu, 10 Jul 2025 13:48:09 +0000 (GMT)
Message-ID: <e77eab1c-446f-4620-95be-d343684d1e95@samsung.com>
Date: Thu, 10 Jul 2025 15:48:08 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
	Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, Benno
	Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Krzysztof
	Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <ipvaegqlkco5qinhvn33mqvg7ev2walvs74xtzvhimxsfsfzhv@gcmpxcdtetdn>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250710134810eucas1p21ca161349642ca2b95dfe5e745fb1885
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6
X-EPHeader: CA
X-CMS-RootMailID: 20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com>
	<20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
	<e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com>
	<ipvaegqlkco5qinhvn33mqvg7ev2walvs74xtzvhimxsfsfzhv@gcmpxcdtetdn>



On 7/10/25 15:10, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Jul 10, 2025 at 10:42:07AM +0200, Michal Wilczynski wrote:
>> On 7/7/25 11:48, Michal Wilczynski wrote:
>>> This patch series introduces Rust support for the T-HEAD TH1520 PWM
>>> controller and demonstrates its use for fan control on the Sipeed Lichee
>>> Pi 4A board.
>>>
>>> The primary goal of this patch series is to introduce a basic set of
>>> Rust abstractions for the Linux PWM subsystem. As a first user and
>>> practical demonstration of these abstractions, the series also provides
>>> a functional PWM driver for the T-HEAD TH1520 SoC. This allows control
>>> of its PWM channels and ultimately enables temperature controlled fan
>>> support for the Lichee Pi 4A board. This work aims to explore the use of
>>> Rust for PWM drivers and lay a foundation for potential future
>>> Rust based PWM drivers.
>>>
>>> The core of this series is a new rust/kernel/pwm.rs module that provides
>>> abstractions for writing PWM chip provider drivers in Rust. This has
>>> been significantly reworked from v1 based on extensive feedback. The key
>>> features of the new abstraction layer include:
>>>
>>>  - Ownership and Lifetime Management: The pwm::Chip wrapper is managed
>>>    by ARef, correctly tying its lifetime to its embedded struct device
>>>    reference counter. Chip registration is handled by a pwm::Registration
>>>    RAII guard, which guarantees that pwmchip_add is always paired with
>>>    pwmchip_remove, preventing resource leaks.
>>>
>>>  - Modern and Safe API: The PwmOps trait is now based on the modern
>>>    waveform API (round_waveform_tohw, write_waveform, etc.) as recommended
>>>    by the subsystem maintainer. It is generic over a driver's
>>>    hardware specific data structure, moving all unsafe serialization logic
>>>    into the abstraction layer and allowing drivers to be written in 100%
>>>    safe Rust.
>>>
>>>  - Ergonomics: The API provides safe, idiomatic wrappers for other PWM
>>>    types (State, Args, Device, etc.) and uses standard kernel error
>>>    handling patterns.
>>>
>>> The series is structured as follows:
>>>  - Expose static function pwmchip_release.
> 
> Is this really necessary? I didn't try to understand the requirements
> yet, but I wonder about that. If you get the pwmchip from
> __pwmchip_add() the right thing to do to release it is to call
> pwmchip_remove(). Feels like a layer violation.

Hi Uwe,
Thank you for the feedback.

It's required to prevent a memory leak in a specific, critical failure
scenario. The sequence of events is as follows:

    pwm::Chip::new() succeeds, allocating both the C struct pwm_chip and
    the Rust drvdata.

    pwm::Registration::register() (which calls pwmchip_add()) fails for
    some reason.

    The ARef<Chip> returned by new() is dropped, its reference count
    goes to zero, and our custom release_callback is called.

In this state:

Calling pwmchip_remove() would be incorrect because the chip was never
successfully added. If our callback only frees the Rust drvdata, the
memory for the C struct pwm_chip is leaked.

Therefore, our custom release_callback  must perform both cleanup tasks:
freeing the Rust drvdata and then calling pwmchip_release to free the C
struct. This "chaining" of the release handlers seems to be the most
robust way to guarantee cleanup in all scenarios.

Note that the bindings still use pwmchip_remove function in 'normal'
failure path.

> 
>> [...]
>>> ---
>>> base-commit: 47753b5a1696283930a78aae79b29371f96f5bca
> 
> I have problems applying this series and don't have this base commit in
> my repo.

Sorry for the confusion. Base commit doesn't exist in the mainline
kernel or linux-next, cause I've added some dependecies for compilation,
like IoMem for the driver (uploaded full branch on github [1]). The
bindings however doesn't depend on anything that's not in linux-next.
Anyway series applies cleanly on linux-next/master like so:

$ git fetch linux-next
$ git checkout linux-next/master
$ b4 shazam https://lore.kernel.org/all/20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com/
Grabbing thread from lore.kernel.org/all/20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 14 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 165 code-review messages
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v10 1/7] pwm: Export `pwmchip_release` for external use
  ✓ [PATCH v10 2/7] rust: pwm: Add Kconfig and basic data structures
  ✓ [PATCH v10 3/7] rust: pwm: Add complete abstraction layer
  ✓ [PATCH v10 4/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
  ✓ [PATCH v10 5/7] dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM controller
  ✓ [PATCH v10 6/7] riscv: dts: thead: Add PWM controller node
  ✓ [PATCH v10 7/7] riscv: dts: thead: Add PWM fan and thermal control
  ---
  ✓ Signed: DKIM/samsung.com
---
Total patches: 7
---
 Base: using specified base-commit 47753b5a1696283930a78aae79b29371f96f5bca
Applying: pwm: Export `pwmchip_release` for external use
Applying: rust: pwm: Add Kconfig and basic data structures
Applying: rust: pwm: Add complete abstraction layer
Applying: pwm: Add Rust driver for T-HEAD TH1520 SoC
Applying: dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM controller
Applying: riscv: dts: thead: Add PWM controller node
Applying: riscv: dts: thead: Add PWM fan and thermal control


> 
> Best regards
> Uwe

[1] - https://github.com/mwilczy/linux/commits/rust-next-pwm-working-fan-for-sending-v15/

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

