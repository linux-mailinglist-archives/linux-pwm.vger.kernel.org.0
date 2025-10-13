Return-Path: <linux-pwm+bounces-7448-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C407BD28BE
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Oct 2025 12:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2451891222
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Oct 2025 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05362FF173;
	Mon, 13 Oct 2025 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hczjRAc5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9332E8B79
	for <linux-pwm@vger.kernel.org>; Mon, 13 Oct 2025 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351043; cv=none; b=c6aU053483N2ExxFbK1ndMAxgA4SGFSb82QMiyoUe5cNLDiy8+2OoXHCYEmMkWyelxPQs+5x+MLuHdE6xhVa58HCtNbXNz709VNSfYrh2qPs+koweRA0Oy4tv81FRa4eQlTjQ71wmdakQz5xga9wI9+YepaCCAQ/LD7+vjzpKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351043; c=relaxed/simple;
	bh=/BQVgQ+CSX2R+Qe7bQM33ftdg/SEKy6rfZzUbURnHj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hEq/IJkyAGoQckzw1dGTUsk2f4Zbt1JFz2UXc+/MoydUCQ4M6SLuFg9q2Iq1rMw0ivwhCYpRNomsIJMcuHKUU7iziu8Q7htTXlO507cFbn5C761na6We5aMBWxySDDj3rJWYCqVfKHMhBMWIpIIf+16bV6iwHW4iyf6sGtQ1gVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hczjRAc5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251013102359euoutp02d745bd2a2e589fd95dee41700a65d9ac~uBfGXI82K2981529815euoutp02S
	for <linux-pwm@vger.kernel.org>; Mon, 13 Oct 2025 10:23:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251013102359euoutp02d745bd2a2e589fd95dee41700a65d9ac~uBfGXI82K2981529815euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760351039;
	bh=UnxQhZSRzfDFHS/D+zsLXL9vQESyx9y8MHFtVnINwB8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hczjRAc5sAsVVuqk7io4cMp5EeDgpCA4y2nrzojt/HHD6vfIIrHk/yXAXJFt/3sDP
	 rJUiuJntpffugfk2DSER0bFeEBE0KItThToljffG4WPrxIqTMDv+KnQyXfbVjbJyH1
	 QOZBhgKOxp9T50pE8M3yjrNrOx77ZgypB6bB+H/g=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251013102358eucas1p2bf340beaea688bfc2ec0d85019598612~uBfFerfHD2166621666eucas1p2X;
	Mon, 13 Oct 2025 10:23:58 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251013102357eusmtip11cff881700a54a60ed0370ce2fe7b2be~uBfEVhpjC1713817138eusmtip1I;
	Mon, 13 Oct 2025 10:23:57 +0000 (GMT)
Message-ID: <bf7cf406-cf4c-415e-b70d-4ffc1f15835d@samsung.com>
Date: Mon, 13 Oct 2025 12:23:57 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/7] Rust Abstractions for PWM subsystem with TH1520
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
In-Reply-To: <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251013102358eucas1p2bf340beaea688bfc2ec0d85019598612
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250930122729eucas1p2c4f1c07a4a504a59ba691b407a39420d
X-EPHeader: CA
X-CMS-RootMailID: 20250930122729eucas1p2c4f1c07a4a504a59ba691b407a39420d
References: <CGME20250930122729eucas1p2c4f1c07a4a504a59ba691b407a39420d@eucas1p2.samsung.com>
	<20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>



On 9/30/25 14:20, Michal Wilczynski wrote:
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
>    types (State, Args, Device, etc.) and uses standard kernel error
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
> Changes in v15:
> - Update the TH1520 driver; read the hardware state directly instead of
>   using state, fix an integer overflow using saturating arithmetic, and
>   add handling zero period edge cases.
> - Add dbg prints, and also update them for using the preferred format
>   for emiting a waveform.
> - Remove the consumer side Args wrapper from the abstraction layer.
> - Link to v14: https://lore.kernel.org/r/20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com
> 

Hi Uwe,
Would you like me to re-base on v6.18-rc1 ?

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

