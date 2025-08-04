Return-Path: <linux-pwm+bounces-6954-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CF7B1AAEF
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 00:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4A818A2ED3
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 22:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ABC286881;
	Mon,  4 Aug 2025 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vn+YsQSa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D623AE62
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346553; cv=none; b=H1wCPIRj4M3UtoD17+ZngJcnLxP1ZeR40Oafrd4Ylj8IQCb0i/L3QyMcNWI+sHaR0/4cccsb6cB/k5cz3Ua6D3+oluFsr+WQxdnxIwEJxr7hKt4UqDKm2J/RrjNSFmuy0OrVJvjpN49WACI1S5FFxQCAWbk/n9dmBz7BDojT5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346553; c=relaxed/simple;
	bh=JUbN3dA5dKNNRuRtqrLVgoTZPHAgBAWedgfI4WsY4zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Wr7JnzuzvmogqLK/DIbcqqF8AGlcDiaxHCKsJPnxgWT9YQ4inpHax1UkJQFGLVCma8LvjVsHhYDvNJaFN+hzedfNYp1L6EvE/yZhvvxkDNPyegvk4hdb6jtMQPY0yPF0wriqEq6Fq07u8Eek85MOD8ekeiZrKztXmnj/qGcYKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Vn+YsQSa; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250804222909euoutp018d3bd8a250da842503586495a04a9d10~YsORNaRNY1296012960euoutp01R
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 22:29:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250804222909euoutp018d3bd8a250da842503586495a04a9d10~YsORNaRNY1296012960euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754346549;
	bh=+RcFBByccHQrOvrGhevDXqOYgnFEm0AztkkNSDHAn7k=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Vn+YsQSaL0tPxgww8oXD504OWFUXRUE0GW+bGSWeh6qa2POk61TgkpqaJE3a8sTUd
	 E3JwCg5oUh1snmdb7S15cMQ8OqYhyTooR4N9odzWsQ0ePCsOEGWyI7T5XJzOhpiZYE
	 +O7aRtumJURiCvFQ3X/+4+apX1dTnxjz4YdtnWn8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250804222908eucas1p2069b21749bbab1ebf085f972ec5fd707~YsOQcXlc72283222832eucas1p2i;
	Mon,  4 Aug 2025 22:29:08 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250804222907eusmtip275da20eec177f6ac18638286e0ca7330~YsOPU6M9h2458224582eusmtip2W;
	Mon,  4 Aug 2025 22:29:07 +0000 (GMT)
Message-ID: <8ad10cc3-6e7d-4a8b-b6f6-9568403ee2b3@samsung.com>
Date: Tue, 5 Aug 2025 00:29:07 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/3] rust: pwm: Add complete abstraction layer
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Drew Fustini
	<drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob
	Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
	Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, Michael
	Turquette <mturquette@baylibre.com>, Drew Fustini <fustini@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <42C9DF97-2E0F-453B-800A-1DA49BF8F29F@collabora.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250804222908eucas1p2069b21749bbab1ebf085f972ec5fd707
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250717090833eucas1p16c916450b59a77d81bd013527755cb21
X-EPHeader: CA
X-CMS-RootMailID: 20250717090833eucas1p16c916450b59a77d81bd013527755cb21
References: <20250717-rust-next-pwm-working-fan-for-sending-v12-0-40f73defae0c@samsung.com>
	<CGME20250717090833eucas1p16c916450b59a77d81bd013527755cb21@eucas1p1.samsung.com>
	<20250717-rust-next-pwm-working-fan-for-sending-v12-3-40f73defae0c@samsung.com>
	<42C9DF97-2E0F-453B-800A-1DA49BF8F29F@collabora.com>


On 7/25/25 17:56, Daniel Almeida wrote:
>> +
>> +    /// Gets the label for this PWM device, if any.
>> +    pub fn label(&self) -> Option<&CStr> {
>> +        // SAFETY: self.as_raw() provides a valid pointer.
>> +        let label_ptr = unsafe { (*self.as_raw()).label };
>> +        if label_ptr.is_null() {
>> +            None
>> +        } else {
>> +            // SAFETY: label_ptr is non-null and points to a C string
>> +            // managed by the kernel, valid for the lifetime of the PWM device.
>> +            Some(unsafe { CStr::from_char_ptr(label_ptr) })
>> +        }
>> +    }
> 
> nit: this can be written more concisely, but I personally don’t mind.

Do you have something specific in mind ? I think the alternative way of
expressing this would use NonNull, but somehow this feels less readable
for me.


