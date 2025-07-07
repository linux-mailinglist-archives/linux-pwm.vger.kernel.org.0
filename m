Return-Path: <linux-pwm+bounces-6749-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86270AFAD19
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 09:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55893BBF69
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA9287255;
	Mon,  7 Jul 2025 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nTcmJlWE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EEB286D6B
	for <linux-pwm@vger.kernel.org>; Mon,  7 Jul 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751873423; cv=none; b=ODazqbgckYW1o2gWu6Q0E6yqBLJN+xbdbm4cfy+m+gLkt+ItK0sAHshZHuZPci46+3bo3hxZ+g+8j2LzGjFZ+FxGVKx/gDAXPEkSyXkPN1BILTWdlC79li6hQAUdtdIEUUTyXcIprdMaVjyT1OiQKbD2Qn9CRZetMWvUtbB5Ck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751873423; c=relaxed/simple;
	bh=aSpnSLUsKoIud4TMn2Bqvcleyy0rBk7G0hRpyIo8X6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=XVvuwvooVApNTPe8c7bOBslhy7SnpfrwQPqQJh/+QJOINCCqBPoSqZpiIpVlNMFTav+q/xM/w9vOFU3EAAHo/JxqqxEiLp8hHnvw7sSYMZjO4y7Mlc1ZVHS7wDIwmDokhJf0P4sJyOOYEQCF/jaJoyE7EFFZkdWWFs+SOiv4t0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nTcmJlWE; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250707073019euoutp02d85057a9f8f984003e21cd36275936a9~P55fc53dc1517915179euoutp023
	for <linux-pwm@vger.kernel.org>; Mon,  7 Jul 2025 07:30:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250707073019euoutp02d85057a9f8f984003e21cd36275936a9~P55fc53dc1517915179euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751873419;
	bh=Q5MiDO4kvDAjyRPyePkrhFPW14vb6d7EHum8/0WQ8v4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nTcmJlWE9ADFjtTB8/5dbhfElVYFVx1jEthmk7Ctq63wpWZA0y3SsvT87qm57mCtz
	 rUjt3bDhvweBckPVDFw5OznBTOS+vV7+8SZ9nHBpYZQENs4/FWNurFGCw+oFHkPpQ1
	 XHWI3W7f3PQJvFFlwDzHrIxWLH38TC9yfJ59Mtd0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250707073018eucas1p1a0c2e714826a2571f8c5281b8ef0457c~P55eomzep1941219412eucas1p1u;
	Mon,  7 Jul 2025 07:30:18 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250707073017eusmtip20a0a1f63bf89beef337da1edc73632c1~P55dgBGZm2165621656eusmtip2K;
	Mon,  7 Jul 2025 07:30:17 +0000 (GMT)
Message-ID: <002c8275-f17d-4a4e-b6b8-4dc74c4d510d@samsung.com>
Date: Mon, 7 Jul 2025 09:30:17 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/6] rust: pwm: Add complete abstraction layer
To: Danilo Krummrich <dakr@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, Michael
	Turquette <mturquette@baylibre.com>, Drew Fustini <fustini@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <aGpqqGMTU3a3O8cn@pollux>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250707073018eucas1p1a0c2e714826a2571f8c5281b8ef0457c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250706114605eucas1p17d1cbd035d14d95f4ad0588c2572b3e2
X-EPHeader: CA
X-CMS-RootMailID: 20250706114605eucas1p17d1cbd035d14d95f4ad0588c2572b3e2
References: <20250706-rust-next-pwm-working-fan-for-sending-v9-0-42b5ac2101c7@samsung.com>
	<CGME20250706114605eucas1p17d1cbd035d14d95f4ad0588c2572b3e2@eucas1p1.samsung.com>
	<20250706-rust-next-pwm-working-fan-for-sending-v9-2-42b5ac2101c7@samsung.com>
	<aGpqqGMTU3a3O8cn@pollux>



