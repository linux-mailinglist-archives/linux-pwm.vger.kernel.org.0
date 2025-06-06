Return-Path: <linux-pwm+bounces-6257-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA89BAD06D1
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 18:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BE21746E7
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 16:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F61289E2E;
	Fri,  6 Jun 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XaAYnvb/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EDC289E01
	for <linux-pwm@vger.kernel.org>; Fri,  6 Jun 2025 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228100; cv=none; b=sL0VM8PTn3hQSIW4oZpz0BDOlOyneYo3nFt8kRwshoDMkPnC8tl49p3rZCdPJ728yk9tEreuKYv3AH5TvFvpc/wKA7oZdMdRw/iyDt6oTY8gtaF7O0H0Q0fagTQ3yleKdHg1ei/Vqb2YDeIKqldB2nxA6Y433QLd94xUzcq0XXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228100; c=relaxed/simple;
	bh=5FCXapijm9KodVEFRg77aRwYafF4dXn2kDNnFXFe09M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=oeOGXaYZYAaYybMQ5C+lqP8R3tvPTu71tRnATVyibMVZ4BDV/mfT520JePJmjto1aLLEEZzkMjlzK7cWHtfHj5RdqmanvT27kH0iOO1Fjzssuj+cIKdFSi0jzhswOhiaqsOuaoHFyiLeT3t6Wpsw7qJKZ5Sv7WeHqdryqalmxUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XaAYnvb/; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250606164136euoutp018afbc9d32e0d6a484f3f1cc9a864113a~Gga_eB3uW0233002330euoutp01H
	for <linux-pwm@vger.kernel.org>; Fri,  6 Jun 2025 16:41:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250606164136euoutp018afbc9d32e0d6a484f3f1cc9a864113a~Gga_eB3uW0233002330euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749228096;
	bh=mnJFHA5ulRzhgLwxfNjBRQiUqguX++zUd23VHbe6KTM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XaAYnvb/Ep9aLxZsG8vG9FWKd4UTZwDZf1KlD/Pz/MnP8g+MH+tQ3RWIybPNDc17x
	 cV4kFkg8QdTRSB4TmDAdkww0WGdVXvetW13q58BLhKbRcA1JNlwbgDNgGe2q3QmyJL
	 pZ/4yztur7q3V1D2oQ6uqgl6I7SXwx6b+xd/Z3e8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250606164134eucas1p1b26805254a1a3e07a7318211bf834e28~Gga89mTvh1202912029eucas1p1J;
	Fri,  6 Jun 2025 16:41:34 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250606164133eusmtip157467893c23ece40f4eb41f3dd30ea84~Gga74zGnv2294722947eusmtip1l;
	Fri,  6 Jun 2025 16:41:33 +0000 (GMT)
Message-ID: <62085c76-7a5e-42f2-acee-138622d7d481@samsung.com>
Date: Fri, 6 Jun 2025 18:41:33 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/6] pwm: Add Rust driver for T-HEAD TH1520 SoC
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
	Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
	Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
	Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CANiq72kVvLogBSVKz0eRg6V4LDB1z7b-6y1WPLSQfXXLW7X3cw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250606164134eucas1p1b26805254a1a3e07a7318211bf834e28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0
X-EPHeader: CA
X-CMS-RootMailID: 20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
	<CGME20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0@eucas1p1.samsung.com>
	<20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com>
	<q6dkihyfosi3k4mtrvyff54nbsjpovmujdbmoqhapo7daznpja@of2p5gtmcq2m>
	<b1c4792e-f997-4eba-a8ed-d2e3f76e3fdd@samsung.com>
	<CANiq72kVvLogBSVKz0eRg6V4LDB1z7b-6y1WPLSQfXXLW7X3cw@mail.gmail.com>



On 6/6/25 17:21, Miguel Ojeda wrote:
> On Fri, Jun 6, 2025 at 4:08 PM Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
>>
>> You're right, thank you. The wrapping_mul is unsafe due to the overflow
>> risk you pointed out.
> 
> What do you mean by "unsafe"? `wrapping_mul` does not trigger UB and
> it intentionally provides wrapping arithmetic.

You're right, I should have said "mathematically incorrect" due to the
overflow, not unsafe

> 
>> The ideal solution would be to use the kernel's own mul_u64_u64_div_u64
>> helper function.
>>
>> Rust maintainers: This binding doesn't seem to be available yet. Would a
>> preparatory patch introducing a minimal rust/kernel/math.rs with  only
>> this binding be the best way to proceed? It seems like a useful utility
>> for more than just this driver.
> 
> Sounds good to me. We also recently had related discussions about
> 64-bit divisions in 32-bit architectures and `const fn`s, you may want
> to take a look:
> 
>     https://lore.kernel.org/rust-for-linux/CANiq72ke45eOwckMhWHvmwxc03dxr4rnxxKvx+HvWdBLopZfrQ@mail.gmail.com/
>     https://lore.kernel.org/rust-for-linux/20250502004524.230553-1-fujita.tomonori@gmail.com/
>     https://lore.kernel.org/rust-for-linux/20250501015818.226376-1-fujita.tomonori@gmail.com/
> 
> I would also be careful choosing the names: if they are supposed the
> same behavior, then please pick the same name as C. Otherwise, we
> should avoid it. Either way, we should document them.
> 
> For instance, is this supposed to be `mul_u64_u64_div_u64`? I guess
> not, given e.g. the `c == 0` case.

Thanks ! Seems like providing a safe Rust wrapper for
mul_u64_u64_div_u64 is the correct path forward. Since it's a standard
helper in the PWM subsystem, using it would allow me to remove the
temporary math implementation from this driver in favor of the kernel's
optimized version.

> 
> I hope that helps & thanks!
> 
> Cheers,
> Miguel
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

