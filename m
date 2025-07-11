Return-Path: <linux-pwm+bounces-6839-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA714B01C25
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 14:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5D03AC32E
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 12:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4082BE658;
	Fri, 11 Jul 2025 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C1irTKJK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C72BDC0F
	for <linux-pwm@vger.kernel.org>; Fri, 11 Jul 2025 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237403; cv=none; b=NnOHUAmtTwc5nG56Px+35RAvkvkgKs0oMq9v7MRoYnHZSOBjSDRjrB6NRACO/kKPCTsBW9Scaq6QUyJQacfVMdcwHp9wgcWwBUdkyGQMGIHbutCt/RNPf6NyPtB29ak/YQ7jOvEjbAEAtsUVLgtl/SNPtriYrtGbgBoXfMYc6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237403; c=relaxed/simple;
	bh=3k7zeyqd7SmF+I9Quix2UZLh1NAmpJ08rR0/1iKfNfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=UXxoYM/egU5zIqOZwnUcuTAZwFO0pL3JXv+3VAjjWj5FWm9DFbG4qi0lfx8PzQgjuca9P/uPNEHGqZYduQeVO/WJRivdbW6bdRLaPd18x5FaDmT1s/sf85ucwYM5aZTlaFqisQrFX//PYHWLst/VFQKWHawwxJ2Apd18dEn9fXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=C1irTKJK; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250711123640euoutp012c5acf82249e8f1f24b65f5cb4134ae3~RMqGxE-pa0438104381euoutp01G
	for <linux-pwm@vger.kernel.org>; Fri, 11 Jul 2025 12:36:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250711123640euoutp012c5acf82249e8f1f24b65f5cb4134ae3~RMqGxE-pa0438104381euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752237400;
	bh=K0K/KtJbTXHNw0pmcTrwWsLkly4FuPuuoVVC7z5NRQU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=C1irTKJKR6dh7Zyb0hzv5ZIWVDUNbUFWxCqT3Z09Oirx/34YrJ7RKqeNSd3wCC3Ji
	 IJHkR0vLQvRNN+rNzQJgYvbmdLrcjiJiV5ZFOgtOudkwD5LrcsUnataJLfTIPiwJIC
	 vNXQ5zUwT/XPaG02QKWIcb1NAG85KB7+rU74SHTY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250711123639eucas1p1941aef7a8b0e49493b430463f97136db~RMqF-42Wd2355023550eucas1p1H;
	Fri, 11 Jul 2025 12:36:39 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250711123637eusmtip2a6e5e3c4f720153c14660001342b34a8~RMqEx1kL50333203332eusmtip2h;
	Fri, 11 Jul 2025 12:36:37 +0000 (GMT)
Message-ID: <020b8036-8959-4733-a5ab-ce8c963ce869@samsung.com>
Date: Fri, 11 Jul 2025 14:36:37 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: Danilo Krummrich <dakr@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
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
	devicetree@vger.kernel.org, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <DB8OT5ZZ4SRO.WP5PBFLML683@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250711123639eucas1p1941aef7a8b0e49493b430463f97136db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6
X-EPHeader: CA
X-CMS-RootMailID: 20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com>
	<20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
	<e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com>
	<ipvaegqlkco5qinhvn33mqvg7ev2walvs74xtzvhimxsfsfzhv@gcmpxcdtetdn>
	<e77eab1c-446f-4620-95be-d343684d1e95@samsung.com>
	<4hmb3di5x2iei43nmrykrj5wzlltrf3vrnqvexiablonbscn57@4bbsz5c76t63>
	<DB8I5J8ZY7QF.2D8HEN6JX4HSZ@kernel.org>
	<cbxpqormchajfcnf7xxopd7j7igriqus4cuu5jfvxb3mbfb5tu@qz4rc67vjyif>
	<DB8OT5ZZ4SRO.WP5PBFLML683@kernel.org>



