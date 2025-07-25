Return-Path: <linux-pwm+bounces-6893-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0BB1215E
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 17:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512A43A95C8
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567102EE985;
	Fri, 25 Jul 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AgZ6wXFg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996124677E;
	Fri, 25 Jul 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753459017; cv=pass; b=JOqwwKWZwWaPtEO4EhJfMsZ/QlnrtOYdMb3QVKivdPU8V08c7T2LhFv5Tu0xQhhDNjHY8BN7i9IlfYDmGUhIG1ICqRVqWKeYADlGoaKDseSt20VM8L55lBqbvfRmnn9iE+rD34M1SbhdJqFrwYzyVi/GaUF7F3om1jt0Q+NNKu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753459017; c=relaxed/simple;
	bh=7z6ALilZGGcVq9OEqBnSz4ScHL7AEzk+/Bv10iEc6Ng=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NqQKr6nxE7B+gXbdVxrE+CQbg1E2nWndKl7c4Kk9AOy/blHzzxqOslYl7XzSWEo6/KZLTwLMid3xdYYcqqeJtYliVTzN618Fyp8bFvR5jJ+Xm5QiyguP7DqBoySz/li80+VRDkbioChADwVxbKEqSfxWBC5ssU4yXela4JU4W+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AgZ6wXFg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753458981; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IGIWm36T9IvuyGU68zv6ZMToi9jtIlncR4sLpblLyt2wtAecWScQz1w7rtpaUWrzVWMrk4LRxnuymM9nMp8ycHqCl8BoRBHsuuUQNOGDTfVkEMIw4cpOQgbUlFJ02XIWNVLYMKR5tvfVP9BnhqGseQXWIDrtufWH8bUOp/k9jZY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753458981; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E9pUD5LyN2FDLdQtIzuQV7vwiykn8dLc91OSN57RN3I=; 
	b=SyhnDNT8HG+Ph8m7Sh0U/AsJgDh9UHopJPAwmmN+PbthTL73E7CtGN7f5z13LygO+YliyEORZazhg53wuqaq50hFv/1rQnlhuf2dDFIJvKpFoTDm6XvP4IL6vmu0rExuuI5aJnC8L2jII5HxYhesgGShJJmpF0KfMTLFBsHOZUw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753458981;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=E9pUD5LyN2FDLdQtIzuQV7vwiykn8dLc91OSN57RN3I=;
	b=AgZ6wXFgHQUUq43WO17mH32pVQ6HAlL2tgs+9blEiyZj+Q1CMDLzQzgH0SZbR0B0
	ZNCO+kxxh+1bui8NjtB9b1lgiLapng6JkFFp/nrvFRtg5yCQJevS0v3+nKg44B4Qri0
	FXTkibyr9fEfnhjdQyC3YYcS9FR4AaGepA25B33o=
Received: by mx.zohomail.com with SMTPS id 1753458979249732.4888301970183;
	Fri, 25 Jul 2025 08:56:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v12 3/3] rust: pwm: Add complete abstraction layer
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250717-rust-next-pwm-working-fan-for-sending-v12-3-40f73defae0c@samsung.com>
Date: Fri, 25 Jul 2025 12:56:00 -0300
Cc: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Drew Fustini <drew@pdp7.com>,
 Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Benno Lossin <lossin@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Drew Fustini <fustini@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <42C9DF97-2E0F-453B-800A-1DA49BF8F29F@collabora.com>
References: <20250717-rust-next-pwm-working-fan-for-sending-v12-0-40f73defae0c@samsung.com>
 <CGME20250717090833eucas1p16c916450b59a77d81bd013527755cb21@eucas1p1.samsung.com>
 <20250717-rust-next-pwm-working-fan-for-sending-v12-3-40f73defae0c@samsung.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Michal,

