Return-Path: <linux-pwm+bounces-6564-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30DEAEC7BA
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Jun 2025 16:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059F17A2FB5
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Jun 2025 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6DC245025;
	Sat, 28 Jun 2025 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oONHRpux"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C0238C10
	for <linux-pwm@vger.kernel.org>; Sat, 28 Jun 2025 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751121508; cv=none; b=VeddzEydv5VBE2A6bn6Y4U69mq7CH6oDBGVij6dgP9iuqulJTK0NfgY0vBacG8KHx/2q73U1eU3wo4K8S2ezpmRgHQZ1PjA6TOcPDiU6GHDnXsylOtDcvvjDYV113noY9Lc384FKdOCPrGY0wFMzypFM53wEzr6Y717LBlKzT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751121508; c=relaxed/simple;
	bh=Tyz7ATLWJ3X1VpK0cksiZbr3c0wiGN2HdZOAu6m7w1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=MiXAaeJDq6ExO32YrUf1+v02gS7MKPPY1dWZDr1jEOTgwMzFJRSyUlTPGFoQ8iBtUNGr30HPop9FO8MPwGuYcQeayPjhY3qvspRI00nldvX5WEOr9t2BioiTCawt0dnWRwZn5DkBmWmGmQYPh2pJzCi2dKeffM3dazkN40B0bLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oONHRpux; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250628143818euoutp0157fbebdd10a6017bfc2493cd62609780~NO7mX7rOK0809908099euoutp01z
	for <linux-pwm@vger.kernel.org>; Sat, 28 Jun 2025 14:38:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250628143818euoutp0157fbebdd10a6017bfc2493cd62609780~NO7mX7rOK0809908099euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751121498;
	bh=KSA9GTM2uJKAomihOW78PbzKddncOKg/92+T4DmqXRM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=oONHRpuxoq++Tw2nhsm9TDHm4CadxEDBQz4po1RczRoJXF0W74DpTt5i1+/6BFc4S
	 IeThJtz14o8MVPDXkjInNzBhFtMmUNIJZC5jmIAN7fMoE7Bvy7HxktmctPGFOnX2+c
	 /sDQGbEAvzNzUaQdfRh1mPCREZoGMWDMdrH4yYkc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250628143816eucas1p20bf7e2b3593efdf490b8e4beb8326f08~NO7k9ascb2529625296eucas1p2o;
	Sat, 28 Jun 2025 14:38:16 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250628143815eusmtip1a7e0e35cf9e35ce2b7d0796376446ed2~NO7jr5drO2363823638eusmtip1E;
	Sat, 28 Jun 2025 14:38:15 +0000 (GMT)
Message-ID: <c127e368-8c1f-4299-b222-a105940ac34e@samsung.com>
Date: Sat, 28 Jun 2025 16:38:15 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] rust: pwm: Add Kconfig and basic data structures
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
In-Reply-To: <q7sz7uci5vnyc24laqzs56vgt4i2jamb3ifyxkqom6qcml5kkv@642prvwxjkxc>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250628143816eucas1p20bf7e2b3593efdf490b8e4beb8326f08
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250623180858eucas1p1815f6d6815b1c715baad94810cefacd5
X-EPHeader: CA
X-CMS-RootMailID: 20250623180858eucas1p1815f6d6815b1c715baad94810cefacd5
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
	<CGME20250623180858eucas1p1815f6d6815b1c715baad94810cefacd5@eucas1p1.samsung.com>
	<20250623-rust-next-pwm-working-fan-for-sending-v5-1-0ca23747c23e@samsung.com>
	<q7sz7uci5vnyc24laqzs56vgt4i2jamb3ifyxkqom6qcml5kkv@642prvwxjkxc>



