Return-Path: <linux-pwm+bounces-7126-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D098AB2E745
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 23:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD7B7270DD
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 21:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1BE30F548;
	Wed, 20 Aug 2025 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="nZllzt/H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7438F283CAA
	for <linux-pwm@vger.kernel.org>; Wed, 20 Aug 2025 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724471; cv=none; b=QJQAR92FD6uBw7jgzuJ21yLQNnEL35VE4aazyI9kJi+eoMMe0033ZS4iTR0oPTABdtWcBkETkr/3VRwAJFw0MdecoWbhi+q/Hzwalo1vXAHJbn2MQpLSGwCXb9qXBt5q5Hx+71Ui1uHy98NOazPLdLkIqVWQQOngXokGkYm7ckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724471; c=relaxed/simple;
	bh=UCpiYdhE44zqQgfzluIh3pXUDG69FJpgu/AGY2HRwLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK7dIcEHWUyMz9mTDhfoABhAt73pBSzUoE/oMxj9eYQvJFhA9AVsiVo+d7a2c0YF0z2/TZEyM0jB6NWwbsjYIj2EQ48fLaFpT8G4/uCHEZPPDUMOqpTxs9iGF955JjPwh1pTTg4xOLWwHdHeoGWVgkUZ6luEv8s+0+8vTbFHGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=nZllzt/H; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755724466; x=1755983666;
	bh=LqO3qxoM83u49DeYjlKifdoiEnHTmndCboMtRSkXb/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nZllzt/HWj2gTWynk4AYWGpv3FsLyZdfMT2Rysuii3OJahb54eoyWVTJ/Y2A0C8ni
	 5BqJQR1OPahpNkOeqllSMz6zsMov5gYNx9YRSrf5feQbNHIw8Qp/ebTIbHocF+A62V
	 Ade2hWe/MwJWrGSjqKvJiXAOnmP7N4KFW3asL7Wz1QxUOzQCylDP/jZLUuFHconjI8
	 4CwdD6DIYkU9efZYteyZSp13HQlJ01Tj3L6i+03kvKdF0aQ/p84lc93eJWrSzhJ+U2
	 CXu6ba3DRxrfjg1pqafuQMRPrlhtd/tQBQRIUK9lWImfPpcZ3cC5AGbXqWLkVNcKH7
	 zHg4H3AiZPDaQ==
X-Pm-Submission-Id: 4c6fMy30zYz2ScDC
Date: Wed, 20 Aug 2025 21:14:17 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Drew Fustini <fustini@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v14 4/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
Message-ID: <aKY6qa63SFZt7j8w@archiso>
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
 <CGME20250820083544eucas1p2be0157353ec1201b0651292792429aa4@eucas1p2.samsung.com>
 <20250820-rust-next-pwm-working-fan-for-sending-v14-4-df2191621429@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-rust-next-pwm-working-fan-for-sending-v14-4-df2191621429@samsung.com>

