Return-Path: <linux-pwm+bounces-6817-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52E4B00965
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 18:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD524A70FA
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755E92EFDA3;
	Thu, 10 Jul 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N+iQ/IgK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C68283CB1
	for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166727; cv=none; b=sTuFqTE+o0YMBF1eEoRJNVeCz+9Hq0YgywNbSR9vy4midH1hd8nPQxipFScdkXpx4QC16uZ/3kej648nG8UvNBP9FPufAPJydld69MtO/8yhTQUVFBTelQ2oYBaXKwdDOI2uZaKuOwy77RLGHlsrCSiCBwn1E+8RfoWzj8G8PJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166727; c=relaxed/simple;
	bh=MyftItMtY36JRBZeZdaONyuNfHOcQetVYlvXfauWP9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=KnF1+B7vhLFulVKpzsE513lkHm/UhbV/S9WgmAvv5LTKbNWK9B6QDw9PR/tO9+QEw6INMEAYcSQfqb5ycGpgxHTbubiVv6RcRhr6CGbswqxCLOixVRIQHZoff5BQIIB75XbyQe0VCgxnF3vl/W9xgJ4gWBqCXmsNJHcnkwetVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=N+iQ/IgK; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250710165843euoutp012f5b89122d7c7c12ca43fcc882288f84~Q8loeP1aX1979419794euoutp01A
	for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 16:58:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250710165843euoutp012f5b89122d7c7c12ca43fcc882288f84~Q8loeP1aX1979419794euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752166723;
	bh=ZgLkHoYpMZXGlyM12JkaB3eUvSr6n7CdDmsdbr4Effk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=N+iQ/IgKJDR12WkLkSHfzHnREv0EVSZqpC/v+RNieKTsC8JifH8dnuKu2sW+z6FjV
	 OwUEFYe1Ay6A/lvzDK1ycZJdVXnFfxGk9K2gSLNhFZYzkZXoBhI7thHgygQCg6n5Ki
	 GIc/Si12W4H0WBZcklPpbKg+MTIOitNRPdoVQKuc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250710165843eucas1p228bef8c7cfef0151b9f27161df285873~Q8ln10Tqr0901609016eucas1p2H;
	Thu, 10 Jul 2025 16:58:43 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250710165842eusmtip2966419c222cc783df17946c63fd3c343~Q8lmxbv6y2112221122eusmtip29;
	Thu, 10 Jul 2025 16:58:42 +0000 (GMT)
Message-ID: <ad17dc8a-80b7-4344-a1be-6cf780567aaa@samsung.com>
Date: Thu, 10 Jul 2025 18:58:41 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
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
	Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Krzysztof
	Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <4hmb3di5x2iei43nmrykrj5wzlltrf3vrnqvexiablonbscn57@4bbsz5c76t63>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250710165843eucas1p228bef8c7cfef0151b9f27161df285873
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



On 7/10/25 17:25, Uwe Kleine-König wrote:
> Hello Michal,
> 
> On Thu, Jul 10, 2025 at 03:48:08PM +0200, Michal Wilczynski wrote:
>> On 7/10/25 15:10, Uwe Kleine-König wrote:
>>> On Thu, Jul 10, 2025 at 10:42:07AM +0200, Michal Wilczynski wrote:
>>>> On 7/7/25 11:48, Michal Wilczynski wrote:
>>>>> The series is structured as follows:
>>>>>  - Expose static function pwmchip_release.
>>>
>>> Is this really necessary? I didn't try to understand the requirements
>>> yet, but I wonder about that. If you get the pwmchip from
>>> __pwmchip_add() the right thing to do to release it is to call
>>> pwmchip_remove(). Feels like a layer violation.
>>
>> It's required to prevent a memory leak in a specific, critical failure
>> scenario. The sequence of events is as follows:
>>
>>     pwm::Chip::new() succeeds, allocating both the C struct pwm_chip and
>>     the Rust drvdata.
>>
>>     pwm::Registration::register() (which calls pwmchip_add()) fails for
>>     some reason.
> 
> If you called pwmchip_alloc() but not yet pwmchip_add(), the right
> function to call for cleanup is pwmchip_put().
> 
>>     The ARef<Chip> returned by new() is dropped, its reference count
>>     goes to zero, and our custom release_callback is called.
>>
>> [...]
>>>>> ---
>>>>> base-commit: 47753b5a1696283930a78aae79b29371f96f5bca
>>>
>>> I have problems applying this series and don't have this base commit in
>>> my repo.
>>
>> Sorry for the confusion. Base commit doesn't exist in the mainline
>> kernel or linux-next, cause I've added some dependecies for compilation,
>> like IoMem for the driver (uploaded full branch on github [1]). The
>> bindings however doesn't depend on anything that's not in linux-next.
> 
> The series didn't apply to my pwm/for-next branch.
> 
> Note that the base-commit should always be a publically known commit.
> See the chapter about "Base Tree Information" in git-format-patch(1).

Hello Uwe,

Okay, thank you for the clarification. I understand the requirement for
a public base commit.

My intention was to include the TH1520 driver primarily as a practical
demonstration of the new abstractions. However the driver can't be
merged as is, since it depends on the unmerged IoMem series and won't
compile against a public commit.

I will rebase the series on pwm/for-next and drop the driver and its
associated device tree patches for now. I'll send a new version
containing just the core PWM abstraction patches, which apply cleanly.

I will resubmit the driver patches once their dependencies are available
in a public tree.

> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

