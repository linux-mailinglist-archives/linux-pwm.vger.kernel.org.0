Return-Path: <linux-pwm+bounces-6827-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF7B0179C
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 11:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F42A16901E
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DCC279DAB;
	Fri, 11 Jul 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lofho167"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71427A444
	for <linux-pwm@vger.kernel.org>; Fri, 11 Jul 2025 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225930; cv=none; b=kS7aGvtm/+1lHJCBkiG0IwP3UvBf0D7FcWnUdt9sTeICpIartUrxKgRD29IY3KedhNjrltuJGjJCpMIq1RyZfCEwBjd3t7jear0iAwIB0+HetCHz57YIrn7Cra3rTPrNR+Je7GLthUF4AsnqlEADKl5kdSxnMDc4wT6iDpcBEPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225930; c=relaxed/simple;
	bh=9LHxuTI8hpxcflNdLOKFQbbQPPlJdw91dYnBuAXCxn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Vb2own1L341qwYPHsle2mag7txKGePeB4LmDNI9zq+xXXQdpzbQBM0UlYXbjKi0/9n253VISbZEzv3n9O+YePn+V/XpNYHm1CfHW68UzNbC8CN49olc4Pd6zlSIFbtwOovgiHBXjfaT4yCkej0FgE4IlXKoYKHkaqJNBBQ2whj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lofho167; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250711092520euoutp01d396f18d3ca33e5ea3e4e33a933223c1~RKDDulz5g1729517295euoutp01b
	for <linux-pwm@vger.kernel.org>; Fri, 11 Jul 2025 09:25:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250711092520euoutp01d396f18d3ca33e5ea3e4e33a933223c1~RKDDulz5g1729517295euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752225920;
	bh=HzPkVcD7EBpLB077YuBkrkHkCg7R8v/lMTm610TXX5M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lofho167lt5+OYJKtBe7YUJJ6Lp8NKwqQQRQ7gDsuC9W+lVy6exTq5fHdfWYhe22o
	 vEyaZAuzdXF8zK35Ok8wiQ6GXPvEe3pOz7xS/3yD6eQjEVnIw9Y9fMfMKUsSta1ehf
	 RtER64Nyp3VUGFlwOF8ft24Iy/Ad9RidLep8Ptjg=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250711092520eucas1p2c27be54c048556b3ce54242ab3d228e4~RKDDMne5X0267102671eucas1p2P;
	Fri, 11 Jul 2025 09:25:20 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250711092518eusmtip1c7e57196a1c1e0613b9ecfbad261718a~RKDCD2bkB3095630956eusmtip1K;
	Fri, 11 Jul 2025 09:25:18 +0000 (GMT)
Message-ID: <e6d85387-b46e-4e4f-90a3-f60a800f1c2e@samsung.com>
Date: Fri, 11 Jul 2025 11:25:18 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] pwm: Export `pwmchip_release` for external use
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
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
In-Reply-To: <tepvopkizn4jezpqcbhwrcsnsrjacztv6kuv53hidcjbrnrs3c@pfcp45jarcoy>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250711092520eucas1p2c27be54c048556b3ce54242ab3d228e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250710185439eucas1p2684255d83d807dfd6f8b9b3caea65df6
X-EPHeader: CA
X-CMS-RootMailID: 20250710185439eucas1p2684255d83d807dfd6f8b9b3caea65df6
References: <20250710-rust-next-pwm-working-fan-for-sending-v11-0-93824a16f9ec@samsung.com>
	<CGME20250710185439eucas1p2684255d83d807dfd6f8b9b3caea65df6@eucas1p2.samsung.com>
	<20250710-rust-next-pwm-working-fan-for-sending-v11-1-93824a16f9ec@samsung.com>
	<tepvopkizn4jezpqcbhwrcsnsrjacztv6kuv53hidcjbrnrs3c@pfcp45jarcoy>



On 7/10/25 22:52, Uwe Kleine-König wrote:
> Hello Michal,
> 
> On Thu, Jul 10, 2025 at 08:54:28PM +0200, Michal Wilczynski wrote:
>> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
>> index 8cafc483db53addf95591d1ac74287532c0fa0ee..8f0698c09e62b893d63fc258da3c34781183056f 100644
>> --- a/include/linux/pwm.h
>> +++ b/include/linux/pwm.h
>> @@ -478,6 +478,7 @@ static inline bool pwm_might_sleep(struct pwm_device *pwm)
>>  
>>  /* PWM provider APIs */
>>  void pwmchip_put(struct pwm_chip *chip);
>> +void pwmchip_release(struct device *dev);
> 
> I want this in a separate section because "normal" provider don't need
> that. Please add a comment that this is only public for technical
> reasons for the Rust wrappers.

OK, thanks !

> 
> I understand you are eager to get this merged, but still I'd ask you to
> slow down your patch sending frequency. Currently I tend to not apply it
> for v6.17-rc1 as I'd like to have that in next for some time.

Thank you for the feedback. All of your points make perfect sense.

My apologies for the rapid pace of submissions; I will follow your
suggestion and be sure to allow more time for discussion between future
versions.

> 
> With you waiting a bit longer before v11 I would have written that in
> reply to the explanation in the v10 thread and we might have saved
> one iteration ...
> 
>>  struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv);
>>  struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv);
>>  
>> @@ -551,6 +552,10 @@ static inline void pwmchip_put(struct pwm_chip *chip)
>>  {
>>  }
>>  
>> +static inline void pwmchip_release(struct device *dev)
>> +{
>> +}
>> +
> 
> Is this needed? There is no user of this function that doesn't depend
> on CONFIG_PWM?!

Since only Rust is using this it's not needed. Thanks !

> 
>>  static inline struct pwm_chip *pwmchip_alloc(struct device *parent,
>>  					     unsigned int npwm,
>>  					     size_t sizeof_priv)
>>
> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

