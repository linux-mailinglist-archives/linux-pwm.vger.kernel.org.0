Return-Path: <linux-pwm+bounces-7125-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F33B2E73B
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 23:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92C3587D6A
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B8E308F09;
	Wed, 20 Aug 2025 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="nq66mxZF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712692D4812;
	Wed, 20 Aug 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724293; cv=none; b=iblh67K+zusqw4B0KBjvIMfskFG6QwQoEdfwj/uaY5rUxNuxPUKyxrIn78Hbzk4nn5QMcC2yNzdEspm4OYi1P2x6UC9jj0tFx9Z4+pUVePaakTMSQXUPGtnyfxgZfzigogtTGvaseUjPzaALoho+2hcCsiHuhJ2T85ii7rCm7No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724293; c=relaxed/simple;
	bh=lMfyezEWt6cm0Z+dXwO56ML04/LPkrLTUV7fl/2JrW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW8UjZui4c2EjG6OVhuk7icedWgbt+6szwkgwi3RHUUKHunB6LgoFsV6iApnxuL0zYJyHXNJ5Xcg+6mDNE1aG6AYnKAAYserllHQzkz45TfIQTxIABL3ZRoauJrtmbS7hAxSp6w7TYptfm+kfWHWcGgw0Z+LV49aErMWyMQSlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=nq66mxZF; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755724284; x=1755983484;
	bh=6caviZzIs7lelearGQpukUKVDo+2CTr4oc5QfWT1Mkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nq66mxZFbqSP95If4BeusFfKPgmA3E9W3tBOmo1zCSdK/gBzkpE5mZSPoGS9VvbLp
	 ut0CEtwi0ZV5bA06ADmjDKQVk6J7h/Y7FvmBaizrNNN+XUh9DKxgC7RX/dY7FcRUmu
	 d0HhutVbw5ZLqUAGS4QD8jJQEvBg49xEkni5J9nHZ7SN/FhKfKI5nb8fcoBk2Pnl/7
	 k8cQ+OGKixL/rvrRcqm1hAB+q7b/kh2hutzLF8ne4EbivyKVZPR+3ONctXewprU1N6
	 K3sMzjggt0mIwL3EAvP7tnC4y034VCPo3+tE7FX2HtbA25g11wZMn5MR8VV18gEv9W
	 2EBK8YJdzjZZQ==
X-Pm-Submission-Id: 4c6fJP6jTHz1DDC1
Date: Wed, 20 Aug 2025 21:11:13 +0000
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
Subject: Re: [PATCH v14 3/7] rust: pwm: Add complete abstraction layer
Message-ID: <aKY58dUO0RsoOqGb@archiso>
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
 <CGME20250820083544eucas1p233f8b8f7d1c0b59acededa3572d632aa@eucas1p2.samsung.com>
 <20250820-rust-next-pwm-working-fan-for-sending-v14-3-df2191621429@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-rust-next-pwm-working-fan-for-sending-v14-3-df2191621429@samsung.com>

