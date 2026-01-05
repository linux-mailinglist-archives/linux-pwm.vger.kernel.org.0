Return-Path: <linux-pwm+bounces-7843-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4FCCF30E9
	for <lists+linux-pwm@lfdr.de>; Mon, 05 Jan 2026 11:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CB58301E6D5
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jan 2026 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E673168E8;
	Mon,  5 Jan 2026 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B0S3VnM/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA73A1E89
	for <linux-pwm@vger.kernel.org>; Mon,  5 Jan 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610252; cv=none; b=fIE2OBKX9PqJoKIBTaLwLpFp7tOXQkI55ajFwxUQs0yrVuRoOogmu7PlwNzfzwkv2H7KmRAbX/CY4BUKX110AEvXomi2RM/v/ODTleadLdNslazOIGl4WrhyUKvm8/EZyVqg26vK57hN5MsOXYIyGrNmygP8xILz9FY1ubFacvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610252; c=relaxed/simple;
	bh=YEZALghmrmSZKlt9PskpO5PpFJL8vJQMWX/q+GZpDVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=lFLtcxmYIXxTrKvqIvhVA5K0TSLVqH+Fhi7IJM6GmCBewOWf9Ss6ZSgFZWJVg7z3CmLMm+ZQLzJBvWu9ODoDVkz6WPlxsko1TaKKw5V9WQ3a1NmslSKqTeXfXbXh6v2LMaZFaRz0P6p03P/wXUt1s8Z8dKPV7nMq0jWcS2rpjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=B0S3VnM/; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260105105041euoutp0264d494875e48d7b9538b2ef7102a0ac7~H0CZBzQdb2395023950euoutp02u
	for <linux-pwm@vger.kernel.org>; Mon,  5 Jan 2026 10:50:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260105105041euoutp0264d494875e48d7b9538b2ef7102a0ac7~H0CZBzQdb2395023950euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767610241;
	bh=Lk5DBiKe5ZAwaSxPMe4gloHOIilzdJw46MPctuWzfG0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=B0S3VnM/1GAMqNAVse9y5BODx0UsHOymtbFn1fHHCVT9xkHSJywqBbsbo57eqptmz
	 xKEy35C8eRR+Qzl1cHuVpkwirv6COtoXTzIyIRx9u9ia9kcehjlaH2VKqpS6THCQdg
	 DwHQWZCodYfYw7iWsO9Wxqvj74VLQ3DRXugVG+v4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260105105041eucas1p2b6d051a96d26eb7643a3a7a1e622b9d5~H0CYzFhBx0093900939eucas1p23;
	Mon,  5 Jan 2026 10:50:41 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260105105040eusmtip1723bc1aaaf92d6f2240f953a12bb9215~H0CYQ4WKz1978719787eusmtip1M;
	Mon,  5 Jan 2026 10:50:40 +0000 (GMT)
Message-ID: <15123ef6-1a36-4b3e-ba4e-9ac5d92c8158@samsung.com>
Date: Mon, 5 Jan 2026 11:50:40 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust: pwm: Fix potential memory leak on init
 error
To: Kari Argillander <kari.argillander@gmail.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260102-pwm-rust-v2-1-2702ce57d571@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260105105041eucas1p2b6d051a96d26eb7643a3a7a1e622b9d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260102075213eucas1p14631809c234a16cfda2c0dfd3331976a
X-EPHeader: CA
X-CMS-RootMailID: 20260102075213eucas1p14631809c234a16cfda2c0dfd3331976a
References: <20260102-pwm-rust-v2-0-2702ce57d571@gmail.com>
	<CGME20260102075213eucas1p14631809c234a16cfda2c0dfd3331976a@eucas1p1.samsung.com>
	<20260102-pwm-rust-v2-1-2702ce57d571@gmail.com>


Hi,
On 1/2/26 08:51, Kari Argillander wrote:
> When initializing a PWM chip using pwmchip_alloc(), the allocated device
> owns an initial reference that must be released on all error paths.
> 
> If __pinned_init() were to fail, the allocated pwm_chip would currently
> leak because the error path returns without calling pwmchip_put().
> 
> Fixes: 7b3dce814a15 ("rust: pwm: Add Kconfig and basic data structures")
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  rust/kernel/pwm.rs | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 2dd72a39acb5..4f683158fc08 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -607,7 +607,11 @@ pub fn new<'a>(
>          let drvdata_ptr = unsafe { bindings::pwmchip_get_drvdata(c_chip_ptr) };
>  
>          // SAFETY: We construct the `T` object in-place in the allocated private memory.
> -        unsafe { data.__pinned_init(drvdata_ptr.cast())? };
> +        unsafe { data.__pinned_init(drvdata_ptr.cast()) }.inspect_err(|_| {
> +            // SAFETY: It is safe to call `pwmchip_put()` with a valid pointer obtained
> +            // from `pwmchip_alloc()`. We will not use pointer after this.
> +            unsafe { bindings::pwmchip_put(c_chip_ptr) }
> +        })?;
>  
>          // SAFETY: `c_chip_ptr` points to a valid chip.
>          unsafe {
> 

Thank you for your patch, sorry for late reply due to holiday season. I
think the patch is good and the Fixes tag is appropriate, as this logic
should have been there in the first place regardless of whether the
pinned init can fail currently or not.

The v2 is fairly similar to what happens with drm device in device.rs
and I think it's more appropriate than v1.

Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>


