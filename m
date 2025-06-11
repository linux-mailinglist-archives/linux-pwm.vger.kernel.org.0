Return-Path: <linux-pwm+bounces-6306-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB9AD5F85
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 21:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6393AA204
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F4C2BF3C7;
	Wed, 11 Jun 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E1cjzmy4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4A2BF3DB
	for <linux-pwm@vger.kernel.org>; Wed, 11 Jun 2025 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671541; cv=none; b=NCer9togQCdWuERndfQNrWHjHhxpM5pRJ11IbFG654SRWgYgs9ozGikVmNzUBwsSpjpsuUbz+eq3jndu+TEMxooyOvtbRcNHGi7LC1DhAiKVEFRLCPPZPxxfkYqGSGexjuevee904lAOrBOnc5vr8yT0+iPfPN8CNOE4AOTkuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671541; c=relaxed/simple;
	bh=gPdZNS7zqyfqRlU4AnvLySBd/OnSMFRbn0C2zaKDgtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hRrK/68Gk1WXLQEwROejnA+h3oNzF/Xd59GmH5UTI/EnwspXYa7rApr6KijTzRGrjSj0dGNcKjDp0WlEEMhxwvTypcg8lJwqsbhPQCwiUaLT7HI77AJ5PdOrhKS6i3DN1eq/aNENkLCzn0OWTJKYjmXU8sIQh9uMcLlKrbmdP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E1cjzmy4; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250611195211euoutp01116468a592d940a59ad41414d188a103~IFPzt9j8m1804918049euoutp010
	for <linux-pwm@vger.kernel.org>; Wed, 11 Jun 2025 19:52:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250611195211euoutp01116468a592d940a59ad41414d188a103~IFPzt9j8m1804918049euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749671531;
	bh=FKuVesrjQ3DAr8qJkC2vW06vldKHX3RTeAPn2ghttkM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=E1cjzmy4M9qxy0PzT60WeCxmaENqsQQWtPqjSAJdaA1AZI6C+8SPwPaMmAVi8LcxJ
	 CXTrFUd2yRaFFRHh+LxQDu75S0qtyU4aTAqBYL8lh0Ou/Yco7nMP4tQ2zvod3Od3Yp
	 3NqeP/sFlyCS4auN/bFUJSLTeeQyUoZZPavT8Ips=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250611195210eucas1p1dc03d0fd6ed56dfe945ed76dd84a0b8f~IFPyKLp6v1619216192eucas1p1U;
	Wed, 11 Jun 2025 19:52:10 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250611195208eusmtip20c62b5d4122a774435d30e41d75dc736~IFPw9No942693226932eusmtip2w;
	Wed, 11 Jun 2025 19:52:08 +0000 (GMT)
Message-ID: <1cc861b3-35d5-4ce1-b53b-4e6ae9d14be5@samsung.com>
Date: Wed, 11 Jun 2025 21:52:08 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Drew Fustini
	<drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob
	Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
	Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, Michael
	Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <jbm3qvowi5vskhnjyqlp3xek36gzzqjt35m66eayxi6lmi525t@iefevopxjl53>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250611195210eucas1p1dc03d0fd6ed56dfe945ed76dd84a0b8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d
X-EPHeader: CA
X-CMS-RootMailID: 20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d
References: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
	<CGME20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d@eucas1p1.samsung.com>
	<20250610-rust-next-pwm-working-fan-for-sending-v2-2-753e2955f110@samsung.com>
	<jbm3qvowi5vskhnjyqlp3xek36gzzqjt35m66eayxi6lmi525t@iefevopxjl53>



