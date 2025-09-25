Return-Path: <linux-pwm+bounces-7351-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E220CB9EEB8
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Sep 2025 13:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E320385D48
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Sep 2025 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE79F2FA0E5;
	Thu, 25 Sep 2025 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QYQxthQS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80322EA483
	for <linux-pwm@vger.kernel.org>; Thu, 25 Sep 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800004; cv=none; b=fwlIbSDYkRd3Si6CHD3ZrZS5vm6Zmi/YZn0t3I4vzCeM/KWyktZ0GFxrzL8Ryr36VpMH+Y7qbmXxmkspg+HBg2qQMpZ2ZKxwDZazGi/8WnPual3m5mKd+HAqvS7vR61qXSAUOjq7HOgyIO54l6RyoNWUCCnjE5szDjTEA3xIvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800004; c=relaxed/simple;
	bh=tWPOJ54fBiTdw0gvZyVcZpoXiuKoSj+4PGphxIupgUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=upnHMDFJGzb7d5RNcjaQv5EMsL5m0hhZyQx7XRjkcbKRDS2UfozMXCxHm75CtAhDbAM0v5NGeK00u1JlM49cbLSZaf1FES2yI7aW2kG9xEvrQx+bi4ZkZy2c0gGidhhLzvDNTvIAGmmvAcZPu/wBgSrclaebvS/Ve9R7pfZp93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QYQxthQS; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250925113319euoutp02e8e1553bdfb51b685a87e3742901adc9~og0fbrjWU2637226372euoutp02C
	for <linux-pwm@vger.kernel.org>; Thu, 25 Sep 2025 11:33:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250925113319euoutp02e8e1553bdfb51b685a87e3742901adc9~og0fbrjWU2637226372euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758799999;
	bh=P9Ec1jWSnugXGZ5AkUhPYGjEOqiEduJxMg/sOLnZKhE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QYQxthQSgPfwqLeihsdey0uww1aNQ/9yFDm+tAB3lJqkpE258tUh1PNxcdB4tKExy
	 rt+xsxspMKiKg6h1O8Hvag6ddBsa1m6iaoFVFkajmnAIwMsoHQHVKg2NstM+GgAwBe
	 GEhYX3l3mp+AESfELWYqTSfj4uzVfnTmgFb8zBg4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250925113318eucas1p2941e2087b8992d315bf1349a6221fb45~og0e1T7Gk2754227542eucas1p2V;
	Thu, 25 Sep 2025 11:33:18 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250925113317eusmtip294bf20309d95bb94e0b2138a8a118478~og0dvyGCE0683706837eusmtip2-;
	Thu, 25 Sep 2025 11:33:17 +0000 (GMT)
Message-ID: <3c0ce788-0e31-4cde-bfc2-e4add5818348@samsung.com>
Date: Thu, 25 Sep 2025 13:33:17 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
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
	Drew Fustini <fustini@kernel.org>, Daniel Almeida
	<daniel.almeida@collabora.com>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <ca2ftwfducf4swuoondajiid642mctilh4lt3grgxpnup3nhag@tyuwyasfw4uj>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250925113318eucas1p2941e2087b8992d315bf1349a6221fb45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250820083544eucas1p2be0157353ec1201b0651292792429aa4
X-EPHeader: CA
X-CMS-RootMailID: 20250820083544eucas1p2be0157353ec1201b0651292792429aa4
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
	<CGME20250820083544eucas1p2be0157353ec1201b0651292792429aa4@eucas1p2.samsung.com>
	<20250820-rust-next-pwm-working-fan-for-sending-v14-4-df2191621429@samsung.com>
	<ca2ftwfducf4swuoondajiid642mctilh4lt3grgxpnup3nhag@tyuwyasfw4uj>



On 9/19/25 09:10, Uwe Kleine-König wrote:
> Hello,
> 
> actually I intended to give my feedback as a patch, but I'm not fluent
> enough in Rust yet :-\, so here come my thoughts in text only.

Hi,
Thanks, will do my best to address the comments

