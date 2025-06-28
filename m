Return-Path: <linux-pwm+bounces-6566-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DD2AEC9AB
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Jun 2025 20:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623163A88AF
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Jun 2025 18:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96386287510;
	Sat, 28 Jun 2025 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZQB2CRQb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E7F277804
	for <linux-pwm@vger.kernel.org>; Sat, 28 Jun 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751134507; cv=none; b=K95q4RuBZsNrLGeNdnZAe+Np3Tdt/zWXPk59Ien8cJu2vO30Vc7lKvNXhPysJrHQbflWXiaEbJ4dbRZq0MOYNseI+r/EUr+TLixqiNQPtfeFbenWrxG3dCDGFFpq6n6my5tca6epNWQbO0Gn7JDqJnghyerVg5wVzjgY682htm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751134507; c=relaxed/simple;
	bh=DqAaSx9Iu74jTCRCpoqiW6+h8SmPhlzSLhjEqvo182I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=n3x1ruXv0uiO14iAhBB7ES0dL3X2nUIXDAMqU1xGBx16Jb4Vx5fDKFvwiJx00voMNYRCYRxzwKv7WPPRmUR+C7KCWjE0dYOl8ffKiQWsqmrVE9HV9KNJH+M2EWenUbOU1wmNrMPevHybCJXwqZh6xN6vSSNdZPOKQ8kSzqO7N3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZQB2CRQb; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250628181502euoutp025602ddc8c03c285aee4c368da5bcf6ae~NR41IdiNF2823728237euoutp02C
	for <linux-pwm@vger.kernel.org>; Sat, 28 Jun 2025 18:15:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250628181502euoutp025602ddc8c03c285aee4c368da5bcf6ae~NR41IdiNF2823728237euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751134502;
	bh=2JA1x1+wxIMxbTcb05JnAkXnXDTnRK4eUQH/s2vY+XY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZQB2CRQbRmZs3pRIe8Bl9Duy3N7ceVBVs/91VdN/4mbECUPi6EzlJ48XsWeg092xp
	 T/13PpGMsFIvSVHYuD6lco/5ijepbwH0pKvopRfqTnWJkuTKOiLtzNsUEv5qC5fb4H
	 FL65xO/uyQNSMV+tXu3JbfcuutEaNhOE2V8DId/Q=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250628181501eucas1p1fa95a0e5ce8ee9081b9b7cd0bd3fc7db~NR4z_sDU71200312003eucas1p15;
	Sat, 28 Jun 2025 18:15:01 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250628181459eusmtip1664c47fbf09b84ffb0d6e5a1c32c784b~NR4ywaDGi1908019080eusmtip1a;
	Sat, 28 Jun 2025 18:14:59 +0000 (GMT)
Message-ID: <21504282-18d1-4165-a1bc-ec4cbbb19c2b@samsung.com>
Date: Sat, 28 Jun 2025 20:14:59 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] pwm: Add Rust driver for T-HEAD TH1520 SoC
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
In-Reply-To: <aot4ow37qsrehgce6vpc5m7ha5w6h4jvj7k7bokn4eo63sjk5x@iyp5ir234kx5>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250628181501eucas1p1fa95a0e5ce8ee9081b9b7cd0bd3fc7db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250623180902eucas1p2960477c0a44f05e991747312b0ae0ff0
X-EPHeader: CA
X-CMS-RootMailID: 20250623180902eucas1p2960477c0a44f05e991747312b0ae0ff0
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
	<CGME20250623180902eucas1p2960477c0a44f05e991747312b0ae0ff0@eucas1p2.samsung.com>
	<20250623-rust-next-pwm-working-fan-for-sending-v5-4-0ca23747c23e@samsung.com>
	<aot4ow37qsrehgce6vpc5m7ha5w6h4jvj7k7bokn4eo63sjk5x@iyp5ir234kx5>



