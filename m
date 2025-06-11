Return-Path: <linux-pwm+bounces-6289-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86225AD4C2C
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 08:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947497A5BC3
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 06:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB022CBE3;
	Wed, 11 Jun 2025 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvAxdRGG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F836213E61;
	Wed, 11 Jun 2025 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625140; cv=none; b=SI63yWbkQmFKjb9MFThk1TU56NZxuvNjLSW7JHlh8MtKr0lJumQHRtRD2RcC+KN68LvBlnayH9Ayn57zP0ariyFswAbqrKdBnBCzX92T1MyzlnNAGeN+PO6ZMC2/KF0P7YWHoFT7SD0wF9rrwZrRLAJKhWTa7qyheipTHN5SgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625140; c=relaxed/simple;
	bh=sJDBY2Xw6Hliqp3t48rqVOdO6+RsGFDMbRDbDObTC3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z58mOC/KSNqr9jup00oTI+aBIC7X2z4RRIn02Y9zBjU/2UhOFp/PNb7HM1nQYgCHSyxR1dWw6UXbZHMzwQXudfZgcLhVosRD1M/Q3YOnstiC2JNju8oCtDVkwrY2T7OMij3cT4D1R6ZUCr4Dn3E2LiotKSSHmIssPneDSeAsLx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvAxdRGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B218C4CEEE;
	Wed, 11 Jun 2025 06:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749625139;
	bh=sJDBY2Xw6Hliqp3t48rqVOdO6+RsGFDMbRDbDObTC3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvAxdRGGN2NTTKtKNMyR7p6xwM6iutE4YqnfVWBo4GzSU9wnaz/OLfpc9ht79WIkq
	 XelBGspDDBQiSAMpKRyG8bAooEhHM/Qz9YGXhGzE91Edme4HCCnGF1mpWFHizhwI8k
	 Pc5QGRSVShWZRofrMXoPNJ0os4nOSEQurgv6Mxsksfbb25igay7vLSFU35YM/sDY90
	 AcIk/DIHcA7pRGiczr3hKT8ZtPTDBH4M7JlaO0YPWjjzxdzu9S3phTqDmrRlh/U+4N
	 X2n3UyY8ON2V66gZlOpdtEgcx7piz901vuabKzcTGrYZNPmH+BOK2Wv2MpAfznzxCQ
	 Bc+JUwZGmGDLw==
Date: Wed, 11 Jun 2025 08:58:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
Message-ID: <jbm3qvowi5vskhnjyqlp3xek36gzzqjt35m66eayxi6lmi525t@iefevopxjl53>
References: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
 <CGME20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d@eucas1p1.samsung.com>
 <20250610-rust-next-pwm-working-fan-for-sending-v2-2-753e2955f110@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bmffslcvo3pn5qxg"
Content-Disposition: inline
In-Reply-To: <20250610-rust-next-pwm-working-fan-for-sending-v2-2-753e2955f110@samsung.com>


--bmffslcvo3pn5qxg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
MIME-Version: 1.0

Hello,

