Return-Path: <linux-pwm+bounces-6147-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C59BAC4D72
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 13:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73626189DF82
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 11:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25525C80B;
	Tue, 27 May 2025 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WoD89lPu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB7259C85
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345575; cv=none; b=JdZ/ub8o4zeyoX749Xr2dmFamAgZI88vrGrX01WAykJUyvJ/kP6ihkypRLaMif0RXGx9WcID0/Wg+XH+30LcnDyaDHdvO2Yvwz4y4+GdWLc8GJYjQFY7Ffx4nMKsCFGGD6Vd7bDedoLDTV+OzU/1waDoopdiFG1VIjuNl6lc+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345575; c=relaxed/simple;
	bh=E8cs76U141TreZG79WCncz+qwuh4oPBNsR275re7vDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=rNaa/y4Ew+4EKOz40xivUCnefm7521GGjtPNncZiSaf3h/4VUnph86suKjHZTn2dfH6rI7I6yVPQbddIccQXdUT0zzF6rdwfvqavGANWXwMnUeVEFHOqyztPQHWC8nnPJosrfwjFLBY5IotU74+CX62gAqHhRM4EcPfaBBJQr8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WoD89lPu; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250527113251euoutp02be297d5bd0ed9a831e33b600677dc512~DXwi3QUqj2274022740euoutp021
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 11:32:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250527113251euoutp02be297d5bd0ed9a831e33b600677dc512~DXwi3QUqj2274022740euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748345571;
	bh=OKjCpSESUkb4BKntR9Q6EhQcq58Kfh6u4ql+GINnGyY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WoD89lPu9lfrFGA9mLG1OZbYyKqSeib/8a+dM1tQ5/I6U4e5euuS2ed4C0QRDL6d2
	 iwzWKIWSekZbLpfwBPl0vpHEPcQCgFPDw8nezSYdhGO24HR3D6k31WS8zEt73bUY6S
	 nWfpFO4ZmephyDFXTDhAydU2cxWGNjGPcIXmLiPE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250527113250eucas1p177261eeb6eed2a801aa7833e502215eb~DXwiRGfoV0287202872eucas1p1f;
	Tue, 27 May 2025 11:32:50 +0000 (GMT)
Received: from [106.210.136.40] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250527113249eusmtip11ed4a69bf02ec744b18abafcb6e3aaf4~DXwhWUyfy2813528135eusmtip1g;
	Tue, 27 May 2025 11:32:49 +0000 (GMT)
Message-ID: <498f0dd5-8dc8-492c-8b0d-abaa3a8f9a9d@samsung.com>
Date: Tue, 27 May 2025 13:32:49 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/6] rust: Add basic PWM abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
	Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Drew Fustini
	<drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob
	Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
	Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Language: pl
From: "Michal Wilczynski/Kernel (PLT) /SRPOL/Engineer/Samsung Electronics"
	<m.wilczynski@samsung.com>
In-Reply-To: <aDMDrT7WIDc-yD0p@pollux.localdomain>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250527113250eucas1p177261eeb6eed2a801aa7833e502215eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c
X-EPHeader: CA
X-CMS-RootMailID: 20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
	<CGME20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c@eucas1p1.samsung.com>
	<20250524-rust-next-pwm-working-fan-for-sending-v1-1-bdd2d5094ff7@samsung.com>
	<aDMDrT7WIDc-yD0p@pollux.localdomain>


