Return-Path: <linux-pwm+bounces-7018-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA1FB2233D
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 11:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE543BD48A
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51B2E8DE6;
	Tue, 12 Aug 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BH8Y9mql"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20272356DA
	for <linux-pwm@vger.kernel.org>; Tue, 12 Aug 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990871; cv=none; b=nzFFqkXTqrSvjIl5V/JoQlaIoZ8ZLSHW1hRNvIhCFJ2AptJUPl8eyoJJY33dACP4+JCgKH6JroKEvrSJvgPeRTaW6q1gm+fpcrczGsKPnSg7Gi4WpHNDxm7c62xZcb46ts2X3EvrVIYNPeYu2xO7nPNif3Vqm64oAZxtn4T2Nsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990871; c=relaxed/simple;
	bh=PbGYvMlzqYx/gA6RLDXradsyz4rLJzdKXURDIyRfsNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=uqYNOe6yQkrmyduYDZm8eocvqe9ObjH3fXTYWyZ2fppggiuC4H2/w18UNldECtGbbbY/UbxhZcRHFuJIYNEqTqnC44cM2iWLA+p07HuGuKZqxH59LVhyc8IWUPZYrVvcAOyPgccWs5wzEiimG9VrKO3o61aAjDdjgBkQ28KVLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BH8Y9mql; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250812092742euoutp01ab06ca45f93724130d3ade4355b88a69~a_uQTfAfx0386203862euoutp01o
	for <linux-pwm@vger.kernel.org>; Tue, 12 Aug 2025 09:27:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250812092742euoutp01ab06ca45f93724130d3ade4355b88a69~a_uQTfAfx0386203862euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754990862;
	bh=g5AHVnaN02SeQdkCUMm3F2XPQfpkP2d1uFtnb+36e6Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=BH8Y9mqlR6X9EU5moo2uOBrTPNczuunrcW8Ux10UL2wyrvY6vSPwG4QNWW46ESur9
	 p2aY8bBqiCXDxtdwd7SytNYVQhwDR05pieKCiv73sttnT69PpAG+4Cm0cfBxsh6Ax7
	 brkLi2eSJYaMJ9d6/Zs+7zjt/inUnI/tcYMKuWao=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250812092741eucas1p18ed7f17ece1be26778845f58868fb528~a_uPpEoNJ3008930089eucas1p1V;
	Tue, 12 Aug 2025 09:27:41 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250812092740eusmtip28fd35ea1890563e079e686f04b78ca2c~a_uOfedmj3004730047eusmtip2C;
	Tue, 12 Aug 2025 09:27:40 +0000 (GMT)
Message-ID: <00ea8f31-140f-467f-8083-e1c044afa391@samsung.com>
Date: Tue, 12 Aug 2025 11:27:40 +0200
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
In-Reply-To: <8C20C615-DBF2-4DF9-9AB3-E78C4B1E7493@collabora.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250812092741eucas1p18ed7f17ece1be26778845f58868fb528
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250717090833eucas1p16c916450b59a77d81bd013527755cb21
X-EPHeader: CA
X-CMS-RootMailID: 20250717090833eucas1p16c916450b59a77d81bd013527755cb21
References: <20250717-rust-next-pwm-working-fan-for-sending-v12-0-40f73defae0c@samsung.com>
	<CGME20250717090833eucas1p16c916450b59a77d81bd013527755cb21@eucas1p1.samsung.com>
	<20250717-rust-next-pwm-working-fan-for-sending-v12-3-40f73defae0c@samsung.com>
	<42C9DF97-2E0F-453B-800A-1DA49BF8F29F@collabora.com>
	<8ad10cc3-6e7d-4a8b-b6f6-9568403ee2b3@samsung.com>
	<8C20C615-DBF2-4DF9-9AB3-E78C4B1E7493@collabora.com>



On 8/6/25 14:49, Daniel Almeida wrote:
> Hi Michal,
> 
>> On 4 Aug 2025, at 19:29, Michal Wilczynski <m.wilczynski@samsung.com> wrote:
>>
>>
>> On 7/25/25 17:56, Daniel Almeida wrote:
>>>> +
>>>> +    /// Gets the label for this PWM device, if any.
>>>> +    pub fn label(&self) -> Option<&CStr> {
>>>> +        // SAFETY: self.as_raw() provides a valid pointer.
>>>> +        let label_ptr = unsafe { (*self.as_raw()).label };
>>>> +        if label_ptr.is_null() {
>>>> +            None
>>>> +        } else {
>>>> +            // SAFETY: label_ptr is non-null and points to a C string
>>>> +            // managed by the kernel, valid for the lifetime of the PWM device.
>>>> +            Some(unsafe { CStr::from_char_ptr(label_ptr) })
>>>> +        }
>>>> +    }
>>>
>>> nit: this can be written more concisely, but I personally don’t mind.
>>
>> Do you have something specific in mind ? I think the alternative way of
>> expressing this would use NonNull, but somehow this feels less readable
>> for me.
> 
> Yes, an early return, i.e.:
> 
> if label_ptr.is_null() {
>   return None
> }
> 
> It saves you one level of indentation by removing the else branch.
> 
>>
>>
>>>> +
>>>> +/// Trait defining the operations for a PWM driver.
>>>> +pub trait PwmOps: 'static + Sized {
>>>> +    /// The driver-specific hardware representation of a waveform.
>>>> +    ///
>>>> +    /// This type must be [`Copy`], [`Default`], and fit within `PWM_WFHWSIZE`.
>>>> +    type WfHw: Copy + Default;
>>>
>>> Can’t you use a build_assert!() here? i.e.:
>>>
>>>    #[doc(hidden)]
>>>    const _CHECK_SZ: () = {
>>>        build_assert!(core::mem::size_of::<Self::WfHw>() <= bindings::PWM_WFHWSIZE as usize);
>>>    };
>>
>> This doesn't work i.e the driver using oversized WfHw compiles
>> correctly, but putting the assert inside the serialize did work, please
>> see below.
> 
> Can you show how it looks like with the build_assert included? Just as a sanity check.