On Tue, Jun 10, 2025 at 02:52:50PM +0200, Michal Wilczynski wrote:
> Introduce a PWM driver for the T-HEAD TH1520 SoC, written in Rust and
> utilizing the safe PWM abstractions from the preceding commit.
>=20
> The driver implements the pwm::PwmOps trait using the modern waveform
> API (round_waveform_tohw, write_waveform, etc.) to support configuration
> of period, duty cycle, and polarity for the TH1520's PWM channels.
>=20
> Resource management is handled using idiomatic Rust patterns. The PWM
> chip object is allocated via pwm::Chip::new and its registration with
> the PWM core is managed by the pwm::Registration RAII guard. This
> ensures pwmchip_remove is always called when the driver unbinds,
> preventing resource leaks. Device managed resources are used for the
> MMIO region, and the clock lifecycle is correctly managed in the
> driver's private data Drop implementation.
>=20
> The driver's core logic is written entirely in safe Rust, with no unsafe
> blocks.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm_th1520.rs | 287 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 299 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5589c0d2253bcb04e78d7b89ef6ef0ed41121d77..966ce515c8bfefdff1975bb71=
6a267435ec0feae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21319,6 +21319,7 @@ F:	drivers/mailbox/mailbox-th1520.c
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>  F:	drivers/pinctrl/pinctrl-th1520.c
>  F:	drivers/pmdomain/thead/
> +F:	drivers/pwm/pwm_th1520.rs
>  F:	drivers/reset/reset-th1520.c
>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>  F:	include/dt-bindings/power/thead,th1520-power.h
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 03c5a100a03e2acdccf8a46b9c70b736b630bd3a..be05658a568cb9156ef623caf=
54ff1aaba898d01 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -719,6 +719,16 @@ config PWM_TEGRA
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-tegra.
> =20
> +config PWM_TH1520_RUST

Is "_RUST" relevant here? I'd drop that.

> +	tristate "TH1520 PWM support (Rust)"

Also while having drivers is rust is a great step forward, it's not
relevant to the user selecting support for the TH1520 device.

> +	depends on RUST_PWM_ABSTRACTIONS
> +	help
> +	  This option enables the driver for the PWM controller found on the
> +	  T-HEAD TH1520 SoC. This driver is written in Rust.
> +
> +	  To compile this driver as a module, choose M here; the module
> +	  will be called pwm-th1520. If you are unsure, say N.
> +
>  config PWM_TIECAP
>  	tristate "ECAP PWM support"
>  	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARC=
H_K3 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 96160f4257fcb0e0951581af0090615c0edf5260..d41b1940df903ba2036d8e3ed=
93efcd66834b7ab 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -73,3 +73,4 @@ obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VISCONTI)	+=3D pwm-visconti.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
>  obj-$(CONFIG_PWM_XILINX)	+=3D pwm-xilinx.o
> +obj-$(CONFIG_PWM_TH1520_RUST)	+=3D pwm_th1520.o

Alphabetic ordering please

> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..9e43474f5123b51c49035d712=
19303a606c20a5a
> --- /dev/null
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
> +
> +//! Rust T-HEAD TH1520 PWM driver

A short paragraph describing the hardware limitations of that driver
here would be nice. While you probably cannot stick to the exact format
used in newer C drivers such that

	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c

emits the info for your driver, I'd appreciate you sticking to mostly
this format.

> +use core::ops::Deref;
> +use kernel::{
> +    c_str,
> +    clk::Clk,
> +    device::{Bound, Core, Device},
> +    devres,
> +    error::{code::*, Result},
> +    io::mem::IoMem,
> +    math::KernelMathExt,
> +    of, platform,
> +    prelude::*,
> +    pwm, time,
> +};
> +
> +const MAX_PWM_NUM: u32 =3D 6;
> +
> +// Register offsets
> +const fn th1520_pwm_chn_base(n: u32) -> usize {
> +    (n * 0x20) as usize
> +}

empty line here between these functions?

> +const fn th1520_pwm_ctrl(n: u32) -> usize {
> +    th1520_pwm_chn_base(n)
> +}
> +const fn th1520_pwm_per(n: u32) -> usize {
> +    th1520_pwm_chn_base(n) + 0x08
> +}
> +const fn th1520_pwm_fp(n: u32) -> usize {
> +    th1520_pwm_chn_base(n) + 0x0c
> +}
> +
> +// Control register bits
> +const PWM_START: u32 =3D 1 << 0;
> +const PWM_CFG_UPDATE: u32 =3D 1 << 2;
> +const PWM_CONTINUOUS_MODE: u32 =3D 1 << 5;
> +const PWM_FPOUT: u32 =3D 1 << 8;
> +
> +const TH1520_PWM_REG_SIZE: usize =3D 0xB0;
> +
> +/// Hardware-specific waveform representation for TH1520.