On 6/27/25 17:28, Uwe Kleine-König wrote:
> On Mon, Jun 23, 2025 at 08:08:52PM +0200, Michal Wilczynski wrote:
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
>>  drivers/pwm/pwm_th1520.rs | 318 ++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 330 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a575622454a2ef57ce055c8a8c4765fa4fddc490..879870471e86dcec4a0e8f5c45d2cc3409411fdd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21402,6 +21402,7 @@ F:	drivers/mailbox/mailbox-th1520.c
>>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>>  F:	drivers/pinctrl/pinctrl-th1520.c
>>  F:	drivers/pmdomain/thead/
>> +F:	drivers/pwm/pwm_th1520.rs
>>  F:	drivers/reset/reset-th1520.c
>>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>>  F:	include/dt-bindings/power/thead,th1520-power.h
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index cfddeae0eab3523f04f361fb41ccd1345c0c937b..a675b3bd68392d1b05a47a2a1390c5606647ca15 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -719,6 +719,16 @@ config PWM_TEGRA
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-tegra.
>>  
>> +config PWM_TH1520
>> +	tristate "TH1520 PWM support"
>> +	depends on RUST_PWM_ABSTRACTIONS
> 
> RUST_PWM_ABSTRACTIONS is user selectable. Is that sensible. From a
> user's POV it shouldn't matter if the driver is written in Rust or not.

You make an excellent point about user experience. My initial thought
was to follow the depends on pattern that I saw in other Rust drivers.

I can see how using select would be cleaner for the end user. My only
hesitation was that it differs from the current convention for Rust
drivers, and I wanted to be careful about changing an established
pattern.

If you are comfortable with setting this direction for the PWM
subsystem, I am happy to make the change to use select
RUST_PWM_ABSTRACTIONS (gated by depends on RUST). Please let me know.