>> +
>> +/// Trait defining the operations for a PWM driver.
>> +pub trait PwmOps: 'static + Sized {
>> +    /// The driver-specific hardware representation of a waveform.
>> +    ///
>> +    /// This type must be [`Copy`], [`Default`], and fit within `PWM_WFHWSIZE`.
>> +    type WfHw: Copy + Default;
> 
> Can’t you use a build_assert!() here? i.e.:
> 
>     #[doc(hidden)]
>     const _CHECK_SZ: () = {
>         build_assert!(core::mem::size_of::<Self::WfHw>() <= bindings::PWM_WFHWSIZE as usize);
>     };

This doesn't work i.e the driver using oversized WfHw compiles
correctly, but putting the assert inside the serialize did work, please
see below.


> 
>> +        Err(ENOTSUPP)
>> +    }
>> +
>> +    /// Convert a hardware-specific representation back to a generic waveform.
>> +    /// This is typically a pure calculation and does not perform I/O.
>> +    fn round_waveform_fromhw(
>> +        _chip: &Chip<Self>,
>> +        _pwm: &Device,
>> +        _wfhw: &Self::WfHw,
>> +        _wf: &mut Waveform,
>> +    ) -> Result<c_int> {
>> +        Err(ENOTSUPP)
>> +    }
> 
> Please include at least a description of what this returns.

Instead I think it should just return Result, reviewed the code and it's
fine.

> 
>> +/// Bridges Rust `PwmOps` to the C `pwm_ops` vtable.
>> +struct Adapter<T: PwmOps> {
>> +    _p: PhantomData<T>,
>> +}
>> +
>> +impl<T: PwmOps> Adapter<T> {
>> +    const VTABLE: PwmOpsVTable = create_pwm_ops::<T>();
>> +
>> +    /// # Safety
>> +    ///
>> +    /// `wfhw_ptr` must be valid for writes of `size_of::<T::WfHw>()` bytes.
>> +    unsafe fn serialize_wfhw(wfhw: &T::WfHw, wfhw_ptr: *mut c_void) -> Result {
>> +        let size = core::mem::size_of::<T::WfHw>();
>> +        if size > bindings::PWM_WFHWSIZE as usize {
>> +            return Err(EINVAL);
>> +        }
> 
> See my previous comment on using build_assert if possible.

So I did try this and it does work, however it results in a cryptic
linker error:
ld.lld: error: undefined symbol: rust_build_error
>>> referenced by pwm_th1520.2c2c3938312114c-cgu.0
>>>               drivers/pwm/pwm_th1520.o:(<kernel::pwm::Adapter<pwm_th1520::Th1520PwmDriverData>>::read_waveform_callback) in archive vmlinux.a
>>> referenced by pwm_th1520.2c2c3938312114c-cgu.0
>>>               drivers/pwm/pwm_th1520.o:(<kernel::pwm::Adapter<pwm_th1520::Th1520PwmDriverData>>::round_waveform_tohw_callback) in archive vmlinux.a
make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux] Error 1
  
I assume this could be fixed at some point to better explain what
failed? I think putting the assert in serialize functions is fine and
the proposed _CHECK_SZ isn't really required.

I would love to do some debugging and find out why that is myself if
time allows :-)

> 
>> +        // SAFETY: `self.as_raw()` provides a valid pointer for `self`'s lifetime.
>> +        unsafe { (*self.as_raw()).npwm }
>> +    }
>> +
>> +    /// Returns `true` if the chip supports atomic operations for configuration.
>> +    pub fn is_atomic(&self) -> bool {
>> +        // SAFETY: `self.as_raw()` provides a valid pointer for `self`'s lifetime.
>> +        unsafe { (*self.as_raw()).atomic }
>> +    }
>> +
>> +    /// Returns a reference to the embedded `struct device` abstraction.
>> +    pub fn device(&self) -> &device::Device {
>> +        // SAFETY: `self.as_raw()` provides a valid pointer to `bindings::pwm_chip`.
>> +        // The `dev` field is an instance of `bindings::device` embedded within `pwm_chip`.
>> +        // Taking a pointer to this embedded field is valid.
>> +        // `device::Device` is `#[repr(transparent)]`.
>> +        // The lifetime of the returned reference is tied to `self`.
>> +        unsafe { device::Device::as_ref(&raw mut (*self.as_raw()).dev) }
>> +    }
> 
> IIRC, these are supposed to be prefixed with “-“ to highlight that it’s a bulleted list.
> 
>> +
>> +    /// Gets the *typed* driver specific data associated with this chip's embedded device.
> 
> I don’t think this emphasis adds anything of value. (IMHO)
> 
>> +    pub fn drvdata(&self) -> &T {
> 
> This is off-topic (sorry), but I wonder if this shouldn’t be renamed “driver_data()” across the tree.

Agree


> 
> 
> — Daniel
> 
> [0] https://lore.kernel.org/rust-for-linux/20250711-device-as-ref-v2-0-1b16ab6402d7@google.com/
> 
> 

For readability cut the rest of the comments, but they will be fixed

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

