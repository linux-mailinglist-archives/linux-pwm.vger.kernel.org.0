Return-Path: <linux-pwm+bounces-7382-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CACBB1BAE
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 23:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4A42A4509
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C41930EF7A;
	Wed,  1 Oct 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="Q3rH9e6Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9226A2727FA;
	Wed,  1 Oct 2025 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352498; cv=none; b=WntjaugkW/PENiNk8x2MJ/IRwJ1wJjmAaAar7OdS2m4TyKOBVyS7kCrlUfILQ522k1bb05w1S8RPVRy/OhGEcGazSR6dLg+SK05t8ne7dai80CMtIjyBtEO+jOXrIHParTRHbp/TgExgf/NYAr2y4GVM3qX1DmK123mIpTY/ESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352498; c=relaxed/simple;
	bh=h0SDlqzubMyx2T3IEnyVrEp7j/ci3ZmMZB1Oq8kB3UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohIw8GbPAAC7aNqFmv0K3KrLncHrKhGzyaEM4ypajNDfRQACfWdTLWZ6Yu9OVlbnstDqwEy7LImGCeKfx0y+U0FWFUC5lH2AMskXuRRJmMZn1oJ/k675NJ+np7J5kCTptgqf7ES38Byax+6BD1Za9JHK8F7albeD1LWwh596Z/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=Q3rH9e6Q; arc=none smtp.client-ip=145.131.90.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=startmail1; t=1759351963;
	bh=UoLolgZjobGjS/KiQaI7MTlo0BgUiakv4CVrspm+7+k=;
	h=Date:From:To:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:From:Subject:To:Date:Sender:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition:Mime-Version:
	 Reply-To:In-Reply-To:References:Message-Id:List-Unsubscribe:
	 List-Unsubscribe-Post:Autocrypt;
	b=Q3rH9e6Q0Ei+/evpcdwzIcU4DnfCsJbXD/3fzLRk3weIh8Jbn85D2yBOaiHlOy1Ij
	 70EoEjE/a0a5mG74BJZ0kB9hohYooyTxdzwL4tRvWSQOrc0LZp1hvO7o5g2Orq7cAD
	 581zSHYD7PdTKvzV9Iqt9uMyml4z0nqhIzCjqZ5hDsi+HNAx80SJkMZ6NIHS5raroT
	 9RMbpSSwYEkniT4heI6UGS640jLv0gMSrUTJpPUjPv2AYV1NreZxBjHknWQLgYzaQZ
	 wnFcksso4yoBF3nEC+ea83im1nG0tqdJ/MGoz4ypPQYmh8iNUON9jmEh5ag4oz91dA
	 1g9XW9XIIKfyA==
Date: Wed, 1 Oct 2025 20:52:39 +0000
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
Subject: Re: [PATCH v15 2/7] rust: pwm: Add Kconfig and basic data structures
Message-ID: <aN2Ul7nHCg6M4uez@archiso>
References: <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
 <CGME20250930122732eucas1p2fbf9c050934b356165377776a8aef247@eucas1p2.samsung.com>
 <20250930-rust-next-pwm-working-fan-for-sending-v15-2-5661c3090877@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250930-rust-next-pwm-working-fan-for-sending-v15-2-5661c3090877@samsung.com>