> 
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
>> index 96160f4257fcb0e0951581af0090615c0edf5260..a410747095327a315a6bcd24ae343ce7857fe323 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -66,6 +66,7 @@ obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
>>  obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
>>  obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
>>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
>> +obj-$(CONFIG_PWM_TH1520)	+= pwm_th1520.o
>>  obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
>>  obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
>>  obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..a77c45cef9cf8f02a25db9d42c45cd0df565b0ec
>> --- /dev/null
>> +++ b/drivers/pwm/pwm_th1520.rs
>> @@ -0,0 +1,318 @@
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
> 
> Important questions to answer here are:
> 
>  - How does the hardware behave on disable? (Does it stop immediately
>    (or at all)? Does it emit a constant output? Which?) 
>  - How does the hardware behave on reconfiguration? (Does it switch
>    immidiately or does it complete the current period? Can there be
>    glitches?

Sure, I have investigated and will add comments explaining that
reconfiguration is glitch free and disabling is done by setting the duty
cycle to zero

> 
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
>> +const MAX_PWM_NUM: u32 = 6;
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
>> +const PWM_START: u32 = 1 << 0;
>> +const PWM_CFG_UPDATE: u32 = 1 << 2;
>> +const PWM_CONTINUOUS_MODE: u32 = 1 << 5;
>> +const PWM_FPOUT: u32 = 1 << 8;
> 
> Can you please add a driver specific prefix to these?

OK

> 
>> +const TH1520_PWM_REG_SIZE: usize = 0xB0;
>> +
>> +fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
>> +    const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
>> +
>> +    match ns.checked_mul(rate_hz) {
>> +        Some(product) => product / NSEC_PER_SEC_U64,
>> +        None => u64::MAX,
>> +    }
> 
> The semantic here is: If ns * rate_hz overflows, return U64_MAX, else ns
> * rate_hz / NSEC_PER_SEC, right?
> 
> If you cannot easily reproduce what mul_u64_u64_div_u64() does, I think
> it would be more prudent do make this:
> 
> 	match ns.checked_mul(rate_hz) {
> 	    Some(product) => product,
> 	    None => u64::MAX,
> 	} / NSEC_PER_SEC_U64

Thank you for the feedback on the calculation. I analyzed the two
approaches and found that on overflow, my version saturates to u64::MAX,
while the suggested version would result in u64::MAX / NSEC_PER_SEC. I
believe my original implementation's saturation behavior is more
predictable. With this in mind, would you be comfortable with me
retaining the original implementation?

> 
>> +}
>> +
>> [...]
>> +impl pwm::PwmOps for Th1520PwmDriverData {
>> +    type WfHw = Th1520WfHw;
>> +
>> +    fn round_waveform_tohw(
>> +        chip: &pwm::Chip,
>> +        _pwm: &pwm::Device,
>> +        wf: &pwm::Waveform,
>> +    ) -> Result<(c_int, Self::WfHw)> {
>> +        let data: &Self = chip.drvdata();
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
>> +        let rate_hz = data.clk.rate().as_hz() as u64;
>> +
>> +        let period_cycles = ns_to_cycles(wf.period_length_ns, rate_hz).min(u32::MAX as u64);
>> +        let mut duty_cycles = ns_to_cycles(wf.duty_length_ns, rate_hz).min(u32::MAX as u64);
>> +
>> +        let mut ctrl_val = PWM_CONTINUOUS_MODE;
>> +
>> +        if wf.duty_offset_ns == 0 {
>> +            ctrl_val |= PWM_FPOUT;
>> +        } else {
>> +            duty_cycles = period_cycles - duty_cycles;
> 
> Huh, this looks wrong. Your hardware only supports the two polarities,
> right? Then configure inversed polarity if
> 
> 	wf->duty_length_ns && wf->duty_offset_ns && wf->duty_length_ns + wf->duty_offset_ns >= wf->period_length_ns
> 
> (i.e. how the pwm-stm32 driver does it).

OK, will fix

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
>> +            "Requested: period {}ns, duty {}ns, offset {}ns -> HW: period {} cyc, duty {} cyc, ctrl 0x{:x}\n",
> 
> Would it be helpful to also emit the clkrate here?

OK will update

> 
>> +            wf.period_length_ns,
>> +            wf.duty_length_ns,
>> +            wf.duty_offset_ns,
>> +            wfhw.period_cycles,
>> +            wfhw.duty_cycles,
>> +            wfhw.ctrl_val
>> +        );
>> +
>> +        Ok((0, wfhw))
>> +    }
>> +
>> +    fn round_waveform_fromhw(
>> +        chip: &pwm::Chip,
>> +        _pwm: &pwm::Device,
>> +        wfhw: &Self::WfHw,
>> +        wf: &mut pwm::Waveform,
>> +    ) -> Result<c_int> {
>> +        let data: &Self = chip.drvdata();
>> +        let rate_hz = data.clk.rate().as_hz() as u64;
>> +
>> +        wf.period_length_ns = cycles_to_ns(wfhw.period_cycles as u64, rate_hz);
>> +
>> +        let duty_cycles = wfhw.duty_cycles as u64;
>> +
>> +        if (wfhw.ctrl_val & PWM_FPOUT) != 0 {
>> +            wf.duty_length_ns = cycles_to_ns(duty_cycles, rate_hz);
>> +            wf.duty_offset_ns = 0;
>> +        } else {
>> +            let period_cycles = wfhw.period_cycles as u64;
>> +            let original_duty_cycles = period_cycles.saturating_sub(duty_cycles);
>> +
>> +            wf.duty_length_ns = cycles_to_ns(original_duty_cycles, rate_hz);
>> +            // We can't recover the original non-zero offset, so we just set it
>> +            // to a representative non-zero value.
>> +            wf.duty_offset_ns = 1;
> 
> For an inversed polarity signal the duty_offset is polarity - duty_cycle.

I believe there was a typo in your suggestion and you meant period
instead of polarity. Based on that, my understanding is that for an
inverted signal, the generic pwm_waveform struct expects duty_offset_ns
to represent the duration of the initial low time, while duty_length_ns
represents the high time.

so the code would look like this:
// For an inverted signal, `duty_length_ns` is the high time (period - low_time).
wf.duty_length_ns = cycles_to_ns(original_duty_cycles, rate_hz);
// The offset is the initial low time, which is what the hardware register provides.
wf.duty_offset_ns = cycles_to_ns(duty_cycles, rate_hz);


> 
>> +        }
>> +
>> +        Ok(0)
>> +    }
> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

