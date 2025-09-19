Return-Path: <linux-pwm+bounces-7332-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A8B881C7
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Sep 2025 09:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61251169E50
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Sep 2025 07:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EEC29BDA1;
	Fri, 19 Sep 2025 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4rptESW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184432AD24;
	Fri, 19 Sep 2025 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265811; cv=none; b=lI2Qkm/wIG7jfTEWldq9DsYz3929WSMINuVAS21Vo7DLgo/1MDWuHL+rmT781+Nx6oYdUzp6hGPWyBFDV3vDS7OEiND+Pya2N2n4SoxELo4LQ31hhocB0ZHvuargS5TAq20iJ10lR/n504i8CVGq3FvKuEs+r0y8VorA0oHTcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265811; c=relaxed/simple;
	bh=UN238o5/y4J5dcysXM/nOx7D7SlXXhWZAQZD1SbKS5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3oVLb+Gm6t9J5DsS59+6VUX3eCeDE7NSDNRIFkhivW4IKlgc7UyvXpDIIBkfG6pamC02Om8iSnMrtnbLCqJPV6DeQoIX29FTLPC6UIvw0aJCUHwZ6uXSz1tPHJoeMDlLMP0JmMmAYRhxsvLdrUpdQSlVJltdHmDsTd5StRvdgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4rptESW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C97C4CEF0;
	Fri, 19 Sep 2025 07:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758265810;
	bh=UN238o5/y4J5dcysXM/nOx7D7SlXXhWZAQZD1SbKS5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4rptESW8c1TJuIle/DO+v42SUIePmqwkH1ldDkMoiKtHMBytvKSjajtJiSb3nPN9
	 SZUiSzFpYmEbdQ2lDykSTMN3H4UtiT6wPc3qd2YIrmcHOadRszfLjUMPnrG8Z2+/oX
	 qmjqpky90EfNmOrqVK/9q7SDeetMtt1sPcTmdt+7ugCRTC+UzRe+CRllLBzfyyDAbq
	 mVWV/EiOiy5wMlkPusXi8GGTJalfO9ryCf5EcuT+Z6vGQmHh3zQcQGuWZHCO2uS5s9
	 pRC1AL2t0dBpSdT3jSU6cMer3lQDJdkYxmxVTXGVkVIjdzDpIwX46CGEiECd+9eb42
	 nmtCQhxgibHoA==
Date: Fri, 19 Sep 2025 09:10:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Benno Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Drew Fustini <fustini@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v14 4/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
Message-ID: <ca2ftwfducf4swuoondajiid642mctilh4lt3grgxpnup3nhag@tyuwyasfw4uj>
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
 <CGME20250820083544eucas1p2be0157353ec1201b0651292792429aa4@eucas1p2.samsung.com>
 <20250820-rust-next-pwm-working-fan-for-sending-v14-4-df2191621429@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uu7qwrkf63ilczbj"
Content-Disposition: inline
In-Reply-To: <20250820-rust-next-pwm-working-fan-for-sending-v14-4-df2191621429@samsung.com>


--uu7qwrkf63ilczbj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 4/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
MIME-Version: 1.0

Hello,

actually I intended to give my feedback as a patch, but I'm not fluent
enough in Rust yet :-\, so here come my thoughts in text only.

On Wed, Aug 20, 2025 at 10:35:39AM +0200, Michal Wilczynski wrote:
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
> blocks, except for the Send and Sync implementations for the driver
> data, which are explained in the comments.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/pwm/Kconfig       |  11 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm_th1520.rs | 355 ++++++++++++++++++++++++++++++++++++++++=
++++++

For consistency I would prefer this file to be named pwm-th1520.rs. I
tried to fix that but then the compiler was unhappy. I guess a minus in
a filename just doesn't work for Rust?

