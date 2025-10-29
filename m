Return-Path: <linux-pwm+bounces-7533-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC7C1CD36
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 19:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04E2D4E020E
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F8A35771E;
	Wed, 29 Oct 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YFumTbjG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA213563DF
	for <linux-pwm@vger.kernel.org>; Wed, 29 Oct 2025 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763921; cv=none; b=XcgjVGneUfYoss8BDPaZ7nRzckShthvsPSnVExhTpQhgn9NX/UH9kPG1jiaaQQW42zpSL8b/+zk6d+8VbaGO09a3ipbXY0LxM8RkRwoHtqjCcQRohfpPTH3w4DFvn+9kPSRv2jzb0FHW0/slT7tmd8G3r6zNM/nnQJtX75O50W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763921; c=relaxed/simple;
	bh=6i5LK+KHZzajbekQNpRqxZg1AvqmhETrZZtaa2laC10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jItOk+gkxlld8CUdG2mr7KapqMpGgcEEvVt+d0oS/FVovhmthYYQWG1EnZNLknXMXYM8Ha4iLVEg5uyVnZKP+8hxR9RKPDE+9FNUcGb+Y+1o23iy6ybl0sX/idyGkrPYb8sRLzeiRJh4wQ61lX00hJpuvZ25tu98d3mRWgaeh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YFumTbjG; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251029185152euoutp012359f719c00dec7f8a5bfb0603c51457~zCvGkOaMy0897708977euoutp018
	for <linux-pwm@vger.kernel.org>; Wed, 29 Oct 2025 18:51:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251029185152euoutp012359f719c00dec7f8a5bfb0603c51457~zCvGkOaMy0897708977euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761763912;
	bh=bQNGVhOQyRYDAT6f5LbiqaQukE8P3fTErRwmbu+uxa0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=YFumTbjG41C6tu1h2AUDSfornvKlbUCc8GAUJqm8oid7casxs71+RYNRvPHlNqyv6
	 1mtSDA459GHvBRsbZsN5QcKz+KUPGDzvN2lPaObSEeQLGe0E5p404Gsb9mFBbZopkR
	 Hf8AvMOgG6UVxHkmQu/Fh4s4oeHx3Avqn4wgy+C0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251029185151eucas1p1d0537f2fc24d4dbc400c773168f20bb8~zCvFn56t52969429694eucas1p1m;
	Wed, 29 Oct 2025 18:51:51 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251029185150eusmtip13980126f40913ce41b484d6f44f45dde~zCvE0SljI2995129951eusmtip1b;
	Wed, 29 Oct 2025 18:51:50 +0000 (GMT)
Message-ID: <1287f917-dc25-4c80-8b09-3d0a7bc8eb6b@samsung.com>
Date: Wed, 29 Oct 2025 19:51:50 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Introduce import_ns support for Rust
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Stephen Rothwell
	<sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CANiq72n8QvygNsdHjaMgYrXiErT82BkWm1XMkc3eUZB1Xy_uAQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251029185151eucas1p1d0537f2fc24d4dbc400c773168f20bb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5
X-EPHeader: CA
X-CMS-RootMailID: 20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5
References: <CGME20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5@eucas1p1.samsung.com>
	<20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
	<2dedlnknikkrwg5f6ocuvjrogdjuqyg4sg6zkkao4w4yyvvsje@dkt7rco3fen3>
	<CANiq72n8QvygNsdHjaMgYrXiErT82BkWm1XMkc3eUZB1Xy_uAQ@mail.gmail.com>



On 10/29/25 19:18, Miguel Ojeda wrote:
> On Wed, Oct 29, 2025 at 11:04 AM Uwe Kleine-König <ukleinek@kernel.org> wrote:
>>
>> If you could mention the command that makes this warning visible, I'd be
>> glad to add that to my repertoire of build checks.
> 
> Yeah, please do!
> 
> I do my best to keep even linux-next and stable kernels Clippy clean
> as much as possible, so it would be nice to have that Clippy fix added
> to -next soon.
> 
> I have other steps that maintainers/contributors should run here:
> 
>     https://protect2.fireeye.com/v1/url?k=0d35e0d3-6dd77d8e-0d346b9c-000babd9f1ba-e5d27bbbccd997ca&q=1&e=d4a64c99-aab6-4741-9747-63f10e63aed4&u=https%3A%2F%2Frust-for-linux.com%2Fcontributing%23submit-checklist-addendum
> 
> Essentially / most importantly: `rustfmt`, `rustdoc` and `CLIPPY=1`.

Oh yeah I think I remembered to run 'rustfmt' couple months ago, but
over time when sending revisions forgot about that, sorry. I guess it
would be great to extend 'b4 prep --check' for those checks as well.

> 
> I am sending a couple fixes for those.
> 
> Thanks!
> 
> Cheers,
> Miguel
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

