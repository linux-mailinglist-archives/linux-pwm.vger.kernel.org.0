Return-Path: <linux-pwm+bounces-6620-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9414AEF0FF
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 10:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF85189D4B5
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 08:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD6926AAA7;
	Tue,  1 Jul 2025 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PwQsOHJX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D126A0B3
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358306; cv=none; b=txOnk4rPXNeOk1KnRzjHfo0jLMOB3N20YPXiPdhAAmQ/+/gPXM03XZ4a1tPskY/NHvrQWqeXd3im140YVFTHaf3A/OF2LKLkK7wElFHMhP0VffrwdnWu5gJWao5Q2UmWA9FrXyhc4MUei/xm2XIC+QoB1/mRiya2B18o/pwg72U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358306; c=relaxed/simple;
	bh=4NBRo7asrbE4jcsC4N5i3/e2ZCZPMxakKBYsVImNKI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sKeFIJN0uVlJ5mKJRKv02MX/RUMOBljvwNY0i+vCIKYGnbToqRgnV6tuzRR2zLiQsNzVfTJZYVLggpHb/e4E2/QF5wuwkm7k8MdWSUkABrTnIXr2gretiPi6fi8DUq5/V6CG5bvNFjT/7nDkhBgTpbUcvpasGpmiJMAa35YzWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PwQsOHJX; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250701082456euoutp01572eb4af51b7b7e2f01f0e9664af3e6c~OExd67eoc0069900699euoutp01k
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 08:24:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250701082456euoutp01572eb4af51b7b7e2f01f0e9664af3e6c~OExd67eoc0069900699euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751358296;
	bh=KfdpUFAVhAyxGqE9eLEIBkkqrEYX2W0imprAxbQivkU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=PwQsOHJXGkU9mixvHQse3EYengfFoqHmA30yZ29Nwz9nTmg5Vjvv3Mjnkdj2yQTO+
	 HA7ti9PjBheHdgVw6q3trtWTW6m0QWrOBK8uQ0cUBq4yTUAK1j2qGYkWFUG+eAtdKk
	 Zd1cwp+uPNs5SfmyqgTwNswNIlSbQiMFzoMmeoPY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250701082456eucas1p27ac527ab6df65b4ad24af9f1936ee772~OExdUXUK-0564305643eucas1p2z;
	Tue,  1 Jul 2025 08:24:56 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250701082454eusmtip179c87208d9c76abee9ff0a1bd9cb19a6~OExcL0hDa2415924159eusmtip1p;
	Tue,  1 Jul 2025 08:24:54 +0000 (GMT)
Message-ID: <ca58f110-7f9a-427d-b018-e514cf34adaf@samsung.com>
Date: Tue, 1 Jul 2025 10:24:54 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] rust: pwm: Add Kconfig and basic data structures
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
In-Reply-To: <n5zfbzu3hn7kqdf3xc7orpeovvdprc2xlf7w3f62uoohkxdk5c@cc24urt5xf36>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250701082456eucas1p27ac527ab6df65b4ad24af9f1936ee772
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250623180858eucas1p1815f6d6815b1c715baad94810cefacd5
X-EPHeader: CA
X-CMS-RootMailID: 20250623180858eucas1p1815f6d6815b1c715baad94810cefacd5
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
	<CGME20250623180858eucas1p1815f6d6815b1c715baad94810cefacd5@eucas1p1.samsung.com>
	<20250623-rust-next-pwm-working-fan-for-sending-v5-1-0ca23747c23e@samsung.com>
	<q7sz7uci5vnyc24laqzs56vgt4i2jamb3ifyxkqom6qcml5kkv@642prvwxjkxc>
	<c127e368-8c1f-4299-b222-a105940ac34e@samsung.com>
	<1450a457-4bd3-4e9c-a74f-3be15c9ec84f@samsung.com>
	<n5zfbzu3hn7kqdf3xc7orpeovvdprc2xlf7w3f62uoohkxdk5c@cc24urt5xf36>



On 6/29/25 12:29, Uwe Kleine-König wrote:
> On Sat, Jun 28, 2025 at 09:47:19PM +0200, Michal Wilczynski wrote:

>>>>> +    /// Sets the polarity of the PWM signal.
>>>>> +    pub fn set_polarity(&mut self, polarity: Polarity) {
>>>>> +        self.0.polarity = polarity.into();
>>>>> +    }
>>>>
>>>> Please don't expose these non-atomic callbacks. pwm_disable() would be
>>>> fine.
>>
>> Hmm, I've just realized that without those setters it would most likely
>> impossible to correctly implement the get_state callback.
> 
> You shouldn't implement the get_state callback for a waveform driver.

You're right that a new driver using the waveform API shouldn't
implement .get_state.

My goal for the abstraction layer, however, is to be flexible enough to
support writing both modern waveform drivers and legacy style drivers
that use the .apply and .get_state callbacks.

To implement the .get_state callback, a driver needs the ability to
construct a State struct and populate its fields from hardware values
before returning it to the PWM core. Without this ability there is no
way to implement get_state callback.

I think the cleaner way, without the setters would be to update the
`new` like so:
    pub fn new(
        period: u64,
        duty_cycle: u64,
        polarity: Polarity,
        enabled: bool,
        usage_power: bool,
    ) -> Self {
        let raw_c_state = bindings::pwm_state {
            period,
            duty_cycle,
            polarity: polarity.into(),
            enabled,
            usage_power,
        };

        State(raw_c_state)
    }

This way the get_state callback would be responsible for creating new
state and initializing it, instead of passing the mutable State to
get_state.


> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

