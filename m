Return-Path: <linux-pwm+bounces-7771-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6ACCABA61
	for <lists+linux-pwm@lfdr.de>; Sun, 07 Dec 2025 23:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06FC8300FF86
	for <lists+linux-pwm@lfdr.de>; Sun,  7 Dec 2025 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8D347DD;
	Sun,  7 Dec 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q7NW3Vax"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0F242D7B
	for <linux-pwm@vger.kernel.org>; Sun,  7 Dec 2025 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765145834; cv=none; b=IxMQCaSzu0p79GWlKdoDTsuMaJG5ktQ0NVhJ1ri/c2mbR/0tdqhLasscdHJKiiCiOzsIuRbyVqWSVulavGg7A3+ibYjmWWVWvfn95OSL+62WH/3DAMkoM0AFdJiTiQ/oCwm2Z6HbnSDdUledcXfxkStCusot0iFm8gQKBFDJKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765145834; c=relaxed/simple;
	bh=NbfFrj0o33ObnV6Z/38UhzX71K0xOOWXfwEFmwO6Fuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=foifNDqQj2Zm2i1IGcFoT0PG1grf4j8zWsqamcT98eFXher3D1NLZ0y51AZNCV+h0l4ZhfgmVPZhkxZZr9rDcYM3kRVWLKhXHNibKQaLAmBacx/7/QMacAK1MJ2gKsjy68z+bNt3+MF9ZuTs8UsRBRrp28q9wnktXuPutM9ggns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Q7NW3Vax; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251207221703euoutp01abd5b93b8be60a3b0a7a27d6db9067bf~-DsYt1Yse1723217232euoutp01B
	for <linux-pwm@vger.kernel.org>; Sun,  7 Dec 2025 22:17:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251207221703euoutp01abd5b93b8be60a3b0a7a27d6db9067bf~-DsYt1Yse1723217232euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1765145823;
	bh=6ZLVhZC18xx0mvblpN9SbwlhVyztlgqMhP5sOQZAvyk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Q7NW3VaxMCuXENzDaAi7YymCj0lxzohP70XexLJU4iKH6gyjr2rzdR6ZYd89mz17c
	 7Ge+08MtOVd/1EsQeoP03kgXbfrosQfi4GTeLMIh42Lgcq8lR06I+wfzbgZWvvkph6
	 /fwLWWMIqWGmdgee0zaTBF8izoW8qe/nmCB19jSk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251207221701eucas1p245e652808a94bd3bcacb97e777898760~-DsW3Ty8C1794817948eucas1p2f;
	Sun,  7 Dec 2025 22:17:01 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251207221700eusmtip16e2f41435a1f6269cfd750b936dae9d0~-DsVzu-rw0914809148eusmtip1k;
	Sun,  7 Dec 2025 22:17:00 +0000 (GMT)
Message-ID: <a3f4e795-e56d-4de0-8b46-5c8ff96d5f77@samsung.com>
Date: Sun, 7 Dec 2025 23:16:59 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: pwm: Add UnregisteredChip wrapper around Chip
To: Markus Probst <markus.probst@posteo.de>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Drew Fustini
	<fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20251202-pwm_safe_register-v2-1-7a2e0d1e287f@posteo.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251207221701eucas1p245e652808a94bd3bcacb97e777898760
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251202181800eucas1p18be878cb74d14444f2df8bdcd7a718ee
X-EPHeader: CA
X-CMS-RootMailID: 20251202181800eucas1p18be878cb74d14444f2df8bdcd7a718ee
References: <CGME20251202181800eucas1p18be878cb74d14444f2df8bdcd7a718ee@eucas1p1.samsung.com>
	<20251202-pwm_safe_register-v2-1-7a2e0d1e287f@posteo.de>