W dniu 25.05.2025 o 13:49, Danilo Krummrich pisze:
> Hi Michal,
>
> On Sat, May 24, 2025 at 11:14:55PM +0200, Michal Wilczynski wrote:
>> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..357fda46faa99c4462149658951ec53bf9cc2d1e
>> --- /dev/null
>> +++ b/rust/kernel/pwm.rs
>> @@ -0,0 +1,376 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
>> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
>> +
>> +//! PWM (Pulse Width Modulator) abstractions.
>> +//!
>> +//! This module provides safe Rust abstractions for working with the Linux
>> +//! kernel's PWM subsystem, leveraging types generated by `bindgen`
>> +//! from `<linux/pwm.h>` and `drivers/pwm/core.c`.
>> +
>> +use crate::{
>> +    bindings,
>> +    device::Device as CoreDevice,
> I recommend referring the the base device as just device::Device, like we do it
> everywhere else where we have this name conflict.
>
> I'm not a huge fan of such aliases, since it's confusing when looking at patches
> that do not have the alias as context later on.
>
>> +    error::*,
>> +    prelude::*,
>> +    str::CStr,
>> +    types::{ForeignOwnable, Opaque},
>> +};
>> +use core::marker::PhantomData;
>> +
>> +/// PWM polarity. Mirrors `enum pwm_polarity`.
>> +#[derive(Copy, Clone, Debug, PartialEq, Eq)]
>> +pub enum Polarity {
>> +    /// Normal polarity (duty cycle defines the high period of the signal)
>> +    Normal,
>> +    /// Inversed polarity (duty cycle defines the low period of the signal)
>> +    Inversed,
>> +}
>> +
>> +impl From<bindings::pwm_polarity> for Polarity {
>> +    fn from(polarity: bindings::pwm_polarity) -> Self {
>> +        match polarity {
>> +            bindings::pwm_polarity_PWM_POLARITY_NORMAL => Polarity::Normal,
>> +            bindings::pwm_polarity_PWM_POLARITY_INVERSED => Polarity::Inversed,
>> +            _ => {
>> +                pr_warn!(
>> +                    "Unknown pwm_polarity value {}, defaulting to Normal\n",
>> +                    polarity
>> +                );
>> +                Polarity::Normal
> Either Polarity::Normal is the correct thing to return in such a case, but then
> we do not need the pr_warn!(), or it is not, but then this should be a TryFrom
> impl instead.
>
>> +            }
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
>> +/// Wrapper for board-dependent PWM arguments (`struct pwm_args`).
>> +#[repr(transparent)]
>> +pub struct Args(Opaque<bindings::pwm_args>);
>> +
>> +impl Args {
>> +    /// Creates an `Args` wrapper from the C struct reference.
>> +    fn from_c_ref(c_args: &bindings::pwm_args) -> Self {
> I'd make this a pointer type instead, rather than having conversion to a
> reference at the caller's side.
>
>> +        // SAFETY: Pointer is valid, construct Opaque wrapper. We copy the data.
>> +        Args(Opaque::new(*c_args))
>> +    }
>> +
>> +    /// Returns the period of the PWM signal in nanoseconds.
>> +    pub fn period(&self) -> u64 {
>> +        // SAFETY: Reading from the valid pointer obtained by `get()`.
> Here and below, you should explain why this pointer is guaranteed to be valid
> instead.
>
>> +        unsafe { (*self.0.get()).period }
>> +    }
>> +
>> +    /// Returns the polarity of the PWM signal.
>> +    pub fn polarity(&self) -> Polarity {
>> +        // SAFETY: Reading from the valid pointer obtained by `get()`.
>> +        Polarity::from(unsafe { (*self.0.get()).polarity })
>> +    }
>> +}
>> +
>> +/// Wrapper for PWM state (`struct pwm_state`).
>> +#[repr(transparent)]
>> +pub struct State(Opaque<bindings::pwm_state>);
>> +
>> +impl State {
>> +    /// Creates a new zeroed `State`.
>> +    pub fn new() -> Self {
>> +        State(Opaque::new(bindings::pwm_state::default()))
>> +    }
>> +
>> +    /// Creates a `State` wrapper around a copy of a C `pwm_state`.
>> +    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
>> +        State(Opaque::new(c_state))
>> +    }
> You probably don't need Opaque here, given that you have instances of
> bindings::pwm_state already.
>
>> +
>> +    /// Creates a `State` wrapper around a reference to a C `pwm_state`.
>> +    fn from_c_ref(c_state: &bindings::pwm_state) -> &Self {
>> +        // SAFETY: Pointer is valid, lifetime tied to input ref. Cast pointer type.
>> +        unsafe { &*(c_state as *const bindings::pwm_state as *const Self) }
>> +    }
>> +
>> +    /// Gets the period of the PWM signal in nanoseconds.
>> +    pub fn period(&self) -> u64 {
>> +        unsafe { (*self.0.get()).period }
> This and all the methods below lack SAFETY comments, did you compile with
> CLIPPY=1? You should get lots of warnings reminding you to add them.
>
> <snip>
>
>> +
>> +/// Wrapper for a PWM device/channel (`struct pwm_device`).
>> +#[repr(transparent)]
>> +pub struct Device(Opaque<bindings::pwm_device>);
>> +
>> +impl Device {
>> +    pub(crate) unsafe fn from_ptr<'a>(ptr: *mut bindings::pwm_device) -> &'a mut Self {
> We usually call this kind of function as_ref(), it'd be nice to stick to that
> for consistency.
>
>> +        unsafe { &mut *ptr.cast::<Self>() }
> A mutable reference -- why?
>
> <snip>
>
>> +/// Wrapper for a PWM chip/controller (`struct pwm_chip`).
>> +#[repr(transparent)]
>> +pub struct Chip(Opaque<bindings::pwm_chip>);
>> +
>> +impl Chip {
>> +    /// Creates a `Chip` reference from a raw pointer. (Safety notes apply)
>> +    pub(crate) unsafe fn from_ptr<'a>(ptr: *mut bindings::pwm_chip) -> &'a mut Self {
> Same here, for the name...
>
>> +        unsafe { &mut *ptr.cast::<Self>() }
> and the mutability.
>
>> +    }
>> +
>> +    /// Returns a raw pointer to the underlying `pwm_chip`.
>> +    pub(crate) fn as_ptr(&self) -> *mut bindings::pwm_chip {
>> +        self.0.get()
>> +    }
>> +
>> +    /// Gets the number of PWM channels (hardware PWMs) on this chip.
>> +    pub fn npwm(&self) -> u32 {
>> +        unsafe { (*self.as_ptr()).npwm }
>> +    }
>> +
>> +    /// Returns `true` if the chip supports atomic operations for configuration.
>> +    pub fn is_atomic(&self) -> bool {
>> +        unsafe { (*self.as_ptr()).atomic }
>> +    }
>> +
>> +    /// Returns a reference to the embedded `struct device` abstraction (`CoreDevice`).
>> +    pub fn device(&self) -> &CoreDevice {
>> +        // SAFETY: `dev` field exists and points to the embedded device.
>> +        let dev_ptr = unsafe { &(*self.as_ptr()).dev as *const _ as *mut bindings::device };
>> +        unsafe { &*(dev_ptr as *mut CoreDevice) }
> Missing SAFETY comment, also please use cast() and cast_{const,mut}() instead.
>
>> +    }
>> +
>> +    /// Returns a reference to the parent device (`struct device`) of this PWM chip's device.
>> +    pub fn parent_device(&self) -> Option<&CoreDevice> {
>> +        // SAFETY: Accessing fields via assumed-valid pointer and bindgen layout.
>> +        let parent_ptr = unsafe { bindings::pwmchip_parent(self.as_ptr()) };
>> +        if parent_ptr.is_null() {
>> +            None
>> +        } else {
>> +            // SAFETY: Pointer is non-null, assume valid device managed by kernel.
>> +            Some(unsafe { &*(parent_ptr as *mut CoreDevice) })
>> +        }
> This can just be
>
> 	self.device().parent() // [1]
>
> which lands through the DRM tree in the upcoming merge window.
>
> [1] https://gitlab.freedesktop.org/drm/kernel/-/blob/drm-next/rust/kernel/device.rs?ref_type=heads#L72
>
>> +    /// Gets the *typed* driver-specific data associated with this chip's embedded device.
>> +    pub fn get_drvdata<T: 'static>(&self) -> Option<&T> {
> I will soon send a patch series that adds drvdata accessors to the generic
> Device abstraction.
>
> Anyways, no need for you to wait for this.
>
>> +        let ptr = unsafe { bindings::pwmchip_get_drvdata(self.as_ptr()) };
> Obviously, the C side calls this pwmchip_get_drvdata() and dev_get_drvdata(),
> however, I suggest not to use get_drvdata() as a method name, since 'get' is
> used in the context of reference counting (get/put) instead, and hence may be
> confusing. Let's just name this drvdata().
>
>> +        if ptr.is_null() {
>> +            None
>> +        } else {
>> +            unsafe { Some(&*(ptr as *const T)) }
>> +        }
>> +    }
>> +
>> +    /// Sets the *typed* driver-specific data associated with this chip's embedded device.
>> +    pub fn set_drvdata<T: 'static + ForeignOwnable>(&mut self, data: T) {
>> +        unsafe { bindings::pwmchip_set_drvdata(self.as_ptr(), data.into_foreign() as _) }
>> +    }
>> +}
>> +
>> +/// Allocates a PWM chip structure using device resource management. Mirrors `devm_pwmchip_alloc`.
>> +pub fn devm_chip_alloc<'a>(
> This should be a function of pwm::Chip rather than standalone.
>
>> +    parent: &'a CoreDevice,
> Since you're using devres, this must be a bound device, i.e. the parameter must
> be &'a device::Device<device::Bound>, see also [2], which lands in the upcoming
> merge window through the driver-core tree.
>
> But I think this shouldn't use devm_pwmchip_alloc() anyways, see below.
>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/tree/rust/kernel/device.rs?h=driver-core-next#n237
>
>> +    npwm: u32,
>> +    sizeof_priv: usize,
>> +) -> Result<&'a mut Chip> {
> Besides the above, this solution seems a bit half-baked, since it means that you
> can only ever access the pwm::Chip as long as you have the &Device<Bound>,
> which, given that you call this function typically from probe(), not beyond the
> scope of probe().
>
> This is because you return a reference which you can't save in the driver's
> private data.
>
> Instead you should use pwmchip_alloc() instead and make this return a real
> instance of pwm::Chip and implement AlwaysRefCounted [3] for pwm::Chip.
>
> You can then store the pwm::Chip instance in the Driver's private data, which
> will only live until the driver is unbound, so it gives the same guarantees.
>
> [3] https://rust.docs.kernel.org/kernel/types/trait.AlwaysRefCounted.html
>
>> +    // SAFETY: `devm_pwmchip_alloc` called with valid args. Returns valid ptr or ERR_PTR.
>> +    let parent_ptr = parent as *const CoreDevice as *mut bindings::device;
>> +    let chip_ptr = unsafe { bindings::devm_pwmchip_alloc(parent_ptr, npwm, sizeof_priv) };
>> +    if unsafe { bindings::IS_ERR(chip_ptr as *const core::ffi::c_void) } {
>> +        let err = unsafe { bindings::PTR_ERR(chip_ptr as *const core::ffi::c_void) };
>> +        pr_err!("devm_pwmchip_alloc failed: {}\n", err);
> You have the parent device, please use dev_err!(). But I don't think this needs
> to error print at all.
>
>> +        Err(Error::from_errno(err as i32))
>> +    } else {
>> +        // SAFETY: `chip_ptr` valid, lifetime managed by `devm` tied to `parent`.
>> +        Ok(unsafe { &mut *(chip_ptr as *mut Chip) })
>> +    }
>> +}
>> +
>> +/// Registers a PWM chip with the PWM subsystem. Mirrors `__pwmchip_add`.
>> +pub fn chip_add(chip: &mut Chip, ops: &'static PwmOpsVTable) -> Result {
>> +    // SAFETY: Pointers are valid. `__pwmchip_add` requires ops to be set.
>> +    unsafe {
>> +        let chip_ptr = chip.as_ptr();
>> +        // Assign the ops pointer directly to the C struct field
>> +        (*chip_ptr).ops = ops.as_ptr();
>> +        to_result(bindings::__pwmchip_add(
>> +            chip_ptr,
>> +            core::ptr::null_mut()
>> +        ))
>> +    }
>> +}
> How do you ensure to unregister the chip, once it was registered through this
> function? I think this can cause UAF bugs. Instead you should wrap this in a
> 'Registration' structure, like we do everywhere else, see for example [4].
>
> The structure should look like this:
>
> 	pub struct Registration(ARef<Chip>);
>
> Registration::new() should register the chip and Registration::drop() should
> unregister the chip.
>
> [4] https://gitlab.freedesktop.org/drm/kernel/-/blob/drm-next/rust/kernel/drm/driver.rs?ref_type=heads#L121
>
>> +/// Registers a PWM chip using device resource management. Mirrors `__devm_pwmchip_add`.
>> +pub fn devm_chip_add(parent: &CoreDevice, chip: &mut Chip, ops: &'static PwmOpsVTable) -> Result {
>> +    // SAFETY: Pointers are valid. `__devm_pwmchip_add` requires ops to be set.
>> +    unsafe {
>> +        let chip_ptr = chip.as_ptr();
>> +        // Assign the ops pointer directly to the C struct field
>> +        (*chip_ptr).ops = ops.as_ptr();
>> +        let parent_ptr = parent as *const CoreDevice as *mut bindings::device;
>> +        to_result(bindings::__devm_pwmchip_add(
>> +            parent_ptr,
>> +            chip_ptr,
>> +            core::ptr::null_mut()
>> +        ))
>> +    }
>> +}
> This won't work anymore when creating a real pwm::Chip instance, since you can't
> guarantee that the pwm::Chip still exists when devres will clean this up.
>
> If you want devres to clean this up, you should make Registration::new() return
> a Result<Devres<Registration>> instance.
>
> This way the Registration keeps a reference to the pwm::Chip (giving the
> guarantee of no potential UAF), and the Devres container ensures to drop the
> Registration when the parent device is unbound internally.
>
> If you want the exact same semantics as your current devm_chip_add(), but
> without potential UAF, there is also Devres::new_foreign_owned() [5]. This way
> Registration::new() will only return a Result.
>
> [5] https://rust.docs.kernel.org/kernel/devres/struct.Devres.html#method.new_foreign_owned

Hi Danilo,
Thank you very much for the detailed review. I took some time to digest 
it and everything you wrote
makes perfect sense. Will also make sure to compile with CLIPPY=1 next time.

Thanks !
Michał

>

