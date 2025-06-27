Return-Path: <linux-pwm+bounces-6557-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD564AEBBEA
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 17:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98307AEDF0
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F22E92B3;
	Fri, 27 Jun 2025 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD7IBdgt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF4B1CAA6C;
	Fri, 27 Jun 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038129; cv=none; b=RgL0AfwGNeJfmI5TStqXcRZ4jsA7mrtehliargX/SGjHhNMceTfdnuudqeZgmUd2oEjuJn74wAOv9KJYwdQKXjeBAadSVYZUUrIRmtap6XYE8bAQC9wj7KyYbBJMY1VJO54OK8tN5xIhUtZ6AlGENFpNAU9FjPqm0sY7QcOsPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038129; c=relaxed/simple;
	bh=QtHjZBImyP82L6fjboplG+GB2+4sny3P40EkhqEuBIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei4mQmdVv9ZOfYJ8CtMqM57T4hGGSSoAvcrfojm5VWuFl+Hk8oXqRnHOPLDzL3KcABx91tOHuVgZ56go3QR4TCn67gqRSkLdLMhjjVEMWuyj6hzymMhArnOI4N1tmg96vSHq4I8gMCUxjcy1HB8A1TDgogHyofwmvsVezStwcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD7IBdgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE4AC4CEE3;
	Fri, 27 Jun 2025 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751038128;
	bh=QtHjZBImyP82L6fjboplG+GB2+4sny3P40EkhqEuBIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CD7IBdgtXz0atRZoKAF+Gp1ID957/kMCWjRMmhbrgTy+VbO5mm+kPDm1LMFfKKqxV
	 eGGxMINWb8jyyk0iF2bCa0mK3wKF8tO9loiMeN7pV/zSEuuNGAZn+1rqrKO6FDRANK
	 ydEaFm58+6Sqln65n8+cjJc23g7ma30DO0xbqu+ofNuF6lxnoy+b3tutnpA27LAo3I
	 uSANDZ8/JbU0J7EKIPmOR55LgkL8hiRrZjz7zzvOtDSiK+kaNV9dVzQR7cR8+UnAGR
	 waxPdAtPgit8wH2IDvtP0TufCut+eIt3a2jsRScVBrajpgu37bEtXkJOAWDdFg9NV7
	 4RbH8GzY3htiA==
Date: Fri, 27 Jun 2025 17:28:45 +0200
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
Subject: Re: [PATCH v5 4/9] pwm: Add Rust driver for T-HEAD TH1520 SoC
Message-ID: <aot4ow37qsrehgce6vpc5m7ha5w6h4jvj7k7bokn4eo63sjk5x@iyp5ir234kx5>
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
 <CGME20250623180902eucas1p2960477c0a44f05e991747312b0ae0ff0@eucas1p2.samsung.com>
 <20250623-rust-next-pwm-working-fan-for-sending-v5-4-0ca23747c23e@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vkfxvii7cyang4hh"
Content-Disposition: inline
In-Reply-To: <20250623-rust-next-pwm-working-fan-for-sending-v5-4-0ca23747c23e@samsung.com>


--vkfxvii7cyang4hh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 4/9] pwm: Add Rust driver for T-HEAD TH1520 SoC
MIME-Version: 1.0

On Mon, Jun 23, 2025 at 08:08:52PM +0200, Michal Wilczynski wrote:
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
>  drivers/pwm/pwm_th1520.rs | 318 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 330 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a575622454a2ef57ce055c8a8c4765fa4fddc490..879870471e86dcec4a0e8f5c4=
5d2cc3409411fdd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21402,6 +21402,7 @@ F:	drivers/mailbox/mailbox-th1520.c
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>  F:	drivers/pinctrl/pinctrl-th1520.c
>  F:	drivers/pmdomain/thead/
> +F:	drivers/pwm/pwm_th1520.rs
>  F:	drivers/reset/reset-th1520.c
>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>  F:	include/dt-bindings/power/thead,th1520-power.h
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index cfddeae0eab3523f04f361fb41ccd1345c0c937b..a675b3bd68392d1b05a47a2a1=
390c5606647ca15 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -719,6 +719,16 @@ config PWM_TEGRA
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-tegra.
> =20
> +config PWM_TH1520
> +	tristate "TH1520 PWM support"
> +	depends on RUST_PWM_ABSTRACTIONS

RUST_PWM_ABSTRACTIONS is user selectable. Is that sensible. From a
user's POV it shouldn't matter if the driver is written in Rust or not.

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
> index 96160f4257fcb0e0951581af0090615c0edf5260..a410747095327a315a6bcd24a=
e343ce7857fe323 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+=3D pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
> +obj-$(CONFIG_PWM_TH1520)	+=3D pwm_th1520.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+=3D pwm-tiehrpwm.o
>  obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..a77c45cef9cf8f02a25db9d42=
c45cd0df565b0ec
> --- /dev/null
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -0,0 +1,318 @@
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

