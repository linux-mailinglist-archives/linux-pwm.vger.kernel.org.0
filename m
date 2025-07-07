Return-Path: <linux-pwm+bounces-6750-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A227AFAE4C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 10:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6AC3A874B
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 08:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B95F289E2D;
	Mon,  7 Jul 2025 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gJeqK7e3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB5800
	for <linux-pwm@vger.kernel.org>; Mon,  7 Jul 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875947; cv=none; b=kY+KnENdIKBiAkckc8Vrp+dHW0bza+3GbkmuVsDfiPufx8z8Yg9ZOISwWbFBYLmNP8aHwNFWjfcjRjq93Kw3M8TAqE/i/VVh5xbLiA29YgtJFOTpgwDEoSjOGb95sTew5RJQ1nqi0A1OvLtadq3G84YhRZK/yQhW1ALTENBy/wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875947; c=relaxed/simple;
	bh=yOqRICLmRYtNzZiWecQrP66gB25Vi58BwOuruBWa+IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hGxoFGAe7EvzRj5DR8/FJgGQw9sCNO532PnOnAQgHCZ6B+rYSozu5DT6JsYbDl1yP31Jo0+vjK1rOaB7ZzdkXGzJpLv1CZu6CPq02E9nIkLdKGbUSLxKhtSYhpQHf/D07qzVEvPt54YZSvu1LReinx6oOQ2GU/SGhE9i7XHtu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gJeqK7e3; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250707081224euoutp01ba600bd60d23f83a581c562866fd0347~P6eOt1ZCE0488504885euoutp01b
	for <linux-pwm@vger.kernel.org>; Mon,  7 Jul 2025 08:12:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250707081224euoutp01ba600bd60d23f83a581c562866fd0347~P6eOt1ZCE0488504885euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751875944;
	bh=dnqfahgdX+avAWwRgYn51cRHDYqFSaWYH3r+HyZbJc8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=gJeqK7e3jDPeVpycraAkwzXkgeJ6egUTI8EfY/qJ4rrdgpNX3mkIiI3++hO4huJVT
	 FTMvgYO8vE5z6vBQP4BTPHmKyH09L6kO5GEay51OavXiZ39FsgvAveWa80D3d3UHUQ
	 zUibBhrSui29xcxj3q7yQkIWIAIvvlnLBdMKAcIw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250707081223eucas1p170446baf185b93004844de16952f1225~P6eOCmy__0035700357eucas1p1v;
	Mon,  7 Jul 2025 08:12:23 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250707081222eusmtip127c52a8d31ab35fe240938c0c347f713~P6eM6tJWH2076020760eusmtip1L;
	Mon,  7 Jul 2025 08:12:22 +0000 (GMT)
Message-ID: <9ec72ebf-33cb-466d-a41b-ea593e63b5e2@samsung.com>
Date: Mon, 7 Jul 2025 10:12:21 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/6] rust: pwm: Add complete abstraction layer
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Danilo
	Krummrich <dakr@kernel.org>
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
	devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <yxtnwax73wkliqkbq5736tswbxrblpwx4bn6z257tyd2xu23jx@y6k6iwdhmsgy>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250707081223eucas1p170446baf185b93004844de16952f1225
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250706114605eucas1p17d1cbd035d14d95f4ad0588c2572b3e2
X-EPHeader: CA
X-CMS-RootMailID: 20250706114605eucas1p17d1cbd035d14d95f4ad0588c2572b3e2
References: <20250706-rust-next-pwm-working-fan-for-sending-v9-0-42b5ac2101c7@samsung.com>
	<CGME20250706114605eucas1p17d1cbd035d14d95f4ad0588c2572b3e2@eucas1p1.samsung.com>
	<20250706-rust-next-pwm-working-fan-for-sending-v9-2-42b5ac2101c7@samsung.com>
	<aGpqqGMTU3a3O8cn@pollux>
	<yxtnwax73wkliqkbq5736tswbxrblpwx4bn6z257tyd2xu23jx@y6k6iwdhmsgy>



On 7/7/25 08:57, Uwe Kleine-König wrote:
> Hello Danilo,
> 
> On Sun, Jul 06, 2025 at 02:23:04PM +0200, Danilo Krummrich wrote:
>> On Sun, Jul 06, 2025 at 01:45:13PM +0200, Michal Wilczynski wrote:
>>> +    /// # Safety
>>> +    ///
>>> +    /// `dev` must be a valid pointer to a `bindings::device` embedded within a
>>> +    /// `bindings::pwm_chip`. This function is called by the device core when the
>>> +    /// last reference to the device is dropped.
>>> +    unsafe extern "C" fn release_callback(dev: *mut bindings::device) {
>>> +        // SAFETY: The function's contract guarantees that `dev` points to a `device`
>>> +        // field embedded within a valid `pwm_chip`. `container_of!` can therefore
>>> +        // safely calculate the address of the containing struct.
>>> +        let c_chip_ptr = unsafe { container_of!(dev, bindings::pwm_chip, dev) };
>>> +
>>> +        // SAFETY: `c_chip_ptr` is a valid pointer to a `pwm_chip` as established
>>> +        // above. Calling this FFI function is safe.
>>> +        let drvdata_ptr = unsafe { bindings::pwmchip_get_drvdata(c_chip_ptr) };
>>> +
>>> +        if !drvdata_ptr.is_null() {
>>
>> Is this check needed? I think one can't create a pwm::Chip instance without
>> providing a T, so this pointer can't be NULL I think.
> 
> There are currently a few C drivers, that don't use a private data
> struct that is managed by the pwmchip. One of them doesn't make use of
> the pwmchip's drvdata at all. The latter is drivers/pwm/pwm-twl-led.c.

Thank you both for the feedback on this point.

My interpretation aligns with Danilo's: the null check is unnecessary
within the context of this Rust abstraction.

The pwm::Chip::new() API as designed guarantees that driver data is
always provided. For the cases Uwe mentioned, where a C driver might not
use private data, the idiomatic Rust solution would be to use a
zero sized type (e.g., an empty struct or ()) for the PwmOps::DrvData.
This approach still results in a valid, non null pointer being passed to
the C core.

Given that all paths within this abstraction lead to a non null drvdata
pointer, I believe removing the redundant check is the correct approach.

> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