> On 17 Jul 2025, at 06:08, Michal Wilczynski <m.wilczynski@samsung.com> =
wrote:
>=20
> Introduce a comprehensive abstraction layer for the PWM subsystem to
> enable writing drivers in Rust.
>=20
> Because `Device`, `Chip`, and `PwmOps` all refer to each other, they
> form a single, indivisible unit with circular dependencies. They are
> introduced together in this single commit to create a complete,
> compilable abstraction layer.
>=20
> The main components are:
> - Data Wrappers: Safe, idiomatic wrappers for core C types like
>   `pwm_device`, and `pwm_chip`.
>=20
> - PwmOps Trait: An interface that drivers can implement to provide
>   their hardware-specific logic, mirroring the C `pwm_ops` interface.
>=20
> - FFI VTable and Adapter: A bridge to connect the high-level PwmOps =
trait
>   to the C kernel's pwm_ops vtable.
>=20
> - Allocation and Lifetime Management: A high-level `Chip::new()`
>   API to safely allocate a chip and a `Registration` guard that =
integrates
>   with `devres` to manage the chip's registration with the PWM core.
>   An `AlwaysRefCounted` implementation and a custom release handler
>   prevent memory leaks by managing the chip's lifetime and freeing
>   driver data correctly.
>=20
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
> rust/kernel/pwm.rs | 653 =
++++++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 651 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index =
3fad101406eac728d9b12083fad7abf7b7f89b25..d881f662f0758fb0a8678386081e8cc2=
37980871 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -8,10 +8,14 @@
>=20
> use crate::{
>     bindings,
> +    container_of,
> +    device::{self, Bound},
> +    devres,
> +    error::{self, to_result},
>     prelude::*,
> -    types::Opaque,
> +    types::{ARef, AlwaysRefCounted, Opaque},
> };
> -use core::convert::TryFrom;
> +use core::{convert::TryFrom, marker::PhantomData, ptr::NonNull};
>=20
> /// PWM polarity. Mirrors [`enum =
pwm_polarity`](srctree/include/linux/pwm.h).
> #[derive(Copy, Clone, Debug, PartialEq, Eq)]
> @@ -135,3 +139,648 @@ pub fn enabled(&self) -> bool {
>         self.0.enabled
>     }
> }
> +
> +/// Describes the outcome of a `round_waveform` operation.
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub enum RoundingOutcome {
> +    /// The requested waveform was achievable exactly or by rounding =
values down.
> +    ExactOrRoundedDown,
> +
> +    /// The requested waveform could only be achieved by rounding up.
> +    RoundedUp,
> +}
> +
> +/// Wrapper for a PWM device [`struct =
pwm_device`](srctree/include/linux/pwm.h).
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::pwm_device>);
> +
> +impl Device {
> +    /// Creates a reference to a [`Device`] from a valid C pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid and remains valid =
for the lifetime of the
> +    /// returned [`Device`] reference.
> +    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::pwm_device) =
-> &'a Self {
> +        // SAFETY: The safety requirements guarantee the validity of =
the dereference, while the
> +        // `Device` type being transparent makes the cast ok.
> +        unsafe { &*ptr.cast::<Self>() }
> +    }

from_raw(). See [0].

> +
> +    /// Returns a raw pointer to the underlying `pwm_device`.
> +    fn as_raw(&self) -> *mut bindings::pwm_device {
> +        self.0.get()
> +    }
> +
> +    /// Gets the hardware PWM index for this device within its chip.
> +    pub fn hwpwm(&self) -> u32 {
> +        // SAFETY: `self.as_raw()` provides a valid pointer for =
`self`'s lifetime.
> +        unsafe { (*self.as_raw()).hwpwm }
> +    }
> +
> +    /// Gets a reference to the parent `Chip` that this device =
belongs to.
> +    pub fn chip<T: PwmOps>(&self) -> &Chip<T> {
> +        // SAFETY: `self.as_raw()` provides a valid pointer. =
(*self.as_raw()).chip
> +        // is assumed to be a valid pointer to `pwm_chip` managed by =
the kernel.
> +        // Chip::as_ref's safety conditions must be met.
> +        unsafe { Chip::<T>::as_ref((*self.as_raw()).chip) }
> +    }
> +
> +    /// Gets the label for this PWM device, if any.
> +    pub fn label(&self) -> Option<&CStr> {
> +        // SAFETY: self.as_raw() provides a valid pointer.
> +        let label_ptr =3D unsafe { (*self.as_raw()).label };
> +        if label_ptr.is_null() {
> +            None
> +        } else {
> +            // SAFETY: label_ptr is non-null and points to a C string
> +            // managed by the kernel, valid for the lifetime of the =
PWM device.
> +            Some(unsafe { CStr::from_char_ptr(label_ptr) })
> +        }
> +    }

nit: this can be written more concisely, but I personally don=E2=80=99t =
mind.

> +
> +    /// Gets a copy of the board-dependent arguments for this PWM =
device.
> +    pub fn args(&self) -> Args {
> +        // SAFETY: self.as_raw() gives a valid pointer to =
`pwm_device`.
> +        // The `args` field is a valid `pwm_args` struct embedded =
within `pwm_device`.
> +        // `Args::from_c_ptr`'s safety conditions are met by =
providing this pointer.
> +        unsafe { Args::from_c_ptr(&(*self.as_raw()).args) }
> +    }
> +
> +    /// Gets a copy of the current state of this PWM device.
> +    pub fn state(&self) -> State {
> +        // SAFETY: `self.as_raw()` gives a valid pointer. =
`(*self.as_raw()).state`
> +        // is a valid `pwm_state` struct. `State::from_c` copies this =
data.
> +        State::from_c(unsafe { (*self.as_raw()).state })
> +    }
> +
> +    /// Sets the PWM waveform configuration and enables the PWM =
signal.
> +    pub fn set_waveform(&self, wf: &Waveform, exact: bool) -> Result =
{
> +        let c_wf =3D bindings::pwm_waveform::from(*wf);
> +
> +        // SAFETY: `self.as_raw()` provides a valid `*mut pwm_device` =
pointer.
> +        // `&c_wf` is a valid pointer to a `pwm_waveform` struct. The =
C function
> +        // handles all necessary internal locking.
> +        let ret =3D unsafe { =
bindings::pwm_set_waveform_might_sleep(self.as_raw(), &c_wf, exact) };
> +        to_result(ret)
> +    }
> +
> +    /// Queries the hardware for the configuration it would apply for =
a given
> +    /// request.
> +    pub fn round_waveform(&self, wf: &mut Waveform) -> =
Result<RoundingOutcome> {
> +        let mut c_wf =3D bindings::pwm_waveform::from(*wf);
> +
> +        // SAFETY: `self.as_raw()` provides a valid `*mut pwm_device` =
pointer.
> +        // `&mut c_wf` is a valid pointer to a mutable `pwm_waveform` =
struct that
> +        // the C function will update.
> +        let ret =3D unsafe { =
bindings::pwm_round_waveform_might_sleep(self.as_raw(), &mut c_wf) };
> +
> +        to_result(ret)?;
> +
> +        *wf =3D Waveform::from(c_wf);
> +
> +        if ret =3D=3D 1 {
> +            Ok(RoundingOutcome::RoundedUp)
> +        } else {
> +            Ok(RoundingOutcome::ExactOrRoundedDown)
> +        }
> +    }
> +
> +    /// Reads the current waveform configuration directly from the =
hardware.
> +    pub fn get_waveform(&self) -> Result<Waveform> {
> +        let mut c_wf =3D bindings::pwm_waveform::default();
> +
> +        // SAFETY: `self.as_raw()` is a valid pointer. We provide a =
valid pointer
> +        // to a stack-allocated `pwm_waveform` struct for the kernel =
to fill.
> +        let ret =3D unsafe { =
bindings::pwm_get_waveform_might_sleep(self.as_raw(), &mut c_wf) };
> +
> +        to_result(ret)?;
> +
> +        Ok(Waveform::from(c_wf))
> +    }
> +}
> +
> +/// Trait defining the operations for a PWM driver.
> +pub trait PwmOps: 'static + Sized {
> +    /// The driver-specific hardware representation of a waveform.
> +    ///
> +    /// This type must be [`Copy`], [`Default`], and fit within =
`PWM_WFHWSIZE`.
> +    type WfHw: Copy + Default;

Can=E2=80=99t you use a build_assert!() here? i.e.:

    #[doc(hidden)]
    const _CHECK_SZ: () =3D {
        build_assert!(core::mem::size_of::<Self::WfHw>() <=3D =
bindings::PWM_WFHWSIZE as usize);
    };


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
> +    /// Convert a generic waveform to the hardware-specific =
representation.
> +    /// This is typically a pure calculation and does not perform =
I/O.
> +    fn round_waveform_tohw(
> +        _chip: &Chip<Self>,
> +        _pwm: &Device,
> +        _wf: &Waveform,
> +    ) -> Result<(c_int, Self::WfHw)> {


I don't think we should use tuples if we can help it. They massively =
hurt
comprehension, i.e.:

(c_int, Self::WfHw)

What is c_int here? and although Self::WfHw is at least clearer given =
the
surrounding context, it's still not great. Compare to:

struct RoundWaveform {
  a_descriptive_field_name: c_int,
  same_here: Self::WfHw
}

The above is much better.


> +        Err(ENOTSUPP)
> +    }
> +
> +    /// Convert a hardware-specific representation back to a generic =
waveform.
> +    /// This is typically a pure calculation and does not perform =
I/O.
> +    fn round_waveform_fromhw(
> +        _chip: &Chip<Self>,
> +        _pwm: &Device,
> +        _wfhw: &Self::WfHw,
> +        _wf: &mut Waveform,
> +    ) -> Result<c_int> {
> +        Err(ENOTSUPP)
> +    }

Please include at least a description of what this returns.

> +
> +    /// Read the current hardware configuration into the =
hardware-specific representation.
> +    fn read_waveform(
> +        _chip: &Chip<Self>,
> +        _pwm: &Device,
> +        _parent_dev: &device::Device<Bound>,
> +    ) -> Result<Self::WfHw> {
> +        Err(ENOTSUPP)
> +    }
> +
> +    /// Write a hardware-specific waveform configuration to the =
hardware.
> +    fn write_waveform(
> +        _chip: &Chip<Self>,
> +        _pwm: &Device,
> +        _wfhw: &Self::WfHw,
> +        _parent_dev: &device::Device<Bound>,
> +    ) -> Result {
> +        Err(ENOTSUPP)
> +    }
> +}

Blank line?

> +/// Bridges Rust `PwmOps` to the C `pwm_ops` vtable.
> +struct Adapter<T: PwmOps> {
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: PwmOps> Adapter<T> {
> +    const VTABLE: PwmOpsVTable =3D create_pwm_ops::<T>();
> +
> +    /// # Safety
> +    ///
> +    /// `wfhw_ptr` must be valid for writes of `size_of::<T::WfHw>()` =
bytes.
> +    unsafe fn serialize_wfhw(wfhw: &T::WfHw, wfhw_ptr: *mut c_void) =
-> Result {
> +        let size =3D core::mem::size_of::<T::WfHw>();
> +        if size > bindings::PWM_WFHWSIZE as usize {
> +            return Err(EINVAL);
> +        }

See my previous comment on using build_assert if possible.

> +
> +        // SAFETY: The caller ensures `wfhw_ptr` is valid for `size` =
bytes.
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
> +    /// `wfhw_ptr` must be valid for reads of `size_of::<T::WfHw>()` =
bytes.
> +    unsafe fn deserialize_wfhw(wfhw_ptr: *const c_void) -> =
Result<T::WfHw> {
> +        let size =3D core::mem::size_of::<T::WfHw>();
> +        if size > bindings::PWM_WFHWSIZE as usize {
> +            return Err(EINVAL);
> +        }
> +
> +        let mut wfhw =3D T::WfHw::default();
> +        // SAFETY: The caller ensures `wfhw_ptr` is valid for `size` =
bytes.
> +        unsafe {
> +            core::ptr::copy_nonoverlapping(
> +                wfhw_ptr.cast::<u8>(),
> +                core::ptr::from_mut::<T::WfHw>(&mut =
wfhw).cast::<u8>(),
> +                size,
> +            );
> +        }
> +
> +        Ok(wfhw)
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `dev` must be a valid pointer to a `bindings::device` =
embedded within a
> +    /// `bindings::pwm_chip`. This function is called by the device =
core when the
> +    /// last reference to the device is dropped.
> +    unsafe extern "C" fn release_callback(dev: *mut bindings::device) =
{
> +        // SAFETY: The function's contract guarantees that `dev` =
points to a `device`
> +        // field embedded within a valid `pwm_chip`. `container_of!` =
can therefore
> +        // safely calculate the address of the containing struct.
> +        let c_chip_ptr =3D unsafe { container_of!(dev, =
bindings::pwm_chip, dev) };
> +
> +        // SAFETY: `c_chip_ptr` is a valid pointer to a `pwm_chip` as =
established
> +        // above. Calling this FFI function is safe.
> +        let drvdata_ptr =3D unsafe { =
bindings::pwmchip_get_drvdata(c_chip_ptr) };
> +
> +        // SAFETY: The driver data was initialized in `new`. We run =
its destructor here.
> +        unsafe { core::ptr::drop_in_place(drvdata_ptr.cast::<T>()) };
> +
> +        // Now, call the original release function to free the =
`pwm_chip` itself.
> +        // SAFETY: `dev` is the valid pointer passed into this =
callback, which is
> +        // the expected argument for `pwmchip_release`.
> +        unsafe { bindings::pwmchip_release(dev); }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn request_callback(
> +        c: *mut bindings::pwm_chip,
> +        p: *mut bindings::pwm_device,

=E2=80=9Cp=E2=80=9D and =E2=80=9Cc=E2=80=9D are not good names. I =
understand that this is a mere callback, but still.

> +    ) -> c_int {
> +        // SAFETY: PWM core guarentees `c` and `p` are valid =
pointers.
> +        let (chip, pwm) =3D unsafe { (Chip::<T>::as_ref(c), =
Device::as_ref(p)) };
> +
> +        // SAFETY: The PWM core guarantees the parent device exists =
and is bound during callbacks.
> +        let bound_parent =3D unsafe { chip.bound_parent_device() };
> +        match T::request(chip, pwm, bound_parent) {
> +            Ok(()) =3D> 0,
> +            Err(e) =3D> e.to_errno(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn capture_callback(
> +        c: *mut bindings::pwm_chip,
> +        p: *mut bindings::pwm_device,
> +        res: *mut bindings::pwm_capture,
> +        timeout: usize,
> +    ) -> c_int {
> +        // SAFETY: Relies on the function's contract that `c` and `p` =
are valid pointers.
> +        let (chip, pwm, result) =3D
> +            unsafe { (Chip::<T>::as_ref(c), Device::as_ref(p), &mut =
*res) };
> +
> +        // SAFETY: The PWM core guarantees the parent device exists =
and is bound during callbacks.
> +        let bound_parent =3D unsafe { chip.bound_parent_device() };
> +        match T::capture(chip, pwm, result, timeout, bound_parent) {
> +            Ok(()) =3D> 0,
> +            Err(e) =3D> e.to_errno(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn round_waveform_tohw_callback(
> +        c: *mut bindings::pwm_chip,
> +        p: *mut bindings::pwm_device,
> +        w: *const bindings::pwm_waveform,
> +        wh: *mut c_void,
> +    ) -> c_int {
> +        // SAFETY: Relies on the function's contract that `c` and `p` =
are valid pointers.
> +        let (chip, pwm, wf) =3D unsafe {
> +            (
> +                Chip::<T>::as_ref(c),
> +                Device::as_ref(p),
> +                Waveform::from(*w),
> +            )
> +        };
> +        match T::round_waveform_tohw(chip, pwm, &wf) {
> +            Ok((status, wfhw)) =3D> {
> +                // SAFETY: `wh` is valid per this function's safety =
contract.
> +                if unsafe { Self::serialize_wfhw(&wfhw, wh) =
}.is_err() {
> +                    return EINVAL.to_errno();
> +                }
> +                status
> +            }
> +            Err(e) =3D> e.to_errno(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn round_waveform_fromhw_callback(
> +        c: *mut bindings::pwm_chip,
> +        p: *mut bindings::pwm_device,
> +        wh: *const c_void,
> +        w: *mut bindings::pwm_waveform,
> +    ) -> c_int {
> +        // SAFETY: Relies on the function's contract that `c` and `p` =
are valid pointers.
> +        let (chip, pwm) =3D unsafe { (Chip::<T>::as_ref(c), =
Device::as_ref(p)) };
> +        // SAFETY: `deserialize_wfhw`'s safety contract is met by =
this function's contract.
> +        let wfhw =3D match unsafe { Self::deserialize_wfhw(wh) } {
> +            Ok(v) =3D> v,
> +            Err(e) =3D> return e.to_errno(),
> +        };
> +
> +        let mut rust_wf =3D Waveform::default();
> +        match T::round_waveform_fromhw(chip, pwm, &wfhw, &mut =
rust_wf) {
> +            Ok(ret) =3D> {
> +                // SAFETY: `w` is guaranteed valid by the C caller.
> +                unsafe {
> +                    *w =3D rust_wf.into();
> +                };
> +                ret
> +            }
> +            Err(e) =3D> e.to_errno(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn read_waveform_callback(
> +        c: *mut bindings::pwm_chip,
> +        p: *mut bindings::pwm_device,
> +        wh: *mut c_void,
> +    ) -> c_int {
> +        // SAFETY: Relies on the function's contract that `c` and `p` =
are valid pointers.
> +        let (chip, pwm) =3D unsafe { (Chip::<T>::as_ref(c), =
Device::as_ref(p)) };
> +
> +        // SAFETY: The PWM core guarantees the parent device exists =
and is bound during callbacks.
> +        let bound_parent =3D unsafe { chip.bound_parent_device() };
> +        match T::read_waveform(chip, pwm, bound_parent) {
> +            // SAFETY: `wh` is valid per this function's safety =
contract.
> +            Ok(wfhw) =3D> match unsafe { Self::serialize_wfhw(&wfhw, =
wh) } {
> +                Ok(()) =3D> 0,
> +                Err(e) =3D> e.to_errno(),
> +            },
> +            Err(e) =3D> e.to_errno(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Pointers from C must be valid.
> +    unsafe extern "C" fn write_waveform_callback(
> +        c: *mut bindings::pwm_chip,
> +        p: *mut bindings::pwm_device,
> +        wh: *const c_void,
> +    ) -> c_int {
> +        // SAFETY: Relies on the function's contract that `c` and `p` =
are valid pointers.
> +        let (chip, pwm) =3D unsafe { (Chip::<T>::as_ref(c), =
Device::as_ref(p)) };
> +
> +        // SAFETY: The PWM core guarantees the parent device exists =
and is bound during callbacks.
> +        let bound_parent =3D unsafe { chip.bound_parent_device() };
> +
> +        // SAFETY: `wh` is valid per this function's safety contract.
> +        let wfhw =3D match unsafe { Self::deserialize_wfhw(wh) } {
> +            Ok(v) =3D> v,
> +            Err(e) =3D> return e.to_errno(),
> +        };
> +        match T::write_waveform(chip, pwm, &wfhw, bound_parent) {
> +            Ok(()) =3D> 0,
> +            Err(e) =3D> e.to_errno(),
> +        }
> +    }
> +}
> +
> +/// VTable structure wrapper for PWM operations.
> +/// Mirrors [`struct pwm_ops`](srctree/include/linux/pwm.h).
> +#[repr(transparent)]
> +pub struct PwmOpsVTable(bindings::pwm_ops);
> +
> +// SAFETY: PwmOpsVTable is Send. The vtable contains only function =
pointers
> +// and a size, which are simple data types that can be safely moved =
across
> +// threads. The thread-safety of calling these functions is handled =
by the
> +// kernel's locking mechanisms.
> +unsafe impl Send for PwmOpsVTable {}
> +
> +// SAFETY: PwmOpsVTable is Sync. The vtable is immutable after it is =
created,
> +// so it can be safely referenced and accessed concurrently by =
multiple threads
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
> +/// Creates a PWM operations vtable for a type `T` that implements =
`PwmOps`.
> +///
> +/// This is used to bridge Rust trait implementations to the C =
`struct pwm_ops`
> +/// expected by the kernel.
> +pub const fn create_pwm_ops<T: PwmOps>() -> PwmOpsVTable {
> +    // SAFETY: `core::mem::zeroed()` is unsafe. For `pwm_ops`, all =
fields are
> +    // `Option<extern "C" fn(...)>` or data, so a zeroed pattern =
(None/0) is valid initially.
> +    let mut ops: bindings::pwm_ops =3D unsafe { core::mem::zeroed() =
};
> +
> +    ops.request =3D Some(Adapter::<T>::request_callback);
> +    ops.capture =3D Some(Adapter::<T>::capture_callback);
> +
> +    ops.round_waveform_tohw =3D =
Some(Adapter::<T>::round_waveform_tohw_callback);
> +    ops.round_waveform_fromhw =3D =
Some(Adapter::<T>::round_waveform_fromhw_callback);
> +    ops.read_waveform =3D Some(Adapter::<T>::read_waveform_callback);
> +    ops.write_waveform =3D =
Some(Adapter::<T>::write_waveform_callback);
> +    ops.sizeof_wfhw =3D core::mem::size_of::<T::WfHw>();
> +
> +    PwmOpsVTable(ops)
> +}
> +
> +/// Wrapper for a PWM chip/controller ([`struct =
pwm_chip`](srctree/include/linux/pwm.h)).
> +#[repr(transparent)]
> +pub struct Chip<T: PwmOps>(Opaque<bindings::pwm_chip>, =
PhantomData<T>);
> +
> +impl<T: PwmOps> Chip<T> {
> +    /// Creates a reference to a [`Chip`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid and remains valid =
for the lifetime of the
> +    /// returned [`Chip`] reference.
> +    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::pwm_chip) -> =
&'a Self {
> +        // SAFETY: The safety requirements guarantee the validity of =
the dereference, while the
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

This name is not good IMHO. We don=E2=80=99t have to provide a 1:1 match =
with C.

> +        // SAFETY: `self.as_raw()` provides a valid pointer for =
`self`'s lifetime.
> +        unsafe { (*self.as_raw()).npwm }
> +    }
> +
> +    /// Returns `true` if the chip supports atomic operations for =
configuration.
> +    pub fn is_atomic(&self) -> bool {
> +        // SAFETY: `self.as_raw()` provides a valid pointer for =
`self`'s lifetime.
> +        unsafe { (*self.as_raw()).atomic }
> +    }
> +
> +    /// Returns a reference to the embedded `struct device` =
abstraction.
> +    pub fn device(&self) -> &device::Device {
> +        // SAFETY: `self.as_raw()` provides a valid pointer to =
`bindings::pwm_chip`.
> +        // The `dev` field is an instance of `bindings::device` =
embedded within `pwm_chip`.
> +        // Taking a pointer to this embedded field is valid.
> +        // `device::Device` is `#[repr(transparent)]`.
> +        // The lifetime of the returned reference is tied to `self`.
> +        unsafe { device::Device::as_ref(&raw mut =
(*self.as_raw()).dev) }
> +    }

