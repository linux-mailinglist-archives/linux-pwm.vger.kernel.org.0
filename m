Return-Path: <linux-pwm+bounces-6747-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD1AFA512
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Jul 2025 14:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF587A450C
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Jul 2025 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64C520B80D;
	Sun,  6 Jul 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvKzmebU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EFC1FDA92;
	Sun,  6 Jul 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751804593; cv=none; b=H5uuK/kydsg6w5dKFmnDS9SX4nZeIzl4PFCq5247qzfA5c7lycu2bUaCq9I/h7Q0o22HYj6NQ/HERQRFzEKBZA5vgZaUUjdVwxn8P857xEzxCf7XGaToC7oSZkhmViTB5dGEGk/9GosICyukdGXiuJoCNxyaC/QM7fRP6rcgvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751804593; c=relaxed/simple;
	bh=N9UmR9j9pvw9tZRtfgFGkozm66WwP+U632CwPMwSDvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7cFlvh9oAIcQ/V6zHkX/S4ekkmDZ5gGI++LggYo+ojhz6LYNlXrYpoqUhpcUHxYl00qYFv9T1tjelYFnguDTvwrTTz2RsRIIeREGRJlhUp9JxbBQGAMkKzwkIXKdLrUNWtAuix+jfCfs0SGbr0vfsI2IfHSsGiMsSIIq25hQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvKzmebU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEFFC4CEED;
	Sun,  6 Jul 2025 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751804593;
	bh=N9UmR9j9pvw9tZRtfgFGkozm66WwP+U632CwPMwSDvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvKzmebUf9otplXwr5ryEJ4O83J9v6x8lvkereRCNeDd8gDPRBFo1mcWtF7/OX9LL
	 Bw1/h5LEZK6GU3oHQmZZfvmvId9/n4Bdbxn4Lcp0Ua8G3YgxAt/8zpxr3JI8VvP3JT
	 nKHL7qs8l+zj0k0M25yOxa1wl6xpsq8s9ph4q+Rz6SUCUqzO7Pa4HHzREUaA4qTUDA
	 JQ3R+egY/vsznt0t/gU82DuJE5eckmxDai8NSTOGByegZQ0luomY93iOS1hXJCkGi5
	 P10tVzcnjC6bfk1gresM7dcJOnCgcdmWNOI7wucpLFXPpmNwKAvssg9KU9j6tOA1eR
	 bPwoN9NSA4QPQ==
Date: Sun, 6 Jul 2025 14:23:04 +0200
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
Subject: Re: [PATCH v9 2/6] rust: pwm: Add complete abstraction layer
Message-ID: <aGpqqGMTU3a3O8cn@pollux>
References: <20250706-rust-next-pwm-working-fan-for-sending-v9-0-42b5ac2101c7@samsung.com>
 <CGME20250706114605eucas1p17d1cbd035d14d95f4ad0588c2572b3e2@eucas1p1.samsung.com>
 <20250706-rust-next-pwm-working-fan-for-sending-v9-2-42b5ac2101c7@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706-rust-next-pwm-working-fan-for-sending-v9-2-42b5ac2101c7@samsung.com>

On Sun, Jul 06, 2025 at 01:45:13PM +0200, Michal Wilczynski wrote:
> +/// Trait defining the operations for a PWM driver.
> +pub trait PwmOps: 'static + Sized {
> +    /// The type of the owned driver data (e.g., `Pin<KBox<...>>`).
> +    type DrvData: 'static + ForeignOwnable;
> +    /// The driver-specific hardware representation of a waveform.
> +    ///
> +    /// This type must be [`Copy`], [`Default`], and fit within `PWM_WFHWSIZE`.
> +    type WfHw: Copy + Default;
> +
> +    /// Optional hook for when a PWM device is requested.
> +    fn request(
> +        _chip: &Chip<Self::DrvData>,
> +        _pwm: &Device,
> +        _parent_dev: &device::Device<Bound>,
> +    ) -> Result {
> +        Ok(())
> +    }
> +
> +    /// Optional hook for when a PWM device is freed.
> +    fn free(_chip: &Chip<Self::DrvData>, _pwm: &Device, _parent_dev: &device::Device<Bound>) {}

NIT: I can't think of a case providing this callback in Rust is useful. Do you
have a clear use-case in mind? Otherwise, I'd not provide this callback until
you have one. Should be trivial to add later on.

> +impl<T: PwmOps> Adapter<T> {

<snip>

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
> +        if !drvdata_ptr.is_null() {

Is this check needed? I think one can't create a pwm::Chip instance without
providing a T, so this pointer can't be NULL I think.

> +            // SAFETY: `drvdata_ptr` was stored by `Chip::new` from an owned `T::DrvData`
> +            // and is guaranteed to be valid if non-null. `from_foreign` can safely
> +            // reclaim ownership to allow Rust to drop and free the data.
> +            let _owned_drvdata = unsafe { T::DrvData::from_foreign(drvdata_ptr.cast()) };
> +        }
> +    }

If you overwrite this callback (as you do below) you're leaking the memory
allocated by pwmchip_alloc().

The simple way to solve this would be to call pwmchip_release() from here.

<snip>

> +impl<T: 'static + ForeignOwnable> Chip<T> {
> +    /// Allocates and wraps a PWM chip using `bindings::pwmchip_alloc`.
> +    ///
> +    /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
> +    /// on its embedded `struct device`.
> +    pub fn new<O: PwmOps<DrvData = T>>(
> +        parent_dev: &device::Device,
> +        npwm: u32,
> +        sizeof_priv: usize,
> +        drvdata: T,
> +    ) -> Result<ARef<Self>> {
> +        // SAFETY: `parent_device_for_dev_field.as_raw()` is valid.
> +        // `bindings::pwmchip_alloc` returns a valid `*mut bindings::pwm_chip` (refcount 1)
> +        // or an ERR_PTR.
> +        let c_chip_ptr_raw =
> +            unsafe { bindings::pwmchip_alloc(parent_dev.as_raw(), npwm, sizeof_priv) };
> +
> +        let c_chip_ptr: *mut bindings::pwm_chip = error::from_err_ptr(c_chip_ptr_raw)?;
> +
> +        // Set the custom release function on the embedded device. This is the crucial step
> +        // to ensure `drvdata` is freed when the chip's refcount reaches zero, regardless
> +        // of whether `Registration::register` was called.
> +        // SAFETY: `c_chip_ptr` points to a valid chip.
> +        unsafe { (*c_chip_ptr).dev.release = Some(Adapter::<O>::release_callback); }

This overwrites [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pwm/core.c?h=v6.16-rc4#n1601

