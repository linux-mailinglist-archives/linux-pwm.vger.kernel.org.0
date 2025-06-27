Return-Path: <linux-pwm+bounces-6556-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B856CAEBB52
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46B5188D5F1
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EA52E92CF;
	Fri, 27 Jun 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM5s/gJ5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529002E8DEE;
	Fri, 27 Jun 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037005; cv=none; b=Jnm7Z4zbkyYONtQQ1gO7bcIMS1UYaEQqkdbcS/iWqKZkFHZzWcNEOCtJy2FU1oBjp1b81p254Qstmws83aWjSZJlOHffKWsLcO8VSQPZlhy84E+7PRku4JH/cSkUDTqXyGivY08bllW/nWnuNrDQ1WuBvOhYGtpO6NHCZoJFAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037005; c=relaxed/simple;
	bh=ecZ01HNw03w8/mQcWZ0Ph+YBOVuhBufRrHPrYkQk+ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJteMkeb/Bk2KPIVx7/IiDagOL0xoxBWZVULEt17xMU4X7XzIISTKulqdyVzUU/S19tyhJgFShkQPknDmOK9pI69SO6RMC3Edp023PwpjoafKL4QQjOrJzYagFk5DdNQysEV2DFDFsJcsO5IxUhlYWmfA/qqW5KMrwXfXNk8OVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM5s/gJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3761CC4CEE3;
	Fri, 27 Jun 2025 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751037004;
	bh=ecZ01HNw03w8/mQcWZ0Ph+YBOVuhBufRrHPrYkQk+ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OM5s/gJ50f12Ha3yblezKhnd7lEXXVUIJ78UyJ/sYqcHyescZmhZ+9VwbVlxs+g7H
	 61xMDfE18sBvTkXHTHJq3sEURJ11EKYPnE9mK/Flr5mQsQoURy82bAe+ukPA3MZ9DY
	 7UIAj9CAw6sRJE6TPm2blXWcO2UbJW7ahycNcb4Bwl8K+AJAYJHLsoK7oBAZDqN/XJ
	 dKNG6qGZXJZYRWZz5l3V7mPNBKkJSY4L4BgZ52U+yhD/iwGpuVwbSXzejA8MnvxILY
	 fB2QooKmYDmV/P3sbEO64CnTolT0JNj0+DCVMHQwpA/vgPCR6F2kylE695kWC6yERu
	 c43/tztr6kIBg==
Date: Fri, 27 Jun 2025 17:10:01 +0200
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
Subject: Re: [PATCH v5 1/9] rust: pwm: Add Kconfig and basic data structures
Message-ID: <q7sz7uci5vnyc24laqzs56vgt4i2jamb3ifyxkqom6qcml5kkv@642prvwxjkxc>
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
 <CGME20250623180858eucas1p1815f6d6815b1c715baad94810cefacd5@eucas1p1.samsung.com>
 <20250623-rust-next-pwm-working-fan-for-sending-v5-1-0ca23747c23e@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="djkmowd5nddaduey"
Content-Disposition: inline
In-Reply-To: <20250623-rust-next-pwm-working-fan-for-sending-v5-1-0ca23747c23e@samsung.com>


--djkmowd5nddaduey
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/9] rust: pwm: Add Kconfig and basic data structures
MIME-Version: 1.0

