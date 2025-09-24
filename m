Return-Path: <linux-pwm+bounces-7349-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7A1B9BB59
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Sep 2025 21:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E001BC231B
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Sep 2025 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA66261B8F;
	Wed, 24 Sep 2025 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="feWL4jvy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039226B2C8
	for <linux-pwm@vger.kernel.org>; Wed, 24 Sep 2025 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742240; cv=none; b=Ckchk5R0qrqXj4M/xMEXookd8NH1PfZG1AVy4nQnqLwagjBahHkjEmObYHusqstmRX8gzRF4V52swFEu3ywwZxvmfCPxd1WRW0l+zpat9AxFtu0axM4XbPkupr1TGsETjiFPkDvAM6R2QfX3SF4y9mlQsZ7iRqNb+fz47RXo9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742240; c=relaxed/simple;
	bh=HBlBtjJuiSJREEKCRDFE2CMgGB0Q+lfxBms6vvoiQs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=YsZUG+PsNeF6wf00EFLjfwkBSQMMBx/k07ayTFLxXahuyMltKgNtgpqzOA8y+fB3Vbyn/iswCFZN7CazrD9nmGTdhcHK093sR75u+SFpQ6n81xA1a4nL2CMuYhxcmkKSTmfjNiOyRUuCts82sbYmNXAv/cHmrAsDEVEXu+4dM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=feWL4jvy; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250924193036euoutp01e4c450f962e4a1f837114d3e32017b71~oTr79qjAE1361513615euoutp018
	for <linux-pwm@vger.kernel.org>; Wed, 24 Sep 2025 19:30:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250924193036euoutp01e4c450f962e4a1f837114d3e32017b71~oTr79qjAE1361513615euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758742236;
	bh=/Gk+JQ7pocHBfcq36N6Notv0uvwakh9CVF4aSzWJ8hw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=feWL4jvyddS/Rk6tUEFJ/d1jrrrJBbbtVkvIx0lREBNp6qbVJJBagYq/pHWTX/7dr
	 Jy9Tqwk2nl7h4GTXgG+Z5lJ71I7YLU/Y/bXia+wqA6iDqDIw88WMHgAFG45hB+WETa
	 Wk+fRSdNiGjlGnD1BkNB5oZ0FjK2jZZC5VzY2ZzI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250924193035eucas1p18bc9f48e524c3824662031da8261758e~oTr7TWTQq1522115221eucas1p1B;
	Wed, 24 Sep 2025 19:30:35 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250924193034eusmtip2cbf8bf03a89dc1fb923f25bee047d0da~oTr6PXOuQ0163201632eusmtip2W;
	Wed, 24 Sep 2025 19:30:34 +0000 (GMT)
Message-ID: <67e3a691-0ba8-4c21-97e1-4471f2a1a87c@samsung.com>
Date: Wed, 24 Sep 2025 21:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/7] pwm: Export `pwmchip_release` for external use
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
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
In-Reply-To: <3jxl6gpxwv376ooyny7qkeokeh7nzafttbyoehmwqzrccn5oip@747v6zdnogso>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250924193035eucas1p18bc9f48e524c3824662031da8261758e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250820083541eucas1p2ad7d78418576b8bc8cbddd8efe83bbe9
X-EPHeader: CA
X-CMS-RootMailID: 20250820083541eucas1p2ad7d78418576b8bc8cbddd8efe83bbe9
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
	<CGME20250820083541eucas1p2ad7d78418576b8bc8cbddd8efe83bbe9@eucas1p2.samsung.com>
	<20250820-rust-next-pwm-working-fan-for-sending-v14-1-df2191621429@samsung.com>
	<3jxl6gpxwv376ooyny7qkeokeh7nzafttbyoehmwqzrccn5oip@747v6zdnogso>



On 9/15/25 12:00, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Aug 20, 2025 at 10:35:36AM +0200, Michal Wilczynski wrote:
>> The upcoming Rust abstraction layer for the PWM subsystem uses a custom
>> `dev->release` handler to safely manage the lifetime of its driver
>> data.
>>
>> To prevent leaking the memory of the `struct pwm_chip` (allocated by
>> `pwmchip_alloc`), this custom handler must also call the original
>> `pwmchip_release` function to complete the cleanup.
>>
>> Make `pwmchip_release` a global, exported function so that it can be
>> called from the Rust FFI bridge. This involves removing the `static`
>> keyword, adding a prototype to the public header, and exporting the
>> symbol.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> 
> I still somewhat dislike this patch. Isn't it possible to make the rust
> abstraction use the pointer that .release is set to when it calls
> pwmchip_alloc()?

Hi Uwe,

Sorry for the delay - I was on vacation and I hope you received my
out of office message.

I agree your suggestion is technically feasible. My concern was that it
would make the abstraction less readable and more complex, as it would
require the FFI wrapper to read the C function pointer and store it as
state within the driver's private data.

The current approach of calling a known, exported function felt more
direct. However, I absolutely agree with your point on C API purity and,
as you suggested, this can be revisited later if needed.

> 
> (I wouldn't further delay this series for this discussion, this can be
> handled just fine at a later point in time.)
> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