On Wed, Aug 20, 2025 at 10:35:39AM +0200, Michal Wilczynski wrote:
> Introduce a PWM driver for the T-HEAD TH1520 SoC, written in Rust and
> utilizing the safe PWM abstractions from the preceding commit.
> 
> The driver implements the pwm::PwmOps trait using the modern waveform
> API (round_waveform_tohw, write_waveform, etc.) to support configuration
> of period, duty cycle, and polarity for the TH1520's PWM channels.
> 
> Resource management is handled using idiomatic Rust patterns. The PWM
> chip object is allocated via pwm::Chip::new and its registration with
> the PWM core is managed by the pwm::Registration RAII guard. This
> ensures pwmchip_remove is always called when the driver unbinds,
> preventing resource leaks. Device managed resources are used for the
> MMIO region, and the clock lifecycle is correctly managed in the
> driver's private data Drop implementation.
> 
> The driver's core logic is written entirely in safe Rust, with no unsafe
> blocks, except for the Send and Sync implementations for the driver
> data, which are explained in the comments.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/pwm/Kconfig       |  11 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm_th1520.rs | 355 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 368 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d7c0676c1d00a02b3d7db2de88b039c08c99c6e..d79dc21f22d143ca8cde6a06194545fbc640e695 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21741,6 +21741,7 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>  F:	drivers/pinctrl/pinctrl-th1520.c
>  F:	drivers/pmdomain/thead/
>  F:	drivers/power/sequencing/pwrseq-thead-gpu.c
> +F:	drivers/pwm/pwm_th1520.rs
>  F:	drivers/reset/reset-th1520.c
>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>  F:	include/dt-bindings/power/thead,th1520-power.h
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 2b608f4378138775ee3ba4d53f682952e1914118..dd6db01832ee985e2e588a413a13df869a029d3d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -729,6 +729,17 @@ config PWM_TEGRA
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-tegra.
>  
> +config PWM_TH1520
> +	tristate "TH1520 PWM support"
> +	depends on RUST
> +	select RUST_PWM_ABSTRACTIONS
> +	help
> +	  This option enables the driver for the PWM controller found on the
> +	  T-HEAD TH1520 SoC.
> +
> +	  To compile this driver as a module, choose M here; the module
> +	  will be called pwm-th1520. If you are unsure, say N.
> +
>  config PWM_TIECAP
>  	tristate "ECAP PWM support"
>  	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ff4f47e5fb7a0dbac72c12de82c3773e5582db6d..5c15c95c6e49143969389198657eed0ecf4086b2 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
> +obj-$(CONFIG_PWM_TH1520)	+= pwm_th1520.o
>  obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
>  obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..5ef887b1b5dfed92c5d4b87a7d48f673352a257e
> --- /dev/null
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
> +
> +//! Rust T-HEAD TH1520 PWM driver
> +//!
> +//! Limitations:
> +//! - The period and duty cycle are controlled by 32-bit hardware registers,
> +//!   limiting the maximum resolution.
> +//! - The driver supports continuous output mode only; one-shot mode is not
> +//!   implemented.
> +//! - The controller hardware provides up to 6 PWM channels.
> +//! - Reconfiguration is glitch free - new period and duty cycle values are
> +//!   latched and take effect at the start of the next period.
> +//! - Polarity is handled via a simple hardware inversion bit; arbitrary
> +//!   duty cycle offsets are not supported.
> +//! - Disabling a channel is achieved by configuring its duty cycle to zero to
> +//!   produce a static low output. Clearing the `start` does not reliably
> +//!   force the static inactive level defined by the `INACTOUT` bit. Hence
> +//!   this method is not used in this driver.
> +//!
> +
> +use core::ops::Deref;
> +use kernel::{
> +    c_str,
> +    clk::Clk,
> +    device::{Bound, Core, Device},
> +    devres,
> +    io::mem::IoMem,
> +    of, platform,
> +    prelude::*,
> +    pwm, time,
> +};
> +
> +const TH1520_MAX_PWM_NUM: u32 = 6;
> +
> +// Register offsets
> +const fn th1520_pwm_chn_base(n: u32) -> usize {
> +    (n * 0x20) as usize
> +}
> +
> +const fn th1520_pwm_ctrl(n: u32) -> usize {
> +    th1520_pwm_chn_base(n)
> +}
> +
> +const fn th1520_pwm_per(n: u32) -> usize {
> +    th1520_pwm_chn_base(n) + 0x08
> +}
> +
> +const fn th1520_pwm_fp(n: u32) -> usize {
> +    th1520_pwm_chn_base(n) + 0x0c
> +}
> +
> +// Control register bits
> +const TH1520_PWM_START: u32 = 1 << 0;
> +const TH1520_PWM_CFG_UPDATE: u32 = 1 << 2;
> +const TH1520_PWM_CONTINUOUS_MODE: u32 = 1 << 5;
> +const TH1520_PWM_FPOUT: u32 = 1 << 8;
> +
> +const TH1520_PWM_REG_SIZE: usize = 0xB0;
> +
> +fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
> +    const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
> +
> +    (match ns.checked_mul(rate_hz) {
> +        Some(product) => product,
> +        None => u64::MAX,
> +    }) / NSEC_PER_SEC_U64
> +}
> +
> +fn cycles_to_ns(cycles: u64, rate_hz: u64) -> u64 {
> +    const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
> +
> +    // Round up
> +    let Some(numerator) = cycles
> +        .checked_mul(NSEC_PER_SEC_U64)
> +        .and_then(|p| p.checked_add(rate_hz - 1))
> +    else {
> +        return u64::MAX;
> +    };
> +
> +    numerator / rate_hz
> +}
> +
> +/// Hardware-specific waveform representation for TH1520.
> +#[derive(Copy, Clone, Debug, Default)]
> +struct Th1520WfHw {
> +    period_cycles: u32,
> +    duty_cycles: u32,
> +    ctrl_val: u32,
> +    enabled: bool,
> +}
> +
> +/// The driver's private data struct. It holds all necessary devres managed resources.
> +#[pin_data(PinnedDrop)]
> +struct Th1520PwmDriverData {
> +    #[pin]
> +    iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
> +    clk: Clk,
> +}
> +
> +// This `unsafe` implementation is a temporary necessity because the underlying `kernel::clk::Clk`
> +// type does not yet expose `Send` and `Sync` implementations. This block should be removed
> +// as soon as the clock abstraction provides these guarantees directly.
> +// TODO: Remove those unsafe impl's when Clk will support them itself.
> +
> +// SAFETY: The `devres` framework requires the driver's private data to be `Send` and `Sync`.
> +// We can guarantee this because the PWM core synchronizes all callbacks, preventing concurrent
> +// access to the contained `iomem` and `clk` resources.
> +unsafe impl Send for Th1520PwmDriverData {}
> +
> +// SAFETY: The same reasoning applies as for `Send`. The PWM core's synchronization
> +// guarantees that it is safe for multiple threads to have shared access (`&self`)
> +// to the driver data during callbacks.
> +unsafe impl Sync for Th1520PwmDriverData {}
> +
> +impl pwm::PwmOps for Th1520PwmDriverData {
> +    type WfHw = Th1520WfHw;
> +
> +    fn round_waveform_tohw(
> +        chip: &pwm::Chip<Self>,
> +        _pwm: &pwm::Device,
> +        wf: &pwm::Waveform,
> +    ) -> Result<pwm::RoundedWaveform<Self::WfHw>> {
> +        let data = chip.drvdata();
> +
> +        if wf.period_length_ns == 0 {
> +            return Ok(pwm::RoundedWaveform {
> +                status: 0,
> +                hardware_waveform: Th1520WfHw {
> +                    enabled: false,
> +                    ..Default::default()
> +                },
> +            });
> +        }
> +
> +        let rate_hz = data.clk.rate().as_hz() as u64;
> +
> +        let period_cycles = ns_to_cycles(wf.period_length_ns, rate_hz).min(u64::from(u32::MAX));
> +        let mut duty_cycles = ns_to_cycles(wf.duty_length_ns, rate_hz).min(u64::from(u32::MAX));
> +
> +        let mut ctrl_val = TH1520_PWM_CONTINUOUS_MODE;
> +
> +        let is_inversed = wf.duty_length_ns > 0
> +            && wf.duty_offset_ns > 0
> +            && wf.duty_length_ns + wf.duty_offset_ns >= wf.period_length_ns;
> +        if is_inversed {
> +            duty_cycles = period_cycles - duty_cycles;
> +        } else {
> +            ctrl_val |= TH1520_PWM_FPOUT;
> +        }
> +
> +        let wfhw = Th1520WfHw {
> +            period_cycles: period_cycles as u32,
> +            duty_cycles: duty_cycles as u32,
> +            ctrl_val,
> +            enabled: true,
> +        };
> +
> +        dev_dbg!(
> +            chip.device(),
> +            "clk_rate: {}Hz Requested: period {}ns, duty {}ns, offset {}ns -> HW: period {} cyc, duty {} cyc, ctrl 0x{:x}\n",
> +            rate_hz,
> +            wf.period_length_ns,
> +            wf.duty_length_ns,
> +            wf.duty_offset_ns,
> +            wfhw.period_cycles,
> +            wfhw.duty_cycles,
> +            wfhw.ctrl_val
> +        );
> +
> +        Ok(pwm::RoundedWaveform {
> +            status: 0,
> +            hardware_waveform: wfhw,
> +        })
> +    }
> +
> +    fn round_waveform_fromhw(
> +        chip: &pwm::Chip<Self>,
> +        _pwm: &pwm::Device,
> +        wfhw: &Self::WfHw,
> +        wf: &mut pwm::Waveform,
> +    ) -> Result {
> +        let data = chip.drvdata();
> +        let rate_hz = data.clk.rate().as_hz() as u64;
> +
> +        wf.period_length_ns = cycles_to_ns(u64::from(wfhw.period_cycles), rate_hz);
> +
> +        let duty_cycles = u64::from(wfhw.duty_cycles);
> +
> +        if (wfhw.ctrl_val & TH1520_PWM_FPOUT) != 0 {
> +            wf.duty_length_ns = cycles_to_ns(duty_cycles, rate_hz);
> +            wf.duty_offset_ns = 0;
> +        } else {
> +            let period_cycles = u64::from(wfhw.period_cycles);
> +            let original_duty_cycles = period_cycles.saturating_sub(duty_cycles);
> +
> +            // For an inverted signal, `duty_length_ns` is the high time (period - low_time).
> +            wf.duty_length_ns = cycles_to_ns(original_duty_cycles, rate_hz);
> +            // The offset is the initial low time, which is what the hardware register provides.
> +            wf.duty_offset_ns = cycles_to_ns(duty_cycles, rate_hz);
> +        }
> +
> +        Ok(())
> +    }
> +
> +    fn read_waveform(
> +        chip: &pwm::Chip<Self>,
> +        pwm: &pwm::Device,
> +        parent_dev: &Device<Bound>,
> +    ) -> Result<Self::WfHw> {
> +        let data = chip.drvdata();
> +        let hwpwm = pwm.hwpwm();
> +        let iomem_accessor = data.iomem.access(parent_dev)?;
> +        let iomap = iomem_accessor.deref();
> +
> +        let ctrl = iomap.try_read32(th1520_pwm_ctrl(hwpwm))?;
> +        let period_cycles = iomap.try_read32(th1520_pwm_per(hwpwm))?;
> +        let duty_cycles = iomap.try_read32(th1520_pwm_fp(hwpwm))?;
> +
> +        let wfhw = Th1520WfHw {
> +            period_cycles,
> +            duty_cycles,
> +            ctrl_val: ctrl,
> +            enabled: duty_cycles != 0,
> +        };
> +
> +        dev_dbg!(
> +            chip.device(),
> +            "PWM-{}: read_waveform: Read hw state - period: {}, duty: {}, ctrl: 0x{:x}, enabled: {}",
> +            hwpwm,
> +            wfhw.period_cycles,
> +            wfhw.duty_cycles,
> +            wfhw.ctrl_val,
> +            wfhw.enabled
> +        );
> +
> +        Ok(wfhw)
> +    }
> +
> +    fn write_waveform(
> +        chip: &pwm::Chip<Self>,
> +        pwm: &pwm::Device,
> +        wfhw: &Self::WfHw,
> +        parent_dev: &Device<Bound>,
> +    ) -> Result {
> +        let data = chip.drvdata();
> +        let hwpwm = pwm.hwpwm();
> +        let iomem_accessor = data.iomem.access(parent_dev)?;
> +        let iomap = iomem_accessor.deref();
> +        let was_enabled = pwm.state().enabled();
> +
> +        if !wfhw.enabled {
> +            if was_enabled {
> +                iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
> +                iomap.try_write32(0, th1520_pwm_fp(hwpwm))?;
> +                iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
> +            }
> +            return Ok(());
> +        }
> +
> +        iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
> +        iomap.try_write32(wfhw.period_cycles, th1520_pwm_per(hwpwm))?;
> +        iomap.try_write32(wfhw.duty_cycles, th1520_pwm_fp(hwpwm))?;
> +        iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
> +
> +        // The `TH1520_PWM_START` bit must be written in a separate, final transaction, and
> +        // only when enabling the channel from a disabled state.
> +        if !was_enabled {
> +            iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_START, th1520_pwm_ctrl(hwpwm))?;
> +        }
> +
> +        dev_dbg!(
> +            chip.device(),
> +            "PWM-{}: Wrote (per: {}, duty: {})",
> +            hwpwm,
> +            wfhw.period_cycles,
> +            wfhw.duty_cycles,
> +        );
> +
> +        Ok(())
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for Th1520PwmDriverData {
> +    fn drop(self: Pin<&mut Self>) {
> +        self.clk.disable_unprepare();
> +    }
> +}
> +
> +struct Th1520PwmPlatformDriver;
> +
> +kernel::of_device_table!(
> +    OF_TABLE,
> +    MODULE_OF_TABLE,
> +    <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
> +    [(of::DeviceId::new(c_str!("thead,th1520-pwm")), ())]
> +);
> +
> +impl platform::Driver for Th1520PwmPlatformDriver {
> +    type IdInfo = ();
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
> +
> +    fn probe(
> +        pdev: &platform::Device<Core>,
> +        _id_info: Option<&Self::IdInfo>,
> +    ) -> Result<Pin<KBox<Self>>> {
> +        let dev = pdev.as_ref();
> +        let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
> +
> +        let clk = Clk::get(dev, None)?;
> +
> +        clk.prepare_enable()?;
> +
> +        // TODO: Get exclusive ownership of the clock to prevent rate changes.
> +        // The Rust equivalent of `clk_rate_exclusive_get()` is not yet available.
> +        // This should be updated once it is implemented.
> +        let rate_hz = clk.rate().as_hz();
> +        if rate_hz == 0 {
> +            dev_err!(dev, "Clock rate is zero\n");
> +            return Err(EINVAL);
> +        }
> +
> +        if rate_hz > time::NSEC_PER_SEC as usize {
> +            dev_err!(
> +                dev,
> +                "Clock rate {} Hz is too high, not supported.\n",
> +                rate_hz
> +            );
> +            return Err(ERANGE);
> +        }
> +
> +        let chip = pwm::Chip::new(
> +            dev,
> +            TH1520_MAX_PWM_NUM,
> +            try_pin_init!(Th1520PwmDriverData {
> +                iomem <- request.iomap_sized::<TH1520_PWM_REG_SIZE>(),
> +                clk <- clk,
> +            }),
> +        )?;
> +
> +        pwm::Registration::register(dev, chip)?;
> +
> +        Ok(KBox::new(Th1520PwmPlatformDriver, GFP_KERNEL)?.into())
> +    }
> +}
> +
> +kernel::module_platform_driver! {
> +    type: Th1520PwmPlatformDriver,
> +    name: "pwm-th1520",
> +    authors: ["Michal Wilczynski <m.wilczynski@samsung.com>"],
> +    description: "T-HEAD TH1520 PWM driver",
> +    license: "GPL v2",
> +}
> 
> -- 
> 2.34.1

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