On 7/6/25 14:23, Danilo Krummrich wrote:
> On Sun, Jul 06, 2025 at 01:45:13PM +0200, Michal Wilczynski wrote:
>> +/// Trait defining the operations for a PWM driver.
>> +pub trait PwmOps: 'static + Sized {
>> +    /// The type of the owned driver data (e.g., `Pin<KBox<...>>`).
>> +    type DrvData: 'static + ForeignOwnable;
>> +    /// The driver-specific hardware representation of a waveform.
>> +    ///
>> +    /// This type must be [`Copy`], [`Default`], and fit within `PWM_WFHWSIZE`.
>> +    type WfHw: Copy + Default;
>> +
>> +    /// Optional hook for when a PWM device is requested.
>> +    fn request(
>> +        _chip: &Chip<Self::DrvData>,
>> +        _pwm: &Device,
>> +        _parent_dev: &device::Device<Bound>,
>> +    ) -> Result {
>> +        Ok(())
>> +    }
>> +
>> +    /// Optional hook for when a PWM device is freed.
>> +    fn free(_chip: &Chip<Self::DrvData>, _pwm: &Device, _parent_dev: &device::Device<Bound>) {}
> 
> NIT: I can't think of a case providing this callback in Rust is useful. Do you
> have a clear use-case in mind? Otherwise, I'd not provide this callback until
> you have one. Should be trivial to add later on.
> 
>> +impl<T: PwmOps> Adapter<T> {
> 
> <snip>
> 
>> +    /// # Safety
>> +    ///
>> +    /// `dev` must be a valid pointer to a `bindings::device` embedded within a
>> +    /// `bindings::pwm_chip`. This function is called by the device core when the
>> +    /// last reference to the device is dropped.
>> +    unsafe extern "C" fn release_callback(dev: *mut bindings::device) {
>> +        // SAFETY: The function's contract guarantees that `dev` points to a `device`
>> +        // field embedded within a valid `pwm_chip`. `container_of!` can therefore
>> +        // safely calculate the address of the containing struct.
>> +        let c_chip_ptr = unsafe { container_of!(dev, bindings::pwm_chip, dev) };
>> +
>> +        // SAFETY: `c_chip_ptr` is a valid pointer to a `pwm_chip` as established
>> +        // above. Calling this FFI function is safe.
>> +        let drvdata_ptr = unsafe { bindings::pwmchip_get_drvdata(c_chip_ptr) };
>> +
>> +        if !drvdata_ptr.is_null() {
> 
> Is this check needed? I think one can't create a pwm::Chip instance without
> providing a T, so this pointer can't be NULL I think.
> 
>> +            // SAFETY: `drvdata_ptr` was stored by `Chip::new` from an owned `T::DrvData`
>> +            // and is guaranteed to be valid if non-null. `from_foreign` can safely
>> +            // reclaim ownership to allow Rust to drop and free the data.
>> +            let _owned_drvdata = unsafe { T::DrvData::from_foreign(drvdata_ptr.cast()) };
>> +        }
>> +    }
> 
> If you overwrite this callback (as you do below) you're leaking the memory
> allocated by pwmchip_alloc().
> 
> The simple way to solve this would be to call pwmchip_release() from here.

Thanks, a pwmchip_release() is static though, so it's either expose the
pwmchip_release in the header, or call kfree() here directly on pwmchip.

> 
> <snip>
> 
>> +impl<T: 'static + ForeignOwnable> Chip<T> {
>> +    /// Allocates and wraps a PWM chip using `bindings::pwmchip_alloc`.
>> +    ///
>> +    /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
>> +    /// on its embedded `struct device`.
>> +    pub fn new<O: PwmOps<DrvData = T>>(
>> +        parent_dev: &device::Device,
>> +        npwm: u32,
>> +        sizeof_priv: usize,
>> +        drvdata: T,
>> +    ) -> Result<ARef<Self>> {
>> +        // SAFETY: `parent_device_for_dev_field.as_raw()` is valid.
>> +        // `bindings::pwmchip_alloc` returns a valid `*mut bindings::pwm_chip` (refcount 1)
>> +        // or an ERR_PTR.
>> +        let c_chip_ptr_raw =
>> +            unsafe { bindings::pwmchip_alloc(parent_dev.as_raw(), npwm, sizeof_priv) };
>> +
>> +        let c_chip_ptr: *mut bindings::pwm_chip = error::from_err_ptr(c_chip_ptr_raw)?;
>> +
>> +        // Set the custom release function on the embedded device. This is the crucial step
>> +        // to ensure `drvdata` is freed when the chip's refcount reaches zero, regardless
>> +        // of whether `Registration::register` was called.
>> +        // SAFETY: `c_chip_ptr` points to a valid chip.
>> +        unsafe { (*c_chip_ptr).dev.release = Some(Adapter::<O>::release_callback); }
> 
> This overwrites [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pwm/core.c?h=v6.16-rc4#n1601
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