> 
> On Wed, Aug 20, 2025 at 10:35:39AM +0200, Michal Wilczynski wrote:
>> Introduce a PWM driver for the T-HEAD TH1520 SoC, written in Rust and
>> utilizing the safe PWM abstractions from the preceding commit.
>>
>> The driver implements the pwm::PwmOps trait using the modern waveform
>> API (round_waveform_tohw, write_waveform, etc.) to support configuration
>> of period, duty cycle, and polarity for the TH1520's PWM channels.
>>
>> Resource management is handled using idiomatic Rust patterns. The PWM
>> chip object is allocated via pwm::Chip::new and its registration with
>> the PWM core is managed by the pwm::Registration RAII guard. This
>> ensures pwmchip_remove is always called when the driver unbinds,
>> preventing resource leaks. Device managed resources are used for the
>> MMIO region, and the clock lifecycle is correctly managed in the
>> driver's private data Drop implementation.
>>
>> The driver's core logic is written entirely in safe Rust, with no unsafe
>> blocks, except for the Send and Sync implementations for the driver
>> data, which are explained in the comments.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  MAINTAINERS               |   1 +
>>  drivers/pwm/Kconfig       |  11 ++
>>  drivers/pwm/Makefile      |   1 +
>>  drivers/pwm/pwm_th1520.rs | 355 ++++++++++++++++++++++++++++++++++++++++++++++
> 
> For consistency I would prefer this file to be named pwm-th1520.rs. I
> tried to fix that but then the compiler was unhappy. I guess a minus in
> a filename just doesn't work for Rust?

In Rust by default the Rust module is called the same as the file. And
the module names can't contain hyphens. I think technically this could
be overridden by 'path' attribute, but it's probably just better to use
underscores '_' like other Rust drivers.