Some comments use 2 and other 3 slashes. Does this have any semantic?

> +#[derive(Copy, Clone, Debug, Default)]
> +struct Th1520WfHw {
> +    period_cycles: u32,
> +    duty_cycles: u32,
> +    ctrl_val: u32,
> +    enabled: bool,
> +}
> +
> +/// The driver's private data struct. It holds all necessary devres-mana=
ged resources.
> +struct Th1520PwmDriverData {
> +    iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
> +    clk: Clk,
> +}
> +
> +impl pwm::PwmOps for Th1520PwmDriverData {
> +    type WfHw =3D Th1520WfHw;
> +
> +    fn get_state(
> +        chip: &mut pwm::Chip,
> +        pwm: &mut pwm::Device,
> +        state: &mut pwm::State,
> +        parent_dev: &Device<Bound>,
> +    ) -> Result {

Huh, if you do the newstyle stuff, .get_state() is wrong. It's either
=2Eround_waveform_tohw() + .round_waveform_fromhw() + .read_waveform() +
=2Ewrite_waveform() or .apply() + .get_state(), but don't mix these.

> +        let data: &Self =3D chip.drvdata().ok_or(EINVAL)?;
> +        let hwpwm =3D pwm.hwpwm();
> +        let iomem_guard =3D data.iomem.access(parent_dev)?;
> +        let iomap =3D iomem_guard.deref();
> +        let ctrl =3D iomap.read32(th1520_pwm_ctrl(hwpwm));
> +        let period_cycles =3D iomap.read32(th1520_pwm_per(hwpwm));
> +        let duty_cycles =3D iomap.read32(th1520_pwm_fp(hwpwm));
> +
> +        state.set_enabled(duty_cycles !=3D 0);
> +
> +        let rate_hz =3D data.clk.rate().as_hz();
> +        let period_ns =3D (period_cycles as u64)
> +            .mul_div(time::NSEC_PER_SEC as u64, rate_hz as u64)
> +            .unwrap_or(0);

What does .unwrap_or(0) do? You need to round up in this mul_div
operation.

> +        state.set_period(period_ns);
> +
> +        let duty_ns =3D (duty_cycles as u64)
> +            .mul_div(time::NSEC_PER_SEC as u64, rate_hz as u64)
> +            .unwrap_or(0);
> +        state.set_duty_cycle(duty_ns);
> +
> +        if (ctrl & PWM_FPOUT) !=3D 0 {
> +            state.set_polarity(pwm::Polarity::Normal);
> +        } else {
> +            state.set_polarity(pwm::Polarity::Inversed);
> +        }
> +
> +        Ok(())
> +    }
> +
> +    fn round_waveform_tohw(
> +        chip: &mut pwm::Chip,
> +        pwm: &mut pwm::Device,
> +        wf: &pwm::Waveform,
> +    ) -> Result<(i32, Self::WfHw)> {
> +        let data: &Self =3D chip.drvdata().ok_or(EINVAL)?;
> +        let hwpwm =3D pwm.hwpwm();
> +
> +        if wf.duty_offset_ns !=3D 0 {
> +            dev_err!(chip.device(), "PWM-{}: Duty offset not supported\n=
", hwpwm);

That's wrong, pick the biggest offset value that is possible to
implement and not bigger than the requested value.
Your hardware can do inversed polarity, so offset is either 0 or
period-duty.

> +            return Err(ENOTSUPP);
> +        }
> +
> +        if wf.period_length_ns =3D=3D 0 {
> +            return Ok((
> +                0,
> +                Th1520WfHw {
> +                    enabled: false,
> +                    ..Default::default()
> +                },
> +            ));
> +        }
> +
> +        let rate_hz =3D data.clk.rate().as_hz();
> +
> +        let period_cycles =3D wf
> +            .period_length_ns
> +            .mul_div(rate_hz as u64, time::NSEC_PER_SEC as u64)
> +            .ok_or(EINVAL)?;

If period_length_ns is BIG, pick the biggest possible period_cycles
value, not EINVAL.

> +        if period_cycles > u32::MAX as u64 {
> +            dev_err!(
> +                chip.device(),
> +                "PWM-{}: Calculated period {} cycles is out of range\n",
> +                hwpwm,
> +                period_cycles
> +            );
> +            return Err(EINVAL);
> +        }

ditto.

> +        let duty_cycles =3D wf
> +            .duty_length_ns
> +            .mul_div(rate_hz as u64, time::NSEC_PER_SEC as u64)
> +            .ok_or(EINVAL)?;
> +        if duty_cycles > period_cycles {

You can assume this won't happen.

> +            dev_err!(
> +                chip.device(),
> +                "PWM-{}: Duty {}ns > period {}ns\n",
> +                hwpwm,
> +                wf.duty_length_ns,
> +                wf.period_length_ns
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let mut ctrl_val =3D PWM_CONTINUOUS_MODE;
> +        if pwm.state().polarity() =3D=3D pwm::Polarity::Normal {
> +            ctrl_val |=3D PWM_FPOUT;

What is pwm.state()? If that's similar to pwm->state in C this is
irrelevant here. It describes the current state, not the new request.

> +        }
> +
> +        let wfhw =3D Th1520WfHw {
> +            period_cycles: period_cycles as u32,
> +            duty_cycles: duty_cycles as u32,
> +            ctrl_val,
> +            enabled: true,
> +        };
> +
> +        dev_dbg!(
> +            chip.device(),
> +            "wfhw -- Period: {}, Duty: {}, Ctrl: 0x{:x}\n",
> +            wfhw.period_cycles,
> +            wfhw.duty_cycles,
> +            wfhw.ctrl_val
> +        );

This would be much more helpful if it also contained the values from wf.

> +        Ok((0, wfhw))
> +    }
> +
> +    fn write_waveform(
> +        chip: &mut pwm::Chip,
> +        pwm: &mut pwm::Device,
> +        wfhw: &Self::WfHw,
> +        parent_dev: &Device<Bound>,
> +    ) -> Result {
> +        let data: &Self =3D chip.drvdata().ok_or(EINVAL)?;
> +        let hwpwm =3D pwm.hwpwm();
> +        let iomem_guard =3D data.iomem.access(parent_dev)?;
> +        let iomap =3D iomem_guard.deref();
> +        let was_enabled =3D pwm.state().enabled();
> +
> +        if !wfhw.enabled {
> +            if was_enabled {
> +                let mut ctrl =3D iomap.read32(th1520_pwm_ctrl(hwpwm));

Do you need that read? Isn't is clear what the value is?

> +                ctrl &=3D !PWM_CFG_UPDATE;
> +
> +                iomap.write32(ctrl, th1520_pwm_ctrl(hwpwm));
> +                iomap.write32(0, th1520_pwm_fp(hwpwm));
> +                iomap.write32(ctrl | PWM_CFG_UPDATE, th1520_pwm_ctrl(hwp=
wm));
> +            }
> +            return Ok(());
> +        }
> +
> +        let ctrl =3D wfhw.ctrl_val & !PWM_CFG_UPDATE;

wfhw.ctrl_val never has PWM_CFG_UPDATE set.

> +        iomap.write32(ctrl, th1520_pwm_ctrl(hwpwm));
> +        iomap.write32(wfhw.period_cycles, th1520_pwm_per(hwpwm));
> +        iomap.write32(wfhw.duty_cycles, th1520_pwm_fp(hwpwm));
> +        iomap.write32(wfhw.ctrl_val | PWM_CFG_UPDATE, th1520_pwm_ctrl(hw=
pwm));
> +
> +        if !was_enabled {
> +            iomap.write32(wfhw.ctrl_val | PWM_START, th1520_pwm_ctrl(hwp=
wm));

Can this be combined with the above write?

> +        }
> +
> +        Ok(())
> +    }
> +}
> +
> +impl Drop for Th1520PwmDriverData {
> +    fn drop(&mut self) {
> +        self.clk.disable_unprepare();
> +    }
> +}
> +
> +static TH1520_PWM_OPS: pwm::PwmOpsVTable =3D pwm::create_pwm_ops::<Th152=
0PwmDriverData>();
> +
> +struct Th1520PwmPlatformDriver {
> +    _registration: pwm::Registration,
> +}
> +
> +kernel::of_device_table!(
> +    OF_TABLE,
> +    MODULE_OF_TABLE,
> +    <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
> +    [(of::DeviceId::new(c_str!("thead,th1520-pwm")), ())]
> +);
> +
> +impl platform::Driver for Th1520PwmPlatformDriver {
> +    type IdInfo =3D ();
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(&OF_TA=
BLE);
> +
> +    fn probe(
> +        pdev: &platform::Device<Core>,
> +        _id_info: Option<&Self::IdInfo>,
> +    ) -> Result<Pin<KBox<Self>>> {
> +        let dev =3D pdev.as_ref();
> +        let resource =3D pdev.resource(0).ok_or(ENODEV)?;
> +        let iomem =3D pdev.ioremap_resource_sized::<TH1520_PWM_REG_SIZE>=
(resource)?;
> +        let clk =3D Clk::get(pdev.as_ref(), None)?;
> +
> +        clk.prepare_enable()?;

We don't have clk_rate_get_exclusive() yet, right? Then please add a
comment here that this needs to be added here when it became available.

> +
> +        let rate_hz =3D clk.rate().as_hz();
> +        if rate_hz =3D=3D 0 {
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
> +        let chip =3D pwm::Chip::new(dev, MAX_PWM_NUM, 0)?;
> +
> +        let drvdata =3D KBox::new(Th1520PwmDriverData { iomem, clk }, GF=
P_KERNEL)?;
> +        chip.set_drvdata(drvdata);
> +
> +        let registration =3D pwm::Registration::new(chip, &TH1520_PWM_OP=
S)?;
> +
> +        Ok(KBox::new(
> +            Th1520PwmPlatformDriver {
> +                _registration: registration,
> +            },
> +            GFP_KERNEL,
> +        )?
> +        .into())
> +    }
> +}
> +
> +kernel::module_platform_driver! {
> +    type: Th1520PwmPlatformDriver,
> +    name: "pwm-th1520",
> +    author: "Michal Wilczynski <m.wilczynski@samsung.com>",
> +    description: "T-HEAD TH1520 PWM driver",
> +    license: "GPL v2",
> +}

Best regards
Uwe

--bmffslcvo3pn5qxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhJKS4ACgkQj4D7WH0S
/k58GggAlQhEWU5R75sFx/+BaRlgKiPO6z3G3YaIH0yDrVITXEkDtm3JsL9FKLTp
QTZMtIeDpvxnf7EwyRl+yJXNKnBdsPFTlL2rkmfD/i+hYqiiedXUz7hLamS2BSNq
rcqJ1wTfZ+u6t7DQyN2CtjAf8I0mFpjYBiFBrspJpqMTac8vgXpW/Vb1WQ6Fna8b
8lxY03sFNLN39urDVfK7VhpduYR8kklrwG5mc5jdaLJK6h4kMaY39xm5s6VhDseF
7rLA0p0CzP2pGxciHfmHN2liUyjGuLEokwdTPBRArHXkur3OcIDa13i09bEoIUHx
RkfG1phdXWwFJ8MGezox3G08lEaSCg==
=TuPQ
-----END PGP SIGNATURE-----

--bmffslcvo3pn5qxg--

