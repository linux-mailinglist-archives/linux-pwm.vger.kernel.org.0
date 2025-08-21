Return-Path: <linux-pwm+bounces-7132-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547D4B30942
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 00:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428AB16FB9C
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Aug 2025 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D72EAB84;
	Thu, 21 Aug 2025 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EchqXJId"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A02E0410
	for <linux-pwm@vger.kernel.org>; Thu, 21 Aug 2025 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815746; cv=none; b=nwUmKVghOKy3K78cEV9vY2OMRAHX+qFAVPuZXSg/tV0bniPdbv+VcSW6GRI0Cs+ps9LIieZeW3Z7En9XfPXApg+PEZFdM5X1RlFuFAZ1oV3Mj2Oun+N03Y83XjVZ6TIc/uiV/4ctQsW9/cZIJ5s9++b57bh2GcKuhncFWr03dYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815746; c=relaxed/simple;
	bh=FkxrYII2TEEj7Hu4cK1rRwgXY6zqhrRnMGhlROYpvDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=R56VKtpY15qN2tNptllJm7/1Y3HDqTr723UFnbCB9cqkMJSv6xBx5Ogg7MIquTtCrxBofuqah4Cn5kqQsfvRYPWVz/xTGbeiDvbHqjnyoyrWjveJ+7VEHPnx8PFe1UwdzjrdBnES8LuQddv0y8FnjdKMTD0HGHXsVjSmVhcmwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EchqXJId; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250821223541euoutp01295f21beba6b2fd06bf19f9120aedf85~d6R0uaoD81752617526euoutp01D
	for <linux-pwm@vger.kernel.org>; Thu, 21 Aug 2025 22:35:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250821223541euoutp01295f21beba6b2fd06bf19f9120aedf85~d6R0uaoD81752617526euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755815741;
	bh=3i+hbzU8RFcDzVjqMTUidVYvZwJLP627miUufKiWjKc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EchqXJIdjhi1/Rw0fXBY4CmZy/EKm7bSiCYPGO6TfZECD3oYg/iML48fWFfMqa3I7
	 t2wIHPc19loWlcJZJcWdc/4W1E7qVDkq6Nq5nGrRRsmjeCZS1vxbybhe+tp0+ol05T
	 dxyzlS99qMR05oryn84X5fjsF8q8XCW5bIWMish4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250821223540eucas1p2887283df2fcd024bb24a0034bebb99ce~d6Rzr2R6r0984009840eucas1p2k;
	Thu, 21 Aug 2025 22:35:40 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250821223539eusmtip2f1a4ec8a2273c2e74d641e183d0914e9~d6RynamBV3047330473eusmtip2H;
	Thu, 21 Aug 2025 22:35:38 +0000 (GMT)
Message-ID: <78ffebda-744b-4a1b-9676-82f46c2d29d1@samsung.com>
Date: Fri, 22 Aug 2025 00:35:38 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/7] rust: pwm: Add complete abstraction layer
To: Elle Rhumsaa <elle@weathered-steel.dev>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
	Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, Benno
	Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Drew Fustini <fustini@kernel.org>, Daniel Almeida
	<daniel.almeida@collabora.com>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <aKY58dUO0RsoOqGb@archiso>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250821223540eucas1p2887283df2fcd024bb24a0034bebb99ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250820083544eucas1p233f8b8f7d1c0b59acededa3572d632aa
X-EPHeader: CA
X-CMS-RootMailID: 20250820083544eucas1p233f8b8f7d1c0b59acededa3572d632aa
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
	<CGME20250820083544eucas1p233f8b8f7d1c0b59acededa3572d632aa@eucas1p2.samsung.com>
	<20250820-rust-next-pwm-working-fan-for-sending-v14-3-df2191621429@samsung.com>
	<aKY58dUO0RsoOqGb@archiso>



On 8/20/25 23:11, Elle Rhumsaa wrote:

>> +/// Wrapper for a PWM device [`struct pwm_device`](srctree/include/linux/pwm.h).
>> +#[repr(transparent)]
>> +pub struct Device(Opaque<bindings::pwm_device>);
>> +
>> +impl Device {
>> +    /// Creates a reference to a [`Device`] from a valid C pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
>> +    /// returned [`Device`] reference.
>> +    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::pwm_device) -> &'a Self {
>> +        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
>> +        // `Device` type being transparent makes the cast ok.
>> +        unsafe { &*ptr.cast::<Self>() }
>> +    }
> 
> This looks like the only constructor for `Device`, and it has restricted
> visibility.
> 
> Would it be helpful to provide a doc-test here to show intended usage?
> 
> After looking at the C code, it looks like the raw `pwm_device` pointer
> is extracted from a `device` struct, or stored in an array of
> `pwm_device` pointers.
> 
> Is the intent that the `pwm_device` will always be allocated from C
> code? For example, is a `pub fn new() -> &'a Self`-style constructor
> not possible/desired?
> 

You're correct the intent is for pwm_device to be allocated and managed
by the C core. The Rust code only ever receives a raw pointer to an
existing device during callbacks.

For this reason, a public new() constructor isn't appropriate, and the
from_raw function is pub(crate) for use only by the FFI adapter. A
doc-test is also impractical since we can't create a valid pwm_device in
a test environment.

> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