Hi Markus,
On 12/2/25 19:17, Markus Probst wrote:
> The `pwm::Registration::register` function provides no guarantee that the
> function isn't called twice with the same pwm chip, which is considered
> unsafe.
> 
> Add `pwm::UnregisteredChip` as wrapper around `pwm::Chip`.
> Implement `pwm::UnregisteredChip::register` for the registration. This
> function takes ownership of `pwm::UnregisteredChip` and therefore
> guarantees that the registration can't be called twice on the same pwm
> chip.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
> This patch provides the additional guarantee that the pwm chip doesn't
> get registered twice.
> 
> The following changes were made:
> - change the visibility of `pwm::Registration` to private
> - remove the `pwm::Registration::register` function
> - add `pwm::UnregisteredChip` - a wrapper around `pwm::Chip`
> - return `pwm::UnregisteredChip` in `pwm::Chip::new`
> - add `pwm::UnregisteredChip::register` for registering the pwm chip
>   once
> - add Send + Sync bounds to `PwmOps`
> 
> Note that I wasn't able to test this patch, due to the lack of hardware.
> 
> Also I was not able to successfully compile drivers/pwm/pwm_th1520.rs,
> as `clk::Clk` seems to be missing. I haven't found the missing patch
> in linux-next nor in

I suspect your kernel configuration is missing CONFIG_COMMON_CLK.

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/log/?h=pwm/for-next
> 
> (the tree in which the th1520 pwm driver was merged).
> So please verify yourself that the driver compiles and throws no errors.
> ---
> Changes in v2:
> - use the `pwm::UnregisteredChip` wrapper instead of moving the
>   registration into `pwm::Chip::new` to allow access to the chip prior
>   to the registration

Agree with this. By returning UnregisteredChip, you solved the safety
issue (preventing double registration) while correctly preserving the
"configuration gap" needed for complex drivers. Good example of Type
State pattern :-)