On 6/27/25 17:10, Uwe Kleine-König wrote:
> On Mon, Jun 23, 2025 at 08:08:49PM +0200, Michal Wilczynski wrote:
>> Introduce the foundational support for PWM abstractions in Rust.
>>
>> This commit adds the `RUST_PWM_ABSTRACTIONS` Kconfig option to enable
>> the feature, along with the necessary build-system support and C
>> helpers.
>>
>> It also introduces the first set of safe wrappers for the PWM
>> subsystem, covering the basic data carrying C structs and enums:
>> - `Polarity`: A safe wrapper for `enum pwm_polarity`.
>> - `Waveform`: A wrapper for `struct pwm_waveform`.
>> - `Args`: A wrapper for `struct pwm_args`.
>> - `State`: A wrapper for `struct pwm_state`.
>>
>> These types provide memory safe, idiomatic Rust representations of the
>> core PWM data structures and form the building blocks for the
>> abstractions that will follow.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  MAINTAINERS                     |   6 ++
>>  drivers/pwm/Kconfig             |  13 +++
>>  rust/bindings/bindings_helper.h |   1 +
>>  rust/helpers/helpers.c          |   1 +
>>  rust/helpers/pwm.c              |  20 ++++
>>  rust/kernel/lib.rs              |   2 +
>>  rust/kernel/pwm.rs              | 198 ++++++++++++++++++++++++++++++++++++++++
>>  7 files changed, 241 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..a575622454a2ef57ce055c8a8c4765fa4fddc490 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20073,6 +20073,12 @@ F:	include/linux/pwm.h
>>  F:	include/linux/pwm_backlight.h
>>  K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
>>  
>> +PWM SUBSYSTEM BINDINGS [RUST]
>> +M:	Michal Wilczynski <m.wilczynski@samsung.com>
>> +S:	Maintained
>> +F:	rust/helpers/pwm.c
>> +F:	rust/kernel/pwm.rs
>> +
>>  PXA GPIO DRIVER
>>  M:	Robert Jarzmik <robert.jarzmik@free.fr>
>>  L:	linux-gpio@vger.kernel.org
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index d9bcd1e8413eaed1602d6686873e263767c58f5f..cfddeae0eab3523f04f361fb41ccd1345c0c937b 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -790,4 +790,17 @@ config PWM_XILINX
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-xilinx.
>>  
>> + config RUST_PWM_ABSTRACTIONS
>> +	bool "Rust PWM abstractions support"
>> +	depends on RUST
>> +	depends on PWM=y
> 
> Currently CONFIG_PWM is a bool, so it cannot be =m. But I considered
> making PWM a tristate variable. How would that interfere with Rust
> support?
> 
>> +	help
>> +	  This option enables the safe Rust abstraction layer for the PWM
>> +	  subsystem. It provides idiomatic wrappers and traits necessary for
>> +	  writing PWM controller drivers in Rust.
>> +
>> +	  The abstractions handle resource management (like memory and reference
>> +	  counting) and provide safe interfaces to the underlying C core,
>> +	  allowing driver logic to be written in safe Rust.
>> +
>>  endif
>> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
>> index 693cdd01f9290fa01375cf78cac0e5a90df74c6c..6fe7dd529577952bf7adb4fe0526b0d5fbd6f3bd 100644
>> --- a/rust/bindings/bindings_helper.h
>> +++ b/rust/bindings/bindings_helper.h
>> @@ -64,6 +64,7 @@
>>  #include <linux/pm_opp.h>
>>  #include <linux/poll.h>
>>  #include <linux/property.h>
>> +#include <linux/pwm.h>
>>  #include <linux/refcount.h>
>>  #include <linux/sched.h>
>>  #include <linux/security.h>
>> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
>> index 16fa9bca5949b85e8d4cdcfe8e6886124f72d8d8..60879e6d794ce0f87e39caafc5495bf5e8acf8f0 100644
>> --- a/rust/helpers/helpers.c
>> +++ b/rust/helpers/helpers.c
>> @@ -31,6 +31,7 @@
>>  #include "platform.c"
>>  #include "pci.c"
>>  #include "pid_namespace.c"
>> +#include "pwm.c"
>>  #include "rbtree.c"
>>  #include "rcu.c"
>>  #include "refcount.c"
>> diff --git a/rust/helpers/pwm.c b/rust/helpers/pwm.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..d75c588863685d3990b525bb1b84aa4bc35ac397
>> --- /dev/null
>> +++ b/rust/helpers/pwm.c
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
>> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
>> +
>> +#include <linux/pwm.h>
>> +
>> +struct device *rust_helper_pwmchip_parent(const struct pwm_chip *chip)
>> +{
>> +	return pwmchip_parent(chip);
>> +}
>> +
>> +void *rust_helper_pwmchip_get_drvdata(struct pwm_chip *chip)
>> +{
>> +	return pwmchip_get_drvdata(chip);
>> +}
>> +
>> +void rust_helper_pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
>> +{
>> +	pwmchip_set_drvdata(chip, data);
>> +}
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index 6b4774b2b1c37f4da1866e993be6230bc6715841..ce1d08b14e456905dbe7b625bbb8ca8b08deae2a 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -105,6 +105,8 @@
>>  pub mod seq_file;
>>  pub mod sizes;
>>  mod static_assert;
>> +#[cfg(CONFIG_RUST_PWM_ABSTRACTIONS)]
>> +pub mod pwm;
>>  #[doc(hidden)]
>>  pub mod std_vendor;
>>  pub mod str;
>> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..ed681b228c414e7ae8bf80ca649ad497c9dc4ec3
>> --- /dev/null
>> +++ b/rust/kernel/pwm.rs
>> @@ -0,0 +1,198 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
>> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
>> +
>> +//! PWM subsystem abstractions.
>> +//!
>> +//! C header: [`include/linux/pwm.h`](srctree/include/linux/pwm.h).
>> +
>> +use crate::{
>> +    bindings,
>> +    prelude::*,
>> +    types::Opaque,
>> +};
>> +use core::convert::TryFrom;
>> +
>> +/// Maximum size for the hardware-specific waveform representation buffer.
>> +///
>> +/// From C: `#define WFHWSIZE 20`
>> +pub const WFHW_MAX_SIZE: usize = 20;
> 
> Can we somehow enforce that this doesn't diverge if the C define is
> increased?

