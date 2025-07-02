Return-Path: <linux-pwm+bounces-6704-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA50AF5C6E
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 17:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68EB18953BB
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499ED30AACD;
	Wed,  2 Jul 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3YKk9tc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FEB30AAC3;
	Wed,  2 Jul 2025 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469223; cv=none; b=r1OAYhvJkKgu2IJvaj/YV3U/GrS/qlNCckMzfj3XqkR6aefX8+pWcFWNzTDcFyCpWgRN/kpz+P9jdwfHVV/gtjbsopmbcdTvllnZKr0yE9HblF2oCGvxA8wwR28A88VCuEt3jlqjhBZdeirFr9518VRTsCgPrOqE+l5lpdutueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469223; c=relaxed/simple;
	bh=9KOpZ+d/XCXNDsoS55VxNUdTj9TN9I7t+x/Rpsw/H7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/MlSEhxLCu5qCP/c/DuPEKogGIdqk72N2GPpLxQKv89NcL+PhCbDW0YP7Cge8RbNHNqZ9zF5sjTZeemWUkc3pqKWn5XB51Lmz84H9iZP1H74nGrCMZ0YMPhkl8aGqLMjFVCQ44/mm4ZgyIODXf9S2y278xu2qVEGjNdd8jnNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3YKk9tc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A56C4CEE7;
	Wed,  2 Jul 2025 15:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751469222;
	bh=9KOpZ+d/XCXNDsoS55VxNUdTj9TN9I7t+x/Rpsw/H7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3YKk9tcc21lKT0e8rJsMgs392Ojl6R9DEscpVgysb7rhzQEb/5aQmDusOXxbcfKN
	 HdFhz4rka4g4jIgo8bej4SSBWSJ1LcCipsCMZ2lOrA6G1tXp2arxNhF8axS6Jm85sn
	 Bi3cG2p92nnYcCrLxZwQZzZh4uasZkmOkoJrQ+gI5k75y2n+XpWsINKGqd4LAIJrzH
	 PymYC+//cYLekNyniNlYPjTQUL7FzMjAnQyC9AoNNX9E91LMFh3tCWYIkAj8pEMxX9
	 3ZI1qDtXCuFm7ac56rBTj7QbLPaQgudPU9IFUQVO0QBjnayWM5dceCsqui6wW4SAl1
	 WwXV/5Tu5oV3g==
Date: Wed, 2 Jul 2025 17:13:34 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/8] rust: pwm: Add core 'Device' and 'Chip' object
 wrappers
Message-ID: <aGVMnmoepIVSS0yK@pollux>
References: <20250702-rust-next-pwm-working-fan-for-sending-v7-0-67ef39ff1d29@samsung.com>
 <CGME20250702134957eucas1p1d84f2ed3014cf98ea3a077c7fae6dea6@eucas1p1.samsung.com>
 <20250702-rust-next-pwm-working-fan-for-sending-v7-3-67ef39ff1d29@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-rust-next-pwm-working-fan-for-sending-v7-3-67ef39ff1d29@samsung.com>