On Wed, Aug 20, 2025 at 10:35:38AM +0200, Michal Wilczynski wrote:
> Introduce a comprehensive abstraction layer for the PWM subsystem to
> enable writing drivers in Rust.
> 
> Because `Device`, `Chip`, and `PwmOps` all refer to each other, they
> form a single, indivisible unit with circular dependencies. They are
> introduced together in this single commit to create a complete,
> compilable abstraction layer.
> 
> The main components are:
>  - Data Wrappers: Safe, idiomatic wrappers for core C types like
>    `pwm_device`, and `pwm_chip`.
> 
>  - PwmOps Trait: An interface that drivers can implement to provide
>    their hardware-specific logic, mirroring the C `pwm_ops` interface.
> 
>  - FFI VTable and Adapter: A bridge to connect the high-level PwmOps trait
>    to the C kernel's pwm_ops vtable.
> 
>  - Allocation and Lifetime Management: A high-level `Chip::new()`
>    API to safely allocate a chip and a `Registration` guard that integrates
>    with `devres` to manage the chip's registration with the PWM core.
>    An `AlwaysRefCounted` implementation and a custom release handler
>    prevent memory leaks by managing the chip's lifetime and freeing
>    driver data correctly.
> 
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  rust/kernel/pwm.rs | 671 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 669 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 57675a3dfca12033355670deb210ca66f8469334..52ab267083f8ecc3090962603cf8b9e4a33dd0c0 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -8,10 +8,14 @@
>  
>  use crate::{
>      bindings,
> +    container_of,
> +    device::{self, Bound},
> +    devres,
> +    error::{self, to_result},
>      prelude::*,
> -    types::Opaque,
> +    types::{ARef, AlwaysRefCounted, Opaque},
>  };
> -use core::convert::TryFrom;
> +use core::{convert::TryFrom, marker::PhantomData, ptr::NonNull};
>  
>  /// PWM polarity. Mirrors [`enum pwm_polarity`](srctree/include/linux/pwm.h).
>  #[derive(Copy, Clone, Debug, PartialEq, Eq)]
> @@ -121,3 +125,666 @@ pub fn enabled(&self) -> bool {
>          self.0.enabled
>      }
>  }
> +
> +/// Describes the outcome of a `round_waveform` operation.
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub enum RoundingOutcome {
> +    /// The requested waveform was achievable exactly or by rounding values down.
> +    ExactOrRoundedDown,
> +
> +    /// The requested waveform could only be achieved by rounding up.
> +    RoundedUp,
> +}
> +
> +/// Wrapper for a PWM device [`struct pwm_device`](srctree/include/linux/pwm.h).
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::pwm_device>);
> +
> +impl Device {
> +    /// Creates a reference to a [`Device`] from a valid C pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
> +    /// returned [`Device`] reference.
> +    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::pwm_device) -> &'a Self {
> +        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
> +        // `Device` type being transparent makes the cast ok.
> +        unsafe { &*ptr.cast::<Self>() }
> +    }

This looks like the only constructor for `Device`, and it has restricted
visibility.

Would it be helpful to provide a doc-test here to show intended usage?

After looking at the C code, it looks like the raw `pwm_device` pointer
is extracted from a `device` struct, or stored in an array of
`pwm_device` pointers.

Is the intent that the `pwm_device` will always be allocated from C
code? For example, is a `pub fn new() -> &'a Self`-style constructor
not possible/desired?

