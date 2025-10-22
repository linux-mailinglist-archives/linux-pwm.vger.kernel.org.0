Return-Path: <linux-pwm+bounces-7470-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59339BFAEB3
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Oct 2025 10:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144F5405563
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Oct 2025 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9C30ACEC;
	Wed, 22 Oct 2025 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ESLrFtqj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAA309F14
	for <linux-pwm@vger.kernel.org>; Wed, 22 Oct 2025 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122089; cv=none; b=NgqGUWvoqPMyHJ6QKZS2Mna+d3fkuDmSKfo/C+VHU4OGRoHkXjBZmU382x8KMGZoCxr9ztH0zX4bRE4tBH3FG6JDRGSpd/iB9H4V3oOZifatgodrJI+hVbV2Nhv8LkLu5WdfLUu+JSoDVk0FbhGVrkF8w6QOXKp5sO/v2+Cz0mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122089; c=relaxed/simple;
	bh=k7go6gqDrFG2+trft2OBLjhjkE6TWd7DLT++h8m7bw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=AsE4KNwDtqpVCHhAj++4pE+E1A2D6Hzc6gGs5LDs8zB9i/a5hTXzx7sl1sT0/FywAPn7W8cmMFhgQ9XRm4owKhdmmu9sFiP3btI/8ja1bzc9oVe9YPbk+VtDs6gllJQkrrY/Rp6IfiRepRM0ohRbxxktPNhkRtpgf7ptEfpayug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ESLrFtqj; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251022083445euoutp024dfe90338409a930bca990de43063d16~wwzTCUGM-0891308913euoutp02I
	for <linux-pwm@vger.kernel.org>; Wed, 22 Oct 2025 08:34:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251022083445euoutp024dfe90338409a930bca990de43063d16~wwzTCUGM-0891308913euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761122085;
	bh=vkkhcjgRhvoU1VOZCS+P7a53/+EplB5Vv+2PW5suPts=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ESLrFtqj26EoOq8ktBxeTtMjZdEY0n/1JoEQJxXxmR4gIREkf6jeguUAYDlLoEhY4
	 V2ixKYNOa5GU2brC8FwusVALde+DubX41MAqVw4UhG66QTciIItZEHACnnkKNQUvf4
	 TRZMf0F8p2U8SoBI4J/sswazj31XTnCWHxFXPH2w=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251022083445eucas1p1486781d516d7a401211b0b3b7b465fff~wwzScrPTL1654616546eucas1p1t;
	Wed, 22 Oct 2025 08:34:45 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251022083443eusmtip2960cf8c9ee5bbaa26be2b023d1a84065~wwzQj4uw_1161111611eusmtip2i;
	Wed, 22 Oct 2025 08:34:42 +0000 (GMT)
Message-ID: <3f9ab01c-470e-48b5-a309-71325ecc4906@samsung.com>
Date: Wed, 22 Oct 2025 10:34:42 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
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
	Drew Fustini <fustini@kernel.org>, Daniel Almeida
	<daniel.almeida@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251022083445eucas1p1486781d516d7a401211b0b3b7b465fff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251016133814eucas1p199cb62658c016e84e34d525e7c87f16e
X-EPHeader: CA
X-CMS-RootMailID: 20251016133814eucas1p199cb62658c016e84e34d525e7c87f16e
References: <CGME20251016133814eucas1p199cb62658c016e84e34d525e7c87f16e@eucas1p1.samsung.com>
	<20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>



On 10/16/25 15:38, Michal Wilczynski wrote:
> This patch series introduces Rust support for the T-HEAD TH1520 PWM
> controller and demonstrates its use for fan control on the Sipeed Lichee
> Pi 4A board.
> 
> The primary goal of this patch series is to introduce a basic set of
> Rust abstractions for the Linux PWM subsystem. As a first user and
> practical demonstration of these abstractions, the series also provides
> a functional PWM driver for the T-HEAD TH1520 SoC. This allows control
> of its PWM channels and ultimately enables temperature controlled fan
> support for the Lichee Pi 4A board. This work aims to explore the use of
> Rust for PWM drivers and lay a foundation for potential future Rust
> based PWM drivers.
> 
> The core of this series is a new rust/kernel/pwm.rs module that provides
> abstractions for writing PWM chip provider drivers in Rust. This has
> been significantly reworked from v1 based on extensive feedback. The key
> features of the new abstraction layer include:
> 
>  - Ownership and Lifetime Management: The pwm::Chip wrapper is managed
>    by ARef, correctly tying its lifetime to its embedded struct device
>    reference counter. Chip registration is handled by a pwm::Registration
>    RAII guard, which guarantees that pwmchip_add is always paired with
>    pwmchip_remove, preventing resource leaks.
> 
>  - Modern and Safe API: The PwmOps trait is now based on the modern
>    waveform API (round_waveform_tohw, write_waveform, etc.) as recommended
>    by the subsystem maintainer. It is generic over a driver's
>    hardware specific data structure, moving all unsafe serialization logic
>    into the abstraction layer and allowing drivers to be written in 100%
>    safe Rust.
> 
>  - Ergonomics: The API provides safe, idiomatic wrappers for other PWM
>    types (State, Device, etc.) and uses standard kernel error
>    handling patterns.
> 
> The series is structured as follows:
>  - Expose static function pwmchip_release.
>  - Rust PWM Abstractions: The new safe abstraction layer.
>  - TH1520 PWM Driver: A new Rust driver for the TH1520 SoC, built on
>    top of the new abstractions.
>  - Device Tree Bindings & Nodes: The remaining patches add the necessary
>    DT bindings and nodes for the TH1520 PWM controller, and the PWM fan
>    configuration for the Lichee Pi 4A board.
> 
> Testing:
> Tested on the TH1520 SoC. The fan works correctly. The duty/period
> calculations are correct. Fan starts slow when the chip is not hot and
> gradually increases the speed when PVT reports higher temperatures.
> 
> The patches doesn't contain any dependencies that are not currently in
> the mainline kernel anymore.
> 
> ---
> Changes in v16:
> - Re-base on top of 6.18-rc1.
> - Make RUST_PWM_ABSTRACTIONS an invisible Kconfig option and remove the
>   redundant depends on PWM=y.
> - Handle period requests that are too small by rounding up to 1 cycle,
>   rather than disabling the PWM.
> - Correctly report a status of 1 to indicate when the period has been
>   rounded up.
> - Change the error code for an unsupported high clock rate from ERANGE
>   to EINVAL for consistency.
> - Link to v15: https://lore.kernel.org/r/20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com
> 

Hi Uwe,

Since you mentioned last time that you were happy with the code, would
you please consider picking up this series for linux-next? It would be
great to get it in for wider testing to ensure everything is solid.

On a related note, it looks like Clk is getting Send and Sync traits
[1], which is excellent news! This will allow the TH1520 PWM driver to
be 100% safe Rust :-).

I recall you prefer to base your pull requests on -rc1. With that in
mind, I plan to send a follow up patch to remove the unsafe block for
the Clk handling after the next merge window closes.

[1] - https://lore.kernel.org/all/20251020-clk-send-sync-v2-0-44ab533ae084@google.com/T/#mdfdfa9947b4d51b9ebc6d667911bf19907761655


Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

