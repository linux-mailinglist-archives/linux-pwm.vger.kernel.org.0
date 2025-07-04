Return-Path: <linux-pwm+bounces-6728-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA093AF9679
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 17:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866A81CC0FE6
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783728EA53;
	Fri,  4 Jul 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhI3At/Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E381A76D4;
	Fri,  4 Jul 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641948; cv=none; b=X/t7jq1edE1kJ/m9K1wJXKKMQ6dNKGKd0drsjawo93C6+PXJgGzVA9rdjP3AJgn9cDd6uHzVx+qhCuQS2aK0PV132dDKWVT7QVrrQEqEu40c+C0ON3F+voj0xegbOIejKwXYPCLwpVxeKfbh+9YYsS7xdEitzFjozZE4S9eKIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641948; c=relaxed/simple;
	bh=hZ10LiY5FNP/Dp6S+DBqAzx6uQgjXZaS8IlUwEsCGJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Two0YHE0nJN/ex/+WCr7aVCXsEXfRfdJie1lenhD8nbYuc4bWcVvdy3QUpLT84tbnnNgYt4RYj+O2qZbH/ajvHUJSyfqFZjt4BuUq5n7QjE94TiNd+ht661JEqt9ztMdoRYRP6GBnjSMxAfIaRkdnhppHK7YpdAGdLRN5xBYecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhI3At/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA33FC4CEE3;
	Fri,  4 Jul 2025 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751641948;
	bh=hZ10LiY5FNP/Dp6S+DBqAzx6uQgjXZaS8IlUwEsCGJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhI3At/YWlFOPWeQNgWpOK/z7lt5fmnRr4cDgf1YXwCzaIRmj36teIkXdk7vE86Yt
	 NQaVta+0qbjEWCt/cT9wzERra7juB8zjgR7V2k/ukkD63VLKuDw+9Oo6W9quS3s7Zv
	 xO3423zNVGe9iqbpSlSXMLV+N5484Ts6ILuRp7iIiPxYpqQFjPXb3vmbOjQBHrNVWR
	 UIl/QOTjK9iUzBsfpRaZPNscXPlIZnEuCr9Ljx7zP0JfPDSNXEF/o+dJEiqxZgOB88
	 eRGMJOBnjk6stxn3bVpqeCjPrOeZxL2WG+MMbxUZ8EqkZsE57LfLXjv/EbQA0EGwpD
	 uzpEujK8cHkVQ==
Date: Fri, 4 Jul 2025 17:12:20 +0200
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
Subject: Re: [PATCH v8 2/7] rust: pwm: Add core 'Device' and 'Chip' object
 wrappers
Message-ID: <aGfvVMBpNoFEJEgC@pollux>
References: <20250704-rust-next-pwm-working-fan-for-sending-v8-0-951e5482c9fd@samsung.com>
 <CGME20250704120212eucas1p1c9ffeefa41b0ddb27db74d26174831bf@eucas1p1.samsung.com>
 <20250704-rust-next-pwm-working-fan-for-sending-v8-2-951e5482c9fd@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-rust-next-pwm-working-fan-for-sending-v8-2-951e5482c9fd@samsung.com>

On Fri, Jul 04, 2025 at 02:01:12PM +0200, Michal Wilczynski wrote:
> +impl<T: 'static + ForeignOwnable> Chip<T> {
> +    /// Allocates and wraps a PWM chip using `bindings::pwmchip_alloc`.
> +    ///
> +    /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
> +    /// on its embedded `struct device`.
> +    pub fn new(
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
> +        // Cast the `*mut bindings::pwm_chip` to `*mut Chip`. This is valid because
> +        // `Chip` is `repr(transparent)` over `Opaque<bindings::pwm_chip>`, and
> +        // `Opaque<T>` is `repr(transparent)` over `T`.
> +        let chip_ptr_as_self = c_chip_ptr.cast::<Self>();
> +
> +        // SAFETY: The pointer is valid, so we can create a temporary ref to set data.
> +        let chip_ref = unsafe { &*chip_ptr_as_self };
> +        // SAFETY: `chip_ref` points to a valid chip from `pwmchip_alloc` and `drvdata` is a valid,
> +        // owned pointer from `ForeignOwnable` to be stored in the chip's private data.
> +        unsafe { bindings::pwmchip_set_drvdata(chip_ref.as_raw(), drvdata.into_foreign().cast()) }

I think that's great now, but you're missing one last piece: You have to ensure
that drvdata is freed eventually. Here you call into_foreign(), but I think
you're missing from_foreign() in pwm_ops::free.

You also have to ensure that your pwm_ops::free() callback is properly called if
a Chip<T> is dropped *before* it has been registered.

Note that, since Chip is now generic over T, you can easily make the
PwmOpsVTable a const within Chip and set the vtable in Chip::new().

See also how drm::Device does this in [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/drm/device.rs

> +
> +        // SAFETY: `chip_ptr_as_self` points to a valid `Chip` (layout-compatible with
> +        // `bindings::pwm_chip`) whose embedded device has refcount 1.
> +        // `ARef::from_raw` takes this pointer and manages it via `AlwaysRefCounted`.
> +        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) })
> +    }

