Return-Path: <linux-pwm+bounces-6308-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E11DAD60E8
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 23:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E473AAEC6
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 21:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC2C23717C;
	Wed, 11 Jun 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bp0W74Lh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267C1C8632
	for <linux-pwm@vger.kernel.org>; Wed, 11 Jun 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676566; cv=none; b=lNuW+omUi5zk9AeMhfqjeBysLqtNzV0iDxpmC4TE7pC9yxSbhBsEMk6jkdvfv8Ap9RQwjkk/i+7qCfxOgQW4S9tFbgAB/GGJ3yntPPdylvZPZoLPF74uD/gZ9wljYtiFrYOIB8g1bWXWYhabwXeMxp86B5bZ+nPSjPi7AZ3YOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676566; c=relaxed/simple;
	bh=34l1hncorS8+nkL26ZB/15dqnRBpVywFqIADeqMlHMU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=vCkhu6IRsmREofBUyalXdZqXwwY8NT1FJPlYVNPuIkwwOb9jwd+sa6usMWETWbOhd0nL3sJcA/ni/xVejGF5BFW40iWZ/EztB/69KbfJdXIwDWvZhdEXba6Tn4DHRdTLIEd290I8E3M1yJvyBzsR6cPj5ZagIWscd/XWN+N1P+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bp0W74Lh; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250611211602euoutp0101d07aff68bbcb944377c6a12b2de560~IGZBAcmeS0046800468euoutp01d
	for <linux-pwm@vger.kernel.org>; Wed, 11 Jun 2025 21:16:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250611211602euoutp0101d07aff68bbcb944377c6a12b2de560~IGZBAcmeS0046800468euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749676562;
	bh=gJSx6fFWCab1L0dG4hF/wx4spo5Eingwx2AqpslewPk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bp0W74LhifQr+oDb85bFPnIvLOvQj11U4xNBK2Ctc3WQbNvMXWHlyVld+paX8aOnx
	 jHUXOFqS4Gqc31gj9khxT2dS4yO5XFKlDvzNkeeaiVcPU7iuznz807UwDsOtlRhIGI
	 wMx6yzURpEnZd1OPa2nu1tm7/icJkWPXwRhDOr4M=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250611211600eucas1p13784b73e9c0257e670846320bca0a2f9~IGY-b_FYG1491714917eucas1p1X;
	Wed, 11 Jun 2025 21:16:00 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250611211558eusmtip17a546ce3e5256d611175ed66f1a5dc7a~IGY8xpr_31879718797eusmtip1c;
	Wed, 11 Jun 2025 21:15:57 +0000 (GMT)
Message-ID: <02e480b9-68eb-47e7-97f5-54e49d259f84@samsung.com>
Date: Wed, 11 Jun 2025 23:15:57 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
From: Michal Wilczynski <m.wilczynski@samsung.com>
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
	Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Content-Language: en-US
In-Reply-To: <1d9bba9e-0f30-4039-812e-60b160271e6b@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250611211600eucas1p13784b73e9c0257e670846320bca0a2f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d
X-EPHeader: CA
X-CMS-RootMailID: 20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d
References: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
	<CGME20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d@eucas1p1.samsung.com>
	<20250610-rust-next-pwm-working-fan-for-sending-v2-2-753e2955f110@samsung.com>
	<jbm3qvowi5vskhnjyqlp3xek36gzzqjt35m66eayxi6lmi525t@iefevopxjl53>
	<1d9bba9e-0f30-4039-812e-60b160271e6b@samsung.com>



On 6/11/25 22:04, Michal Wilczynski wrote:
> 
> 
> On 6/11/25 08:58, Uwe Kleine-König wrote:
>> Hello,
>>
>>
>> What does .unwrap_or(0) do? You need to round up in this mul_div
>> operation.

Yeah and I'm thinking that the helper needs to be updated or new one
added like mul_div_round_up, to do the rounding

> 
> The .unwrap_or(0) is to handle the case where the mul_div helper returns
> None, which can happen if the divisor (rate_hz) is zero. In that case,
> the period  becomes 0. The mul_div helper is introduced in this commit
> [1].
> 
> [1] - https://lore.kernel.org/all/20250609-math-rust-v1-v1-1-285fac00031f@samsung.com/
> 


Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