> +
> +    /// Returns a raw pointer to the underlying `pwm_device`.
> +    fn as_raw(&self) -> *mut bindings::pwm_device {
> +        self.0.get()
> +    }
> +
> +    /// Gets the hardware PWM index for this device within its chip.
> +    pub fn hwpwm(&self) -> u32 {
> +        // SAFETY: `self.as_raw()` provides a valid pointer for `self`'s lifetime.
> +        unsafe { (*self.as_raw()).hwpwm }
> +    }
> +
> +    /// Gets a reference to the parent `Chip` that this device belongs to.
> +    pub fn chip<T: PwmOps>(&self) -> &Chip<T> {
> +        // SAFETY: `self.as_raw()` provides a valid pointer. (*self.as_raw()).chip
> +        // is assumed to be a valid pointer to `pwm_chip` managed by the kernel.
> +        // Chip::from_raw's safety conditions must be met.
> +        unsafe { Chip::<T>::from_raw((*self.as_raw()).chip) }
> +    }
> +
> +    /// Gets the label for this PWM device, if any.
> +    pub fn label(&self) -> Option<&CStr> {
> +        // SAFETY: self.as_raw() provides a valid pointer.
> +        let label_ptr = unsafe { (*self.as_raw()).label };
> +        if label_ptr.is_null() {
> +            return None
> +        }
> +
> +        // SAFETY: label_ptr is non-null and points to a C string
> +        // managed by the kernel, valid for the lifetime of the PWM device.
> +        Some(unsafe { CStr::from_char_ptr(label_ptr) })
> +    }
> +
> +    /// Gets a copy of the board-dependent arguments for this PWM device.
> +    pub fn args(&self) -> Args {
> +        // SAFETY: `self.as_raw()` gives a valid pointer. `(*self.as_raw()).args`
> +        // is a valid `pwm_args` struct. `Args::from_c` copies this data.
> +        unsafe { Args::from_c((*self.as_raw()).args) }
> +    }
> +
> +    /// Gets a copy of the current state of this PWM device.
> +    pub fn state(&self) -> State {
> +        // SAFETY: `self.as_raw()` gives a valid pointer. `(*self.as_raw()).state`
> +        // is a valid `pwm_state` struct. `State::from_c` copies this data.
> +        State::from_c(unsafe { (*self.as_raw()).state })
> +    }
> +
> +    /// Sets the PWM waveform configuration and enables the PWM signal.
> +    pub fn set_waveform(&self, wf: &Waveform, exact: bool) -> Result {
> +        let c_wf = bindings::pwm_waveform::from(*wf);
> +
> +        // SAFETY: `self.as_raw()` provides a valid `*mut pwm_device` pointer.
> +        // `&c_wf` is a valid pointer to a `pwm_waveform` struct. The C function
> +        // handles all necessary internal locking.
> +        let ret = unsafe { bindings::pwm_set_waveform_might_sleep(self.as_raw(), &c_wf, exact) };
> +        to_result(ret)
> +    }
> +
> +    /// Queries the hardware for the configuration it would apply for a given
> +    /// request.
> +    pub fn round_waveform(&self, wf: &mut Waveform) -> Result<RoundingOutcome> {
> +        let mut c_wf = bindings::pwm_waveform::from(*wf);
> +
> +        // SAFETY: `self.as_raw()` provides a valid `*mut pwm_device` pointer.
> +        // `&mut c_wf` is a valid pointer to a mutable `pwm_waveform` struct that
> +        // the C function will update.
> +        let ret = unsafe { bindings::pwm_round_waveform_might_sleep(self.as_raw(), &mut c_wf) };
> +
> +        to_result(ret)?;
> +
> +        *wf = Waveform::from(c_wf);
> +
> +        if ret == 1 {
> +            Ok(RoundingOutcome::RoundedUp)
> +        } else {
> +            Ok(RoundingOutcome::ExactOrRoundedDown)
> +        }
> +    }
> +
> +    /// Reads the current waveform configuration directly from the hardware.
> +    pub fn get_waveform(&self) -> Result<Waveform> {
> +        let mut c_wf = bindings::pwm_waveform::default();
> +
> +        // SAFETY: `self.as_raw()` is a valid pointer. We provide a valid pointer
> +        // to a stack-allocated `pwm_waveform` struct for the kernel to fill.
> +        let ret = unsafe { bindings::pwm_get_waveform_might_sleep(self.as_raw(), &mut c_wf) };
> +
> +        to_result(ret)?;
> +
> +        Ok(Waveform::from(c_wf))
> +    }
> +}
> +
> +/// The result of a `round_waveform_tohw` operation.
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub struct RoundedWaveform<WfHw> {
> +    /// A status code, 0 for success or 1 if values were rounded up.
> +    pub status: c_int,
> +    /// The driver-specific hardware representation of the waveform.
> +    pub hardware_waveform: WfHw,
> +}
> +
> +/// Trait defining the operations for a PWM driver.
> +pub trait PwmOps: 'static + Sized {
> +    /// The driver-specific hardware representation of a waveform.
> +    ///
> +    /// This type must be [`Copy`], [`Default`], and fit within `PWM_WFHWSIZE`.
> +    type WfHw: Copy + Default;
> +
> +    /// Optional hook for when a PWM device is requested.
> +    fn request(
> +        _chip: &Chip<Self>,
> +        _pwm: &Device,
> +        _parent_dev: &device::Device<Bound>,
> +    ) -> Result {
> +        Ok(())
> +    }
> +
> +    /// Optional hook for capturing a PWM signal.
> +    fn capture(
> +        _chip: &Chip<Self>,
> +        _pwm: &Device,
> +        _result: &mut bindings::pwm_capture,
> +        _timeout: usize,
> +        _parent_dev: &device::Device<Bound>,
> +    ) -> Result {
> +        Err(ENOTSUPP)
> +    }
> +
> +    /// Convert a generic waveform to the hardware-specific representation.
> +    /// This is typically a pure calculation and does not perform I/O.
> +    fn round_waveform_tohw(
> +        _chip: &Chip<Self>,
> +        _pwm: &Device,
> +        _wf: &Waveform,
> +    ) -> Result<RoundedWaveform<Self::WfHw>> {
> +        Err(ENOTSUPP)
> +    }
> +
> +    /// Convert a hardware-specific representation back to a generic waveform.
> +    /// This is typically a pure calculation and does not perform I/O.
> +    fn round_waveform_fromhw(
> +        _chip: &Chip<Self>,
> +        _pwm: &Device,
> +        _wfhw: &Self::WfHw,
> +        _wf: &mut Waveform,
> +    ) -> Result {
> +        Err(ENOTSUPP)
> +    }
> +
> +    /// Read the current hardware configuration into the hardware-specific representation.
> +    fn read_waveform(
> +        _chip: &Chip<Self>,
> +        _pwm: &Device,
> +        _parent_dev: &device::Device<Bound>,
> +    ) -> Result<Self::WfHw> {
> +        Err(ENOTSUPP)
> +    }
> +
> +    /// Write a hardware-specific waveform configuration to the hardware.
> +    fn write_waveform(
> +        _chip: &Chip<Self>,
> +        _pwm: &Device,
> +        _wfhw: &Self::WfHw,
> +        _parent_dev: &device::Device<Bound>,
> +    ) -> Result {
> +        Err(ENOTSUPP)
> +    }
> +}
> +
> +/// Bridges Rust `PwmOps` to the C `pwm_ops` vtable.
> +struct Adapter<T: PwmOps> {
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: PwmOps> Adapter<T> {
> +    const VTABLE: PwmOpsVTable = create_pwm_ops::<T>();
> +
> +    /// # Safety
> +    ///
> +    /// `wfhw_ptr` must be valid for writes of `size_of::<T::WfHw>()` bytes.
> +    unsafe fn serialize_wfhw(wfhw: &T::WfHw, wfhw_ptr: *mut c_void) -> Result {
> +        let size = core::mem::size_of::<T::WfHw>();
> +
> +        build_assert!(size <= bindings::PWM_WFHWSIZE as usize);
> +
> +        // SAFETY: The caller ensures `wfhw_ptr` is valid for `size` bytes.
> +        unsafe {
> +            core::ptr::copy_nonoverlapping(
> +                core::ptr::from_ref::<T::WfHw>(wfhw).cast::<u8>(),
> +                wfhw_ptr.cast::<u8>(),
> +                size,
> +            );
> +        }
> +
> +        Ok(())
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `wfhw_ptr` must be valid for reads of `size_of::<T::WfHw>()` bytes.
> +    unsafe fn deserialize_wfhw(wfhw_ptr: *const c_void) -> Result<T::WfHw> {
> +        let size = core::mem::size_of::<T::WfHw>();
> +
> +        build_assert!(size <= bindings::PWM_WFHWSIZE as usize);
> +
> +        let mut wfhw = T::WfHw::default();
> +        // SAFETY: The caller ensures `wfhw_ptr` is valid for `size` bytes.
> +        unsafe {
> +            core::ptr::copy_nonoverlapping(
> +                wfhw_ptr.cast::<u8>(),
> +                core::ptr::from_mut::<T::WfHw>(&mut wfhw).cast::<u8>(),
> +                size,
> +            );
> +        }
> +
> +        Ok(wfhw)
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `dev` must be a valid pointer to a `bindings::device` embedded within a
> +    /// `bindings::pwm_chip`. This function is called by the device core when the
> +    /// last reference to the device is dropped.
> +    unsafe extern "C" fn release_callback(dev: *mut bindings::device) {
> +        // SAFETY: The function's contract guarantees that `dev` points to a `device`
> +        // field embedded within a valid `pwm_chip`. `container_of!` can therefore
> +        // safely calculate the address of the containing struct.
> +        let c_chip_ptr = unsafe { container_of!(dev, bindings::pwm_chip, dev) };
> +
> +        // SAFETY: `c_chip_ptr` is a valid pointer to a `pwm_chip` as established
> +        // above. Calling this FFI function is safe.
> +        let drvdata_ptr = unsafe { bindings::pwmchip_get_drvdata(c_chip_ptr) };
> +
> +        // SAFETY: The driver data was initialized in `new`. We run its destructor here.
> +        unsafe { core::ptr::drop_in_place(drvdata_ptr.cast::<T>()) };
> +
> +        // Now, call the original release function to free the `pwm_chip` itself.
> +        // SAFETY: `dev` is the valid pointer passed into this callback, which is
> +        // the expected argument for `pwmchip_release`.
> +        unsafe { bindings::pwmchip_release(dev); }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn request_callback(
> +        chip_ptr: *mut bindings::pwm_chip,
> +        pwm_ptr: *mut bindings::pwm_device,
> +    ) -> c_int {
> +        // SAFETY: PWM core guarentees `chip_ptr` and `pwm_ptr` are valid pointers.
> +        let (chip, pwm) = unsafe { (Chip::<T>::from_raw(chip_ptr), Device::from_raw(pwm_ptr)) };
> +
> +        // SAFETY: The PWM core guarantees the parent device exists and is bound during callbacks.
> +        let bound_parent = unsafe { chip.bound_parent_device() };
> +        match T::request(chip, pwm, bound_parent) {
> +            Ok(()) => 0,
> +            Err(e) => e.to_errno(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn capture_callback(
> +        chip_ptr: *mut bindings::pwm_chip,
> +        pwm_ptr: *mut bindings::pwm_device,
> +        res: *mut bindings::pwm_capture,
> +        timeout: usize,
> +    ) -> c_int {
> +        // SAFETY: Relies on the function's contract that `chip_ptr` and `pwm_ptr` are valid
> +        // pointers.
> +        let (chip, pwm, result) = unsafe {
> +            (
> +                Chip::<T>::from_raw(chip_ptr),
> +                Device::from_raw(pwm_ptr),
> +                &mut *res,
> +            )
> +        };
> +
> +        // SAFETY: The PWM core guarantees the parent device exists and is bound during callbacks.
> +        let bound_parent = unsafe { chip.bound_parent_device() };
> +        match T::capture(chip, pwm, result, timeout, bound_parent) {
> +            Ok(()) => 0,
> +            Err(e) => e.to_errno(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn round_waveform_tohw_callback(
> +        chip_ptr: *mut bindings::pwm_chip,
> +        pwm_ptr: *mut bindings::pwm_device,
> +        wf_ptr: *const bindings::pwm_waveform,
> +        wfhw_ptr: *mut c_void,
> +    ) -> c_int {
> +        // SAFETY: Relies on the function's contract that `chip_ptr` and `pwm_ptr` are valid
> +        // pointers.
> +        let (chip, pwm, wf) = unsafe {
> +            (
> +                Chip::<T>::from_raw(chip_ptr),
> +                Device::from_raw(pwm_ptr),
> +                Waveform::from(*wf_ptr),
> +            )
> +        };
> +        match T::round_waveform_tohw(chip, pwm, &wf) {
> +            Ok(rounded) => {
> +                // SAFETY: `wfhw_ptr` is valid per this function's safety contract.
> +                if unsafe { Self::serialize_wfhw(&rounded.hardware_waveform, wfhw_ptr) }.is_err() {
> +                    return EINVAL.to_errno();
> +                }
> +                rounded.status
> +            }
> +            Err(e) => e.to_errno(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn round_waveform_fromhw_callback(
> +        chip_ptr: *mut bindings::pwm_chip,
> +        pwm_ptr: *mut bindings::pwm_device,
> +        wfhw_ptr: *const c_void,
> +        wf_ptr: *mut bindings::pwm_waveform,
> +    ) -> c_int {
> +        // SAFETY: Relies on the function's contract that `chip_ptr` and `pwm_ptr` are valid
> +        // pointers.
> +        let (chip, pwm) = unsafe { (Chip::<T>::from_raw(chip_ptr), Device::from_raw(pwm_ptr)) };
> +        // SAFETY: `deserialize_wfhw`'s safety contract is met by this function's contract.
> +        let wfhw = match unsafe { Self::deserialize_wfhw(wfhw_ptr) } {
> +            Ok(v) => v,
> +            Err(e) => return e.to_errno(),
> +        };
> +
> +        let mut rust_wf = Waveform::default();
> +        match T::round_waveform_fromhw(chip, pwm, &wfhw, &mut rust_wf) {
> +            Ok(()) => {
> +                // SAFETY: `wf_ptr` is guaranteed valid by the C caller.
> +                unsafe {
> +                    *wf_ptr = rust_wf.into();
> +                };
> +                0
> +            }
> +            Err(e) => e.to_errno(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn read_waveform_callback(
> +        chip_ptr: *mut bindings::pwm_chip,
> +        pwm_ptr: *mut bindings::pwm_device,
> +        wfhw_ptr: *mut c_void,
> +    ) -> c_int {
> +        // SAFETY: Relies on the function's contract that `chip_ptr` and `pwm_ptr` are valid
> +        // pointers.
> +        let (chip, pwm) = unsafe { (Chip::<T>::from_raw(chip_ptr), Device::from_raw(pwm_ptr)) };
> +
> +        // SAFETY: The PWM core guarantees the parent device exists and is bound during callbacks.
> +        let bound_parent = unsafe { chip.bound_parent_device() };
> +        match T::read_waveform(chip, pwm, bound_parent) {
> +            // SAFETY: `wfhw_ptr` is valid per this function's safety contract.
> +            Ok(wfhw) => match unsafe { Self::serialize_wfhw(&wfhw, wfhw_ptr) } {
> +                Ok(()) => 0,
> +                Err(e) => e.to_errno(),
> +            },
> +            Err(e) => e.to_errno(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn write_waveform_callback(
> +        chip_ptr: *mut bindings::pwm_chip,
> +        pwm_ptr: *mut bindings::pwm_device,
> +        wfhw_ptr: *const c_void,
> +    ) -> c_int {
> +        // SAFETY: Relies on the function's contract that `chip_ptr` and `pwm_ptr` are valid
> +        // pointers.
> +        let (chip, pwm) = unsafe { (Chip::<T>::from_raw(chip_ptr), Device::from_raw(pwm_ptr)) };
> +
> +        // SAFETY: The PWM core guarantees the parent device exists and is bound during callbacks.
> +        let bound_parent = unsafe { chip.bound_parent_device() };
> +
> +        // SAFETY: `wfhw_ptr` is valid per this function's safety contract.
> +        let wfhw = match unsafe { Self::deserialize_wfhw(wfhw_ptr) } {
> +            Ok(v) => v,
> +            Err(e) => return e.to_errno(),
> +        };
> +        match T::write_waveform(chip, pwm, &wfhw, bound_parent) {
> +            Ok(()) => 0,
> +            Err(e) => e.to_errno(),
> +        }
> +    }
> +}
> +
> +/// VTable structure wrapper for PWM operations.
> +/// Mirrors [`struct pwm_ops`](srctree/include/linux/pwm.h).
> +#[repr(transparent)]
> +pub struct PwmOpsVTable(bindings::pwm_ops);
> +
> +// SAFETY: PwmOpsVTable is Send. The vtable contains only function pointers
> +// and a size, which are simple data types that can be safely moved across
> +// threads. The thread-safety of calling these functions is handled by the
> +// kernel's locking mechanisms.
> +unsafe impl Send for PwmOpsVTable {}
> +
> +// SAFETY: PwmOpsVTable is Sync. The vtable is immutable after it is created,
> +// so it can be safely referenced and accessed concurrently by multiple threads
> +// e.g. to read the function pointers.
> +unsafe impl Sync for PwmOpsVTable {}
> +
> +impl PwmOpsVTable {
> +    /// Returns a raw pointer to the underlying `pwm_ops` struct.
> +    pub(crate) fn as_raw(&self) -> *const bindings::pwm_ops {
> +        &self.0
> +    }
> +}
> +
> +/// Creates a PWM operations vtable for a type `T` that implements `PwmOps`.
> +///
> +/// This is used to bridge Rust trait implementations to the C `struct pwm_ops`
> +/// expected by the kernel.
> +pub const fn create_pwm_ops<T: PwmOps>() -> PwmOpsVTable {
> +    // SAFETY: `core::mem::zeroed()` is unsafe. For `pwm_ops`, all fields are
> +    // `Option<extern "C" fn(...)>` or data, so a zeroed pattern (None/0) is valid initially.
> +    let mut ops: bindings::pwm_ops = unsafe { core::mem::zeroed() };
> +
> +    ops.request = Some(Adapter::<T>::request_callback);
> +    ops.capture = Some(Adapter::<T>::capture_callback);
> +
> +    ops.round_waveform_tohw = Some(Adapter::<T>::round_waveform_tohw_callback);
> +    ops.round_waveform_fromhw = Some(Adapter::<T>::round_waveform_fromhw_callback);
> +    ops.read_waveform = Some(Adapter::<T>::read_waveform_callback);
> +    ops.write_waveform = Some(Adapter::<T>::write_waveform_callback);
> +    ops.sizeof_wfhw = core::mem::size_of::<T::WfHw>();
> +
> +    PwmOpsVTable(ops)
> +}
> +
> +/// Wrapper for a PWM chip/controller ([`struct pwm_chip`](srctree/include/linux/pwm.h)).
> +#[repr(transparent)]
> +pub struct Chip<T: PwmOps>(Opaque<bindings::pwm_chip>, PhantomData<T>);
> +
> +impl<T: PwmOps> Chip<T> {
> +    /// Creates a reference to a [`Chip`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
> +    /// returned [`Chip`] reference.
> +    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::pwm_chip) -> &'a Self {
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
> +    pub fn num_channels(&self) -> u32 {
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
> +        // SAFETY:
> +        // - `self.as_raw()` provides a valid pointer to `bindings::pwm_chip`.
> +        // - The `dev` field is an instance of `bindings::device` embedded
> +        //   within `pwm_chip`.
> +        // - Taking a pointer to this embedded field is valid.
> +        // - `device::Device` is `#[repr(transparent)]`.
> +        // - The lifetime of the returned reference is tied to `self`.
> +        unsafe { device::Device::from_raw(&raw mut (*self.as_raw()).dev) }
> +    }
> +
> +    /// Gets the typed driver specific data associated with this chip's embedded device.
> +    pub fn drvdata(&self) -> &T {
> +        // SAFETY: `pwmchip_get_drvdata` returns the pointer to the private data area,
> +        // which we know holds our `T`. The pointer is valid for the lifetime of `self`.
> +        unsafe { &*bindings::pwmchip_get_drvdata(self.as_raw()).cast::<T>() }
> +    }
> +
> +    /// Returns a reference to the parent device of this PWM chip's device.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must guarantee that the parent device exists and is bound.
> +    /// This is guaranteed by the PWM core during `PwmOps` callbacks.
> +    unsafe fn bound_parent_device(&self) -> &device::Device<Bound> {
> +        // SAFETY: Per the function's safety contract, the parent device exists.
> +        let parent = unsafe { self.device().parent().unwrap_unchecked() };
> +
> +        // SAFETY: Per the function's safety contract, the parent device is bound.
> +        // This is guaranteed by the PWM core during `PwmOps` callbacks.
> +        unsafe { parent.as_bound() }
> +    }
> +
> +    /// Allocates and wraps a PWM chip using `bindings::pwmchip_alloc`.
> +    ///
> +    /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
> +    /// on its embedded `struct device`.
> +    pub fn new(
> +        parent_dev: &device::Device,
> +        num_channels: u32,
> +        data: impl pin_init::PinInit<T, Error>,
> +    ) -> Result<ARef<Self>> {
> +        let sizeof_priv = core::mem::size_of::<T>();
> +        // SAFETY: `pwmchip_alloc` allocates memory for the C struct and our private data.
> +        let c_chip_ptr_raw = unsafe {
> +            bindings::pwmchip_alloc(parent_dev.as_raw(), num_channels, sizeof_priv)
> +        };
> +
> +        let c_chip_ptr: *mut bindings::pwm_chip = error::from_err_ptr(c_chip_ptr_raw)?;
> +
> +        // SAFETY: The `drvdata` pointer is the start of the private area, which is where
> +        // we will construct our `T` object.
> +        let drvdata_ptr = unsafe { bindings::pwmchip_get_drvdata(c_chip_ptr) };
> +
> +        // SAFETY: We construct the `T` object in-place in the allocated private memory.
> +        unsafe { data.__pinned_init(drvdata_ptr.cast())? };
> +
> +        // SAFETY: `c_chip_ptr` points to a valid chip.
> +        unsafe { (*c_chip_ptr).dev.release = Some(Adapter::<T>::release_callback); }
> +
> +        // SAFETY: `c_chip_ptr` points to a valid chip.
> +        // The `Adapter`'s `VTABLE` has a 'static lifetime, so the pointer
> +        // returned by `as_raw()` is always valid.
> +        unsafe { (*c_chip_ptr).ops = Adapter::<T>::VTABLE.as_raw(); }
> +
> +        // Cast the `*mut bindings::pwm_chip` to `*mut Chip`. This is valid because
> +        // `Chip` is `repr(transparent)` over `Opaque<bindings::pwm_chip>`, and
> +        // `Opaque<T>` is `repr(transparent)` over `T`.
> +        let chip_ptr_as_self = c_chip_ptr.cast::<Self>();
> +
> +        // SAFETY: `chip_ptr_as_self` points to a valid `Chip` (layout-compatible with
> +        // `bindings::pwm_chip`) whose embedded device has refcount 1.
> +        // `ARef::from_raw` takes this pointer and manages it via `AlwaysRefCounted`.
> +        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) })
> +    }
> +}
> +
> +// SAFETY: Implements refcounting for `Chip` using the embedded `struct device`.
> +unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
> +    #[inline]
> +    fn inc_ref(&self) {
> +        // SAFETY: `self.0.get()` points to a valid `pwm_chip` because `self` exists.
> +        // The embedded `dev` is valid. `get_device` increments its refcount.
> +        unsafe { bindings::get_device(&raw mut (*self.0.get()).dev); }
> +    }
> +
> +    #[inline]
> +    unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
> +        let c_chip_ptr = obj.cast::<bindings::pwm_chip>().as_ptr();
> +
> +        // SAFETY: `obj` is a valid pointer to a `Chip` (and thus `bindings::pwm_chip`)
> +        // with a non-zero refcount. `put_device` handles decrement and final release.
> +        unsafe { bindings::put_device(&raw mut (*c_chip_ptr).dev); }
> +    }
> +}
> +
> +// SAFETY: `Chip` is a wrapper around `*mut bindings::pwm_chip`. The underlying C
> +// structure's state is managed and synchronized by the kernel's device model
> +// and PWM core locking mechanisms. Therefore, it is safe to move the `Chip`
> +// wrapper (and the pointer it contains) across threads.
> +unsafe impl<T: PwmOps + Send> Send for Chip<T> {}
> +
> +// SAFETY: It is safe for multiple threads to have shared access (`&Chip`) because
> +// the `Chip` data is immutable from the Rust side without holding the appropriate
> +// kernel locks, which the C core is responsible for. Any interior mutability is
> +// handled and synchronized by the C kernel code.
> +unsafe impl<T: PwmOps + Sync> Sync for Chip<T> {}
> +
> +/// A resource guard that ensures `pwmchip_remove` is called on drop.
> +///
> +/// This struct is intended to be managed by the `devres` framework by transferring its ownership
> +/// via [`Devres::register`]. This ties the lifetime of the PWM chip registration
> +/// to the lifetime of the underlying device.
> +pub struct Registration<T: PwmOps> {
> +    chip: ARef<Chip<T>>,
> +}
> +
> +impl<T: 'static + PwmOps + Send + Sync> Registration<T> {
> +    /// Registers a PWM chip with the PWM subsystem.
> +    ///
> +    /// Transfers its ownership to the `devres` framework, which ties its lifetime
> +    /// to the parent device.
> +    /// On unbind of the parent device, the `devres` entry will be dropped, automatically
> +    /// calling `pwmchip_remove`. This function should be called from the driver's `probe`.
> +    pub fn register(
> +        dev: &device::Device<Bound>,
> +        chip: ARef<Chip<T>>,
> +    ) -> Result {
> +	let chip_parent = chip.device().parent().ok_or(EINVAL)?;
> +        if dev.as_raw() != chip_parent.as_raw() {
> +            return Err(EINVAL);
> +        }
> +
> +        let c_chip_ptr = chip.as_raw();
> +
> +        // SAFETY: `c_chip_ptr` points to a valid chip with its ops initialized.
> +        // `__pwmchip_add` is the C function to register the chip with the PWM core.
> +        unsafe {
> +            to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()))?;
> +        }
> +
> +        let registration = Registration { chip };
> +
> +        devres::register(dev, registration, GFP_KERNEL)
> +    }
> +}
> +
> +impl<T: PwmOps> Drop for Registration<T> {
> +    fn drop(&mut self) {
> +        let chip_raw = self.chip.as_raw();
> +
> +        // SAFETY: `chip_raw` points to a chip that was successfully registered.
> +        // `bindings::pwmchip_remove` is the correct C function to unregister it.
> +        // This `drop` implementation is called automatically by `devres` on driver unbind.
> +        unsafe { bindings::pwmchip_remove(chip_raw); }
> +    }
> +}
> 
> -- 
> 2.34.1

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

