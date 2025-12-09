Return-Path: <linux-pwm+bounces-7789-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF2ECB0188
	for <lists+linux-pwm@lfdr.de>; Tue, 09 Dec 2025 14:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9D9331B5870
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Dec 2025 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90030330B19;
	Tue,  9 Dec 2025 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DISYFaX9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35A330B1E
	for <linux-pwm@vger.kernel.org>; Tue,  9 Dec 2025 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287694; cv=none; b=me3cjNSCin3yA8P+vdqi/k747qASj3DQWqW1YG6A2JkgNBaZoppIoaxFMrpQd8BIjBK9fhWv6B7QPR37sFqPADDNkcKcsQMcD+C2LqMKw39dW/nHqgBc5ydBKzl1md0KYVUF8Ogg07TjA4xr/POZ2eiXvzSaE4/vSNLDUBSbWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287694; c=relaxed/simple;
	bh=kJk1Mdu9xXvv+bQyE7E7F9faw/Qf9P3GDjSaY0xFvWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hVzhsC3pKAqWS7IfpTuMsZ83Xa3jui0lsYCebzjmlMGKHddmYYa1zx+WpfvQfMW3KJ4FM5ZIPvFNZZD+uA4oh7iAoDJyJe/beef3VEeoAtp0y5Qp74RjUh6fdy5kV5iP3AjEpbfYKRHeCJO+SWXaXe+yOoirH4+xH5Zma/vxQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DISYFaX9; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251209134130euoutp01fb75cf05462f5d52ce9280cd70ea8189~-j81CtKWY2343223432euoutp01W
	for <linux-pwm@vger.kernel.org>; Tue,  9 Dec 2025 13:41:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251209134130euoutp01fb75cf05462f5d52ce9280cd70ea8189~-j81CtKWY2343223432euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1765287690;
	bh=NYkdWnmHGgFN43Uqa8YF07pn4VK88DvECmSTgJyvBxI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=DISYFaX9BUFOZD0EdnhHagJD2E5+Q0kTeKjknFwSLXxzvUE8tmvQlHZadeUUFPmPB
	 k3ni9HrjUkaFzMZLMkGSyXzE2qYCeltzaSbOY8UrSb7STY8webP0tYyB876OQmudaB
	 xVWY66h5qVejbV+pMAY+y4i+rd0PzIbsyQ6FySzY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251209134130eucas1p22a063fe18c5fdccb8e586892570f3895~-j80gIjuJ1957519575eucas1p2P;
	Tue,  9 Dec 2025 13:41:30 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251209134129eusmtip129f83220e2503bac3a89ad1f43f2971a~-j8zxf-hZ0170401704eusmtip1C;
	Tue,  9 Dec 2025 13:41:29 +0000 (GMT)
Message-ID: <5a742181-dff6-4073-ada0-342298da63b6@samsung.com>
Date: Tue, 9 Dec 2025 14:41:29 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: pwm: Add UnregisteredChip wrapper around Chip
To: Markus Probst <markus.probst@posteo.de>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Drew Fustini
	<fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun
	Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <a66b337528d700ae92d7940a04c59206e06a8495.camel@posteo.de>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251209134130eucas1p22a063fe18c5fdccb8e586892570f3895
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251202181800eucas1p18be878cb74d14444f2df8bdcd7a718ee
X-EPHeader: CA
X-CMS-RootMailID: 20251202181800eucas1p18be878cb74d14444f2df8bdcd7a718ee
References: <CGME20251202181800eucas1p18be878cb74d14444f2df8bdcd7a718ee@eucas1p1.samsung.com>
	<20251202-pwm_safe_register-v2-1-7a2e0d1e287f@posteo.de>
	<a3f4e795-e56d-4de0-8b46-5c8ff96d5f77@samsung.com>
	<zdwto7ahccckl2r3qoculu52lsus3dey2lcur2l3ltrxp5nrcf@djusgl5cdfu3>
	<a66b337528d700ae92d7940a04c59206e06a8495.camel@posteo.de>



On 12/9/25 13:26, Markus Probst wrote:
> On Tue, 2025-12-09 at 09:08 +0100, Uwe Kleine-König wrote:
>> On Sun, Dec 07, 2025 at 11:16:59PM +0100, Michal Wilczynski wrote:
>>> On 12/2/25 19:17, Markus Probst wrote:
>> What does "not able to successfully compile drivers/pwm/pwm_th1520.rs"
>> mean? You were unable to find a .config that included CONFIG_PWM_TH1520,
>> or you got a compiler error? If it's the latter, ...
>>
>>> I suspect your kernel configuration is missing CONFIG_COMMON_CLK.
>>
>> ... are we missing a dependency for the driver?
> I got a compiler error. Enabling CONFIG_COMMON_CLK indeed fixes it.
> 
> Without it:
>   CLIPPY     drivers/pwm/pwm_th1520.o
> error[E0432]: unresolved import `kernel::clk::Clk`
>   --> drivers/pwm/pwm_th1520.rs:26:5
>    |
> 26 |     clk::Clk,
>    |     ^^^^^^^^ no `Clk` in `clk`
> 
> error: aborting due to 1 previous error
> 
> For more information about this error, try `rustc --explain E0432`.
> make[4]: *** [scripts/Makefile.build:354: drivers/pwm/pwm_th1520.o]
> Error 1
> make[3]: *** [scripts/Makefile.build:556: drivers/pwm] Error 2
> make[2]: *** [scripts/Makefile.build:556: drivers] Error 2
> make[1]: *** [/home/markustieger/build/synology/linux-
> upstream/Makefile:2010: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> A simple fix would be to add "depends on COMMON_CLK" in
> drivers/pwm/Kconfig for PWM_TH1520.
	
While at it I think we should also add dependency on ARCH_THEAD |
COMPILE_TEST as well as HAS_IOMEM in my opinion. I think some of those
dependencies were lost when we were iterating on the patchset for some
reason, can't recall when exactly.

If you plan to send a patch include those as well. Otherwise let me know
and I send a patch.

> 
> Thanks
> - Markus Probst
Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

