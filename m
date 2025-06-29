Return-Path: <linux-pwm+bounces-6570-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C687AECC2B
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Jun 2025 12:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706B43B48CE
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Jun 2025 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B59A2192F5;
	Sun, 29 Jun 2025 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqMYwkjg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616A720F067;
	Sun, 29 Jun 2025 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751192959; cv=none; b=WfjHtUR67oO+D4pFSoi3sxS2jsIYnXX3Dk3yAC0+Tt0ZgINPdXsR/T7hFqIotXHmQGU4Uc4ku7ET1Skm1NJvJWT+oWrZLBGaOi9PMizQt5eXHe4I+mCfs4OetsV5fooOBo5b0mDY2GGHVoqeROLyftKjkpS60fQBdo/2Wsc/xIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751192959; c=relaxed/simple;
	bh=z4rFmtsCpklwld6eBT9J670DO9dKDKw8dNnBhPf4XGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os1b5IegEx8imGzTU78Wa7NWFT1mfFUJPO1/FTlIlkXF15xFllggfUc72XMU0EL65p2vjHVj6BB1G7RL95lSkMf5BX/Tt0IYbzHG9tBYA3N+sOa2KqS+vzWxYT1q8GLu+Hz1Iz5hsv/jWxLow5KJbdWd+Mz1lZRQD9OcTDBZlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqMYwkjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B96C4CEEB;
	Sun, 29 Jun 2025 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751192956;
	bh=z4rFmtsCpklwld6eBT9J670DO9dKDKw8dNnBhPf4XGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqMYwkjgmmrIsD0DyWw3tLXkOGqLc8cVenDHp6eGTwJVNK6lKH/93b355+B9MfIGi
	 CigTW4f+4p0SUP4CotFI7Jk9MFdbsQqf0JyfdyIUNue6+YC618UJ2mIOUuPo16UkVp
	 6MhRy4MtTImCZYSRRvq8l2uIPJxY4met+BpViG6U8sLT3+mlcCwee6DmvjQGg3h037
	 GfqLBPVB2neMlBxeLl0etgZ0PbYq1nEDwFmWD5YWxXOuy85O9ZJuEuz0i0yB4qJOwJ
	 opP/J6R5zpWlGKD/VLWhc/zkJ5JLZuIVAaErQSRMJ13uVXyRMeq535faAMExAsCwN4
	 OYhoiOI2N8JXQ==
Date: Sun, 29 Jun 2025 12:29:13 +0200
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
Message-ID: <n5zfbzu3hn7kqdf3xc7orpeovvdprc2xlf7w3f62uoohkxdk5c@cc24urt5xf36>
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
 <CGME20250623180858eucas1p1815f6d6815b1c715baad94810cefacd5@eucas1p1.samsung.com>
 <20250623-rust-next-pwm-working-fan-for-sending-v5-1-0ca23747c23e@samsung.com>
 <q7sz7uci5vnyc24laqzs56vgt4i2jamb3ifyxkqom6qcml5kkv@642prvwxjkxc>
 <c127e368-8c1f-4299-b222-a105940ac34e@samsung.com>
 <1450a457-4bd3-4e9c-a74f-3be15c9ec84f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xtyje22fzap3kfwu"
Content-Disposition: inline
In-Reply-To: <1450a457-4bd3-4e9c-a74f-3be15c9ec84f@samsung.com>


--xtyje22fzap3kfwu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/9] rust: pwm: Add Kconfig and basic data structures
MIME-Version: 1.0

