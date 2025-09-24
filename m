Return-Path: <linux-pwm+bounces-7350-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21354B9BD15
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Sep 2025 22:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B6D38090F
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Sep 2025 20:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15F3322DC2;
	Wed, 24 Sep 2025 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GZJFO8Cm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCF270EA3
	for <linux-pwm@vger.kernel.org>; Wed, 24 Sep 2025 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758744663; cv=none; b=FWCDMBZ98DH/4DsfLWS1HVWV1mGw7nyAcsaJIsz+yCb5Dauzo+kL2b+W/8KGnBXYo4l1vEZxUSupYWg+19twLKQUt8MQu/BF16V33gQe86/+CVzqF2I54Sjw0/X8uUIzyQ6pc8LZqQy/6R3YtUiZDTsxyIAouyI0fciNj6S0R4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758744663; c=relaxed/simple;
	bh=qroifid5E0JwSNY9T4DkdPNSWtVvxDZkd0VXckpiAIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=A6aFXT6jGOAjjqVOsNWoBl367tIXOuSjiNIROeoCCAOJJSUpVdclxPA6D5hLblMw2eKSQYR77+iygxkGfQaqmGM9tW8dGWyTV+kbeqiOUGdZHNUEas6b0TTpY6jJz0TQqJds+mwqsZy6QTy2dzdY9cOb9vl6pOI+Xb7HMaTSArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GZJFO8Cm; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250924201059euoutp01fd74d3ab902086d72b7c6428a44b323b~oUPMrzLRz1591615916euoutp01Y
	for <linux-pwm@vger.kernel.org>; Wed, 24 Sep 2025 20:10:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250924201059euoutp01fd74d3ab902086d72b7c6428a44b323b~oUPMrzLRz1591615916euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758744659;
	bh=yBKtwjJbPQtED8z7fycvzGQLEUnEMfBKiPR2MumIREw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=GZJFO8CmRhsefzb4ZNLdzaYTF6Q/ntMXChwbvLFW41SUpZKQrVaJ2QmhBsuDG4DhM
	 RkZoK2LxmmmoyNNH4TqD8+luA4tXD1CqHfJDf3s0RNtj8s4o2otF4PnLYWOq8Kmz5B
	 4Mg/IE/l5VtD4mMQNfJDT6kYj7gaqLqjOZoeVKvU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250924201058eucas1p2d73ba09b4daf4e1779f658dfb3d99722~oUPLmwszc0365803658eucas1p2d;
	Wed, 24 Sep 2025 20:10:58 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250924201057eusmtip1dcd4c37a079be0694d2881ebcaa5a599~oUPKi7Zsq1997819978eusmtip10;
	Wed, 24 Sep 2025 20:10:57 +0000 (GMT)
Message-ID: <0bbdb7d1-5d07-4997-955e-497134a4aa30@samsung.com>
Date: Wed, 24 Sep 2025 22:10:57 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/7] rust: pwm: Add Kconfig and basic data
 structures
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
In-Reply-To: <upgthwp3cyohhe2gkzsramzshmvz3icjbhro6hgk2drbbqczi4@ygaanetydgjv>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250924201058eucas1p2d73ba09b4daf4e1779f658dfb3d99722
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250820083542eucas1p221dacb3b69524b0dd6f7abf870adbe04
X-EPHeader: CA
X-CMS-RootMailID: 20250820083542eucas1p221dacb3b69524b0dd6f7abf870adbe04
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
	<CGME20250820083542eucas1p221dacb3b69524b0dd6f7abf870adbe04@eucas1p2.samsung.com>
	<20250820-rust-next-pwm-working-fan-for-sending-v14-2-df2191621429@samsung.com>
	<upgthwp3cyohhe2gkzsramzshmvz3icjbhro6hgk2drbbqczi4@ygaanetydgjv>



On 9/15/25 12:13, Uwe Kleine-König wrote:
> Hello Michal,
> 
> On Wed, Aug 20, 2025 at 10:35:37AM +0200, Michal Wilczynski wrote:
>> Introduce the foundational support for PWM abstractions in Rust.
>>
>> This commit adds the `RUST_PWM_ABSTRACTIONS` Kconfig option to enable
>> the feature, along with the necessary build-system support and C
>> helpers.
>>
>> It also introduces the first set of safe wrappers for the PWM
>> subsystem, covering the basic data carrying C structs and enums:
>> - `Polarity`: A safe wrapper for `enum pwm_polarity`.
>> - `Waveform`: A wrapper for `struct pwm_waveform`.
>> - `Args`: A wrapper for `struct pwm_args`.
>> - `State`: A wrapper for `struct pwm_state`.
> 
> Args, State and Polarity are only needed for the consumer side of the
> PWM API in Rust, right?
> 
> I don't particularily like like pwm_args and wonder if this really has
> to be exposed to Rust.

You're right that Args is primarily for the consumer side, and our
provider driver doesn't use it at all. I only included it for
completeness, so I'm happy to remove it from the abstractions.

I did use State on the provider side, however, to check if a channel is
enabled before writing new hardware values - I've seen your comment
about it that it's better to use the HW registers instead, I remember I
tried doing something like this back in May when started working on
this, but haven't succeeded - will refresh my memory and respond to the
driver comments.

> 
> I think for State (and thus Polarity) we have to have it for the
> forseeable future.
> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