On Tue, Sep 30, 2025 at 02:20:33PM +0200, Michal Wilczynski wrote:
> Introduce the foundational support for PWM abstractions in Rust.
> 
> This commit adds the `RUST_PWM_ABSTRACTIONS` Kconfig option to enable
> the feature, along with the necessary build-system support and C
> helpers.
> 
> It also introduces the first set of safe wrappers for the PWM
> subsystem, covering the basic data carrying C structs and enums:
> - `Polarity`: A safe wrapper for `enum pwm_polarity`.
> - `Waveform`: A wrapper for `struct pwm_waveform`.
> - `State`: A wrapper for `struct pwm_state`.
> 
> These types provide memory safe, idiomatic Rust representations of the
> core PWM data structures and form the building blocks for the
> abstractions that will follow.
> 
> Tested-by: Drew Fustini <fustini@kernel.org>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS                     |   8 ++++
>  drivers/pwm/Kconfig             |  13 +++++
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/pwm.c              |  20 ++++++++
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/pwm.rs              | 102 ++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 147 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa45799dfe07de2f54de6d6a1ce0615..5d7c0676c1d00a02b3d7db2de88b039c08c99c6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20387,6 +20387,14 @@ F:	include/linux/pwm.h
>  F:	include/linux/pwm_backlight.h
>  K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
>  
> +PWM SUBSYSTEM BINDINGS [RUST]
> +M:	Michal Wilczynski <m.wilczynski@samsung.com>
> +L:	linux-pwm@vger.kernel.org
> +L:	rust-for-linux@vger.kernel.org
> +S:	Maintained
> +F:	rust/helpers/pwm.c
> +F:	rust/kernel/pwm.rs
> +
>  PXA GPIO DRIVER
>  M:	Robert Jarzmik <robert.jarzmik@free.fr>
>  L:	linux-gpio@vger.kernel.org
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index f00ce973dddf651287168b44228574f4d5c28dc0..2b608f4378138775ee3ba4d53f682952e1914118 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -800,4 +800,17 @@ config PWM_XILINX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-xilinx.
>  
> + config RUST_PWM_ABSTRACTIONS
> +	bool "Rust PWM abstractions support"
> +	depends on RUST
> +	depends on PWM=y
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
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 84d60635e8a9baef1f1a1b2752dc0fa044f8542f..7a06ee5781eadc9f21ccd456b574a9cb152cd58c 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -66,6 +66,7 @@
>  #include <linux/pm_opp.h>
>  #include <linux/poll.h>
>  #include <linux/property.h>
> +#include <linux/pwm.h>
>  #include <linux/refcount.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/sched.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7cf7fe95e41dd51717050648d6160bebebdf4b26..861052ffffaff60e9c2e8109e55f3b6158ff2281 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -35,6 +35,7 @@
>  #include "platform.c"
>  #include "poll.c"
>  #include "property.c"
> +#include "pwm.c"
>  #include "rbtree.c"
>  #include "rcu.c"
>  #include "refcount.c"
> diff --git a/rust/helpers/pwm.c b/rust/helpers/pwm.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d75c588863685d3990b525bb1b84aa4bc35ac397
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
> index ed53169e795c0badf548025a57f946fa18bc73e3..e339b552f9650803b1efa1eb8ecc6fe9d2c56563 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -117,6 +117,8 @@
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
> index 0000000000000000000000000000000000000000..beabf0086a2f1beea01e0b0a9f6540c601f77a49
> --- /dev/null
> +++ b/rust/kernel/pwm.rs
> @@ -0,0 +1,102 @@
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
> +/// PWM polarity. Mirrors [`enum pwm_polarity`](srctree/include/linux/pwm.h).
> +#[derive(Copy, Clone, Debug, PartialEq, Eq)]
> +pub enum Polarity {
> +    /// Normal polarity (duty cycle defines the high period of the signal).
> +    Normal,
> +
> +    /// Inversed polarity (duty cycle defines the low period of the signal).
> +    Inversed,
> +}
> +
> +impl TryFrom<bindings::pwm_polarity> for Polarity {
> +    type Error = Error;
> +
> +    fn try_from(polarity: bindings::pwm_polarity) -> Result<Self, Error> {
> +        match polarity {
> +            bindings::pwm_polarity_PWM_POLARITY_NORMAL => Ok(Polarity::Normal),
> +            bindings::pwm_polarity_PWM_POLARITY_INVERSED => Ok(Polarity::Inversed),
> +            _ => Err(EINVAL),
> +        }
> +    }
> +}
> +
> +impl From<Polarity> for bindings::pwm_polarity {
> +    fn from(polarity: Polarity) -> Self {
> +        match polarity {
> +            Polarity::Normal => bindings::pwm_polarity_PWM_POLARITY_NORMAL,
> +            Polarity::Inversed => bindings::pwm_polarity_PWM_POLARITY_INVERSED,
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
> +    /// For a typical normal polarity configuration (active-high) this is the
> +    /// high time of the signal.
> +    pub duty_length_ns: u64,
> +
> +    /// Duty-cycle start offset, in nanoseconds.
> +    ///
> +    /// Delay from the beginning of the period to the first active edge.
> +    /// In most simple PWM setups this is `0`, so the duty cycle starts
> +    /// immediately at each period’s start.
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
> +/// Wrapper for PWM state [`struct pwm_state`](srctree/include/linux/pwm.h).
> +#[repr(transparent)]
> +pub struct State(bindings::pwm_state);
> +
> +impl State {
> +    /// Creates a `State` wrapper by taking ownership of a C `pwm_state` value.
> +    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
> +        State(c_state)
> +    }
> +
> +    /// Returns `true` if the PWM signal is enabled.
> +    pub fn enabled(&self) -> bool {
> +        self.0.enabled
> +    }
> +}
> 
> -- 
> 2.34.1
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