IIRC, these are supposed to be prefixed with =E2=80=9C-=E2=80=9C to =
highlight that it=E2=80=99s a bulleted list.

> +
> +    /// Gets the *typed* driver specific data associated with this =
chip's embedded device.

I don=E2=80=99t think this emphasis adds anything of value. (IMHO)

> +    pub fn drvdata(&self) -> &T {

This is off-topic (sorry), but I wonder if this shouldn=E2=80=99t be =
renamed =E2=80=9Cdriver_data()=E2=80=9D across the tree.

> +        // SAFETY: `pwmchip_get_drvdata` returns the pointer to the =
private data area,
> +        // which we know holds our `T`. The pointer is valid for the =
lifetime of `self`.
> +        unsafe { =
&*bindings::pwmchip_get_drvdata(self.as_raw()).cast::<T>() }
> +    }
> +
> +    /// Returns a reference to the parent device of this PWM chip's =
device.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must guarantee that the parent device exists and =
is bound.
> +    /// This is guaranteed by the PWM core during `PwmOps` callbacks.
> +    unsafe fn bound_parent_device(&self) -> &device::Device<Bound> {
> +        // SAFETY: Per the function's safety contract, the parent =
device exists.
> +        let parent =3D unsafe { =
self.device().parent().unwrap_unchecked() };
> +
> +        // SAFETY: Per the function's safety contract, the parent =
device is bound.
> +        // The pointer is cast from `&Device` to `&Device<Bound>`.
> +        unsafe { =
&*core::ptr::from_ref(parent).cast::<device::Device<Bound>>() }
> +    }
> +
> +    /// Allocates and wraps a PWM chip using =
`bindings::pwmchip_alloc`.
> +    ///
> +    /// Returns an [`ARef<Chip>`] managing the chip's lifetime via =
refcounting
> +    /// on its embedded `struct device`.
> +    pub fn new(
> +        parent_dev: &device::Device,
> +        npwm: u32,
> +        data: impl pin_init::PinInit<T, Error>,
> +    ) -> Result<ARef<Self>> {
> +
> +        let sizeof_priv =3D core::mem::size_of::<T>();
> +        // SAFETY: `pwmchip_alloc` allocates memory for the C struct =
and our private data.
> +        let c_chip_ptr_raw =3D unsafe {
> +            bindings::pwmchip_alloc(parent_dev.as_raw(), npwm, =
sizeof_priv)
> +        };
> +
> +        let c_chip_ptr: *mut bindings::pwm_chip =3D =
error::from_err_ptr(c_chip_ptr_raw)?;
> +
> +        // SAFETY: The `drvdata` pointer is the start of the private =
area, which is where
> +        // we will construct our `T` object.
> +        let drvdata_ptr =3D unsafe { =
bindings::pwmchip_get_drvdata(c_chip_ptr) };
> +
> +        // SAFETY: We construct the `T` object in-place in the =
allocated private memory.
> +        unsafe { data.__pinned_init(drvdata_ptr.cast())? };
> +
> +        // SAFETY: `c_chip_ptr` points to a valid chip.
> +        unsafe { (*c_chip_ptr).dev.release =3D =
Some(Adapter::<T>::release_callback); }
> +
> +        // SAFETY: `c_chip_ptr` points to a valid chip.
> +        // The `Adapter`'s `VTABLE` has a 'static lifetime, so the =
pointer
> +        // returned by `as_raw()` is always valid.
> +        unsafe { (*c_chip_ptr).ops =3D Adapter::<T>::VTABLE.as_raw(); =
}
> +
> +        // Cast the `*mut bindings::pwm_chip` to `*mut Chip`. This is =
valid because
> +        // `Chip` is `repr(transparent)` over =
`Opaque<bindings::pwm_chip>`, and
> +        // `Opaque<T>` is `repr(transparent)` over `T`.
> +        let chip_ptr_as_self =3D c_chip_ptr.cast::<Self>();
> +
> +        // SAFETY: `chip_ptr_as_self` points to a valid `Chip` =
(layout-compatible with
> +        // `bindings::pwm_chip`) whose embedded device has refcount =
1.
> +        // `ARef::from_raw` takes this pointer and manages it via =
`AlwaysRefCounted`.
> +        Ok(unsafe { =
ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) })
> +    }
> +}
> +
> +// SAFETY: Implements refcounting for `Chip` using the embedded =
`struct device`.
> +unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
> +    #[inline]
> +    fn inc_ref(&self) {
> +        // SAFETY: `self.0.get()` points to a valid `pwm_chip` =
because `self` exists.
> +        // The embedded `dev` is valid. `get_device` increments its =
refcount.
> +        unsafe { bindings::get_device(&raw mut (*self.0.get()).dev); =
}
> +    }
> +
> +    #[inline]
> +    unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
> +        let c_chip_ptr =3D obj.cast::<bindings::pwm_chip>().as_ptr();
> +
> +        // SAFETY: `obj` is a valid pointer to a `Chip` (and thus =
`bindings::pwm_chip`)
> +        // with a non-zero refcount. `put_device` handles decrement =
and final release.
> +        unsafe { bindings::put_device(&raw mut (*c_chip_ptr).dev); }
> +    }
> +}
> +
> +// SAFETY: `Chip` is a wrapper around `*mut bindings::pwm_chip`. The =
underlying C
> +// structure's state is managed and synchronized by the kernel's =
device model
> +// and PWM core locking mechanisms. Therefore, it is safe to move the =
`Chip`
> +// wrapper (and the pointer it contains) across threads.
> +unsafe impl<T: PwmOps + Send> Send for Chip<T> {}
> +
> +// SAFETY: It is safe for multiple threads to have shared access =
(`&Chip`) because
> +// the `Chip` data is immutable from the Rust side without holding =
the appropriate
> +// kernel locks, which the C core is responsible for. Any interior =
mutability is
> +// handled and synchronized by the C kernel code.
> +unsafe impl<T: PwmOps + Sync> Sync for Chip<T> {}
> +
> +/// A resource guard that ensures `pwmchip_remove` is called on drop.
> +///
> +/// This struct is intended to be managed by the `devres` framework =
by transferring its ownership
> +/// via [`Devres::register`]. This ties the lifetime of the PWM chip =
registration
> +/// to the lifetime of the underlying device.
> +pub struct Registration<T: PwmOps> {
> +    chip: ARef<Chip<T>>,
> +}
> +
> +impl<T: 'static + PwmOps  + Send + Sync> Registration<T> {
> +    /// Registers a PWM chip with the PWM subsystem.
> +    ///
> +    /// Transfers its ownership to the `devres` framework, which ties =
its lifetime
> +    /// to the parent device.
> +    /// On unbind of the parent device, the `devres` entry will be =
dropped, automatically
> +    /// calling `pwmchip_remove`. This function should be called from =
the driver's `probe`.
> +    pub fn register(
> +        dev: &device::Device<Bound>,
> +        chip: ARef<Chip<T>>,
> +    ) -> Result {
> + let chip_parent =3D chip.device().parent().ok_or(EINVAL)?;
> +        if dev.as_raw() !=3D chip_parent.as_raw() {
> +            return Err(EINVAL);
> +        }
> +
> +        let c_chip_ptr =3D chip.as_raw();
> +
> +        // SAFETY: `c_chip_ptr` points to a valid chip with its ops =
initialized.
> +        // `__pwmchip_add` is the C function to register the chip =
with the PWM core.
> +        unsafe {
> +            to_result(bindings::__pwmchip_add(c_chip_ptr, =
core::ptr::null_mut()))?;
> +        }
> +
> +        let registration =3D Registration { chip };
> +
> +        devres::Devres::new_foreign_owned(dev, registration, =
GFP_KERNEL)
> +    }
> +}
> +
> +impl<T: PwmOps> Drop for Registration<T> {
> +    fn drop(&mut self) {
> +        let chip_raw =3D self.chip.as_raw();
> +
> +        // SAFETY: `chip_raw` points to a chip that was successfully =
registered.
> +        // `bindings::pwmchip_remove` is the correct C function to =
unregister it.
> +        // This `drop` implementation is called automatically by =
`devres` on driver unbind.
> +        unsafe { bindings::pwmchip_remove(chip_raw); }
> +    }
> +}
>=20
> --=20
> 2.34.1
>=20
>=20


=E2=80=94 Daniel

[0] =
https://lore.kernel.org/rust-for-linux/20250711-device-as-ref-v2-0-1b16ab6=
402d7@google.com/


