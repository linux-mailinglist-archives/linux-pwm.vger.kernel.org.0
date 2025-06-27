Return-Path: <linux-pwm+bounces-6547-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF735AEB763
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 14:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA6D3A66F1
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C412C15BD;
	Fri, 27 Jun 2025 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sftZOycl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35EA2BEFE5;
	Fri, 27 Jun 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026375; cv=none; b=LOj454kiVEOpNa1HN4GQcosU8vpqeOEOhhyitMYUt6jas0VXL4RX12ywoA0IkoZZWw1ZzDIlPoTYqvggs8WHD4Hn2XtJr7kX3MNTZJdnn7DjEr2QFUP77ZPBxVW7rwNnLmGnrRV09hosAV37TuBxsSBhCQwiUSuhD1rBo3ULvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026375; c=relaxed/simple;
	bh=C6oegAaJ6Q9XOuL86FjJu5fzYxEuJUZ71dKO2pzkkNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccng3ONfYUGqizahC/sQ5w3j5bzM+S4GkwoM4IYI1JdFkACaZFR1IqAz5ZOiZEOcxx+a2QtbjCbuyRy6Zy+UYj276UvUOSYPeF/tgIlZG29DuKu/jpouaOhDTCaMflfLpVPvYTMDDChqI7TdlWASRHbQEQs1GXiRzrPWC9y5T7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sftZOycl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6153C4CEE3;
	Fri, 27 Jun 2025 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751026374;
	bh=C6oegAaJ6Q9XOuL86FjJu5fzYxEuJUZ71dKO2pzkkNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sftZOyclg0UnjLvH59IBt3TWlpu4GVOW4KuMn8IEDuNrH2vgoHXZSa2IWzQCGGp+F
	 0iUvAhRQ8QbFdRyHnK3kbDHevMUO6/pDQ7eHfiAtXrWH9DIYuA/NwwCHmddErxrQvd
	 EhxQxR03CgCIJuprGt35iCoWpUVCp+i+9GYzHYmqCMamk57ZxzoAcZV10yeMpZGRgH
	 WbHRJ/tm6DnZBbQf0qPzqtq98A+E+4qpYoFnp9m+E+HUrLW2WRyDh3QCP2VZJ/mOph
	 ss/bWH7nlFaFJ5IAA3BwX3vWRvHMEvx3OjT+YMWHWPmbhgU0blePaRiruCixQxauZ7
	 sDQ1YZKaxcHNA==
Date: Fri, 27 Jun 2025 14:12:46 +0200
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
Subject: Re: [PATCH v5 2/9] rust: pwm: Add core 'Device' and 'Chip' object
 wrappers
Message-ID: <aF6Kvrk3UTC1Jj5Q@pollux>
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
 <CGME20250623180859eucas1p10ebb40f33046d52618ba738ebbbaa664@eucas1p1.samsung.com>
 <20250623-rust-next-pwm-working-fan-for-sending-v5-2-0ca23747c23e@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-rust-next-pwm-working-fan-for-sending-v5-2-0ca23747c23e@samsung.com>

On Mon, Jun 23, 2025 at 08:08:50PM +0200, Michal Wilczynski wrote:
> +    /// Gets the *typed* driver-specific data associated with this chip's embedded device.
> +    pub fn drvdata<T: 'static>(&self) -> &T {
> +        // SAFETY: `self.as_raw()` gives a valid pwm_chip pointer.
> +        // `bindings::pwmchip_get_drvdata` is the C function to retrieve driver data.
> +        let ptr = unsafe { bindings::pwmchip_get_drvdata(self.as_raw()) };
> +
> +        // SAFETY: The only way to create a chip is through Chip::new, which initializes
> +        // this pointer.
> +        unsafe { &*ptr.cast::<T>() }
> +    }
> +
> +    /// Sets the *typed* driver-specific data associated with this chip's embedded device.
> +    pub fn set_drvdata<T: 'static + ForeignOwnable>(&self, data: T) {
> +        // SAFETY: `self.as_raw()` gives a valid pwm_chip pointer.
> +        // `bindings::pwmchip_set_drvdata` is the C function to set driver data.
> +        // `data.into_foreign()` provides a valid `*mut c_void`.
> +        unsafe { bindings::pwmchip_set_drvdata(self.as_raw(), data.into_foreign().cast()) }
> +    }

I think this is unsound, e.g. what happens if someone calls set_drvdata() twice?
Then you leak the ForeignOwnable from the first call.

Anyways, this does not need to be public, you should just call
bindings::pwmchip_set_drvdata() once in Self::new().

Please also see [1], where I introduce generic accessors for drvdata for Device.

[1] https://lore.kernel.org/lkml/20250621195118.124245-3-dakr@kernel.org/

> +    /// Allocates and wraps a PWM chip using `bindings::pwmchip_alloc`.
> +    ///
> +    /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
> +    /// on its embedded `struct device`.
> +    pub fn new<T: 'static + ForeignOwnable>(
> +        parent_dev: &device::Device,
> +        npwm: u32,
> +        sizeof_priv: usize,
> +	drvdata: T,
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
> +	// SAFETY: The pointer is valid, so we can create a temporary ref to set data.
> +        let chip_ref = unsafe { &*chip_ptr_as_self };
> +        chip_ref.set_drvdata(drvdata);
> +
> +        // SAFETY: `chip_ptr_as_self` points to a valid `Chip` (layout-compatible with
> +        // `bindings::pwm_chip`) whose embedded device has refcount 1.
> +        // `ARef::from_raw` takes this pointer and manages it via `AlwaysRefCounted`.
> +        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) })
> +    }
> +}