On 6/11/25 08:58, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Jun 10, 2025 at 02:52:50PM +0200, Michal Wilczynski wrote:
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
>> blocks.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  MAINTAINERS               |   1 +
>>  drivers/pwm/Kconfig       |  10 ++
>>  drivers/pwm/Makefile      |   1 +
>>  drivers/pwm/pwm_th1520.rs | 287 ++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 299 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5589c0d2253bcb04e78d7b89ef6ef0ed41121d77..966ce515c8bfefdff1975bb716a267435ec0feae 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21319,6 +21319,7 @@ F:	drivers/mailbox/mailbox-th1520.c
>>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>>  F:	drivers/pinctrl/pinctrl-th1520.c
>>  F:	drivers/pmdomain/thead/
>> +F:	drivers/pwm/pwm_th1520.rs
>>  F:	drivers/reset/reset-th1520.c
>>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>>  F:	include/dt-bindings/power/thead,th1520-power.h
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 03c5a100a03e2acdccf8a46b9c70b736b630bd3a..be05658a568cb9156ef623caf54ff1aaba898d01 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -719,6 +719,16 @@ config PWM_TEGRA
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-tegra.
>>  
>> +config PWM_TH1520_RUST
> 
> Is "_RUST" relevant here? I'd drop that.

Yeah I think it's a good idea to drop.

> 
>> +	tristate "TH1520 PWM support (Rust)"
> 
> Also while having drivers is rust is a great step forward, it's not
> relevant to the user selecting support for the TH1520 device.
> 
>> +	depends on RUST_PWM_ABSTRACTIONS
>> +	help
>> +	  This option enables the driver for the PWM controller found on the
>> +	  T-HEAD TH1520 SoC. This driver is written in Rust.
>> +
>> +	  To compile this driver as a module, choose M here; the module
>> +	  will be called pwm-th1520. If you are unsure, say N.
>> +
>>  config PWM_TIECAP
>>  	tristate "ECAP PWM support"
>>  	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 96160f4257fcb0e0951581af0090615c0edf5260..d41b1940df903ba2036d8e3ed93efcd66834b7ab 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -73,3 +73,4 @@ obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>>  obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
>>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
>>  obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
>> +obj-$(CONFIG_PWM_TH1520_RUST)	+= pwm_th1520.o
> 
> Alphabetic ordering please
> 
>> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..9e43474f5123b51c49035d71219303a606c20a5a
>> --- /dev/null
>> +++ b/drivers/pwm/pwm_th1520.rs
>> @@ -0,0 +1,287 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
>> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
>> +
>> +//! Rust T-HEAD TH1520 PWM driver
> 
> A short paragraph describing the hardware limitations of that driver
> here would be nice. While you probably cannot stick to the exact format
> used in newer C drivers such that
> 
> 	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c
> 
> emits the info for your driver, I'd appreciate you sticking to mostly
> this format.

Good point. I will add a documentation comment block at the top of the
file outlining the hardware limitations, keeping the format as close as
possible to what is used in the C drivers.

> 
>> +use core::ops::Deref;
>> +use kernel::{
>> +    c_str,
>> +    clk::Clk,
>> +    device::{Bound, Core, Device},
>> +    devres,
>> +    error::{code::*, Result},
>> +    io::mem::IoMem,
>> +    math::KernelMathExt,
>> +    of, platform,
>> +    prelude::*,
>> +    pwm, time,
>> +};
>> +
>> +const MAX_PWM_NUM: u32 = 6;
>> +
>> +// Register offsets
>> +const fn th1520_pwm_chn_base(n: u32) -> usize {
>> +    (n * 0x20) as usize
>> +}
> 
> empty line here between these functions?
> 
>> +const fn th1520_pwm_ctrl(n: u32) -> usize {
>> +    th1520_pwm_chn_base(n)
>> +}
>> +const fn th1520_pwm_per(n: u32) -> usize {
>> +    th1520_pwm_chn_base(n) + 0x08
>> +}
>> +const fn th1520_pwm_fp(n: u32) -> usize {
>> +    th1520_pwm_chn_base(n) + 0x0c
>> +}
>> +
>> +// Control register bits
>> +const PWM_START: u32 = 1 << 0;
>> +const PWM_CFG_UPDATE: u32 = 1 << 2;
>> +const PWM_CONTINUOUS_MODE: u32 = 1 << 5;
>> +const PWM_FPOUT: u32 = 1 << 8;
>> +
>> +const TH1520_PWM_REG_SIZE: usize = 0xB0;
>> +
>> +/// Hardware-specific waveform representation for TH1520.
> 
> Some comments use 2 and other 3 slashes. Does this have any semantic?

Yes, they have a semantic difference. /// denotes a documentation
comment that is processed by rustdoc to generate documentation, while //
is a regular implementation comment. The compiler is configured to
require documentation for public items (like structs and functions),
which is why /// is used on the struct definition.