On Sat, Jun 28, 2025 at 09:47:19PM +0200, Michal Wilczynski wrote:
>=20
>=20
> On 6/28/25 16:38, Michal Wilczynski wrote:
> >=20
> >=20
> > On 6/27/25 17:10, Uwe Kleine-K=C3=B6nig wrote:
> >> On Mon, Jun 23, 2025 at 08:08:49PM +0200, Michal Wilczynski wrote:
> >>> Introduce the foundational support for PWM abstractions in Rust.
> >>>
> >>> This commit adds the `RUST_PWM_ABSTRACTIONS` Kconfig option to enable
> >>> the feature, along with the necessary build-system support and C
> >>> helpers.
> >>>
> >>> It also introduces the first set of safe wrappers for the PWM
> >>> subsystem, covering the basic data carrying C structs and enums:
> >>> - `Polarity`: A safe wrapper for `enum pwm_polarity`.
> >>> - `Waveform`: A wrapper for `struct pwm_waveform`.
> >>> - `Args`: A wrapper for `struct pwm_args`.
> >>> - `State`: A wrapper for `struct pwm_state`.
> >>>
> >>> These types provide memory safe, idiomatic Rust representations of the
> >>> core PWM data structures and form the building blocks for the
> >>> abstractions that will follow.
> >>>
> >>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> >>> ---
> >>>  MAINTAINERS                     |   6 ++
> >>>  drivers/pwm/Kconfig             |  13 +++
> >>>  rust/bindings/bindings_helper.h |   1 +
> >>>  rust/helpers/helpers.c          |   1 +
> >>>  rust/helpers/pwm.c              |  20 ++++
> >>>  rust/kernel/lib.rs              |   2 +
> >>>  rust/kernel/pwm.rs              | 198 ++++++++++++++++++++++++++++++=
++++++++++
> >>>  7 files changed, 241 insertions(+)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..a575622454a2ef57ce055=
c8a8c4765fa4fddc490 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -20073,6 +20073,12 @@ F:	include/linux/pwm.h
> >>>  F:	include/linux/pwm_backlight.h
> >>>  K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
> >>> =20
> >>> +PWM SUBSYSTEM BINDINGS [RUST]
> >>> +M:	Michal Wilczynski <m.wilczynski@samsung.com>
> >>> +S:	Maintained
> >>> +F:	rust/helpers/pwm.c
> >>> +F:	rust/kernel/pwm.rs
> >>> +
> >>>  PXA GPIO DRIVER
> >>>  M:	Robert Jarzmik <robert.jarzmik@free.fr>
> >>>  L:	linux-gpio@vger.kernel.org
> >>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >>> index d9bcd1e8413eaed1602d6686873e263767c58f5f..cfddeae0eab3523f04f36=
1fb41ccd1345c0c937b 100644
> >>> --- a/drivers/pwm/Kconfig
> >>> +++ b/drivers/pwm/Kconfig
> >>> @@ -790,4 +790,17 @@ config PWM_XILINX
> >>>  	  To compile this driver as a module, choose M here: the module
> >>>  	  will be called pwm-xilinx.
> >>> =20
> >>> + config RUST_PWM_ABSTRACTIONS
> >>> +	bool "Rust PWM abstractions support"
> >>> +	depends on RUST
> >>> +	depends on PWM=3Dy
> >>
> >> Currently CONFIG_PWM is a bool, so it cannot be =3Dm. But I considered
> >> making PWM a tristate variable. How would that interfere with Rust
> >> support?
> >>
> >>> +	help
> >>> +	  This option enables the safe Rust abstraction layer for the PWM
> >>> +	  subsystem. It provides idiomatic wrappers and traits necessary for
> >>> +	  writing PWM controller drivers in Rust.
> >>> +
> >>> +	  The abstractions handle resource management (like memory and refe=
rence
> >>> +	  counting) and provide safe interfaces to the underlying C core,
> >>> +	  allowing driver logic to be written in safe Rust.
> >>> +
> >>>  endif
> >>> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings=
_helper.h
> >>> index 693cdd01f9290fa01375cf78cac0e5a90df74c6c..6fe7dd529577952bf7adb=
4fe0526b0d5fbd6f3bd 100644
> >>> --- a/rust/bindings/bindings_helper.h
> >>> +++ b/rust/bindings/bindings_helper.h
> >>> @@ -64,6 +64,7 @@
> >>>  #include <linux/pm_opp.h>
> >>>  #include <linux/poll.h>
> >>>  #include <linux/property.h>
> >>> +#include <linux/pwm.h>
> >>>  #include <linux/refcount.h>
> >>>  #include <linux/sched.h>
> >>>  #include <linux/security.h>
> >>> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> >>> index 16fa9bca5949b85e8d4cdcfe8e6886124f72d8d8..60879e6d794ce0f87e39c=
aafc5495bf5e8acf8f0 100644
> >>> --- a/rust/helpers/helpers.c
> >>> +++ b/rust/helpers/helpers.c
> >>> @@ -31,6 +31,7 @@
> >>>  #include "platform.c"
> >>>  #include "pci.c"
> >>>  #include "pid_namespace.c"
> >>> +#include "pwm.c"
> >>>  #include "rbtree.c"
> >>>  #include "rcu.c"
> >>>  #include "refcount.c"
> >>> diff --git a/rust/helpers/pwm.c b/rust/helpers/pwm.c
> >>> new file mode 100644
> >>> index 0000000000000000000000000000000000000000..d75c588863685d3990b52=
5bb1b84aa4bc35ac397
> >>> --- /dev/null
> >>> +++ b/rust/helpers/pwm.c
> >>> @@ -0,0 +1,20 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
> >>> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
> >>> +
> >>> +#include <linux/pwm.h>
> >>> +
> >>> +struct device *rust_helper_pwmchip_parent(const struct pwm_chip *chi=
p)
> >>> +{
> >>> +	return pwmchip_parent(chip);
> >>> +}
> >>> +
> >>> +void *rust_helper_pwmchip_get_drvdata(struct pwm_chip *chip)
> >>> +{
> >>> +	return pwmchip_get_drvdata(chip);
> >>> +}
> >>> +
> >>> +void rust_helper_pwmchip_set_drvdata(struct pwm_chip *chip, void *da=
ta)
> >>> +{
> >>> +	pwmchip_set_drvdata(chip, data);
> >>> +}
> >>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> >>> index 6b4774b2b1c37f4da1866e993be6230bc6715841..ce1d08b14e456905dbe7b=
625bbb8ca8b08deae2a 100644
> >>> --- a/rust/kernel/lib.rs
> >>> +++ b/rust/kernel/lib.rs
> >>> @@ -105,6 +105,8 @@
> >>>  pub mod seq_file;
> >>>  pub mod sizes;
> >>>  mod static_assert;
> >>> +#[cfg(CONFIG_RUST_PWM_ABSTRACTIONS)]
> >>> +pub mod pwm;
> >>>  #[doc(hidden)]
> >>>  pub mod std_vendor;
> >>>  pub mod str;
> >>> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> >>> new file mode 100644
> >>> index 0000000000000000000000000000000000000000..ed681b228c414e7ae8bf8=
0ca649ad497c9dc4ec3
> >>> --- /dev/null
> >>> +++ b/rust/kernel/pwm.rs
> >>> @@ -0,0 +1,198 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
> >>> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
> >>> +
> >>> +//! PWM subsystem abstractions.
> >>> +//!
> >>> +//! C header: [`include/linux/pwm.h`](srctree/include/linux/pwm.h).
> >>> +
> >>> +use crate::{
> >>> +    bindings,
> >>> +    prelude::*,
> >>> +    types::Opaque,
> >>> +};
> >>> +use core::convert::TryFrom;
> >>> +
> >>> +/// Maximum size for the hardware-specific waveform representation b=
uffer.
> >>> +///
> >>> +/// From C: `#define WFHWSIZE 20`
> >>> +pub const WFHW_MAX_SIZE: usize =3D 20;
> >>
> >> Can we somehow enforce that this doesn't diverge if the C define is
> >> increased?
> >=20
> > You are absolutely right. The hardcoded value is a maintenance risk. The
> > #define is in core.c, so bindgen cannot see it.
> >=20
> > I can address this by submitting a patch to move the #define WFHWSIZE to
> > include/linux/pwm.h. This will make it part of the public API, allow
> > bindgen to generate a binding for it, and ensure the Rust code can never
> > diverge. Is this fine ?
> >=20
> >>
> >>> +/// PWM polarity. Mirrors [`enum pwm_polarity`](srctree/include/linu=
x/pwm.h).
> >>> +#[derive(Copy, Clone, Debug, PartialEq, Eq)]
> >>> +pub enum Polarity {
> >>> +    /// Normal polarity (duty cycle defines the high period of the s=
ignal).
> >>> +    Normal,
> >>> +
> >>> +    /// Inversed polarity (duty cycle defines the low period of the =
signal).
> >>> +    Inversed,
> >>> +}
> >>> +
> >>> +impl TryFrom<bindings::pwm_polarity> for Polarity {
> >>> +    type Error =3D Error;
> >>> +
> >>> +    fn try_from(polarity: bindings::pwm_polarity) -> Result<Self, Er=
ror> {
> >>> +        match polarity {
> >>> +            bindings::pwm_polarity_PWM_POLARITY_NORMAL =3D> Ok(Polar=
ity::Normal),
> >>> +            bindings::pwm_polarity_PWM_POLARITY_INVERSED =3D> Ok(Pol=
arity::Inversed),
> >>> +            _ =3D> Err(EINVAL),
> >>> +        }
> >>> +    }
> >>> +}
> >>> +
> >>> +impl From<Polarity> for bindings::pwm_polarity {
> >>> +    fn from(polarity: Polarity) -> Self {
> >>> +        match polarity {
> >>> +            Polarity::Normal =3D> bindings::pwm_polarity_PWM_POLARIT=
Y_NORMAL,
> >>> +            Polarity::Inversed =3D> bindings::pwm_polarity_PWM_POLAR=
ITY_INVERSED,
> >>> +        }
> >>> +    }
> >>> +}
> >>> +
> >>> +/// Represents a PWM waveform configuration.
> >>> +/// Mirrors struct [`struct pwm_waveform`](srctree/include/linux/pwm=
=2Eh).
> >>> +#[derive(Copy, Clone, Debug, Default, PartialEq, Eq)]
> >>> +pub struct Waveform {
> >>> +    /// Total duration of one complete PWM cycle, in nanoseconds.
> >>> +    pub period_length_ns: u64,
> >>> +
> >>> +    /// Duty-cycle active time, in nanoseconds.
> >>> +    ///
> >>> +    /// For a typical normal polarity configuration (active-high) th=
is is the
> >>> +    /// high time of the signal.
> >>> +    pub duty_length_ns: u64,
> >>> +
> >>> +    /// Duty-cycle start offset, in nanoseconds.
> >>> +    ///
> >>> +    /// Delay from the beginning of the period to the first active e=
dge.
> >>> +    /// In most simple PWM setups this is `0`, so the duty cycle sta=
rts
> >>> +    /// immediately at each period=E2=80=99s start.
> >>> +    pub duty_offset_ns: u64,
> >>> +}
> >>> +
> >>> +impl From<bindings::pwm_waveform> for Waveform {
> >>> +    fn from(wf: bindings::pwm_waveform) -> Self {
> >>> +        Waveform {
> >>> +            period_length_ns: wf.period_length_ns,
> >>> +            duty_length_ns: wf.duty_length_ns,
> >>> +            duty_offset_ns: wf.duty_offset_ns,
> >>> +        }
> >>> +    }
> >>> +}
> >>> +
> >>> +impl From<Waveform> for bindings::pwm_waveform {
> >>> +    fn from(wf: Waveform) -> Self {
> >>> +        bindings::pwm_waveform {
> >>> +            period_length_ns: wf.period_length_ns,
> >>> +            duty_length_ns: wf.duty_length_ns,
> >>> +            duty_offset_ns: wf.duty_offset_ns,
> >>> +        }
> >>> +    }
> >>> +}
> >>> +
> >>> +/// Wrapper for board-dependent PWM arguments [`struct pwm_args`](sr=
ctree/include/linux/pwm.h).
> >>> +#[repr(transparent)]
> >>> +pub struct Args(Opaque<bindings::pwm_args>);
> >>> +
> >>> +impl Args {
> >>> +    /// Creates an `Args` wrapper from a C struct pointer.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// The caller must ensure that `c_args_ptr` is a valid, non-nul=
l pointer
> >>> +    /// to `bindings::pwm_args` and that the pointed-to data is valid
> >>> +    /// for the duration of this function call (as data is copied).
> >>> +    unsafe fn from_c_ptr(c_args_ptr: *const bindings::pwm_args) -> S=
elf {
> >>> +        // SAFETY: Caller guarantees `c_args_ptr` is valid. We deref=
erence it to copy.
> >>> +        Args(Opaque::new(unsafe { *c_args_ptr }))
> >>> +    }
> >>> +
> >>> +    /// Returns the period of the PWM signal in nanoseconds.
> >>> +    pub fn period(&self) -> u64 {
> >>> +        // SAFETY: `self.0.get()` returns a pointer to the `bindings=
::pwm_args`
> >>> +        // managed by the `Opaque` wrapper. This pointer is guarante=
ed to be
> >>> +        // valid and aligned for the lifetime of `self` because `Opa=
que` owns a copy.
> >>> +        unsafe { (*self.0.get()).period }
> >>> +    }
> >>> +
> >>> +    /// Returns the polarity of the PWM signal.
> >>> +    pub fn polarity(&self) -> Result<Polarity, Error> {
> >>> +        // SAFETY: `self.0.get()` returns a pointer to the `bindings=
::pwm_args`
> >>> +        // managed by the `Opaque` wrapper. This pointer is guarante=
ed to be
> >>> +        // valid and aligned for the lifetime of `self`.
> >>> +        let raw_polarity =3D unsafe { (*self.0.get()).polarity };
> >>> +        Polarity::try_from(raw_polarity)
> >>> +    }
> >>> +}
> >>> +
> >>> +/// Wrapper for PWM state [`struct pwm_state`](srctree/include/linux=
/pwm.h).
> >>> +#[repr(transparent)]
> >>> +pub struct State(bindings::pwm_state);
> >>> +
> >>> +impl Default for State {
> >>> +    fn default() -> Self {
> >>> +        Self::new()
> >>> +    }
> >>> +}
> >>> +
> >>> +impl State {
> >>> +    /// Creates a new zeroed `State`.
> >>> +    pub fn new() -> Self {
> >>> +        State(bindings::pwm_state::default())
> >>> +    }
> >>> +
> >>> +    /// Creates a `State` wrapper by taking ownership of a C `pwm_st=
ate` value.
> >>> +    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
> >>> +        State(c_state)
> >>> +    }
> >>> +
> >>> +    /// Gets the period of the PWM signal in nanoseconds.
> >>> +    pub fn period(&self) -> u64 {
> >>> +        self.0.period
> >>> +    }
> >>> +
> >>> +    /// Sets the period of the PWM signal in nanoseconds.
> >>> +    pub fn set_period(&mut self, period_ns: u64) {
> >>> +        self.0.period =3D period_ns;
> >>> +    }
> >>> +
> >>> +    /// Gets the duty cycle of the PWM signal in nanoseconds.
> >>> +    pub fn duty_cycle(&self) -> u64 {
> >>> +        self.0.duty_cycle
> >>> +    }
> >>> +
> >>> +    /// Sets the duty cycle of the PWM signal in nanoseconds.
> >>> +    pub fn set_duty_cycle(&mut self, duty_ns: u64) {
> >>> +        self.0.duty_cycle =3D duty_ns;
> >>> +    }
> >>> +
> >>> +    /// Returns `true` if the PWM signal is enabled.
> >>> +    pub fn enabled(&self) -> bool {
> >>> +        self.0.enabled
> >>> +    }
> >>> +
> >>> +    /// Sets the enabled state of the PWM signal.
> >>> +    pub fn set_enabled(&mut self, enabled: bool) {
> >>> +        self.0.enabled =3D enabled;
> >>> +    }
> >>> +
> >>> +    /// Gets the polarity of the PWM signal.
> >>> +    pub fn polarity(&self) -> Result<Polarity, Error> {
> >>> +        Polarity::try_from(self.0.polarity)
> >>> +    }
> >>> +
> >>> +    /// Sets the polarity of the PWM signal.
> >>> +    pub fn set_polarity(&mut self, polarity: Polarity) {
> >>> +        self.0.polarity =3D polarity.into();
> >>> +    }
> >>
> >> Please don't expose these non-atomic callbacks. pwm_disable() would be
> >> fine.
>=20
> Hmm, I've just realized that without those setters it would most likely
> impossible to correctly implement the get_state callback.

You shouldn't implement the get_state callback for a waveform driver.

Best regards
Uwe

--xtyje22fzap3kfwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhhFXcACgkQj4D7WH0S
/k4hXwgAjDI3/yCxGQSnVNi7bmlkJAfS/Ar/IwEdC6uePUNh7sWLnwO55/pVf7DE
oPHSegfWLKW1coyIjdpe/TQAPk/li1qMHRIfE1JvLwKh5OAGp/pacySNb5D5HESH
EPXHCs3ar6tq3hC9XSZj+nO5/2uKrwN7hoBIY7uuJzByQ0ulFmqrNzpzw+C3k/vD
bZJKGINaBY2Ps9DJ2mMoy0NsCb0JdcWG2HD6sXlW1nA4tenKDhIyyk6oL4cDwkDL
DshTBF9k1Y+WunbCOkeEre5ySasV95Wtcr/FcIOKxdfkDKw5jPorh2qGIj+CAHAl
uuB+FAHXCy4bBYlM+HDzaoBVjG9Ezg==
=NlRT
-----END PGP SIGNATURE-----

--xtyje22fzap3kfwu--

