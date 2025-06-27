Return-Path: <linux-pwm+bounces-6560-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4977FAEBF4A
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 20:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFCF17AF341
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4761C860A;
	Fri, 27 Jun 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f89gT4qm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107624502A;
	Fri, 27 Jun 2025 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050321; cv=none; b=D/TPdYlSuKT+tXc0cQ1EST/QjC+nBSPC6gkadrmfoJjGatlFKedd5p3UZtPNLVcT0C39nZIzPTAqgqsAx478ATSfbckmflIy/RXV7/jABKBHdtodFQr8tV/S+XIhuRrdxDWUUCicki34kG04IKDQlN7V+m/2pDn6aW6EljwVeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050321; c=relaxed/simple;
	bh=euvnyW4y4L7Ax2AaJfgnY285+oZy74N4SwvcUrcj4aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngurEg5zteG7LpgdzfO7XpTVDkaw/3jn8iPFgbqI6KlF5QgQ7hJ/ToCtxzfOW+z1ApKrwPgIDHFmRtO4W9AwKco03WNrQDPmT1YWq/s2XdCWebFwRhpj+pkn76UzYgJ3H8t+rPlqJ7uosJIbQP8Ki+HSy6BxtuxCIm7Q+8EE4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f89gT4qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CA3C4CEE3;
	Fri, 27 Jun 2025 18:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751050319;
	bh=euvnyW4y4L7Ax2AaJfgnY285+oZy74N4SwvcUrcj4aA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f89gT4qmMIdFe6oB5I+WVQS4FNELutxouQp7A4Pbl8uaWBia15pG1PeQbOWhWSzS4
	 ldrmQcjnd70byKhVmXgxNS9u5Tr1MzI16xM9vacE3gxT7SftOQayTZoyj2qFAIBfR1
	 DnmbUjv4BKN17rpd5w1SClMSBQmFF0UG2XdT2CRRDHW20mwpkTx9AYQcu6ncIg3EKs
	 iZbul4cc4L8Yi86LWWRERnejaccCX6uPfL2QqP1idwMg4kRD5LXkpp6g2zVwzWHpxw
	 f+Gl5pogZhQsteJfOly0+pK7ZLoVTudL+XMzXUtV6dBMy6xhDM0Q3UMn9jSeZzPuqX
	 LZS5q2LzrxKOA==
Message-ID: <8c4284f6-58eb-4d9a-b2e7-e1c66d3fcad6@kernel.org>
Date: Fri, 27 Jun 2025 20:51:51 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] rust: pwm: Add driver operations trait and
 registration support
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Drew Fustini <drew@pdp7.com>,
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Benno Lossin
 <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
 <CGME20250623180900eucas1p2ffbd79e79f690189ae89aefcc3793e50@eucas1p2.samsung.com>
 <20250623-rust-next-pwm-working-fan-for-sending-v5-3-0ca23747c23e@samsung.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250623-rust-next-pwm-working-fan-for-sending-v5-3-0ca23747c23e@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 8:08 PM, Michal Wilczynski wrote:
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 3865b43ec47df6cb0c09bc74a228535512b6b1a8..25bc07a3df1d43467a3a6ec8f2362ae8f770360a 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -8,12 +8,13 @@
>   
>   use crate::{
>       bindings,
> -    device,
> -    error,
> +    device::{self, Bound},
> +    devres::Devres,
> +    error::{self, to_result},
>       prelude::*,
>       types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
>   };
> -use core::{convert::TryFrom, ptr::NonNull};
> +use core::{convert::TryFrom, marker::PhantomData, ptr::NonNull};
>   
>   /// Maximum size for the hardware-specific waveform representation buffer.
>   ///
> @@ -408,3 +409,482 @@ unsafe impl Send for Chip {}
>   // kernel locks, which the C core is responsible for. Any interior mutability is
>   // handled and synchronized by the C kernel code.
>   unsafe impl Sync for Chip {}
> +
> +/// A resource guard that ensures `pwmchip_remove` is called on drop.
> +///
> +/// This struct is intended to be managed by the `devres` framework by transferring its ownership
> +/// via [`Devres::new_foreign_owned`]. This ties the lifetime of the PWM chip registration
> +/// to the lifetime of the underlying device.
> +pub struct Registration {
> +    chip: ARef<Chip>,
> +}
> +
> +impl Registration {
> +    /// Registers a PWM chip with the PWM subsystem.
> +    ///
> +    /// Transfers its ownership to the `devres` framework, which ties its lifetime
> +    /// to the parent device.
> +    /// On unbind of the parent device, the `devres` entry will be dropped, automatically
> +    /// calling `pwmchip_remove`. This function should be called from the driver's `probe`.
> +    pub fn new_foreign_owned(
> +        dev: &device::Device<Bound>,
> +        chip: ARef<Chip>,
> +        ops_vtable: &'static PwmOpsVTable,
> +    ) -> Result {
> +        let c_chip_ptr = chip.as_raw();
> +
> +        // SAFETY: `c_chip_ptr` is valid because the `ARef<Chip>` that owns it exists.
> +        // The vtable pointer is also valid. This sets the `.ops` field on the C struct.
> +        unsafe {
> +            (*c_chip_ptr).ops = ops_vtable.as_raw();
> +        }
> +
> +        // SAFETY: `c_chip_ptr` points to a valid chip with its ops initialized.
> +        // `__pwmchip_add` is the C function to register the chip with the PWM core.
> +        unsafe {
> +            to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()))?;
> +        }
> +
> +        let registration = Registration { chip };
> +
> +        Devres::new_foreign_owned(dev, registration, GFP_KERNEL)?;
> +
> +        Ok(())

This can just be:

	Devres::new_foreign_owned(dev, registration, GFP_KERNEL)

I.e. no need for the `Ok(())` below.

With that,

	Reviewed-by: Danilo Krummrich <dakr@kernel.org>

for the Registration bits.

@Uwe: Just a head-up if you plan to pick this up for the upcoming merge window,
Devres::new_foreign_owned() will be replaced with devres::register() --
semantics and arguments do not change.

> +    }
> +}
> +
> +impl Drop for Registration {
> +    fn drop(&mut self) {
> +        let chip_raw = self.chip.as_raw();
> +
> +        // SAFETY: `chip_raw` points to a chip that was successfully registered.
> +        // `bindings::pwmchip_remove` is the correct C function to unregister it.
> +        // This `drop` implementation is called automatically by `devres` on driver unbind.
> +        unsafe {
> +            bindings::pwmchip_remove(chip_raw);
> +        }

NIT: You can write this in one line as:

	unsafe { bindings::pwmchip_remove(chip_raw) };