On Mon, Jun 23, 2025 at 08:08:49PM +0200, Michal Wilczynski wrote:
> Introduce the foundational support for PWM abstractions in Rust.
>=20
> This commit adds the `RUST_PWM_ABSTRACTIONS` Kconfig option to enable
> the feature, along with the necessary build-system support and C
> helpers.
>=20
> It also introduces the first set of safe wrappers for the PWM
> subsystem, covering the basic data carrying C structs and enums:
> - `Polarity`: A safe wrapper for `enum pwm_polarity`.
> - `Waveform`: A wrapper for `struct pwm_waveform`.
> - `Args`: A wrapper for `struct pwm_args`.
> - `State`: A wrapper for `struct pwm_state`.
>=20
> These types provide memory safe, idiomatic Rust representations of the
> core PWM data structures and form the building blocks for the
> abstractions that will follow.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS                     |   6 ++
>  drivers/pwm/Kconfig             |  13 +++
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/pwm.c              |  20 ++++
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/pwm.rs              | 198 ++++++++++++++++++++++++++++++++++=
++++++
>  7 files changed, 241 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..a575622454a2ef57ce055c8a8=
c4765fa4fddc490 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20073,6 +20073,12 @@ F:	include/linux/pwm.h
>  F:	include/linux/pwm_backlight.h
>  K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
> =20
> +PWM SUBSYSTEM BINDINGS [RUST]
> +M:	Michal Wilczynski <m.wilczynski@samsung.com>
> +S:	Maintained
> +F:	rust/helpers/pwm.c
> +F:	rust/kernel/pwm.rs
> +
>  PXA GPIO DRIVER
>  M:	Robert Jarzmik <robert.jarzmik@free.fr>
>  L:	linux-gpio@vger.kernel.org
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index d9bcd1e8413eaed1602d6686873e263767c58f5f..cfddeae0eab3523f04f361fb4=
1ccd1345c0c937b 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -790,4 +790,17 @@ config PWM_XILINX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-xilinx.
> =20
> + config RUST_PWM_ABSTRACTIONS
> +	bool "Rust PWM abstractions support"
> +	depends on RUST
> +	depends on PWM=3Dy

Currently CONFIG_PWM is a bool, so it cannot be =3Dm. But I considered
making PWM a tristate variable. How would that interfere with Rust
support?

