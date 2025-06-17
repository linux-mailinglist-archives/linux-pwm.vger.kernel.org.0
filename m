Return-Path: <linux-pwm+bounces-6400-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D54ADCA17
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 13:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A4A176D32
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150D2E06C8;
	Tue, 17 Jun 2025 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hk3/aRhf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED992D9EEA
	for <linux-pwm@vger.kernel.org>; Tue, 17 Jun 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161367; cv=none; b=PmR9rBN/JY7DelNSO7UikcANpVKGKmlIJwb7OhHKT3kKtN5gXRLzxyzHqK8EgUZ8+de/h7p8ontPbPEAh7DkZmWlThc9qZ5lHPEeWQQ76aF+CdCVmM3MWDWuI0V43zBGeIgAEqMIYtzKn20Zko3UJGNx9J+LqcrNeBtAOJ42kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161367; c=relaxed/simple;
	bh=spf/OGWq9rNYwhtnFTQUzUHQXPQ8m2LBqxJ8x0nCh68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ljQUajdlfmlVCNQuvj2lyjfBSWJaxC9ejmdN+Xkon/Tx9mNnqfRqpWyiJiq5BMICLd3rCLXX2vOAJSlKO3Qp3Dsvo5L5HK14KqvsJec7QH//ww4V+rSnoiQmwnwb3fIbpc5A71puDfLWKvvNhOku6a0LdcyBc1iNjH96pybB0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hk3/aRhf; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250617115558euoutp028560e91720b0250aca9550503b12d483~J0nuFBLMm0966909669euoutp02K
	for <linux-pwm@vger.kernel.org>; Tue, 17 Jun 2025 11:55:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250617115558euoutp028560e91720b0250aca9550503b12d483~J0nuFBLMm0966909669euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750161358;
	bh=oofikVxRsBxHxPSDdlnvLJyVhdL+RF7rzHi6wUMuvQs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hk3/aRhfplI0MimyM+0Ny2W5f3hpPbZ//3yhhymz2n67YIKDfT3D3KCZ2wiRiOJ7x
	 iR2hztlhHdIbLNoFSk5f7oeOHipEVMXkbWJ04oYrtS/1qML0eCIb9xeIW1IVjbbN22
	 ENbXparJC5pyBqD0Dfc75BwwVviBUUsgvb8Bcm1s=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250617115557eucas1p1fe0dc838ed601d75fe7deba27d312aa7~J0ntgrNum2233822338eucas1p1l;
	Tue, 17 Jun 2025 11:55:57 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250617115556eusmtip1a9ce151263637f622a84b2312a20b25d~J0nsOwoz40555305553eusmtip1i;
	Tue, 17 Jun 2025 11:55:56 +0000 (GMT)
Message-ID: <b1c7c305-fad9-4161-b627-b5c1db9cb0ee@samsung.com>
Date: Tue, 17 Jun 2025 13:55:55 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
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
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <5aam5ff3m24yzsqdh7w2zplccuwmmr2no7jhgmdnxggmhpo4hl@r6iawlw7f42m>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250617115557eucas1p1fe0dc838ed601d75fe7deba27d312aa7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d
X-EPHeader: CA
X-CMS-RootMailID: 20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d
References: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
	<CGME20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d@eucas1p1.samsung.com>
	<20250610-rust-next-pwm-working-fan-for-sending-v2-2-753e2955f110@samsung.com>
	<jbm3qvowi5vskhnjyqlp3xek36gzzqjt35m66eayxi6lmi525t@iefevopxjl53>
	<d1523586-82ca-4863-964f-331718bb1f0e@samsung.com>
	<5aam5ff3m24yzsqdh7w2zplccuwmmr2no7jhgmdnxggmhpo4hl@r6iawlw7f42m>



On 6/12/25 22:36, Uwe Kleine-König wrote:
> Hello Michael,
> 
> On Thu, Jun 12, 2025 at 10:14:13AM +0200, Michal Wilczynski wrote:
>> On 6/11/25 08:58, Uwe Kleine-König wrote:
>>> Huh, if you do the newstyle stuff, .get_state() is wrong. It's either
>>> .round_waveform_tohw() + .round_waveform_fromhw() + .read_waveform() +
>>> .write_waveform() or .apply() + .get_state(), but don't mix these.
>>
>> In the process of implementing the full "newstyle" waveform API as you
>> suggested, I discovered a hardware limitation. After writing new values
>> to the period and duty cycle registers, reading them back does not
>> return the programmed values, which makes it impossible to reliably
>> report the current hardware state.
>>
>> This appears to be a known quirk of the hardware, as the reference C
>> driver from T-HEAD [1] also omits the .get_state callback, likely for
>> the same reason.
> 
> Do you read complete non-sense or e.g. the old configuration until
> the current period ends?
> 
> I guess would be that .get_state wasn't implemented because this is an
> oldoldstyle driver and it works also without that function.

Hi Uwe,

My apologies for the confusion. After further testing, it appears I was
mistaken, and the hardware reads are working correctly. I must have made
an error when testing via sysfs.

I'll be submitting a v3 that implements the full round_waveform_tohw(),
round_waveform_fromhw(), read_waveform(), and write_waveform()
combination as you initially suggested.

> 
>> Given this, would it be acceptable to provide a write-only driver? My
>> proposed solution would be to omit the .read_waveform() and
>> .round_waveform_fromhw() implementations from my PwmOps trait. This
> 
> Please don't skip .round_waveform_fromhw(), that one is needed for
> pwm_round_waveform_might_sleep().
> 
> I don't like it, but given that the hardware doesn't play along there is
> no alternative.
> 
>> would mean the driver can correctly set the PWM state, but attempting to
>> read it back via sysfs would fail (e.g., with -EOPNOTSUPP), reflecting
>> the hardware's capability.
> 
> I think there might be another patch opportunity then to make PWM_DEBUG
> work with that.
> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