> 
>>  4 files changed, 368 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5d7c0676c1d00a02b3d7db2de88b039c08c99c6e..d79dc21f22d143ca8cde6a06194545fbc640e695 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21741,6 +21741,7 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>>  F:	drivers/pinctrl/pinctrl-th1520.c
>>  F:	drivers/pmdomain/thead/
>>  F:	drivers/power/sequencing/pwrseq-thead-gpu.c
>> +F:	drivers/pwm/pwm_th1520.rs
>>  F:	drivers/reset/reset-th1520.c
>>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>>  F:	include/dt-bindings/power/thead,th1520-power.h
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 2b608f4378138775ee3ba4d53f682952e1914118..dd6db01832ee985e2e588a413a13df869a029d3d 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -729,6 +729,17 @@ config PWM_TEGRA
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-tegra.
>>  
>> +config PWM_TH1520
>> +	tristate "TH1520 PWM support"
>> +	depends on RUST
>> +	select RUST_PWM_ABSTRACTIONS
>> +	help
>> +	  This option enables the driver for the PWM controller found on the
>> +	  T-HEAD TH1520 SoC.
>> +
>> +	  To compile this driver as a module, choose M here; the module
>> +	  will be called pwm-th1520. If you are unsure, say N.
>> +
>>  config PWM_TIECAP
>>  	tristate "ECAP PWM support"
>>  	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index ff4f47e5fb7a0dbac72c12de82c3773e5582db6d..5c15c95c6e49143969389198657eed0ecf4086b2 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -67,6 +67,7 @@ obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
>>  obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
>>  obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
>>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
>> +obj-$(CONFIG_PWM_TH1520)	+= pwm_th1520.o
>>  obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
>>  obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
>>  obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..5ef887b1b5dfed92c5d4b87a7d48f673352a257e
>> --- /dev/null
>> +++ b/drivers/pwm/pwm_th1520.rs
>> @@ -0,0 +1,355 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
>> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
>> +
>> +//! Rust T-HEAD TH1520 PWM driver
>> +//!
>> +//! Limitations:
>> +//! - The period and duty cycle are controlled by 32-bit hardware registers,
>> +//!   limiting the maximum resolution.
>> +//! - The driver supports continuous output mode only; one-shot mode is not
>> +//!   implemented.
>> +//! - The controller hardware provides up to 6 PWM channels.
>> +//! - Reconfiguration is glitch free - new period and duty cycle values are
>> +//!   latched and take effect at the start of the next period.
>> +//! - Polarity is handled via a simple hardware inversion bit; arbitrary
>> +//!   duty cycle offsets are not supported.
>> +//! - Disabling a channel is achieved by configuring its duty cycle to zero to
>> +//!   produce a static low output. Clearing the `start` does not reliably
>> +//!   force the static inactive level defined by the `INACTOUT` bit. Hence
>> +//!   this method is not used in this driver.
>> +//!
>> +
>> +use core::ops::Deref;
>> +use kernel::{
>> +    c_str,
>> +    clk::Clk,
>> +    device::{Bound, Core, Device},
>> +    devres,
>> +    io::mem::IoMem,
>> +    of, platform,
>> +    prelude::*,
>> +    pwm, time,
>> +};
>> +
>> +const TH1520_MAX_PWM_NUM: u32 = 6;
>> +
>> +// Register offsets
>> +const fn th1520_pwm_chn_base(n: u32) -> usize {
>> +    (n * 0x20) as usize
>> +}
>> +
>> +const fn th1520_pwm_ctrl(n: u32) -> usize {
>> +    th1520_pwm_chn_base(n)
>> +}
>> +
>> +const fn th1520_pwm_per(n: u32) -> usize {
>> +    th1520_pwm_chn_base(n) + 0x08
>> +}
>> +
>> +const fn th1520_pwm_fp(n: u32) -> usize {
>> +    th1520_pwm_chn_base(n) + 0x0c
>> +}
>> +
>> +// Control register bits
>> +const TH1520_PWM_START: u32 = 1 << 0;
>> +const TH1520_PWM_CFG_UPDATE: u32 = 1 << 2;
>> +const TH1520_PWM_CONTINUOUS_MODE: u32 = 1 << 5;
>> +const TH1520_PWM_FPOUT: u32 = 1 << 8;
>> +
>> +const TH1520_PWM_REG_SIZE: usize = 0xB0;
>> +
>> +fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
>> +    const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
>> +
>> +    (match ns.checked_mul(rate_hz) {
>> +        Some(product) => product,
>> +        None => u64::MAX,
>> +    }) / NSEC_PER_SEC_U64
>> +}
>> +
>> +fn cycles_to_ns(cycles: u64, rate_hz: u64) -> u64 {
>> +    const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
>> +
>> +    // Round up
>> +    let Some(numerator) = cycles
>> +        .checked_mul(NSEC_PER_SEC_U64)
>> +        .and_then(|p| p.checked_add(rate_hz - 1))
>> +    else {
>> +        return u64::MAX;
>> +    };
>> +
>> +    numerator / rate_hz
> 
> Does cycles_to_ns(18446744074, 66000000) yield u64::MAX or u64::MAX /
> 66000000? Reading through the docs I found I think it's the former. I
> guess we don't reach these spheres in the driver, but conceptually the
> latter would be better and I think that's relevant as this is the first
> Rust driver and so very likely will be the blueprint for further
> drivers.
> 
> Further below you're using saturating_sub(), is there a similar variant
> for multiplication that could simplify this function to
> 
> 	let numerator = cyles
> 	  .saturating_mul(NSEC_PER_SEC_U64)
> 	  .saturating_add(rate_hz - 1);
> 
> 	numerator / rate_hz
> 
> ?

Yeah I think this would work

> 
> Additionally I'd add a comment that this should be replaced by
> mul_u64_u64_div_u64_roundup() once that exists in Rust. (Sigh, I just
> notice we still don't have that in C yet.)

Sure

> 
>> +}
>> +
>> +/// Hardware-specific waveform representation for TH1520.
>> +#[derive(Copy, Clone, Debug, Default)]
>> +struct Th1520WfHw {
>> +    period_cycles: u32,
>> +    duty_cycles: u32,
>> +    ctrl_val: u32,
>> +    enabled: bool,
>> +}
>> +
>> +/// The driver's private data struct. It holds all necessary devres managed resources.
>> +#[pin_data(PinnedDrop)]
>> +struct Th1520PwmDriverData {
>> +    #[pin]
>> +    iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
>> +    clk: Clk,
>> +}
>> +
>> +// This `unsafe` implementation is a temporary necessity because the underlying `kernel::clk::Clk`
>> +// type does not yet expose `Send` and `Sync` implementations. This block should be removed
>> +// as soon as the clock abstraction provides these guarantees directly.
>> +// TODO: Remove those unsafe impl's when Clk will support them itself.
>> +
>> +// SAFETY: The `devres` framework requires the driver's private data to be `Send` and `Sync`.
>> +// We can guarantee this because the PWM core synchronizes all callbacks, preventing concurrent
>> +// access to the contained `iomem` and `clk` resources.
>> +unsafe impl Send for Th1520PwmDriverData {}
>> +
>> +// SAFETY: The same reasoning applies as for `Send`. The PWM core's synchronization
>> +// guarantees that it is safe for multiple threads to have shared access (`&self`)
>> +// to the driver data during callbacks.
>> +unsafe impl Sync for Th1520PwmDriverData {}
>> +
>> +impl pwm::PwmOps for Th1520PwmDriverData {
>> +    type WfHw = Th1520WfHw;
>> +
>> +    fn round_waveform_tohw(
>> +        chip: &pwm::Chip<Self>,
>> +        _pwm: &pwm::Device,
>> +        wf: &pwm::Waveform,
>> +    ) -> Result<pwm::RoundedWaveform<Self::WfHw>> {
>> +        let data = chip.drvdata();
>> +
>> +        if wf.period_length_ns == 0 {
> 
> Please add a dev_dbg! here for consistency with the wf.period_length_ns
> != 0 case here.
> 
>> +            return Ok(pwm::RoundedWaveform {
>> +                status: 0,
>> +                hardware_waveform: Th1520WfHw {
>> +                    enabled: false,
>> +                    ..Default::default()
>> +                },
>> +            });
>> +        }
>> +
>> +        let rate_hz = data.clk.rate().as_hz() as u64;
>> +
>> +        let period_cycles = ns_to_cycles(wf.period_length_ns, rate_hz).min(u64::from(u32::MAX));
> 
> What happens if you get period_cycles = 0 here?

How about add an if for early return ? Like below:
	if period_cycles == 0 {
            dev_dbg!(
                chip.device(),
                "Requested period {} ns is too small for clock rate {} Hz, disabling PWM.\n",
                wf.period_length_ns,
                rate_hz
            );

            return Ok(pwm::RoundedWaveform {
                status: 0,
                hardware_waveform: Th1520WfHw {
                    enabled: false,
                    ..Default::default()
                },
            });
        }


> 
>> +        let mut duty_cycles = ns_to_cycles(wf.duty_length_ns, rate_hz).min(u64::from(u32::MAX));
>> +
>> +        let mut ctrl_val = TH1520_PWM_CONTINUOUS_MODE;
>> +
>> +        let is_inversed = wf.duty_length_ns > 0
>> +            && wf.duty_offset_ns > 0
>> +            && wf.duty_length_ns + wf.duty_offset_ns >= wf.period_length_ns;
> 
> For
> 	duty_length_ns =   0x8000000000000000
> 	duty_offset_ns =   0x8000000000000000
> 	period_length_ns = 0xffffffffffffffff
> 
> this should evaluate to true (right?) but if + overflows in the same way
> in Rust as it does in C, you get is_inversed = false here.
> 
> The safe condition is
> 
> 	wf.duty_offset_ns >= wf.period_length_ns - wf.duty_length_ns
> 
> here.

OK will change it thanks.

> 
>> +        if is_inversed {
>> +            duty_cycles = period_cycles - duty_cycles;
>> +        } else {
>> +            ctrl_val |= TH1520_PWM_FPOUT;
>> +        }
>> +
>> +        let wfhw = Th1520WfHw {
>> +            period_cycles: period_cycles as u32,
>> +            duty_cycles: duty_cycles as u32,
> 
> This casts period_cycles and duty_cycles from an u64 to an u32, right?
> Can you please add a comment that shortly explains why these values fit
> into an u32?

Will add a comment.

> 
>> +            ctrl_val,
>> +            enabled: true,
>> +        };
>> +
>> +        dev_dbg!(
>> +            chip.device(),
>> +            "clk_rate: {}Hz Requested: period {}ns, duty {}ns, offset {}ns -> HW: period {} cyc, duty {} cyc, ctrl 0x{:x}\n",
> 
> " " before the units please.
> 
> I want to establish
> 
> 	"{}/{} [+{}]", duty_length_ns, period_length_ns, duty_offset_ns
> 
> as the typical way to emit a waveform. Please use that consistently.

Sure, thanks

> 
>> +            rate_hz,
>> +            wf.period_length_ns,
>> +            wf.duty_length_ns,
>> +            wf.duty_offset_ns,
>> +            wfhw.period_cycles,
>> +            wfhw.duty_cycles,
>> +            wfhw.ctrl_val
>> +        );
>> +
>> +        Ok(pwm::RoundedWaveform {
>> +            status: 0,
>> +            hardware_waveform: wfhw,
>> +        })
>> +    }
>> +
>> +    fn round_waveform_fromhw(
>> +        chip: &pwm::Chip<Self>,
>> +        _pwm: &pwm::Device,
>> +        wfhw: &Self::WfHw,
>> +        wf: &mut pwm::Waveform,
>> +    ) -> Result {
>> +        let data = chip.drvdata();
>> +        let rate_hz = data.clk.rate().as_hz() as u64;
>> +
>> +        wf.period_length_ns = cycles_to_ns(u64::from(wfhw.period_cycles), rate_hz);
> 
> Here I wonder again about wfhw.period_cycles = 0.
> 
>> +        let duty_cycles = u64::from(wfhw.duty_cycles);
>> +
>> +        if (wfhw.ctrl_val & TH1520_PWM_FPOUT) != 0 {
>> +            wf.duty_length_ns = cycles_to_ns(duty_cycles, rate_hz);
>> +            wf.duty_offset_ns = 0;
>> +        } else {
>> +            let period_cycles = u64::from(wfhw.period_cycles);
>> +            let original_duty_cycles = period_cycles.saturating_sub(duty_cycles);
>> +
>> +            // For an inverted signal, `duty_length_ns` is the high time (period - low_time).
>> +            wf.duty_length_ns = cycles_to_ns(original_duty_cycles, rate_hz);
>> +            // The offset is the initial low time, which is what the hardware register provides.
>> +            wf.duty_offset_ns = cycles_to_ns(duty_cycles, rate_hz);
>> +        }
>> +
>> +        Ok(())
>> +    }
>> +
>> +    fn read_waveform(
>> +        chip: &pwm::Chip<Self>,
>> +        pwm: &pwm::Device,
>> +        parent_dev: &Device<Bound>,
>> +    ) -> Result<Self::WfHw> {
>> +        let data = chip.drvdata();
>> +        let hwpwm = pwm.hwpwm();
>> +        let iomem_accessor = data.iomem.access(parent_dev)?;
>> +        let iomap = iomem_accessor.deref();
>> +
>> +        let ctrl = iomap.try_read32(th1520_pwm_ctrl(hwpwm))?;
>> +        let period_cycles = iomap.try_read32(th1520_pwm_per(hwpwm))?;
>> +        let duty_cycles = iomap.try_read32(th1520_pwm_fp(hwpwm))?;
>> +
>> +        let wfhw = Th1520WfHw {
>> +            period_cycles,
>> +            duty_cycles,
>> +            ctrl_val: ctrl,
>> +            enabled: duty_cycles != 0,
>> +        };
>> +
>> +        dev_dbg!(
>> +            chip.device(),
>> +            "PWM-{}: read_waveform: Read hw state - period: {}, duty: {}, ctrl: 0x{:x}, enabled: {}",
>> +            hwpwm,
>> +            wfhw.period_cycles,
>> +            wfhw.duty_cycles,
>> +            wfhw.ctrl_val,
>> +            wfhw.enabled
>> +        );
>> +
>> +        Ok(wfhw)
>> +    }
>> +
>> +    fn write_waveform(
>> +        chip: &pwm::Chip<Self>,
>> +        pwm: &pwm::Device,
>> +        wfhw: &Self::WfHw,
>> +        parent_dev: &Device<Bound>,
>> +    ) -> Result {
>> +        let data = chip.drvdata();
>> +        let hwpwm = pwm.hwpwm();
>> +        let iomem_accessor = data.iomem.access(parent_dev)?;
>> +        let iomap = iomem_accessor.deref();
>> +        let was_enabled = pwm.state().enabled();
> 
> The driver would be a tad more robust if was_enabled is determined from
> the hardware registers instead. (And also it helps not to add another
> dependency on pwm.state which I'd like to get rid of in the long run
> with waveforms being the canonical representation internally.)

I checked and it seems to me like I can make it work with HW registers,
will include that in next revision.

> 
>> +
>> +        if !wfhw.enabled {
> 
> dev_dbg! here for consistence please.
> 
>> +            if was_enabled {
>> +                iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
>> +                iomap.try_write32(0, th1520_pwm_fp(hwpwm))?;
>> +                iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
>> +            }
>> +            return Ok(());
>> +        }
>> +
>> +        iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
>> +        iomap.try_write32(wfhw.period_cycles, th1520_pwm_per(hwpwm))?;
>> +        iomap.try_write32(wfhw.duty_cycles, th1520_pwm_fp(hwpwm))?;
>> +        iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
>> +
>> +        // The `TH1520_PWM_START` bit must be written in a separate, final transaction, and
>> +        // only when enabling the channel from a disabled state.
>> +        if !was_enabled {
>> +            iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_START, th1520_pwm_ctrl(hwpwm))?;
>> +        }
>> +
>> +        dev_dbg!(
>> +            chip.device(),
>> +            "PWM-{}: Wrote (per: {}, duty: {})",
>> +            hwpwm,
>> +            wfhw.period_cycles,
>> +            wfhw.duty_cycles,
>> +        );
>> +
>> +        Ok(())
>> +    }
>> +}
> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

