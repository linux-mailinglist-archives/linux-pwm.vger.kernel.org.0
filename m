Return-Path: <linux-pwm+bounces-6705-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4716DAF5CBE
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 17:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296FC1C45A34
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC9F2F2358;
	Wed,  2 Jul 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt1ABjjI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC022F365B;
	Wed,  2 Jul 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469669; cv=none; b=MoxZH+q+y4A2vJYAqfclfvcgvMYH15Y8DO2i4Va4YKPyA7a88IU9FtDcFktBhmqR5ID2/tBZqS0dEbsW0nfK389DVvR6OMr+gqKwMz0G1XzDjrHEpKHUbnSd1Liha8wLYec89Bz1aX8HZhLGU6yNvIFfSx6syyyLr3C52H2i2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469669; c=relaxed/simple;
	bh=M/1qI026Rf8MHuDJoLIxqcQbHcw9InNMCIRG1daBlW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS6C02ukT/m718ZBuT2daezwc3+RWT/FVyB4zXKG8qjf4UW7U43xdoEeXC0WVyA16njWTE6R77Ccn6cjCLn2DfMJhb6lh0dffqYm/MFsidnv2BMzN1FbgNBJoMxrH50xL0PSRdK+NK31rY2Ds8wY+tVIauA655yfDzlmKXQwsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt1ABjjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A127C4CEE7;
	Wed,  2 Jul 2025 15:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751469668;
	bh=M/1qI026Rf8MHuDJoLIxqcQbHcw9InNMCIRG1daBlW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gt1ABjjID7Yl1S93DXNEXXx9Gu+slXGI3XlUkze9+VdPfBrRji29vH/Za7ojXIyJc
	 NoY/8Kk5iCroXeRw/044bIbHoRswoHsJy00tTHMdd1NAnNLUdJg0rNQvTJQNRoa9Vk
	 oEjZWsS/9UOnwcmtp+bEdcCepAJJ1B4kb1zCN2LG1SUT3mtc2IoqUnW2p1WwAm+aBU
	 kUKnxBuGnEEuO9FWQHj+ewubg6e7wXbxE7icOT9PkwujBlhN8Kwtdx2p0aFiwVd+FD
	 rthuZtHy4zRT/tsB04nNnve7FTpvTj7Q0Dppc1lF1c4kvsndaOBiafeh1s4WRaKNNR
	 dih7Dip1xrTLg==
Date: Wed, 2 Jul 2025 17:21:00 +0200
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
Subject: Re: [PATCH v7 4/8] rust: pwm: Add driver operations trait and
 registration support
Message-ID: <aGVOXNqnSjCm8fQl@pollux>
References: <20250702-rust-next-pwm-working-fan-for-sending-v7-0-67ef39ff1d29@samsung.com>
 <CGME20250702134958eucas1p26baf0f661006f5b79c31b2afa683baee@eucas1p2.samsung.com>
 <20250702-rust-next-pwm-working-fan-for-sending-v7-4-67ef39ff1d29@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-rust-next-pwm-working-fan-for-sending-v7-4-67ef39ff1d29@samsung.com>

On Wed, Jul 02, 2025 at 03:45:32PM +0200, Michal Wilczynski wrote:
> +impl Registration {
> +    /// Registers a PWM chip with the PWM subsystem.
> +    ///
> +    /// Transfers its ownership to the `devres` framework, which ties its lifetime
> +    /// to the parent device.
> +    /// On unbind of the parent device, the `devres` entry will be dropped, automatically
> +    /// calling `pwmchip_remove`. This function should be called from the driver's `probe`.
> +    pub fn register(
> +        dev: &device::Device<Bound>,
> +        chip: ARef<Chip>,
> +        ops_vtable: &'static PwmOpsVTable,
> +    ) -> Result {

One thing I did miss here: Given that this should give us the guarantee that the
parent device of the Chip is always bound, you have to add a check for this
here, i.e. fail if `dev.as_raw() != chip.parent().as_raw()`.

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
> +        devres::register(dev, registration, GFP_KERNEL)
> +    }
> +}