Important questions to answer here are:

 - How does the hardware behave on disable? (Does it stop immediately
   (or at all)? Does it emit a constant output? Which?)=20
 - How does the hardware behave on reconfiguration? (Does it switch
   immidiately or does it complete the current period? Can there be
   glitches?

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
> +const MAX_PWM_NUM: u32 =3D 6;
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
> +const PWM_START: u32 =3D 1 << 0;
> +const PWM_CFG_UPDATE: u32 =3D 1 << 2;
> +const PWM_CONTINUOUS_MODE: u32 =3D 1 << 5;
> +const PWM_FPOUT: u32 =3D 1 << 8;

Can you please add a driver specific prefix to these?

> +const TH1520_PWM_REG_SIZE: usize =3D 0xB0;
> +
> +fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
> +    const NSEC_PER_SEC_U64: u64 =3D time::NSEC_PER_SEC as u64;
> +
> +    match ns.checked_mul(rate_hz) {
> +        Some(product) =3D> product / NSEC_PER_SEC_U64,
> +        None =3D> u64::MAX,
> +    }

The semantic here is: If ns * rate_hz overflows, return U64_MAX, else ns
* rate_hz / NSEC_PER_SEC, right?

If you cannot easily reproduce what mul_u64_u64_div_u64() does, I think
it would be more prudent do make this:

	match ns.checked_mul(rate_hz) {
	    Some(product) =3D> product,
	    None =3D> u64::MAX,
	} / NSEC_PER_SEC_U64

> +}
> +
> [...]
> +impl pwm::PwmOps for Th1520PwmDriverData {
> +    type WfHw =3D Th1520WfHw;
> +
> +    fn round_waveform_tohw(
> +        chip: &pwm::Chip,
> +        _pwm: &pwm::Device,
> +        wf: &pwm::Waveform,
> +    ) -> Result<(c_int, Self::WfHw)> {
> +        let data: &Self =3D chip.drvdata();
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
> +        let rate_hz =3D data.clk.rate().as_hz() as u64;
> +
> +        let period_cycles =3D ns_to_cycles(wf.period_length_ns, rate_hz)=
=2Emin(u32::MAX as u64);
> +        let mut duty_cycles =3D ns_to_cycles(wf.duty_length_ns, rate_hz)=
=2Emin(u32::MAX as u64);
> +
> +        let mut ctrl_val =3D PWM_CONTINUOUS_MODE;
> +
> +        if wf.duty_offset_ns =3D=3D 0 {
> +            ctrl_val |=3D PWM_FPOUT;
> +        } else {
> +            duty_cycles =3D period_cycles - duty_cycles;

Huh, this looks wrong. Your hardware only supports the two polarities,
right? Then configure inversed polarity if

	wf->duty_length_ns && wf->duty_offset_ns && wf->duty_length_ns + wf->duty_=
offset_ns >=3D wf->period_length_ns

(i.e. how the pwm-stm32 driver does it).

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
> +            "Requested: period {}ns, duty {}ns, offset {}ns -> HW: perio=
d {} cyc, duty {} cyc, ctrl 0x{:x}\n",

Would it be helpful to also emit the clkrate here?

> +            wf.period_length_ns,
> +            wf.duty_length_ns,
> +            wf.duty_offset_ns,
> +            wfhw.period_cycles,
> +            wfhw.duty_cycles,
> +            wfhw.ctrl_val
> +        );
> +
> +        Ok((0, wfhw))
> +    }
> +
> +    fn round_waveform_fromhw(
> +        chip: &pwm::Chip,
> +        _pwm: &pwm::Device,
> +        wfhw: &Self::WfHw,
> +        wf: &mut pwm::Waveform,
> +    ) -> Result<c_int> {
> +        let data: &Self =3D chip.drvdata();
> +        let rate_hz =3D data.clk.rate().as_hz() as u64;
> +
> +        wf.period_length_ns =3D cycles_to_ns(wfhw.period_cycles as u64, =
rate_hz);
> +
> +        let duty_cycles =3D wfhw.duty_cycles as u64;
> +
> +        if (wfhw.ctrl_val & PWM_FPOUT) !=3D 0 {
> +            wf.duty_length_ns =3D cycles_to_ns(duty_cycles, rate_hz);
> +            wf.duty_offset_ns =3D 0;
> +        } else {
> +            let period_cycles =3D wfhw.period_cycles as u64;
> +            let original_duty_cycles =3D period_cycles.saturating_sub(du=
ty_cycles);
> +
> +            wf.duty_length_ns =3D cycles_to_ns(original_duty_cycles, rat=
e_hz);
> +            // We can't recover the original non-zero offset, so we just=
 set it
> +            // to a representative non-zero value.
> +            wf.duty_offset_ns =3D 1;

For an inversed polarity signal the duty_offset is polarity - duty_cycle.

> +        }
> +
> +        Ok(0)
> +    }

Best regards
Uwe

--vkfxvii7cyang4hh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmheuKsACgkQj4D7WH0S
/k63Mgf/b+iJPKal4W5i41FIDsXdTx4wlBWLFoajKZKGZs/HOtmYjrp37yH6sm03
+NTlYMPvgbxnD3+jCG4CEF09T4/VZ/pL0mIZvY/xb2uJ8LvH1PDza/zJIFWJmqy8
5JbJtXXCBZGGMK0P0RD6ojA6M6yQnzdp9gftfPVrCIf+4jxf4UBQEuqhu74+f8gd
agLM/ei3d8Y8KTuRsd7JfYcsWh7jTO5AyMZ08UE4hW26fjGP+HxtmJD3Ir+JsMU4
QYK4hn2F4I8XHdiqIT5ExjFe6d/8U7XWZ2a2sPTVoBSKepKKsi4guyraTevqhnYO
uegIgvtvqtGYqcvydO1dhtKn2r0iAA==
=Duul
-----END PGP SIGNATURE-----

--vkfxvii7cyang4hh--

