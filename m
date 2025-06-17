Return-Path: <linux-pwm+bounces-6417-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E4ADD044
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 16:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524A33A47AB
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE0C202965;
	Tue, 17 Jun 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSTCRk8U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997B2CCDE;
	Tue, 17 Jun 2025 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171270; cv=none; b=d0KAOAvHaM4wIjVryUoZ6qsFaiHnMremXbdi2KGdR95OO6Z3d+/YjO8kxXIrerNNUPyHm5fYQZDDeclSH/wCKg91m1SUSMLmW5Z9xlf79nF3cBZQrJLWQrgUsfNe8p/qPzPLUTjScXcEEHJUfiqjo1VGdqRtdBgqiKwAAxU0zSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171270; c=relaxed/simple;
	bh=XdJb0Fw4Rr6pT0ZoN+vrT8BJNFqp2n7RZt9bLdoicy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcCjAhgg0L38niekZ8SEGzwmokzFOZhik6zFX4v9WIA+cQdIhBqStlANqZmvRg5Sh+RkBPVU8J3Nwe0/nWO98zHLas07iBkOq4Vj5kdK3i9pX1xie+Hs3nftcQ8IT6pH/dlLJINo3Kf25133l94S8yaO3YRq+CnammmOIrWxvJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSTCRk8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD93C4CEE3;
	Tue, 17 Jun 2025 14:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750171269;
	bh=XdJb0Fw4Rr6pT0ZoN+vrT8BJNFqp2n7RZt9bLdoicy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSTCRk8Uwi677vKg6k6lOAWXdtA+M+meFSVzjlFArZ9bvcH54PzhYbqd7CJlg63T/
	 xJ0+p8rTVazZ6/wO72ITTYo2jiM5Tbugln+L3yIBtD9EBCyLvlK3Uf+wo/ABwAm3Vy
	 fPAoXHXkEsLyBw49G9HKJjcjV6mofeyhQa4lbM/8mb3sWMomcQgyA7/LvkGC8yKDG9
	 odnD5n9ZIAUz+x2GSLx7JB/j6pW2RBIQtlbDvHkin8zrtZV/xYDMLS6fmj6g31qdWG
	 HZkv+V2DMP0ZzeS0iAymfIqkXqCiWdwpzWqjTJXdU4eV1g/aaKOhKSpv5Kz+VAmX7Z
	 jrf/zUgEtABtw==
Date: Tue, 17 Jun 2025 16:41:00 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 3/9] rust: pwm: Add driver operations trait and
 registration support
Message-ID: <aFF-fNOOEzoiomFu@pollux>
References: <20250617-rust-next-pwm-working-fan-for-sending-v3-0-1cca847c6f9f@samsung.com>
 <CGME20250617140838eucas1p2a31af5a73297580c2421263c1c6ba700@eucas1p2.samsung.com>
 <20250617-rust-next-pwm-working-fan-for-sending-v3-3-1cca847c6f9f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-rust-next-pwm-working-fan-for-sending-v3-3-1cca847c6f9f@samsung.com>

On Tue, Jun 17, 2025 at 04:07:26PM +0200, Michal Wilczynski wrote:
> +/// Manages the registration of a PWM chip, ensuring `pwmchip_remove` is called on drop.
> +pub struct Registration {
> +    chip: ManuallyDrop<ARef<Chip>>,

Why is this ManuallyDrop when you call ManuallyDrop::drop(&mut self.chip) as
the last thing in Registration::drop()?

I think you don't need ManuallyDrop here.

> +}
> +
> +impl Registration {
> +    /// Registers a PWM chip (obtained via `Chip::new`) with the PWM subsystem.
> +    ///
> +    /// Takes an [`ARef<Chip>`]. On `Drop` of the returned `Registration` object,
> +    /// `pwmchip_remove` is called for the chip.
> +    pub fn new(chip: ARef<Chip>, ops_vtable: &'static PwmOpsVTable) -> Result<Self> {

For the reason mentioned in [1] this should either return Result<Devres<Self>>
or just Result, if you use Devres::new_foreign_owned() (see also [2]).

In case of the latter, the Registration instance is automatically dropped once
the parent device is unbound.

If you go with the first, you can drop the Devres<Registration> (and hence the
inner Registration) at any arbitrary point of time, but Devres will still
gurarantee that the inner Registration is dropped once the parent device is
unbound, i.e. it can't out-live driver unbind.

This guarantees that the &Device<Bound> instance you provide in the callbacks
below is guaranteed to be valid.

[1] https://lore.kernel.org/lkml/aFF7qqlexxh540FW@pollux/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/drm/driver.rs#n134

> +        // Get the raw C pointer from ARef<Chip>.
> +        let c_chip_ptr = chip.as_raw().cast::<bindings::pwm_chip>();
> +
> +        // SAFETY: `c_chip_ptr` is valid (guaranteed by ARef existing).
> +        // `ops_vtable.as_raw()` provides a valid `*const bindings::pwm_ops`.
> +        // `bindings::__pwmchip_add` preconditions (valid pointers, ops set on chip) are met.
> +        unsafe {
> +            (*c_chip_ptr).ops = ops_vtable.as_raw();
> +            to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()))?;
> +        }

Please split this up into separate unsafe blocks.

> +        Ok(Registration {
> +            chip: ManuallyDrop::new(chip),
> +        })
> +    }
> +}
> +
> +impl Drop for Registration {
> +    fn drop(&mut self) {
> +        let chip = &**self.chip;
> +        let chip_raw: *mut bindings::pwm_chip = chip.as_raw();
> +
> +        // SAFETY: `chip_raw` points to a chip that was successfully registered via `Self::new`.
> +        // `bindings::pwmchip_remove` is the correct C function to unregister it.
> +        unsafe {
> +            bindings::pwmchip_remove(chip_raw);
> +            ManuallyDrop::drop(&mut self.chip); // Drops the ARef<Chip>
> +        }

Same here, but I don't think ManuallyDrop is needed anyways.

> +    }
> +}

