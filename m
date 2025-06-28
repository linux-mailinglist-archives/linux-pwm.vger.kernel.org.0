Return-Path: <linux-pwm+bounces-6565-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA8AEC80E
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Jun 2025 17:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5370217D104
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Jun 2025 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4DD25392E;
	Sat, 28 Jun 2025 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mSr5CnBZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346524E016
	for <linux-pwm@vger.kernel.org>; Sat, 28 Jun 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122803; cv=none; b=HTOn7TevQeyCpamlAmVkX/hINuSkihkNLBd5FnvDnJ+kwyNfnNjn5ULiouwEMRCheGJ9BVqL+SK6y8dLGyThMaonnuieNiSWm+VLMMFzNUDEs2NHBQKDOeX91ObDX3p8CW/+TulGc/eb0Fc7iwKAMxZq2JSj8H9E3Qas5nFXfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122803; c=relaxed/simple;
	bh=bMKnRAjj4+BlOLa9W5+0P7HUnfQRmvXx9kbjRTWJfWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=TBlncRLCB2Chc3pX+jJcRW9bVBinbortJc+XLva47k0+F59PCNGVgEmMrc1dtJNaS4eyKgKwpMR7K62T/YtlL00OGvvB4clmEst2FrhO3ueqNNbhqd2yDulzcudjKQoKukxhYlu4PC3pOATYVqrfs3/pnFNvWqoF68PyLsPgN1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mSr5CnBZ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250628150000euoutp0288b1688f358dbe0d5e60c6bc4cb18aa5~NPOiqwejH0811508115euoutp02H
	for <linux-pwm@vger.kernel.org>; Sat, 28 Jun 2025 15:00:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250628150000euoutp0288b1688f358dbe0d5e60c6bc4cb18aa5~NPOiqwejH0811508115euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751122800;
	bh=iPLiuotXR3pLvhRQOSqtXf5NifLPkVWrQ6ZXxbZuw3Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mSr5CnBZRzfx6aAp1yHyfCqkZDU3yQrUc9FGDXIfhXuN/5RNTxpqMWbve4iE44X3c
	 z28wZiTlUzWA34JXyivzg5KHAdNqjX1PbVJbSJHmk2NQfq6nF/X9JKKJ9MGtuPDZz3
	 FSj3tcn/dUE8FYlgx+2howgQo/6AQQnGbtkGw8oE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250628145958eucas1p2a6252159d9e210271037f04a5f64bcf2~NPOhNrPea2071620716eucas1p2L;
	Sat, 28 Jun 2025 14:59:58 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250628145957eusmtip27308016313ad13db5410a2ce67c9e323~NPOgCb8Jg2822428224eusmtip2D;
	Sat, 28 Jun 2025 14:59:57 +0000 (GMT)
Message-ID: <08b44fb5-1dad-4cc8-a843-85ac2fa6b7e9@samsung.com>
Date: Sat, 28 Jun 2025 16:59:57 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] rust: pwm: Add core 'Device' and 'Chip' object
 wrappers
To: Danilo Krummrich <dakr@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Drew Fustini <drew@pdp7.com>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
	Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, Benno
	Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <aF6Kvrk3UTC1Jj5Q@pollux>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250628145958eucas1p2a6252159d9e210271037f04a5f64bcf2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250623180859eucas1p10ebb40f33046d52618ba738ebbbaa664
X-EPHeader: CA
X-CMS-RootMailID: 20250623180859eucas1p10ebb40f33046d52618ba738ebbbaa664
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
	<CGME20250623180859eucas1p10ebb40f33046d52618ba738ebbbaa664@eucas1p1.samsung.com>
	<20250623-rust-next-pwm-working-fan-for-sending-v5-2-0ca23747c23e@samsung.com>
	<aF6Kvrk3UTC1Jj5Q@pollux>



On 6/27/25 14:12, Danilo Krummrich wrote:
> On Mon, Jun 23, 2025 at 08:08:50PM +0200, Michal Wilczynski wrote:
>> +    /// Gets the *typed* driver-specific data associated with this chip's embedded device.
>> +    pub fn drvdata<T: 'static>(&self) -> &T {
>> +        // SAFETY: `self.as_raw()` gives a valid pwm_chip pointer.
>> +        // `bindings::pwmchip_get_drvdata` is the C function to retrieve driver data.
>> +        let ptr = unsafe { bindings::pwmchip_get_drvdata(self.as_raw()) };
>> +
>> +        // SAFETY: The only way to create a chip is through Chip::new, which initializes
>> +        // this pointer.
>> +        unsafe { &*ptr.cast::<T>() }
>> +    }
>> +
>> +    /// Sets the *typed* driver-specific data associated with this chip's embedded device.
>> +    pub fn set_drvdata<T: 'static + ForeignOwnable>(&self, data: T) {
>> +        // SAFETY: `self.as_raw()` gives a valid pwm_chip pointer.
>> +        // `bindings::pwmchip_set_drvdata` is the C function to set driver data.
>> +        // `data.into_foreign()` provides a valid `*mut c_void`.
>> +        unsafe { bindings::pwmchip_set_drvdata(self.as_raw(), data.into_foreign().cast()) }
>> +    }
> 
> I think this is unsound, e.g. what happens if someone calls set_drvdata() twice?
> Then you leak the ForeignOwnable from the first call.
> 
> Anyways, this does not need to be public, you should just call
> bindings::pwmchip_set_drvdata() once in Self::new().
> 
> Please also see [1], where I introduce generic accessors for drvdata for Device.

Thanks, it would be a great idea to update the code after below patchset
is merged.

> 
> [1] https://lore.kernel.org/lkml/20250621195118.124245-3-dakr@kernel.org/
> 
>> +    /// Allocates and wraps a PWM chip using `bindings::pwmchip_alloc`.
>> +    ///
>> +    /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
>> +    /// on its embedded `struct device`.
>> +    pub fn new<T: 'static + ForeignOwnable>(
>> +        parent_dev: &device::Device,
>> +        npwm: u32,
>> +        sizeof_priv: usize,
>> +	drvdata: T,
>> +    ) -> Result<ARef<Self>> {
>> +        // SAFETY: `parent_device_for_dev_field.as_raw()` is valid.
>> +        // `bindings::pwmchip_alloc` returns a valid `*mut bindings::pwm_chip` (refcount 1)
>> +        // or an ERR_PTR.
>> +        let c_chip_ptr_raw =
>> +            unsafe { bindings::pwmchip_alloc(parent_dev.as_raw(), npwm, sizeof_priv) };
>> +
>> +        let c_chip_ptr: *mut bindings::pwm_chip = error::from_err_ptr(c_chip_ptr_raw)?;
>> +
>> +        // Cast the `*mut bindings::pwm_chip` to `*mut Chip`. This is valid because
>> +        // `Chip` is `repr(transparent)` over `Opaque<bindings::pwm_chip>`, and
>> +        // `Opaque<T>` is `repr(transparent)` over `T`.
>> +        let chip_ptr_as_self = c_chip_ptr.cast::<Self>();
>> +
>> +	// SAFETY: The pointer is valid, so we can create a temporary ref to set data.
>> +        let chip_ref = unsafe { &*chip_ptr_as_self };
>> +        chip_ref.set_drvdata(drvdata);
>> +
>> +        // SAFETY: `chip_ptr_as_self` points to a valid `Chip` (layout-compatible with
>> +        // `bindings::pwm_chip`) whose embedded device has refcount 1.
>> +        // `ARef::from_raw` takes this pointer and manages it via `AlwaysRefCounted`.
>> +        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) })
>> +    }
>> +}
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