> +	help
> +	  This option enables the safe Rust abstraction layer for the PWM
> +	  subsystem. It provides idiomatic wrappers and traits necessary for
> +	  writing PWM controller drivers in Rust.
> +
> +	  The abstractions handle resource management (like memory and reference
> +	  counting) and provide safe interfaces to the underlying C core,
> +	  allowing driver logic to be written in safe Rust.
> +
>  endif
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 693cdd01f9290fa01375cf78cac0e5a90df74c6c..6fe7dd529577952bf7adb4fe0=
526b0d5fbd6f3bd 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -64,6 +64,7 @@
>  #include <linux/pm_opp.h>
>  #include <linux/poll.h>
>  #include <linux/property.h>
> +#include <linux/pwm.h>
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
>  #include <linux/security.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 16fa9bca5949b85e8d4cdcfe8e6886124f72d8d8..60879e6d794ce0f87e39caafc=
5495bf5e8acf8f0 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -31,6 +31,7 @@
>  #include "platform.c"
>  #include "pci.c"
>  #include "pid_namespace.c"
> +#include "pwm.c"
>  #include "rbtree.c"
>  #include "rcu.c"
>  #include "refcount.c"
> diff --git a/rust/helpers/pwm.c b/rust/helpers/pwm.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d75c588863685d3990b525bb1=
b84aa4bc35ac397
> --- /dev/null
> +++ b/rust/helpers/pwm.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
> +
> +#include <linux/pwm.h>
> +
> +struct device *rust_helper_pwmchip_parent(const struct pwm_chip *chip)
> +{
> +	return pwmchip_parent(chip);
> +}
> +
> +void *rust_helper_pwmchip_get_drvdata(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +void rust_helper_pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
> +{
> +	pwmchip_set_drvdata(chip, data);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 6b4774b2b1c37f4da1866e993be6230bc6715841..ce1d08b14e456905dbe7b625b=
bb8ca8b08deae2a 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -105,6 +105,8 @@
>  pub mod seq_file;
>  pub mod sizes;
>  mod static_assert;
> +#[cfg(CONFIG_RUST_PWM_ABSTRACTIONS)]
> +pub mod pwm;
>  #[doc(hidden)]
>  pub mod std_vendor;
>  pub mod str;
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..ed681b228c414e7ae8bf80ca6=
49ad497c9dc4ec3
> --- /dev/null
> +++ b/rust/kernel/pwm.rs
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
> +
> +//! PWM subsystem abstractions.
> +//!
> +//! C header: [`include/linux/pwm.h`](srctree/include/linux/pwm.h).
> +
> +use crate::{
> +    bindings,
> +    prelude::*,
> +    types::Opaque,
> +};
> +use core::convert::TryFrom;
> +
> +/// Maximum size for the hardware-specific waveform representation buffe=
r.
> +///
> +/// From C: `#define WFHWSIZE 20`
> +pub const WFHW_MAX_SIZE: usize =3D 20;

Can we somehow enforce that this doesn't diverge if the C define is
increased?

> +/// PWM polarity. Mirrors [`enum pwm_polarity`](srctree/include/linux/pw=
m.h).
> +#[derive(Copy, Clone, Debug, PartialEq, Eq)]
> +pub enum Polarity {
> +    /// Normal polarity (duty cycle defines the high period of the signa=
l).
> +    Normal,
> +
> +    /// Inversed polarity (duty cycle defines the low period of the sign=
al).
> +    Inversed,
> +}
> +
> +impl TryFrom<bindings::pwm_polarity> for Polarity {
> +    type Error =3D Error;
> +
> +    fn try_from(polarity: bindings::pwm_polarity) -> Result<Self, Error>=
 {
> +        match polarity {
> +            bindings::pwm_polarity_PWM_POLARITY_NORMAL =3D> Ok(Polarity:=
:Normal),
> +            bindings::pwm_polarity_PWM_POLARITY_INVERSED =3D> Ok(Polarit=
y::Inversed),
> +            _ =3D> Err(EINVAL),
> +        }
> +    }
> +}
> +
> +impl From<Polarity> for bindings::pwm_polarity {
> +    fn from(polarity: Polarity) -> Self {
> +        match polarity {
> +            Polarity::Normal =3D> bindings::pwm_polarity_PWM_POLARITY_NO=
RMAL,
> +            Polarity::Inversed =3D> bindings::pwm_polarity_PWM_POLARITY_=
INVERSED,
> +        }
> +    }
> +}
> +
> +/// Represents a PWM waveform configuration.
> +/// Mirrors struct [`struct pwm_waveform`](srctree/include/linux/pwm.h).
> +#[derive(Copy, Clone, Debug, Default, PartialEq, Eq)]
> +pub struct Waveform {
> +    /// Total duration of one complete PWM cycle, in nanoseconds.
> +    pub period_length_ns: u64,
> +
> +    /// Duty-cycle active time, in nanoseconds.
> +    ///
> +    /// For a typical normal polarity configuration (active-high) this i=
s the
> +    /// high time of the signal.
> +    pub duty_length_ns: u64,
> +
> +    /// Duty-cycle start offset, in nanoseconds.
> +    ///
> +    /// Delay from the beginning of the period to the first active edge.
> +    /// In most simple PWM setups this is `0`, so the duty cycle starts
> +    /// immediately at each period=E2=80=99s start.
> +    pub duty_offset_ns: u64,
> +}
> +
> +impl From<bindings::pwm_waveform> for Waveform {
> +    fn from(wf: bindings::pwm_waveform) -> Self {
> +        Waveform {
> +            period_length_ns: wf.period_length_ns,
> +            duty_length_ns: wf.duty_length_ns,
> +            duty_offset_ns: wf.duty_offset_ns,
> +        }
> +    }
> +}
> +
> +impl From<Waveform> for bindings::pwm_waveform {
> +    fn from(wf: Waveform) -> Self {
> +        bindings::pwm_waveform {
> +            period_length_ns: wf.period_length_ns,
> +            duty_length_ns: wf.duty_length_ns,
> +            duty_offset_ns: wf.duty_offset_ns,
> +        }
> +    }
> +}
> +
> +/// Wrapper for board-dependent PWM arguments [`struct pwm_args`](srctre=
e/include/linux/pwm.h).
> +#[repr(transparent)]
> +pub struct Args(Opaque<bindings::pwm_args>);
> +
> +impl Args {
> +    /// Creates an `Args` wrapper from a C struct pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `c_args_ptr` is a valid, non-null po=
inter
> +    /// to `bindings::pwm_args` and that the pointed-to data is valid
> +    /// for the duration of this function call (as data is copied).
> +    unsafe fn from_c_ptr(c_args_ptr: *const bindings::pwm_args) -> Self {
> +        // SAFETY: Caller guarantees `c_args_ptr` is valid. We dereferen=
ce it to copy.
> +        Args(Opaque::new(unsafe { *c_args_ptr }))
> +    }
> +
> +    /// Returns the period of the PWM signal in nanoseconds.
> +    pub fn period(&self) -> u64 {
> +        // SAFETY: `self.0.get()` returns a pointer to the `bindings::pw=
m_args`
> +        // managed by the `Opaque` wrapper. This pointer is guaranteed t=
o be
> +        // valid and aligned for the lifetime of `self` because `Opaque`=
 owns a copy.
> +        unsafe { (*self.0.get()).period }
> +    }
> +
> +    /// Returns the polarity of the PWM signal.
> +    pub fn polarity(&self) -> Result<Polarity, Error> {
> +        // SAFETY: `self.0.get()` returns a pointer to the `bindings::pw=
m_args`
> +        // managed by the `Opaque` wrapper. This pointer is guaranteed t=
o be
> +        // valid and aligned for the lifetime of `self`.
> +        let raw_polarity =3D unsafe { (*self.0.get()).polarity };
> +        Polarity::try_from(raw_polarity)
> +    }
> +}
> +
> +/// Wrapper for PWM state [`struct pwm_state`](srctree/include/linux/pwm=
=2Eh).
> +#[repr(transparent)]
> +pub struct State(bindings::pwm_state);
> +
> +impl Default for State {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +impl State {
> +    /// Creates a new zeroed `State`.
> +    pub fn new() -> Self {
> +        State(bindings::pwm_state::default())
> +    }
> +
> +    /// Creates a `State` wrapper by taking ownership of a C `pwm_state`=
 value.
> +    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
> +        State(c_state)
> +    }
> +
> +    /// Gets the period of the PWM signal in nanoseconds.
> +    pub fn period(&self) -> u64 {
> +        self.0.period
> +    }
> +
> +    /// Sets the period of the PWM signal in nanoseconds.
> +    pub fn set_period(&mut self, period_ns: u64) {
> +        self.0.period =3D period_ns;
> +    }
> +
> +    /// Gets the duty cycle of the PWM signal in nanoseconds.
> +    pub fn duty_cycle(&self) -> u64 {
> +        self.0.duty_cycle
> +    }
> +
> +    /// Sets the duty cycle of the PWM signal in nanoseconds.
> +    pub fn set_duty_cycle(&mut self, duty_ns: u64) {
> +        self.0.duty_cycle =3D duty_ns;
> +    }
> +
> +    /// Returns `true` if the PWM signal is enabled.
> +    pub fn enabled(&self) -> bool {
> +        self.0.enabled
> +    }
> +
> +    /// Sets the enabled state of the PWM signal.
> +    pub fn set_enabled(&mut self, enabled: bool) {
> +        self.0.enabled =3D enabled;
> +    }
> +
> +    /// Gets the polarity of the PWM signal.
> +    pub fn polarity(&self) -> Result<Polarity, Error> {
> +        Polarity::try_from(self.0.polarity)
> +    }
> +
> +    /// Sets the polarity of the PWM signal.
> +    pub fn set_polarity(&mut self, polarity: Polarity) {
> +        self.0.polarity =3D polarity.into();
> +    }

Please don't expose these non-atomic callbacks. pwm_disable() would be
fine.

Otherwise I'd prefer if pwm_set_waveform_might_sleep() is the API
exposed to/by Rust.

> +    /// Returns `true` if the PWM signal is configured for power usage h=
int.
> +    pub fn usage_power(&self) -> bool {
> +        self.0.usage_power
> +    }
> +
> +    /// Sets the power usage hint for the PWM signal.
> +    pub fn set_usage_power(&mut self, usage_power: bool) {
> +        self.0.usage_power =3D usage_power;
> +    }

I would prefer to not expose usage_power, too.

> +}

Best regards
Uwe

--djkmowd5nddaduey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhetEcACgkQj4D7WH0S
/k5Qzgf+IP3VcXjlu5slOEzweMckF6TssvkQXvkWSPspAsIBWfJs1u5oazmNoil7
KSYVg7F8jWamYHVZyka9FzmIGPzaK7HAmEr8dhPpOfvnTH5Cwj4b7qEAJZ2OsGRC
qX5I1gzxtdV9+W+joaFNYRq6gLvuRCok7Fwszkf/xFLPUQdAJr0c26fOXSqd6OmQ
9DZ3tmzUph8NNdvHvz0gtgfmx98HmYqSlxY0fBV1MK3Gk2jyhIkhlvyOUcbf9btu
frqIqxv8BJAMnndE0lkzPehQg3t8pQqgci6gnulC/d/rU1eNbz6JE/8goCTa0rHt
tEujjCnA89MMqqI1EekmtuuTzle6Pw==
=mdlD
-----END PGP SIGNATURE-----

--djkmowd5nddaduey--

