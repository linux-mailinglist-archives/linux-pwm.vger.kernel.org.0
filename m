Return-Path: <linux-pwm+bounces-6475-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C38AE3D0F
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 12:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693B9188A48D
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 10:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF623E359;
	Mon, 23 Jun 2025 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GzKVBdPw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668C423BD09;
	Mon, 23 Jun 2025 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675328; cv=none; b=e7cJ8Og5CceS8+uozXB0bgVVzG6ddAuYWZs5t8xfyMJyIxcjstsyDDk/Yc5dkPQZY4CWjI3bYwJWfcjosMrIAbELLF0KByZ7Is5vV0fGpvaPQ9Mjj9nj5ileepz79jiSOmDyJrGe2KcNnYPKDD5eexeo43qO2t5+dG3ktZU4GNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675328; c=relaxed/simple;
	bh=BpponAcg+z4hGFK/u5zBtOrapD2VBIN9qxipHbAfAZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=UA56g/+bLNLxt153mbXpSmWPZ6aU5bV4mriWfrdFKxu0Z+khDI3yLwzwmNSegnhxvOydskhDpsu6cPSKCE+iPqmystSCV+5SUaNwQqSR7TQjBHi87qv2PTFUrr+bZM6/S7XpU2wCBe37Ie7U2wLpjyvfbGwp5Of3CxAEdLEaAAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GzKVBdPw; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250623104204euoutp012401a2774c3ecc6088173c26bf10b1ec~Lpe6VQh3p2279622796euoutp012;
	Mon, 23 Jun 2025 10:42:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250623104204euoutp012401a2774c3ecc6088173c26bf10b1ec~Lpe6VQh3p2279622796euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750675324;
	bh=ZgC7RmHblf1sf7WhXqmx7u6LQrZhsQXE/footszyEW0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=GzKVBdPw94wRPygDILO19gR4YjbJe52ce42rJk/B3hzlaWlrRlfdwI8nsZzPkDiQR
	 oHaiH1lEGlhXsfloz3SwuT/GSfXbXvhOrUWgy+NKZPTMSNBdHMWEf8RvcPeRf9TVzb
	 iloMNZJkhXyEyTut7qAzHEx/iDzsnRv5iMjOI6wE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250623104203eucas1p1ad615a6dbbfc1e4a493d4eb81b68d666~Lpe52oEhj0250002500eucas1p1v;
	Mon, 23 Jun 2025 10:42:03 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250623104202eusmtip1432554c88ece7735183b4593540639d1~Lpe4jGdCu1485414854eusmtip1Q;
	Mon, 23 Jun 2025 10:42:02 +0000 (GMT)
Message-ID: <962be35f-65be-4589-a844-cb613ea40286@samsung.com>
Date: Mon, 23 Jun 2025 12:42:02 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Drew Fustini
	<fustini@kernel.org>
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
	Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CANiq72=YsoFSSm9QU0W2ZQseeQTWFNkXYVR1mODdv3HHg-0PAQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250623104203eucas1p1ad615a6dbbfc1e4a493d4eb81b68d666
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250618122801eucas1p2f9ca464e9e5c8d954d5150500952aeed
X-EPHeader: CA
X-CMS-RootMailID: 20250618122801eucas1p2f9ca464e9e5c8d954d5150500952aeed
References: <CGME20250618122801eucas1p2f9ca464e9e5c8d954d5150500952aeed@eucas1p2.samsung.com>
	<20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>
	<aFSw44++s7xMkJ9I@x1>
	<CANiq72=YsoFSSm9QU0W2ZQseeQTWFNkXYVR1mODdv3HHg-0PAQ@mail.gmail.com>



On 6/21/25 14:21, Miguel Ojeda wrote:
> On Fri, Jun 20, 2025 at 2:52 AM Drew Fustini <fustini@kernel.org> wrote:
>>
>> Did I do something wrong?
> 
> No -- the file just doesn't exist in the patches.

Yeah I did something wrong, I missed it during the commit split, and for
me compilation worked as I had many untracked files in the repository
and were compiling with pwm.c as one of them.

> 
> Cheers,
> Miguel
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