On 7/10/25 23:19, Danilo Krummrich wrote:
> On Thu Jul 10, 2025 at 10:57 PM CEST, Uwe Kleine-König wrote:
>> On Thu, Jul 10, 2025 at 06:06:26PM +0200, Danilo Krummrich wrote:
>>> On Thu Jul 10, 2025 at 5:25 PM CEST, Uwe Kleine-König wrote:
>>>> Hello Michal,
>>>>
>>>> On Thu, Jul 10, 2025 at 03:48:08PM +0200, Michal Wilczynski wrote:
>>>>> On 7/10/25 15:10, Uwe Kleine-König wrote:
>>>>>> On Thu, Jul 10, 2025 at 10:42:07AM +0200, Michal Wilczynski wrote:
>>>>>>> On 7/7/25 11:48, Michal Wilczynski wrote:
>>>>>>>> The series is structured as follows:
>>>>>>>>  - Expose static function pwmchip_release.
>>>>>>
>>>>>> Is this really necessary? I didn't try to understand the requirements
>>>>>> yet, but I wonder about that. If you get the pwmchip from
>>>>>> __pwmchip_add() the right thing to do to release it is to call
>>>>>> pwmchip_remove(). Feels like a layer violation.
>>>>>
>>>>> It's required to prevent a memory leak in a specific, critical failure
>>>>> scenario. The sequence of events is as follows:
>>>>>
>>>>>     pwm::Chip::new() succeeds, allocating both the C struct pwm_chip and
>>>>>     the Rust drvdata.
>>>>>
>>>>>     pwm::Registration::register() (which calls pwmchip_add()) fails for
>>>>>     some reason.
>>>>
>>>
>>> (Just trying to help clear up the confusion.)
>>
>> Very appreciated!
>>
>>>> If you called pwmchip_alloc() but not yet pwmchip_add(), the right
>>>> function to call for cleanup is pwmchip_put().
>>>
>>> That is exactly what is happening when ARef<Chip> is dropped. If the reference
>>> count drops to zero, pwmchip_release() is called, which frees the chip. However,
>>> this would leave the driver's private data allocation behind, which is owned by
>>> the Chip instance.
>>
>> I don't understand that. The chip and the driver private data both are
>> located in the same allocation. How is this a problem of the driver
>> private data only then? The kfree() in pwmchip_release() is good enough
>> for both?!
> 
> Not in the current abstractions, there are two allocations, one for the Chip and
> one for the driver's private data, or in other words the abstraction uses
> pwmchip_set_drvdata() and pwmchip_get_drvdata().
> 
> Having a brief look at pwmchip_alloc(), it seems to me that PWM supports the
> subclassing pattern with pwmchip_priv().
> 
> We should probably take advantage of that. Assuming we do that, the Rust
> abstraction still needs a release() callback because we still need to call
> drop_in_place() in order to get the destructor of the driver's private data
> type called. We actually missed this in DRM and I fixed it up recently [1].
> 
> @Michal: With the subclassing pattern the Chip structure would look like this:
> 
> 	#[repr(C)]
> 	#[pin_data]
> 	pub struct Chip<T> {
> 	   inner: Opaque<bindings::pwm_chip>,
> 	   #[pin]
> 	   data: T,
> 	}
}

Hello

Thank you both for the detailed feedback and suggestions.

Danilo, you are right, we should absolutely use the subclassing pattern
to have a single allocation for the chip and driver data. This is a much
cleaner design.

As I looked into this, the main difference is that the C struct pwm_chip
doesn't have a fixed size because of the pwms[] array at the end. This
prevents us from using the exact struct layout you suggested.

pub pwms: __IncompleteArrayField<pwm_device>,

Therefore, to correctly implement the subclassing pattern, it would be
sufficient to leave the current struct as is and use pwmchip_get_drvdata to
acquire pointers to the allocated drvdata.

pub struct Chip<T: PwmOps>(Opaque<bindings::pwm_chip>, PhantomData<T>);

This will still achieve the goal of a single allocation via
pwmchip_alloc's sizeof_priv argument, while working around the DST
limitation.

> 
> And in the release() callback would look like this:
> 
>     extern "C" fn release(ptr: *mut bindings::pwm_chip) {
>         // CAST: Casting `ptr` to `Chip<T>` is valid, since [...].
>         let this = ptr.cast<Chip<T>>();

I think this would use pwmchip_get_drvdata instead.

> 
>         // SAFETY:
>         // - When `release` runs it is guaranteed that there is no further access to `this`.
>         // - `this` is valid for dropping.
>         unsafe { core::ptr::drop_in_place(this) };
>     }
> 
> This is exactly what we're doing in DRM as well, I would have recommended this
> to begin with, but I didn't recognize that PWM supports subclassing. :)
> 
> I recommend having a look at [2].
> 
> [1] https://lore.kernel.org/all/20250629153747.72536-1-dakr@kernel.org/
> [2] https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-fixes/rust/kernel/drm/device.rs
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