On Wed, Jul 02, 2025 at 03:45:31PM +0200, Michal Wilczynski wrote:
> Building on the basic data types, this commit introduces the central
> object abstractions for the PWM subsystem: Device and Chip. It also
> includes the core trait implementations that make the Chip wrapper a
> complete, safe, and managed object.
> 
> The main components of this change are:
>  - Device and Chip Structs: These structs wrap the underlying struct
>    pwm_device and struct pwm_chip C objects, providing safe, idiomatic
>    methods to access their fields.
> 
>  - High-Level `Device` API: Exposes safe wrappers for the modern
>    `waveform` API, allowing consumers to apply, read, and pre-validate
>    hardware configurations.
> 
>  - Core Trait Implementations for Chip:
>     - AlwaysRefCounted: Links the Chip's lifetime to its embedded
>       struct device reference counter. This enables automatic lifetime
>       management via ARef.
>     - Send and Sync: Marks the Chip wrapper as safe for use across
>       threads. This is sound because the C core handles all necessary
>       locking for the underlying object's state.
> 
> These wrappers and traits form a robust foundation for building PWM
> drivers in Rust.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Few more comments below, with those fixed:

	Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> +/// Wrapper for a PWM device [`struct pwm_device`](srctree/include/linux/pwm.h).
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::pwm_device>);
> +
> +impl Device {

<snip>

> +    /// Gets a reference to the parent `Chip` that this device belongs to.
> +    pub fn chip(&self) -> &Chip {
> +        // SAFETY: `self.as_raw()` provides a valid pointer. (*self.as_raw()).chip
> +        // is assumed to be a valid pointer to `pwm_chip` managed by the kernel.
> +        // Chip::as_ref's safety conditions must be met.
> +        unsafe { Chip::as_ref((*self.as_raw()).chip) }

I assume the C API does guarantee that a struct pwm_device *always* holds a
valid pointer to a struct pwm_chip?

> +
> +/// Wrapper for a PWM chip/controller ([`struct pwm_chip`](srctree/include/linux/pwm.h)).
> +#[repr(transparent)]
> +pub struct Chip(Opaque<bindings::pwm_chip>);
> +
> +impl Chip {
> +    /// Creates a reference to a [`Chip`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
> +    /// returned [`Chip`] reference.
> +    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::pwm_chip) -> &'a Self {
> +        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
> +        // `Chip` type being transparent makes the cast ok.
> +        unsafe { &*ptr.cast::<Self>() }
> +    }
> +
> +    /// Returns a raw pointer to the underlying `pwm_chip`.
> +    pub(crate) fn as_raw(&self) -> *mut bindings::pwm_chip {
> +        self.0.get()
> +    }
> +
> +    /// Gets the number of PWM channels (hardware PWMs) on this chip.
> +    pub fn npwm(&self) -> u32 {
> +        // SAFETY: `self.as_raw()` provides a valid pointer for `self`'s lifetime.
> +        unsafe { (*self.as_raw()).npwm }
> +    }
> +
> +    /// Returns `true` if the chip supports atomic operations for configuration.
> +    pub fn is_atomic(&self) -> bool {
> +        // SAFETY: `self.as_raw()` provides a valid pointer for `self`'s lifetime.
> +        unsafe { (*self.as_raw()).atomic }
> +    }
> +
> +    /// Returns a reference to the embedded `struct device` abstraction.
> +    pub fn device(&self) -> &device::Device {
> +        // SAFETY: `self.as_raw()` provides a valid pointer to `bindings::pwm_chip`.
> +        // The `dev` field is an instance of `bindings::device` embedded within `pwm_chip`.
> +        // Taking a pointer to this embedded field is valid.
> +        // `device::Device` is `#[repr(transparent)]`.
> +        // The lifetime of the returned reference is tied to `self`.
> +        let dev_field_ptr = unsafe { core::ptr::addr_of!((*self.as_raw()).dev) };

I think you can use `&raw` instead.

> +        // SAFETY: `dev_field_ptr` is a valid pointer to `bindings::device`.
> +        // Casting and dereferencing is safe due to `repr(transparent)` and lifetime.
> +        unsafe { &*(dev_field_ptr.cast::<device::Device>()) }

Please use Device::as_ref() instead.

> +    }
> +
> +    /// Gets the *typed* driver-specific data associated with this chip's embedded device.
> +    pub fn drvdata<T: 'static>(&self) -> &T {

You need to make the whole Chip structure generic over T, i.e.
Chip<T: ForeignOwnable>.

Otherwise the API is unsafe, since the caller can pass in any T when calling
`chip.drvdata()` regardless of whether you actually stored as private data
through Chip::new().

Also, given that `T: ForeignOwnable`, you should return `T::Borrowed`.

> +        // SAFETY: `self.as_raw()` gives a valid pwm_chip pointer.
> +        // `bindings::pwmchip_get_drvdata` is the C function to retrieve driver data.
> +        let ptr = unsafe { bindings::pwmchip_get_drvdata(self.as_raw()) };
> +
> +        // SAFETY: The only way to create a chip is through Chip::new, which initializes
> +        // this pointer.
> +        unsafe { &*ptr.cast::<T>() }
> +    }
> +
> +    /// Allocates and wraps a PWM chip using `bindings::pwmchip_alloc`.
> +    ///
> +    /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
> +    /// on its embedded `struct device`.
> +    pub fn new<T: 'static + ForeignOwnable>(
> +        parent_dev: &device::Device,
> +        npwm: u32,
> +        sizeof_priv: usize,
> +        drvdata: T,

As mentioned above, the whole Chip structure needs to be generic over T,
otherwise you can't guarantee that this T is the same T as the one in drvdata().

> +// SAFETY: Implements refcounting for `Chip` using the embedded `struct device`.
> +unsafe impl AlwaysRefCounted for Chip {
> +    #[inline]
> +    fn inc_ref(&self) {
> +        // SAFETY: `self.0.get()` points to a valid `pwm_chip` because `self` exists.
> +        // The embedded `dev` is valid. `get_device` increments its refcount.
> +        unsafe {
> +            bindings::get_device(core::ptr::addr_of_mut!((*self.0.get()).dev));

I think you can use `&raw mut` instead.

Also, if you move the semicolon at the end of the unsafe block, this goes in one
line.

> +        }
> +    }
> +
> +    #[inline]
> +    unsafe fn dec_ref(obj: NonNull<Chip>) {
> +        let c_chip_ptr = obj.cast::<bindings::pwm_chip>().as_ptr();
> +
> +        // SAFETY: `obj` is a valid pointer to a `Chip` (and thus `bindings::pwm_chip`)
> +        // with a non-zero refcount. `put_device` handles decrement and final release.
> +        unsafe {
> +            bindings::put_device(core::ptr::addr_of_mut!((*c_chip_ptr).dev));
> +        }

Same here.

> +    }
> +}