>  4 files changed, 368 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d7c0676c1d00a02b3d7db2de88b039c08c99c6e..d79dc21f22d143ca8cde6a061=
94545fbc640e695 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21741,6 +21741,7 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thea=
d.c
>  F:	drivers/pinctrl/pinctrl-th1520.c
>  F:	drivers/pmdomain/thead/
>  F:	drivers/power/sequencing/pwrseq-thead-gpu.c
> +F:	drivers/pwm/pwm_th1520.rs
>  F:	drivers/reset/reset-th1520.c
>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>  F:	include/dt-bindings/power/thead,th1520-power.h
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 2b608f4378138775ee3ba4d53f682952e1914118..dd6db01832ee985e2e588a413=
a13df869a029d3d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -729,6 +729,17 @@ config PWM_TEGRA
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-tegra.
> =20
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
>  	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARC=
H_K3 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ff4f47e5fb7a0dbac72c12de82c3773e5582db6d..5c15c95c6e491439693891986=
57eed0ecf4086b2 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+=3D pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
> +obj-$(CONFIG_PWM_TH1520)	+=3D pwm_th1520.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+=3D pwm-tiehrpwm.o
>  obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..5ef887b1b5dfed92c5d4b87a7=
d48f673352a257e
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
> +//! - The period and duty cycle are controlled by 32-bit hardware regist=
ers,
> +//!   limiting the maximum resolution.
> +//! - The driver supports continuous output mode only; one-shot mode is =
not
> +//!   implemented.
> +//! - The controller hardware provides up to 6 PWM channels.
> +//! - Reconfiguration is glitch free - new period and duty cycle values =
are
> +//!   latched and take effect at the start of the next period.
> +//! - Polarity is handled via a simple hardware inversion bit; arbitrary
> +//!   duty cycle offsets are not supported.
> +//! - Disabling a channel is achieved by configuring its duty cycle to z=
ero to
> +//!   produce a static low output. Clearing the `start` does not reliably
> +//!   force the static inactive level defined by the `INACTOUT` bit. Hen=
ce
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
> +const TH1520_MAX_PWM_NUM: u32 =3D 6;
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
> +const TH1520_PWM_START: u32 =3D 1 << 0;
> +const TH1520_PWM_CFG_UPDATE: u32 =3D 1 << 2;
> +const TH1520_PWM_CONTINUOUS_MODE: u32 =3D 1 << 5;
> +const TH1520_PWM_FPOUT: u32 =3D 1 << 8;
> +
> +const TH1520_PWM_REG_SIZE: usize =3D 0xB0;
> +
> +fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
> +    const NSEC_PER_SEC_U64: u64 =3D time::NSEC_PER_SEC as u64;
> +
> +    (match ns.checked_mul(rate_hz) {
> +        Some(product) =3D> product,
> +        None =3D> u64::MAX,
> +    }) / NSEC_PER_SEC_U64
> +}
> +
> +fn cycles_to_ns(cycles: u64, rate_hz: u64) -> u64 {
> +    const NSEC_PER_SEC_U64: u64 =3D time::NSEC_PER_SEC as u64;
> +
> +    // Round up
> +    let Some(numerator) =3D cycles
> +        .checked_mul(NSEC_PER_SEC_U64)
> +        .and_then(|p| p.checked_add(rate_hz - 1))
> +    else {
> +        return u64::MAX;
> +    };
> +
> +    numerator / rate_hz

Does cycles_to_ns(18446744074, 66000000) yield u64::MAX or u64::MAX /
66000000? Reading through the docs I found I think it's the former. I
guess we don't reach these spheres in the driver, but conceptually the
latter would be better and I think that's relevant as this is the first
Rust driver and so very likely will be the blueprint for further
drivers.

Further below you're using saturating_sub(), is there a similar variant
for multiplication that could simplify this function to

	let numerator =3D cyles
	  .saturating_mul(NSEC_PER_SEC_U64)
	  .saturating_add(rate_hz - 1);

	numerator / rate_hz

?

Additionally I'd add a comment that this should be replaced by
mul_u64_u64_div_u64_roundup() once that exists in Rust. (Sigh, I just
notice we still don't have that in C yet.)

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
> +/// The driver's private data struct. It holds all necessary devres mana=
ged resources.
> +#[pin_data(PinnedDrop)]
> +struct Th1520PwmDriverData {
> +    #[pin]
> +    iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
> +    clk: Clk,
> +}
> +
> +// This `unsafe` implementation is a temporary necessity because the und=
erlying `kernel::clk::Clk`
> +// type does not yet expose `Send` and `Sync` implementations. This bloc=
k should be removed
> +// as soon as the clock abstraction provides these guarantees directly.
> +// TODO: Remove those unsafe impl's when Clk will support them itself.
> +
> +// SAFETY: The `devres` framework requires the driver's private data to =
be `Send` and `Sync`.
> +// We can guarantee this because the PWM core synchronizes all callbacks=
, preventing concurrent
> +// access to the contained `iomem` and `clk` resources.
> +unsafe impl Send for Th1520PwmDriverData {}
> +
> +// SAFETY: The same reasoning applies as for `Send`. The PWM core's sync=
hronization
> +// guarantees that it is safe for multiple threads to have shared access=
 (`&self`)
> +// to the driver data during callbacks.
> +unsafe impl Sync for Th1520PwmDriverData {}
> +
> +impl pwm::PwmOps for Th1520PwmDriverData {
> +    type WfHw =3D Th1520WfHw;
> +
> +    fn round_waveform_tohw(
> +        chip: &pwm::Chip<Self>,
> +        _pwm: &pwm::Device,
> +        wf: &pwm::Waveform,
> +    ) -> Result<pwm::RoundedWaveform<Self::WfHw>> {
> +        let data =3D chip.drvdata();
> +
> +        if wf.period_length_ns =3D=3D 0 {

Please add a dev_dbg! here for consistency with the wf.period_length_ns
!=3D 0 case here.

> +            return Ok(pwm::RoundedWaveform {
> +                status: 0,
> +                hardware_waveform: Th1520WfHw {
> +                    enabled: false,
> +                    ..Default::default()
> +                },
> +            });
> +        }
> +
> +        let rate_hz =3D data.clk.rate().as_hz() as u64;
> +
> +        let period_cycles =3D ns_to_cycles(wf.period_length_ns, rate_hz)=
=2Emin(u64::from(u32::MAX));

What happens if you get period_cycles =3D 0 here?

> +        let mut duty_cycles =3D ns_to_cycles(wf.duty_length_ns, rate_hz)=
=2Emin(u64::from(u32::MAX));
> +
> +        let mut ctrl_val =3D TH1520_PWM_CONTINUOUS_MODE;
> +
> +        let is_inversed =3D wf.duty_length_ns > 0
> +            && wf.duty_offset_ns > 0
> +            && wf.duty_length_ns + wf.duty_offset_ns >=3D wf.period_leng=
th_ns;

For
	duty_length_ns =3D   0x8000000000000000
	duty_offset_ns =3D   0x8000000000000000
	period_length_ns =3D 0xffffffffffffffff

this should evaluate to true (right?) but if + overflows in the same way
in Rust as it does in C, you get is_inversed =3D false here.

The safe condition is

	wf.duty_offset_ns >=3D wf.period_length_ns - wf.duty_length_ns

here.

> +        if is_inversed {
> +            duty_cycles =3D period_cycles - duty_cycles;
> +        } else {
> +            ctrl_val |=3D TH1520_PWM_FPOUT;
> +        }
> +
> +        let wfhw =3D Th1520WfHw {
> +            period_cycles: period_cycles as u32,
> +            duty_cycles: duty_cycles as u32,

This casts period_cycles and duty_cycles from an u64 to an u32, right?
Can you please add a comment that shortly explains why these values fit
into an u32?

> +            ctrl_val,
> +            enabled: true,
> +        };
> +
> +        dev_dbg!(
> +            chip.device(),
> +            "clk_rate: {}Hz Requested: period {}ns, duty {}ns, offset {}=
ns -> HW: period {} cyc, duty {} cyc, ctrl 0x{:x}\n",

" " before the units please.

I want to establish

	"{}/{} [+{}]", duty_length_ns, period_length_ns, duty_offset_ns

as the typical way to emit a waveform. Please use that consistently.

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
> +        let data =3D chip.drvdata();
> +        let rate_hz =3D data.clk.rate().as_hz() as u64;
> +
> +        wf.period_length_ns =3D cycles_to_ns(u64::from(wfhw.period_cycle=
s), rate_hz);

Here I wonder again about wfhw.period_cycles =3D 0.

> +        let duty_cycles =3D u64::from(wfhw.duty_cycles);
> +
> +        if (wfhw.ctrl_val & TH1520_PWM_FPOUT) !=3D 0 {
> +            wf.duty_length_ns =3D cycles_to_ns(duty_cycles, rate_hz);
> +            wf.duty_offset_ns =3D 0;
> +        } else {
> +            let period_cycles =3D u64::from(wfhw.period_cycles);
> +            let original_duty_cycles =3D period_cycles.saturating_sub(du=
ty_cycles);
> +
> +            // For an inverted signal, `duty_length_ns` is the high time=
 (period - low_time).
> +            wf.duty_length_ns =3D cycles_to_ns(original_duty_cycles, rat=
e_hz);
> +            // The offset is the initial low time, which is what the har=
dware register provides.
> +            wf.duty_offset_ns =3D cycles_to_ns(duty_cycles, rate_hz);
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
> +        let data =3D chip.drvdata();
> +        let hwpwm =3D pwm.hwpwm();
> +        let iomem_accessor =3D data.iomem.access(parent_dev)?;
> +        let iomap =3D iomem_accessor.deref();
> +
> +        let ctrl =3D iomap.try_read32(th1520_pwm_ctrl(hwpwm))?;
> +        let period_cycles =3D iomap.try_read32(th1520_pwm_per(hwpwm))?;
> +        let duty_cycles =3D iomap.try_read32(th1520_pwm_fp(hwpwm))?;
> +
> +        let wfhw =3D Th1520WfHw {
> +            period_cycles,
> +            duty_cycles,
> +            ctrl_val: ctrl,
> +            enabled: duty_cycles !=3D 0,
> +        };
> +
> +        dev_dbg!(
> +            chip.device(),
> +            "PWM-{}: read_waveform: Read hw state - period: {}, duty: {}=
, ctrl: 0x{:x}, enabled: {}",
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
> +        let data =3D chip.drvdata();
> +        let hwpwm =3D pwm.hwpwm();
> +        let iomem_accessor =3D data.iomem.access(parent_dev)?;
> +        let iomap =3D iomem_accessor.deref();
> +        let was_enabled =3D pwm.state().enabled();

The driver would be a tad more robust if was_enabled is determined from
the hardware registers instead. (And also it helps not to add another
dependency on pwm.state which I'd like to get rid of in the long run
with waveforms being the canonical representation internally.)

> +
> +        if !wfhw.enabled {

dev_dbg! here for consistence please.

> +            if was_enabled {
> +                iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))=
?;
> +                iomap.try_write32(0, th1520_pwm_fp(hwpwm))?;
> +                iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE,=
 th1520_pwm_ctrl(hwpwm))?;
> +            }
> +            return Ok(());
> +        }
> +
> +        iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
> +        iomap.try_write32(wfhw.period_cycles, th1520_pwm_per(hwpwm))?;
> +        iomap.try_write32(wfhw.duty_cycles, th1520_pwm_fp(hwpwm))?;
> +        iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE, th1520_=
pwm_ctrl(hwpwm))?;
> +
> +        // The `TH1520_PWM_START` bit must be written in a separate, fin=
al transaction, and
> +        // only when enabling the channel from a disabled state.
> +        if !was_enabled {
> +            iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_START, th1520_p=
wm_ctrl(hwpwm))?;
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

Best regards
Uwe

--uu7qwrkf63ilczbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjNAcYACgkQj4D7WH0S
/k4Sewf/SVau6tkPjfRkfj0oxHSb6f/jhZChnnVs4iPLwVSRazcobjGdD0WcUBQB
fhDJHbAaYey6ihKnfiIL7mdcQxhwsfqfxfGqGY0Y2/hvyKFuV1CPtMPXzKEWvnP/
cwHE6pOC1RfipN5UEwq3oUqIDwyPzq7vUdpWSxSFa3UbKg/nU5gnN2W2Mlb80X4r
0pZli7Ht35xlNWbFhNc2/Zj/6bQtuA+E1U20dXy6fyH1k+3NqNjPMgfrq1z1SrUM
lWYiHLKVE6d4JovqEVolhplH2akJfWCprBS7eVs1HxD3FKfhvHYf6sOzBlUw4JZm
+Z+1n6Rga3Rq1Z7d2tzl1/g+8zE9yg==
=IOjA
-----END PGP SIGNATURE-----

--uu7qwrkf63ilczbj--

