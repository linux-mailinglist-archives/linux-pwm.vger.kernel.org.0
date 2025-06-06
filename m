Return-Path: <linux-pwm+bounces-6253-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A7DAD03BB
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 16:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCA4189318C
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554A8289353;
	Fri,  6 Jun 2025 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OcDUG8+o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8C288C3A
	for <linux-pwm@vger.kernel.org>; Fri,  6 Jun 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749218899; cv=none; b=B8iI/R6PygCvByP0VVkwYKWwHw5lZXik7/i3EAquacyi/dVJN8GB/NozIjLkxRcUbd9yP0Jzgh/IdTSVUW6The6YlH0dnQuo5GSEDOsdwILe9yXLH/AmOXZLi06Wb7xtsKqz+CXd2ol7VJbRVPmRa7f0ITtrke6vT+KNJwHDaq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749218899; c=relaxed/simple;
	bh=wthOag1sm5nU4GXRcSPL17HJQFHnh+gJbmk4KahBEjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ctt0wzsvWdFPsl6Tfv5YmCyI9WH+z4cTX7qcGW3uWqjuyBVNVKX2X+VHP+mLQwswhI/JyTEM0ablQSgQm0VlG53yrZlm0oNZf1Am8QYWHGP6q6AbMtKPCAW0Rzpt45pmjFMGEppYi+THlLOfXJ76Eqx8FbhM90LTfsxHaweUM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OcDUG8+o; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250606140809euoutp0299bb50109d098e6511c6aa1747c1e11b~GeU-U7anl0971209712euoutp02Z
	for <linux-pwm@vger.kernel.org>; Fri,  6 Jun 2025 14:08:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250606140809euoutp0299bb50109d098e6511c6aa1747c1e11b~GeU-U7anl0971209712euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749218889;
	bh=bBhDO8zSdUXt9NYlkunjU4em2Hqfqu0XOindhBrcoTc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OcDUG8+oIpQoYcgz6PzSyiucceUr7OkxWSJFGw1xVsuPMIZA4GVtzcR4R40kAVapF
	 mcjdY/p+8DhvOvnQVQpSod96c/+HE5c90h6Lliy8cAZA07O8PmsKCSY7QQJhIJCGH7
	 dEhg4vi8UEuQR+gENWhHlBAnPlET672WYDjht+Po=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250606140808eucas1p155936501c7e0d1da1b2ba7d85e71a18a~GeU_tgXBa0375003750eucas1p1C;
	Fri,  6 Jun 2025 14:08:08 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250606140807eusmtip16476b184f66b219739281a59673e9ff8~GeU9qr1yA2361423614eusmtip1c;
	Fri,  6 Jun 2025 14:08:07 +0000 (GMT)
Message-ID: <b1c4792e-f997-4eba-a8ed-d2e3f76e3fdd@samsung.com>
Date: Fri, 6 Jun 2025 16:08:07 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/6] pwm: Add Rust driver for T-HEAD TH1520 SoC
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
	Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
	Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
	Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
	Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
	Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <q6dkihyfosi3k4mtrvyff54nbsjpovmujdbmoqhapo7daznpja@of2p5gtmcq2m>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250606140808eucas1p155936501c7e0d1da1b2ba7d85e71a18a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0
X-EPHeader: CA
X-CMS-RootMailID: 20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
	<CGME20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0@eucas1p1.samsung.com>
	<20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com>
	<q6dkihyfosi3k4mtrvyff54nbsjpovmujdbmoqhapo7daznpja@of2p5gtmcq2m>



On 6/5/25 12:39, Uwe Kleine-König wrote:
> Hello,
> 
> I don't speak Rust, so please double-check all my feedback if it really
> applies.

No problem, appreciate your time and experience with PWM subsystem !