For a sanity check, here’s the code I added to the PwmOps trait, exactly
as you suggested:

#[doc(hidden)]
const _CHECK_SZ: () = {
    build_assert!(core::mem::size_of::<Self::WfHw>() <= bindings::PWM_WFHWSIZE as usize);
};

To test it, I went into the pwm-th1520 driver and changed its WfHw
implementation to be larger than PWM_WFHWSIZE. I expected the build to
fail because of the build_assert!, but it compiled without any errors.

This is why I concluded it "doesn't work" in this position, whereas
placing the check inside the serialize function did cause a (linker)
error as expected. I'm probably missing something subtle here.

> 
>>
>>
>>>
>>>> +        Err(ENOTSUPP)
>>>> +    }
>>>> +
>>>> +    /// Convert a hardware-specific representation back to a generic waveform.
>>>> +    /// This is typically a pure calculation and does not perform I/O.
>>>> +    fn round_waveform_fromhw(
>>>> +        _chip: &Chip<Self>,
>>>> +        _pwm: &Device,
>>>> +        _wfhw: &Self::WfHw,
>>>> +        _wf: &mut Waveform,
>>>> +    ) -> Result<c_int> {
>>>> +        Err(ENOTSUPP)
>>>> +    }
>>>
>>> Please include at least a description of what this returns.
>>
>> Instead I think it should just return Result, reviewed the code and it's
>> fine.
>>
> 
> Ack.
> 
>>>
>>>> +/// Bridges Rust `PwmOps` to the C `pwm_ops` vtable.
>>>> +struct Adapter<T: PwmOps> {
>>>> +    _p: PhantomData<T>,
>>>> +}
>>>> +
>>>> +impl<T: PwmOps> Adapter<T> {
>>>> +    const VTABLE: PwmOpsVTable = create_pwm_ops::<T>();
>>>> +
>>>> +    /// # Safety
>>>> +    ///
>>>> +    /// `wfhw_ptr` must be valid for writes of `size_of::<T::WfHw>()` bytes.
>>>> +    unsafe fn serialize_wfhw(wfhw: &T::WfHw, wfhw_ptr: *mut c_void) -> Result {
>>>> +        let size = core::mem::size_of::<T::WfHw>();
>>>> +        if size > bindings::PWM_WFHWSIZE as usize {
>>>> +            return Err(EINVAL);
>>>> +        }
>>>
>>> See my previous comment on using build_assert if possible.
>>
>> So I did try this and it does work, however it results in a cryptic
>> linker error:
>> ld.lld: error: undefined symbol: rust_build_error
>>>>> referenced by pwm_th1520.2c2c3938312114c-cgu.0
>>>>>              drivers/pwm/pwm_th1520.o:(<kernel::pwm::Adapter<pwm_th1520::Th1520PwmDriverData>>::read_waveform_callback) in archive vmlinux.a
>>>>> referenced by pwm_th1520.2c2c3938312114c-cgu.0
>>>>>              drivers/pwm/pwm_th1520.o:(<kernel::pwm::Adapter<pwm_th1520::Th1520PwmDriverData>>::round_waveform_tohw_callback) in archive vmlinux.a
>> make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux] Error 1
>>
>> I assume this could be fixed at some point to better explain what
>> failed? I think putting the assert in serialize functions is fine and
>> the proposed _CHECK_SZ isn't really required.
>>
>> I would love to do some debugging and find out why that is myself if
>> time allows :-)
> 
> There is nothing wrong here. A canonical Rust-for-Linux experience is stumbling
> upon the error generated by build_assert and being rightly confused. People ask
> about this every few months :)
> 
> This just means that the build_assert triggered and the build failed as a
> result. IOW, it means that your build_assert is working properly to catch
> errors.

Yeah it is working correctly, I was just hoping errors can be somehow
made more informative :-), but it is hard and would require some support
from compiler as I imagine.

> 
> — Daniel
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