> 
>> +#[derive(Copy, Clone, Debug, Default)]
>> +struct Th1520WfHw {
>> +    period_cycles: u32,
>> +    duty_cycles: u32,
>> +    ctrl_val: u32,
>> +    enabled: bool,
>> +}
>> +
>> +/// The driver's private data struct. It holds all necessary devres-managed resources.
>> +struct Th1520PwmDriverData {
>> +    iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
>> +    clk: Clk,
>> +}
>> +
>> +impl pwm::PwmOps for Th1520PwmDriverData {
>> +    type WfHw = Th1520WfHw;
>> +
>> +    fn get_state(
>> +        chip: &mut pwm::Chip,
>> +        pwm: &mut pwm::Device,
>> +        state: &mut pwm::State,
>> +        parent_dev: &Device<Bound>,
>> +    ) -> Result {
> 
> Huh, if you do the newstyle stuff, .get_state() is wrong. It's either
> .round_waveform_tohw() + .round_waveform_fromhw() + .read_waveform() +
> .write_waveform() or .apply() + .get_state(), but don't mix these.

You are absolutely right. This was a misunderstanding of the new API on
my part. I will remove the .get_state implementation entirely in the
next version and rely solely on the waveform operations.

> 
>> +        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
>> +        let hwpwm = pwm.hwpwm();
>> +        let iomem_guard = data.iomem.access(parent_dev)?;
>> +        let iomap = iomem_guard.deref();
>> +        let ctrl = iomap.read32(th1520_pwm_ctrl(hwpwm));
>> +        let period_cycles = iomap.read32(th1520_pwm_per(hwpwm));
>> +        let duty_cycles = iomap.read32(th1520_pwm_fp(hwpwm));
>> +
>> +        state.set_enabled(duty_cycles != 0);
>> +
>> +        let rate_hz = data.clk.rate().as_hz();
>> +        let period_ns = (period_cycles as u64)
>> +            .mul_div(time::NSEC_PER_SEC as u64, rate_hz as u64)
>> +            .unwrap_or(0);
> 
> What does .unwrap_or(0) do? You need to round up in this mul_div
> operation.

The .unwrap_or(0) is to handle the case where the mul_div helper returns
None, which can happen if the divisor (rate_hz) is zero. In that case,
the period  becomes 0. The mul_diver helper is introduced in this commit
[1].

[1] - https://lore.kernel.org/all/20250609-math-rust-v1-v1-1-285fac00031f@samsung.com/

> 
>> +        state.set_period(period_ns);
>> +
>> +        let duty_ns = (duty_cycles as u64)
>> +            .mul_div(time::NSEC_PER_SEC as u64, rate_hz as u64)
>> +            .unwrap_or(0);
>> +        state.set_duty_cycle(duty_ns);
>> +
>> +        if (ctrl & PWM_FPOUT) != 0 {
>> +            state.set_polarity(pwm::Polarity::Normal);
>> +        } else {
>> +            state.set_polarity(pwm::Polarity::Inversed);
>> +        }
>> +
>> +        Ok(())
>> +    }
>> +
>> +    fn round_waveform_tohw(
>> +        chip: &mut pwm::Chip,
>> +        pwm: &mut pwm::Device,
>> +        wf: &pwm::Waveform,
>> +    ) -> Result<(i32, Self::WfHw)> {
>> +        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
>> +        let hwpwm = pwm.hwpwm();
>> +
>> +        if wf.duty_offset_ns != 0 {
>> +            dev_err!(chip.device(), "PWM-{}: Duty offset not supported\n", hwpwm);
> 
> That's wrong, pick the biggest offset value that is possible to
> implement and not bigger than the requested value.
> Your hardware can do inversed polarity, so offset is either 0 or
> period-duty.

Addressed below with the pwm.state() comment

> 
>> +            return Err(ENOTSUPP);
>> +        }
>> +
>> +        if wf.period_length_ns == 0 {
>> +            return Ok((
>> +                0,
>> +                Th1520WfHw {
>> +                    enabled: false,
>> +                    ..Default::default()
>> +                },
>> +            ));
>> +        }
>> +
>> +        let rate_hz = data.clk.rate().as_hz();
>> +
>> +        let period_cycles = wf
>> +            .period_length_ns
>> +            .mul_div(rate_hz as u64, time::NSEC_PER_SEC as u64)
>> +            .ok_or(EINVAL)?;
> 
> If period_length_ns is BIG, pick the biggest possible period_cycles
> value, not EINVAL.

In this case EINVAL mean the function would return EINVAL not
'period_cycles' = EINVAL. This won't happen here since
time::NSEC_PER_SEC is a constant, so this won't return None. This is not
checking for overflow.

> 
>> +        if period_cycles > u32::MAX as u64 {

In here I could pick period_cycles = u32::MAX.

>> +            dev_err!(
>> +                chip.device(),
>> +                "PWM-{}: Calculated period {} cycles is out of range\n",
>> +                hwpwm,
>> +                period_cycles
>> +            );
>> +            return Err(EINVAL);
>> +        }
> 
> ditto.
> 
>> +        let duty_cycles = wf
>> +            .duty_length_ns
>> +            .mul_div(rate_hz as u64, time::NSEC_PER_SEC as u64)
>> +            .ok_or(EINVAL)?;
>> +        if duty_cycles > period_cycles {
> 
> You can assume this won't happen.
> 
>> +            dev_err!(
>> +                chip.device(),
>> +                "PWM-{}: Duty {}ns > period {}ns\n",
>> +                hwpwm,
>> +                wf.duty_length_ns,
>> +                wf.period_length_ns
>> +            );
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        let mut ctrl_val = PWM_CONTINUOUS_MODE;
>> +        if pwm.state().polarity() == pwm::Polarity::Normal {
>> +            ctrl_val |= PWM_FPOUT;
> 
> What is pwm.state()? If that's similar to pwm->state in C this is
> irrelevant here. It describes the current state, not the new request.

Yes, you are correct. I should derive the polarity from the requested
waveform arguments, not from the current state. I see now how to handle
both the duty_offset and the polarity based on the arguments in wf. I
will implement the correct logic.

> 
>> +        }
>> +
>> +        let wfhw = Th1520WfHw {
>> +            period_cycles: period_cycles as u32,
>> +            duty_cycles: duty_cycles as u32,
>> +            ctrl_val,
>> +            enabled: true,
>> +        };
>> +
>> +        dev_dbg!(
>> +            chip.device(),
>> +            "wfhw -- Period: {}, Duty: {}, Ctrl: 0x{:x}\n",
>> +            wfhw.period_cycles,
>> +            wfhw.duty_cycles,
>> +            wfhw.ctrl_val
>> +        );
> 
> This would be much more helpful if it also contained the values from wf.
> 
>> +        Ok((0, wfhw))
>> +    }
>> +
>> +    fn write_waveform(
>> +        chip: &mut pwm::Chip,
>> +        pwm: &mut pwm::Device,
>> +        wfhw: &Self::WfHw,
>> +        parent_dev: &Device<Bound>,
>> +    ) -> Result {
>> +        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
>> +        let hwpwm = pwm.hwpwm();
>> +        let iomem_guard = data.iomem.access(parent_dev)?;
>> +        let iomap = iomem_guard.deref();
>> +        let was_enabled = pwm.state().enabled();
>> +
>> +        if !wfhw.enabled {
>> +            if was_enabled {
>> +                let mut ctrl = iomap.read32(th1520_pwm_ctrl(hwpwm));
> 
> Do you need that read? Isn't is clear what the value is?
> 
>> +                ctrl &= !PWM_CFG_UPDATE;
>> +
>> +                iomap.write32(ctrl, th1520_pwm_ctrl(hwpwm));
>> +                iomap.write32(0, th1520_pwm_fp(hwpwm));
>> +                iomap.write32(ctrl | PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm));
>> +            }
>> +            return Ok(());
>> +        }
>> +
>> +        let ctrl = wfhw.ctrl_val & !PWM_CFG_UPDATE;
> 
> wfhw.ctrl_val never has PWM_CFG_UPDATE set.

You're right about the redundant read and the logic with PWM_CFG_UPDATE.
These are leftovers from a frustrating debug session related to a clock
gating issue. I will refactor this section to be cleaner and more
direct.

> 
>> +        iomap.write32(ctrl, th1520_pwm_ctrl(hwpwm));
>> +        iomap.write32(wfhw.period_cycles, th1520_pwm_per(hwpwm));
>> +        iomap.write32(wfhw.duty_cycles, th1520_pwm_fp(hwpwm));
>> +        iomap.write32(wfhw.ctrl_val | PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm));
>> +
>> +        if !was_enabled {
>> +            iomap.write32(wfhw.ctrl_val | PWM_START, th1520_pwm_ctrl(hwpwm));
> 
> Can this be combined with the above write?

Per the TH1520 peripheral manual [2] (chapter 6.6.2.1), the PWM_START bit
should only be asserted when enabling the PWM for the first time, not
during a reconfiguration of an alreadyrunning channel. The separate if
statement is there to handle this specific hardware requirement.

[2] - https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/blob/6b56e2d69485c375c5912eaa2791f79f1d089c07/docs/TH1520%20Peripheral%20Interface%20User%2

> 
>> +        }
>> +
>> +        Ok(())
>> +    }
>> +}
>> +
>> +impl Drop for Th1520PwmDriverData {
>> +    fn drop(&mut self) {
>> +        self.clk.disable_unprepare();
>> +    }
>> +}
>> +
>> +static TH1520_PWM_OPS: pwm::PwmOpsVTable = pwm::create_pwm_ops::<Th1520PwmDriverData>();
>> +
>> +struct Th1520PwmPlatformDriver {
>> +    _registration: pwm::Registration,
>> +}
>> +
>> +kernel::of_device_table!(
>> +    OF_TABLE,
>> +    MODULE_OF_TABLE,
>> +    <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
>> +    [(of::DeviceId::new(c_str!("thead,th1520-pwm")), ())]
>> +);
>> +
>> +impl platform::Driver for Th1520PwmPlatformDriver {
>> +    type IdInfo = ();
>> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
>> +
>> +    fn probe(
>> +        pdev: &platform::Device<Core>,
>> +        _id_info: Option<&Self::IdInfo>,
>> +    ) -> Result<Pin<KBox<Self>>> {
>> +        let dev = pdev.as_ref();
>> +        let resource = pdev.resource(0).ok_or(ENODEV)?;
>> +        let iomem = pdev.ioremap_resource_sized::<TH1520_PWM_REG_SIZE>(resource)?;
>> +        let clk = Clk::get(pdev.as_ref(), None)?;
>> +
>> +        clk.prepare_enable()?;
> 
> We don't have clk_rate_get_exclusive() yet, right? Then please add a
> comment here that this needs to be added here when it became available.

Yeah sadly we don't have that abstraction yet.

> 
>> +
>> +        let rate_hz = clk.rate().as_hz();
>> +        if rate_hz == 0 {
>> +            dev_err!(dev, "Clock rate is zero\n");
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        if rate_hz > time::NSEC_PER_SEC as usize {
>> +            dev_err!(
>> +                dev,
>> +                "Clock rate {} Hz is too high, not supported.\n",
>> +                rate_hz
>> +            );
>> +            return Err(ERANGE);
>> +        }
>> +
>> +        let chip = pwm::Chip::new(dev, MAX_PWM_NUM, 0)?;
>> +
>> +        let drvdata = KBox::new(Th1520PwmDriverData { iomem, clk }, GFP_KERNEL)?;
>> +        chip.set_drvdata(drvdata);
>> +
>> +        let registration = pwm::Registration::new(chip, &TH1520_PWM_OPS)?;
>> +
>> +        Ok(KBox::new(
>> +            Th1520PwmPlatformDriver {
>> +                _registration: registration,
>> +            },
>> +            GFP_KERNEL,
>> +        )?
>> +        .into())
>> +    }
>> +}
>> +
>> +kernel::module_platform_driver! {
>> +    type: Th1520PwmPlatformDriver,
>> +    name: "pwm-th1520",
>> +    author: "Michal Wilczynski <m.wilczynski@samsung.com>",
>> +    description: "T-HEAD TH1520 PWM driver",
>> +    license: "GPL v2",
>> +}
> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