> 
> On Sat, May 24, 2025 at 11:14:56PM +0200, Michal Wilczynski wrote:
>> Introduce a PWM driver for the T-HEAD TH1520 SoC written in Rust. It
>> utilizes the Rust PWM abstractions added in the previous commit.
>>
>> The driver implements the standard PwmOps for the PWM framework,
>> supporting configuration of period, duty cycle, and polarity for the
>> TH1520's PWM channels. It uses devm managed resources for the PWM chip
>> itself and Rust DevRes for I/O memory. Clock management is handled using
>> Rust's RAII pattern.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  MAINTAINERS               |   1 +
>>  drivers/pwm/Kconfig       |   6 +
>>  drivers/pwm/Makefile      |   1 +
>>  drivers/pwm/pwm_th1520.rs | 272 ++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 280 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2b080e8f3d873b1e401b3a2fe1207c224c4591fc..0cfac73aea65076c5ccb50a25ea686fb86b472b8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20986,6 +20986,7 @@ F:	drivers/mailbox/mailbox-th1520.c
>>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>>  F:	drivers/pinctrl/pinctrl-th1520.c
>>  F:	drivers/pmdomain/thead/
>> +F:	drivers/pwm/pwm_th1520.rs
>>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>>  F:	include/dt-bindings/power/thead,th1520-power.h
>>  F:	include/linux/firmware/thead/thead,th1520-aon.h
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index b5bd5c13b3a5e5a575a0fbfb2e285f5665b7a671..796fcd8343b7c8e30f62edc2e0fecf0e9b1ae20e 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -684,6 +684,12 @@ config PWM_TEGRA
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-tegra.
>>  
>> +config PWM_TH1520_RUST
>> +	tristate "TH1520 PWM support (Rust)"
>> +	depends on RUST_PWM_ABSTRACTIONS
>> +	help
>> +	  Generic PWM framework driver for TH1520 SoC.
>> +
>>  config PWM_TIECAP
>>  	tristate "ECAP PWM support"
>>  	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 539e0def3f82fcb866ab83a0346a15f7efdd7127..6890f860ada6f1a6ed43dd3a3a9584cd2fa877f3 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -70,3 +70,4 @@ obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>>  obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
>>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
>>  obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
>> +obj-$(CONFIG_PWM_TH1520_RUST)	+= pwm_th1520.o
>> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..4665e293e8d0bdc1a62a4e295cdaf4d47b3dd134
>> --- /dev/null
>> +++ b/drivers/pwm/pwm_th1520.rs
>> @@ -0,0 +1,272 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
>> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
>> +
>> +//! Rust T-HEAD TH1520 PWM driver
>> +use kernel::{c_str, clk::Clk, device, io::mem::IoMem, of, platform, prelude::*, pwm, time};
>> +
>> +const MAX_PWM_NUM: u32 = 6;
>> +
>> +const fn th1520_pwm_chn_base(n: u32) -> u32 {
>> +    n * 0x20
>> +}
>> +const fn th1520_pwm_ctrl(n: u32) -> u32 {
>> +    th1520_pwm_chn_base(n) + 0x00
>> +}
>> +const fn th1520_pwm_per(n: u32) -> u32 {
>> +    th1520_pwm_chn_base(n) + 0x08
>> +}
>> +const fn th1520_pwm_fp(n: u32) -> u32 {
>> +    th1520_pwm_chn_base(n) + 0x0c
>> +}
>> +
>> +const PWM_START: u32 = 1 << 0;
>> +const PWM_CFG_UPDATE: u32 = 1 << 2;
>> +const PWM_CONTINUOUS_MODE: u32 = 1 << 5;
>> +const PWM_FPOUT: u32 = 1 << 8;
>> +const PWM_INFACTOUT: u32 = 1 << 9;
>> +
>> +struct Th1520PwmChipData {
>> +    clk: Clk,
>> +    iomem: kernel::devres::Devres<IoMem<0>>,
>> +}
>> +
>> +impl Th1520PwmChipData {
>> +    fn _config(
>> +        &self,
>> +        hwpwm: u32,
>> +        duty_ns: u64,
>> +        period_ns: u64,
>> +        target_polarity: pwm::Polarity,
> 
> Why "target_polarity"? duty_ns and period_ns also don't contain
> "target_"?

You're right, that was an inconsistent name. I've since re-worked the
driver to use the modern waveform API as you suggested in the other
thread. In the new version, this function no longer exists, and the new
round_waveform_tohw op takes a &pwm::Waveform parameter, which resolves
this naming issue. Thank you for pointing it out.

> 
>> +    ) -> Result<u32> {
>> +        let regs = self.iomem.try_access().ok_or_else(|| {
>> +            pr_err!("PWM-{}: Failed to access I/O memory in _config\n", hwpwm);
>> +            EBUSY
>> +        })?;
>> +
>> +        // Calculate cycle values
>> +        let rate_hz_u64 = self.clk.rate().as_hz() as u64;
>> +
>> +        if duty_ns > period_ns {
>> +            pr_err!(
>> +                "PWM-{}: Duty {}ns > period {}ns\n",
>> +                hwpwm,
>> +                duty_ns,
>> +                period_ns
>> +            );
>> +            return Err(EINVAL);
>> +        }
>> +        if period_ns == 0 {
>> +            pr_err!("PWM-{}: Period is zero\n", hwpwm);
>> +            return Err(EINVAL);
>> +        }
> 
> You don't need to check for period_ns == 0 explicitly. This case then
> hits period_cycle == 0 below.
> 
>> +
>> +        let mut period_cycle = mul_div_u64(period_ns, rate_hz_u64, time::NSEC_PER_SEC as u64);
> 
> if period_ns is big and rate_hz_u64 > NSEC_PER_SEC this might overflow.
> 
> Typically refuse to probe if rate_hz_u64 > NSEC_PER_SEC and call
> clk_rate_exclusive_get().
> 
>> +        if period_cycle > u32::MAX as u64 {
>> +            period_cycle = u32::MAX as u64;
>> +        }
>> +        if period_cycle == 0 {
>> +            pr_err!(
>> +                "PWM-{}: Calculated period_cycle is zero, not allowed by HW\n",
>> +                hwpwm
>> +            );
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        let mut duty_cycle = mul_div_u64(duty_ns, rate_hz_u64, time::NSEC_PER_SEC as u64);
>> +        if duty_cycle > u32::MAX as u64 {
>> +            duty_cycle = u32::MAX as u64;
>> +        }
>> +
>> +        let mut base_ctrl_val = PWM_INFACTOUT | PWM_CONTINUOUS_MODE;
>> +        if target_polarity == pwm::Polarity::Normal {
>> +            // FPOUT=1 for Normal
>> +            base_ctrl_val |= PWM_FPOUT;
>> +        } else {
>> +            // Inversed, FPOUT=0
>> +            base_ctrl_val &= !PWM_FPOUT;
>> +        }
>> +        regs.try_write32(base_ctrl_val, th1520_pwm_ctrl(hwpwm) as usize)?;
>> +        pr_debug!(
>> +            "PWM-{}: _config: Initial CTRL write (polarity, mode): 0x{:x}\n",
>> +            hwpwm,
>> +            base_ctrl_val
>> +        );
>> +
>> +        // Write period and duty registers
>> +        regs.try_write32(period_cycle as u32, th1520_pwm_per(hwpwm) as usize)?;
>> +        regs.try_write32(duty_cycle as u32, th1520_pwm_fp(hwpwm) as usize)?;
>> +        pr_debug!(
>> +            "PWM-{}: _config: Period_cyc={}, Duty_cyc={}\n",
>> +            hwpwm,
>> +            period_cycle,
>> +            duty_cycle
>> +        );
>> +
>> +        // Apply period/duty by toggling CFG_UPDATE from 0 to 1.
>> +        // The `base_ctrl_val` (just written to HW) has CFG_UPDATE=0. Now set it.
>> +        let ctrl_val_for_update = base_ctrl_val | PWM_CFG_UPDATE;
>> +        regs.try_write32(ctrl_val_for_update, th1520_pwm_ctrl(hwpwm) as usize)?;
>> +        pr_debug!(
>> +            "PWM-{}: _config: CTRL write with CFG_UPDATE: 0x{:x}\n",
>> +            hwpwm,
>> +            ctrl_val_for_update
>> +        );
>> +
>> +        Ok(ctrl_val_for_update)
>> +    }
>> +
>> +    fn _enable(&self, hwpwm: u32, ctrl_val_after_config: u32) -> Result {
>> +        let regs = self.iomem.try_access().ok_or_else(|| {
>> +            pr_err!("PWM-{}: Failed to access I/O memory in _enable\n", hwpwm);
>> +            EBUSY
>> +        })?;
>> +
>> +        // ctrl_val_after_config already has mode, polarity, and CFG_UPDATE correctly set.
>> +        // Now add the START bit. START bit auto-clears.
>> +        let ctrl_to_start = ctrl_val_after_config | PWM_START;
>> +        regs.try_write32(ctrl_to_start, th1520_pwm_ctrl(hwpwm) as usize)?;
>> +        pr_debug!(
>> +            "PWM-{}: _enable: CTRL write with START: 0x{:x}\n",
>> +            hwpwm,
>> +            ctrl_to_start
>> +        );
>> +        Ok(())
>> +    }
>> +
>> +    fn _disable(&self, hwpwm: u32) -> Result<()> {
>> +        let regs = self.iomem.try_access().ok_or_else(|| {
>> +            pr_err!("PWM-{}: Failed to access I/O memory in _disable\n", hwpwm);
>> +            EINVAL
>> +        })?;
>> +
>> +        let mut ctrl_val = regs.try_read32(th1520_pwm_ctrl(hwpwm) as usize)?;
>> +        pr_debug!("PWM-{}: _disable: Read CTRL: 0x{:x}\n", hwpwm, ctrl_val);
>> +
>> +        // Ensure CFG_UPDATE is 0 before updating duty (Limitation #4)
>> +        if (ctrl_val & PWM_CFG_UPDATE) != 0 {
>> +            ctrl_val &= !PWM_CFG_UPDATE;
>> +            regs.try_write32(ctrl_val, th1520_pwm_ctrl(hwpwm) as usize)?;
>> +            pr_debug!(
>> +                "PWM-{}: _disable: Cleared CFG_UPDATE, wrote CTRL: 0x{:x}\n",
>> +                hwpwm,
>> +                ctrl_val
>> +            );
>> +        }
>> +
>> +        // Set duty cycle to 0
>> +        regs.try_write32(0, th1520_pwm_fp(hwpwm) as usize)?;
>> +        pr_debug!("PWM-{}: _disable: Wrote 0 to DUTY (FP) register\n", hwpwm);
>> +
>> +        // Apply the 0% duty by toggling CFG_UPDATE from 0 to 1
>> +        // Use the ctrl_val that has CFG_UPDATE cleared (or was already clear)
>> +        ctrl_val |= PWM_CFG_UPDATE;
>> +        regs.try_write32(ctrl_val, th1520_pwm_ctrl(hwpwm) as usize)?;
>> +        pr_debug!(
>> +            "PWM-{}: _disable: Set CFG_UPDATE, wrote CTRL: 0x{:x}\n",
>> +            hwpwm,
>> +            ctrl_val
>> +        );
>> +
>> +        Ok(())
>> +    }
>> +}
>> +
>> +impl pwm::PwmOps for Th1520PwmChipData {
>> +    // This driver implements get_state
> 
> I don't spot the get_state implementation?!

That's a good catch, thank you. You are correct, the comment was ahead
of the implementation in this RFC version. My intention was to keep the
initial patch focused. I have now added the full get_state
implementation for v2.

> 
>> +    fn apply(
>> +        pwm_chip_ref: &mut pwm::Chip,
>> +        pwm_dev: &mut pwm::Device,
>> +        target_state: &pwm::State,
> 
> In C code I like these variables be called "chip", "pwm" and "state"
> respectively. Is that possible here, too?

Absolutely. That makes sense for consistency with the C codebase. In the
new waveform based version, I've ensured the PwmOps parameters are named
simply chip, pwm to align with standard practice.

> 
>> +    ) -> Result {
>> +        let data: &Th1520PwmChipData = pwm_chip_ref.get_drvdata().ok_or(EINVAL)?;
>> +        let hwpwm = pwm_dev.hwpwm();
>> +
>> +        if !target_state.enabled() {
>> +            if pwm_dev.state().enabled() {
>> +                data._disable(hwpwm)?;
>> +            }
>> +
>> +            return Ok(());
>> +        }
>> +
>> +        // Configure period, duty, and polarity.
>> +        // This function also latches period/duty with CFG_UPDATE.
>> +        // It returns the control value that was written with CFG_UPDATE set.
>> +        let ctrl_val_after_config = data._config(
>> +            hwpwm,
>> +            target_state.duty_cycle(),
>> +            target_state.period(),
>> +            target_state.polarity(),
>> +        )?;
>> +
>> +        // Enable by setting START bit if it wasn't enabled before this apply call
>> +        if !pwm_dev.state().enabled() {
>> +            data._enable(hwpwm, ctrl_val_after_config)?;
>> +        }
>> +
>> +        Ok(())
>> +    }
>> +}
>> +
>> +impl Drop for Th1520PwmChipData {
>> +    fn drop(&mut self) {
>> +        self.clk.disable_unprepare();
>> +    }
>> +}
>> +
>> +fn mul_div_u64(a: u64, b: u64, c: u64) -> u64 {
>> +    if c == 0 {
>> +        return 0;
>> +    }
>> +    a.wrapping_mul(b) / c
>> +}
> 
> Is this save if a * b > U64_MAX? I would have expected such a function
> to already exist in generic code.

You're right, thank you. The wrapping_mul is unsafe due to the overflow
risk you pointed out.

The ideal solution would be to use the kernel's own mul_u64_u64_div_u64
helper function.

Rust maintainers: This binding doesn't seem to be available yet. Would a
preparatory patch introducing a minimal rust/kernel/math.rs with  only
this binding be the best way to proceed? It seems like a useful utility
for more than just this driver.

> 
>> +static TH1520_PWM_OPS: pwm::PwmOpsVTable = pwm::create_pwm_ops::<Th1520PwmChipData>();
>> +
>> +struct Th1520PwmPlatformDriver;
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
>> +        pdev: &platform::Device<device::Core>,
>> +        _id_info: Option<&Self::IdInfo>,
>> +    ) -> Result<Pin<KBox<Self>>> {
>> +        let resource = pdev.resource(0).ok_or(ENODEV)?;
>> +        let iomem = pdev.ioremap_resource(&resource)?;
>> +
>> +        let clk = Clk::get(pdev.as_ref(), None)?;
>> +
>> +        clk.prepare_enable()?;
> 
> Is there something like devm_clk_get_enabled() such that the drop
> function becomes redundant?

I've reviewed the current clk.rs abstractions that were recently merged,
and while they provide Clk::get() (which is refcounted), a combined
devm_clk_get_enabled() doesn't exist yet. Because of this, the driver
must manually call enable and disable. I've achieved it through Rust
RAII.

> 
>> +        let driver_data = KBox::new(Th1520PwmChipData { clk, iomem }, GFP_KERNEL)?;
>> +        let pwm_chip = pwm::devm_chip_alloc(pdev.as_ref(), MAX_PWM_NUM, 0)?;
>> +
>> +        let result = pwm::devm_chip_add(pdev.as_ref(), pwm_chip, &TH1520_PWM_OPS);
>> +        if result.is_err() {
>> +            pr_err!("Failed to add PWM chip: {:?}\n", result);
>> +            return Err(EIO);
>> +        }
>> +
>> +        pwm_chip.set_drvdata(driver_data);
>> +        pr_info!("T-HEAD TH1520 PWM probed correctly\n");
> 
> Please degrade to pr_debug. Each driver emitting a message is an
> annoyance.
> 
>> +        Ok(KBox::new(Self, GFP_KERNEL)?.into())
>> +    }
>> +}
>> +
>> +kernel::module_platform_driver! {
>> +    type: Th1520PwmPlatformDriver,
>> +    name: "pwm_th1520",
>> +    author: "Michal Wilczynski",
>> +    description: "T-HEAD TH1520 PWM driver",
>> +    license: "GPL v2",
>> +}
> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