You are absolutely right. The hardcoded value is a maintenance risk. The
#define is in core.c, so bindgen cannot see it.

I can address this by submitting a patch to move the #define WFHWSIZE to
include/linux/pwm.h. This will make it part of the public API, allow
bindgen to generate a binding for it, and ensure the Rust code can never
diverge. Is this fine ?

> 
>> +/// PWM polarity. Mirrors [`enum pwm_polarity`](srctree/include/linux/pwm.h).
>> +#[derive(Copy, Clone, Debug, PartialEq, Eq)]
>> +pub enum Polarity {
>> +    /// Normal polarity (duty cycle defines the high period of the signal).
>> +    Normal,
>> +
>> +    /// Inversed polarity (duty cycle defines the low period of the signal).
>> +    Inversed,
>> +}
>> +
>> +impl TryFrom<bindings::pwm_polarity> for Polarity {
>> +    type Error = Error;
>> +
>> +    fn try_from(polarity: bindings::pwm_polarity) -> Result<Self, Error> {
>> +        match polarity {
>> +            bindings::pwm_polarity_PWM_POLARITY_NORMAL => Ok(Polarity::Normal),
>> +            bindings::pwm_polarity_PWM_POLARITY_INVERSED => Ok(Polarity::Inversed),
>> +            _ => Err(EINVAL),
>> +        }
>> +    }
>> +}
>> +
>> +impl From<Polarity> for bindings::pwm_polarity {
>> +    fn from(polarity: Polarity) -> Self {
>> +        match polarity {
>> +            Polarity::Normal => bindings::pwm_polarity_PWM_POLARITY_NORMAL,
>> +            Polarity::Inversed => bindings::pwm_polarity_PWM_POLARITY_INVERSED,
>> +        }
>> +    }
>> +}
>> +
>> +/// Represents a PWM waveform configuration.
>> +/// Mirrors struct [`struct pwm_waveform`](srctree/include/linux/pwm.h).
>> +#[derive(Copy, Clone, Debug, Default, PartialEq, Eq)]
>> +pub struct Waveform {
>> +    /// Total duration of one complete PWM cycle, in nanoseconds.
>> +    pub period_length_ns: u64,
>> +
>> +    /// Duty-cycle active time, in nanoseconds.
>> +    ///
>> +    /// For a typical normal polarity configuration (active-high) this is the
>> +    /// high time of the signal.
>> +    pub duty_length_ns: u64,
>> +
>> +    /// Duty-cycle start offset, in nanoseconds.
>> +    ///
>> +    /// Delay from the beginning of the period to the first active edge.
>> +    /// In most simple PWM setups this is `0`, so the duty cycle starts
>> +    /// immediately at each period’s start.
>> +    pub duty_offset_ns: u64,
>> +}
>> +
>> +impl From<bindings::pwm_waveform> for Waveform {
>> +    fn from(wf: bindings::pwm_waveform) -> Self {
>> +        Waveform {
>> +            period_length_ns: wf.period_length_ns,
>> +            duty_length_ns: wf.duty_length_ns,
>> +            duty_offset_ns: wf.duty_offset_ns,
>> +        }
>> +    }
>> +}
>> +
>> +impl From<Waveform> for bindings::pwm_waveform {
>> +    fn from(wf: Waveform) -> Self {
>> +        bindings::pwm_waveform {
>> +            period_length_ns: wf.period_length_ns,
>> +            duty_length_ns: wf.duty_length_ns,
>> +            duty_offset_ns: wf.duty_offset_ns,
>> +        }
>> +    }
>> +}
>> +
>> +/// Wrapper for board-dependent PWM arguments [`struct pwm_args`](srctree/include/linux/pwm.h).
>> +#[repr(transparent)]
>> +pub struct Args(Opaque<bindings::pwm_args>);
>> +
>> +impl Args {
>> +    /// Creates an `Args` wrapper from a C struct pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `c_args_ptr` is a valid, non-null pointer
>> +    /// to `bindings::pwm_args` and that the pointed-to data is valid
>> +    /// for the duration of this function call (as data is copied).
>> +    unsafe fn from_c_ptr(c_args_ptr: *const bindings::pwm_args) -> Self {
>> +        // SAFETY: Caller guarantees `c_args_ptr` is valid. We dereference it to copy.
>> +        Args(Opaque::new(unsafe { *c_args_ptr }))
>> +    }
>> +
>> +    /// Returns the period of the PWM signal in nanoseconds.
>> +    pub fn period(&self) -> u64 {
>> +        // SAFETY: `self.0.get()` returns a pointer to the `bindings::pwm_args`
>> +        // managed by the `Opaque` wrapper. This pointer is guaranteed to be
>> +        // valid and aligned for the lifetime of `self` because `Opaque` owns a copy.
>> +        unsafe { (*self.0.get()).period }
>> +    }
>> +
>> +    /// Returns the polarity of the PWM signal.
>> +    pub fn polarity(&self) -> Result<Polarity, Error> {
>> +        // SAFETY: `self.0.get()` returns a pointer to the `bindings::pwm_args`
>> +        // managed by the `Opaque` wrapper. This pointer is guaranteed to be
>> +        // valid and aligned for the lifetime of `self`.
>> +        let raw_polarity = unsafe { (*self.0.get()).polarity };
>> +        Polarity::try_from(raw_polarity)
>> +    }
>> +}
>> +
>> +/// Wrapper for PWM state [`struct pwm_state`](srctree/include/linux/pwm.h).
>> +#[repr(transparent)]
>> +pub struct State(bindings::pwm_state);
>> +
>> +impl Default for State {
>> +    fn default() -> Self {
>> +        Self::new()
>> +    }
>> +}
>> +
>> +impl State {
>> +    /// Creates a new zeroed `State`.
>> +    pub fn new() -> Self {
>> +        State(bindings::pwm_state::default())
>> +    }
>> +
>> +    /// Creates a `State` wrapper by taking ownership of a C `pwm_state` value.
>> +    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
>> +        State(c_state)
>> +    }
>> +
>> +    /// Gets the period of the PWM signal in nanoseconds.
>> +    pub fn period(&self) -> u64 {
>> +        self.0.period
>> +    }
>> +
>> +    /// Sets the period of the PWM signal in nanoseconds.
>> +    pub fn set_period(&mut self, period_ns: u64) {
>> +        self.0.period = period_ns;
>> +    }
>> +
>> +    /// Gets the duty cycle of the PWM signal in nanoseconds.
>> +    pub fn duty_cycle(&self) -> u64 {
>> +        self.0.duty_cycle
>> +    }
>> +
>> +    /// Sets the duty cycle of the PWM signal in nanoseconds.
>> +    pub fn set_duty_cycle(&mut self, duty_ns: u64) {
>> +        self.0.duty_cycle = duty_ns;
>> +    }
>> +
>> +    /// Returns `true` if the PWM signal is enabled.
>> +    pub fn enabled(&self) -> bool {
>> +        self.0.enabled
>> +    }
>> +
>> +    /// Sets the enabled state of the PWM signal.
>> +    pub fn set_enabled(&mut self, enabled: bool) {
>> +        self.0.enabled = enabled;
>> +    }
>> +
>> +    /// Gets the polarity of the PWM signal.
>> +    pub fn polarity(&self) -> Result<Polarity, Error> {
>> +        Polarity::try_from(self.0.polarity)
>> +    }
>> +
>> +    /// Sets the polarity of the PWM signal.
>> +    pub fn set_polarity(&mut self, polarity: Polarity) {
>> +        self.0.polarity = polarity.into();
>> +    }
> 
> Please don't expose these non-atomic callbacks. pwm_disable() would be
> fine.
> 
> Otherwise I'd prefer if pwm_set_waveform_might_sleep() is the API
> exposed to/by Rust.


OK, I'll remove all the setters from the State, while will keep the
getters, as they would be useful in apply callbacks. Will implement
additional functions for Device i.e set_waveform, round_waveform and
get_waveform, and the new enum to expose the result of the
round_waveform more idiomatically.

/// Describes the outcome of a `round_waveform` operation.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum RoundingOutcome {
    /// The requested waveform was achievable exactly or by rounding values down.
    ExactOrRoundedDown,

    /// The requested waveform could only be achieved by rounding up.
    RoundedUp,
}

> 
>> +    /// Returns `true` if the PWM signal is configured for power usage hint.
>> +    pub fn usage_power(&self) -> bool {
>> +        self.0.usage_power
>> +    }
>> +
>> +    /// Sets the power usage hint for the PWM signal.
>> +    pub fn set_usage_power(&mut self, usage_power: bool) {
>> +        self.0.usage_power = usage_power;
>> +    }
> 
> I would prefer to not expose usage_power, too.
> 
>> +}
> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