> - Link to v1: https://lore.kernel.org/r/20251127-pwm_safe_register-v1-1-d22d0ed068ac@posteo.de
> ---
>  drivers/pwm/pwm_th1520.rs |  2 +-
>  rust/kernel/pwm.rs        | 68 ++++++++++++++++++++++++++++++-----------------
>  2 files changed, 45 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index 955c359b07fb..65a52b6620ab 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -372,7 +372,7 @@ fn probe(
>              }),
>          )?;
>  
> -        pwm::Registration::register(dev, chip)?;
> +        chip.register()?;
>  
>          Ok(KBox::new(Th1520PwmPlatformDriver, GFP_KERNEL)?.into())
>      }
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index cb00f8a8765c..bf7515d04d8a 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -15,7 +15,11 @@
>      prelude::*,
>      types::{ARef, AlwaysRefCounted, Opaque}, //
>  };
> -use core::{marker::PhantomData, ptr::NonNull};
> +use core::{
> +    marker::PhantomData,
> +    ops::Deref,
> +    ptr::NonNull, //
> +};
>  
>  /// Represents a PWM waveform configuration.
>  /// Mirrors struct [`struct pwm_waveform`](srctree/include/linux/pwm.h).
> @@ -173,7 +177,7 @@ pub struct RoundedWaveform<WfHw> {
>  }
>  
>  /// Trait defining the operations for a PWM driver.
> -pub trait PwmOps: 'static + Sized {
> +pub trait PwmOps: 'static + Send + Sync + Sized {
>      /// The driver-specific hardware representation of a waveform.
>      ///
>      /// This type must be [`Copy`], [`Default`], and fit within `PWM_WFHWSIZE`.
> @@ -584,11 +588,12 @@ unsafe fn bound_parent_device(&self) -> &device::Device<Bound> {
>      ///
>      /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
>      /// on its embedded `struct device`.
> -    pub fn new(
> -        parent_dev: &device::Device,
> +    #[allow(clippy::new_ret_no_self)]
> +    pub fn new<'a>(
> +        parent_dev: &'a device::Device<Bound>,
>          num_channels: u32,
>          data: impl pin_init::PinInit<T, Error>,
> -    ) -> Result<ARef<Self>> {
> +    ) -> Result<UnregisteredChip<'a, T>> {
>          let sizeof_priv = core::mem::size_of::<T>();
>          // SAFETY: `pwmchip_alloc` allocates memory for the C struct and our private data.
>          let c_chip_ptr_raw =
> @@ -623,7 +628,9 @@ pub fn new(
>          // SAFETY: `chip_ptr_as_self` points to a valid `Chip` (layout-compatible with
>          // `bindings::pwm_chip`) whose embedded device has refcount 1.
>          // `ARef::from_raw` takes this pointer and manages it via `AlwaysRefCounted`.
> -        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) })
> +        let chip = unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) };
> +
> +        Ok(UnregisteredChip { chip, parent_dev })
>      }
>  }
>  
> @@ -654,37 +661,29 @@ unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
>  // structure's state is managed and synchronized by the kernel's device model
>  // and PWM core locking mechanisms. Therefore, it is safe to move the `Chip`
>  // wrapper (and the pointer it contains) across threads.
> -unsafe impl<T: PwmOps + Send> Send for Chip<T> {}
> +unsafe impl<T: PwmOps> Send for Chip<T> {}
>  
>  // SAFETY: It is safe for multiple threads to have shared access (`&Chip`) because
>  // the `Chip` data is immutable from the Rust side without holding the appropriate
>  // kernel locks, which the C core is responsible for. Any interior mutability is
>  // handled and synchronized by the C kernel code.
> -unsafe impl<T: PwmOps + Sync> Sync for Chip<T> {}
> +unsafe impl<T: PwmOps> Sync for Chip<T> {}
>  
> -/// A resource guard that ensures `pwmchip_remove` is called on drop.
> -///
> -/// This struct is intended to be managed by the `devres` framework by transferring its ownership
> -/// via [`devres::register`]. This ties the lifetime of the PWM chip registration
> -/// to the lifetime of the underlying device.
> -pub struct Registration<T: PwmOps> {
> +/// A wrapper arround `ARef<Chip<T>>` that ensures that `register` can only be called once.

nit:
s/arround/around/

> +pub struct UnregisteredChip<'a, T: PwmOps> {
>      chip: ARef<Chip<T>>,
> +    parent_dev: &'a device::Device<Bound>,
>  }
>  
> -impl<T: 'static + PwmOps + Send + Sync> Registration<T> {
> +impl<T: PwmOps> UnregisteredChip<'_, T> {
>      /// Registers a PWM chip with the PWM subsystem.
>      ///
>      /// Transfers its ownership to the `devres` framework, which ties its lifetime
>      /// to the parent device.
>      /// On unbind of the parent device, the `devres` entry will be dropped, automatically
>      /// calling `pwmchip_remove`. This function should be called from the driver's `probe`.
> -    pub fn register(dev: &device::Device<Bound>, chip: ARef<Chip<T>>) -> Result {
> -        let chip_parent = chip.device().parent().ok_or(EINVAL)?;
> -        if dev.as_raw() != chip_parent.as_raw() {
> -            return Err(EINVAL);
> -        }
> -
> -        let c_chip_ptr = chip.as_raw();
> +    pub fn register(self) -> Result<ARef<Chip<T>>> {
> +        let c_chip_ptr = self.chip.as_raw();
>  
>          // SAFETY: `c_chip_ptr` points to a valid chip with its ops initialized.
>          // `__pwmchip_add` is the C function to register the chip with the PWM core.
> @@ -692,12 +691,33 @@ pub fn register(dev: &device::Device<Bound>, chip: ARef<Chip<T>>) -> Result {
>              to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()))?;
>          }
>  
> -        let registration = Registration { chip };
> +        let registration = Registration {
> +            chip: ARef::clone(&self.chip),
> +        };
> +
> +        devres::register(self.parent_dev, registration, GFP_KERNEL)?;
>  
> -        devres::register(dev, registration, GFP_KERNEL)
> +        Ok(self.chip)
>      }
>  }
>  
> +impl<T: PwmOps> Deref for UnregisteredChip<'_, T> {
> +    type Target = Chip<T>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.chip
> +    }
> +}
> +
> +/// A resource guard that ensures `pwmchip_remove` is called on drop.
> +///
> +/// This struct is intended to be managed by the `devres` framework by transferring its ownership
> +/// via [`devres::register`]. This ties the lifetime of the PWM chip registration
> +/// to the lifetime of the underlying device.
> +struct Registration<T: PwmOps> {
> +    chip: ARef<Chip<T>>,
> +}
> +
>  impl<T: PwmOps> Drop for Registration<T> {
>      fn drop(&mut self) {
>          let chip_raw = self.chip.as_raw();
> 
> ---
> base-commit: fae00ea9f00367771003ace78f29549dead58fc7
> change-id: 20251127-pwm_safe_register-e49b0a261101
> 
> 

Thank you for your work. I've tested this patch successfully.
Other than the typo this looks perfect.

Tested-by: Michal Wilczynski <m.wilczynski@samsung.com>
Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>


