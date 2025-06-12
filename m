Return-Path: <linux-pwm+bounces-6316-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868CFAD7236
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 15:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4C31C26170
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE14248867;
	Thu, 12 Jun 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e+p98fe2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41B224468B
	for <linux-pwm@vger.kernel.org>; Thu, 12 Jun 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734835; cv=none; b=WGkMYYLGz6wlSDsE6Xd7KIjvHop3s0yjT2gP3I0gRGJGmm2NjnpzkdUEUGoo8Iso2XuXTNfEUfT2MeqHVMrgD0J+fpt7Xte0jjLYFDHOe4qGIggIVhl+C7/rQ+EiAq3juhnnCkJC8bmoYH99hqpBHtfbx9qcWYCtk+x6w+PcBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734835; c=relaxed/simple;
	bh=4LHEwxEc3hBPrlnpoz7wEtk78FB0iBFJ2kl/SiFP2GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jZyc1v3J4YOGoqrHRAApsLVrHbiHhDDLtC+A7HF0lD+du2FYOWGuumCzqkOUBeGzGWaZSWur3FgHsH1ccIJEXIa+dFhlGQFj+mnnkiRjkbIcW93K8U6slnSCvULACoqUxDLKy0u+5YggFPCj8REDgB0e3DvB9gTgMc0klMkIYLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=e+p98fe2; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250612132711euoutp0120637a109bc24ca56f336998bbceda47~ITo8mDz_p2730127301euoutp01k
	for <linux-pwm@vger.kernel.org>; Thu, 12 Jun 2025 13:27:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250612132711euoutp0120637a109bc24ca56f336998bbceda47~ITo8mDz_p2730127301euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749734832;
	bh=PULRw5otkpn6GT9WVK7m+LoEccaSTbNn1hjyoEzOiIs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=e+p98fe2EtXbMFxwWvQgJluh1QObjr8g6tF2nHs1kG+Hcjb3bO5O924WF1GVlTPyk
	 YhWHkegBS5oA4jFG8qH0C5OBvo/7m/hgotMW9dT1Iay0p0xMz4OUgLKQmM2GGgWlW0
	 s/gQAlg+rNLhrihoWDunNEKjcRep3lrnbq6wGfAg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250612132711eucas1p1db84d1c02a89f07e7346dec9dc6c48e8~ITo75vBrM2197421974eucas1p1Q;
	Thu, 12 Jun 2025 13:27:11 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250612132709eusmtip2f714daf4dd428c2679068f9872962dc7~ITo6trRkm1234712347eusmtip23;
	Thu, 12 Jun 2025 13:27:09 +0000 (GMT)
Message-ID: <b3252042-e7fd-4ac9-a4ad-0226d21fd477@samsung.com>
Date: Thu, 12 Jun 2025 15:27:09 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Drew Fustini
	<drew@pdp7.com>
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
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <t26bhukukjzy7e4d2omtvjchxxzlnfyx54ku7xbytcnxkuk7xk@6tap2t3z2oaq>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250612132711eucas1p1db84d1c02a89f07e7346dec9dc6c48e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9
X-EPHeader: CA
X-CMS-RootMailID: 20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9
References: <CGME20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9@eucas1p2.samsung.com>
	<20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
	<aEifXZnLxKd2wa0w@x1> <6ca6016e-3b17-48a0-ad8d-bb05317aa100@samsung.com>
	<aEoWtviFl0vYATXe@x1>
	<t26bhukukjzy7e4d2omtvjchxxzlnfyx54ku7xbytcnxkuk7xk@6tap2t3z2oaq>



On 6/12/25 07:01, Uwe Kleine-König wrote:
> Hello Drew,
> 
> On Wed, Jun 11, 2025 at 04:52:22PM -0700, Drew Fustini wrote:
>> I also enabled the pwm fan driver. However, there is a probe failure:
>>
>> [    1.250921] pwm-fan pwm-fan: Failed to configure PWM: -524
>> [    1.256546] pwm-fan pwm-fan: probe with driver pwm-fan failed with error -524
> 
> 524 = ENOTSUPP, so it seems the request had duty_offset > 0. Does your
> fan use PWM_POLARITY_INVERTED? If so, try without that flag. If your fan
> really needs an inverted PWM this of course makes fan control buggy.
> With the next revision it should work fine (as a duty_offset > 0 should
> get rounded down to 0).

Since we're running the same DT, the polarity shouldn't be inverted. I
see you have CONFIG_PWM_DEBUG=y enabled, which is most likely the reason
the probe fails.

With that option, the following check is performed in __pwm_apply:

if (IS_ENABLED(CONFIG_PWM_DEBUG)) {
	struct pwm_waveform wf_rounded;

		err = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
		if (err)
			return err;

In this revision of the driver, I have not implemented the read-waveform
callbacks, so the Rust PWM abstractions correctly return -ENOTSUPP.

Uwe, this poses a problem, as reading from the duty and period registers
on the TH1520 SoC's PWM controller appears to be broken.


> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

