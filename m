Return-Path: <linux-pwm+bounces-6624-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C690AEF1E3
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 10:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9873B32EF
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 08:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2DB25BF0E;
	Tue,  1 Jul 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WypqO/7x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52724246784
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359949; cv=none; b=aVGSbQF/9Lo5MensNCCuzgA1rXwXH1wwjrtyEtb7dSB+gt+JuA28PFU8Bz6QNluF/IJABk7C1v/1U8n9UGFKyyZJpcTk4vA3ShYOcAl+e4Oohe8L6lYcq/aUHxtHBzmKNK90dqxP4aFD1Zf6s0Ko1cPwt4xc75bqHuam/lk1Txo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359949; c=relaxed/simple;
	bh=65oAe0qpLcRgjSC486bat76EyBiBDhhxgd5LMUbXjzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=XQkZBwWnOC5KkOhylZb9b6Y+BaYUcYLM/d0p8gRikCCnsXLBPHkeTUhfwQMGb8XcR2ejWMA8r0JBIb2OuXDDRBzvEc2FwJeWrPMuDpoAbsyxWQ9SyixdKpQJVRVPty9Rxz/lU1L2WocNNOzX64tvadqfxKDCQwfwx7kQ7ikdopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WypqO/7x; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250701085225euoutp02a28cdf8b25370f7d8164476a618e81aa~OFJdo9AEy2207522075euoutp02S
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 08:52:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250701085225euoutp02a28cdf8b25370f7d8164476a618e81aa~OFJdo9AEy2207522075euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751359945;
	bh=jiMSvhTO3EuRijPHPyzHEcK75GqOsBl3jGoGvHtO4dI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WypqO/7xv2nYZLsiGJH8BavQ4NJdGsvs1gBin449bTfoI3/D/riZ4tdaL1LmVCelv
	 MQRrGSri6TEYSs2Dw0U3Vt87LLLvD8t+tf97Csp7yNfa2beJS4IDoUSKwqaEh06DYa
	 prdQ5MEet3kM3WhtWTerMV5Q3nq0jehFZFa+cVb8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250701085224eucas1p2d74efed39332d4ddb82e9881a6f586a3~OFJdDOVz31375613756eucas1p2O;
	Tue,  1 Jul 2025 08:52:24 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250701085223eusmtip207386da0b4d9ddd9eea052e444116d0c~OFJb4_9xu1783617836eusmtip2a;
	Tue,  1 Jul 2025 08:52:23 +0000 (GMT)
Message-ID: <425fe73f-8cb2-4238-9e15-55403ed9daf6@samsung.com>
Date: Tue, 1 Jul 2025 10:52:23 +0200
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
In-Reply-To: <ayp32pdwvpko3zuatgt2jgtfxgcmrmc5aujkx6twjchmyazpz7@yeo3kxgxnpda>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250701085224eucas1p2d74efed39332d4ddb82e9881a6f586a3
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
	<ayp32pdwvpko3zuatgt2jgtfxgcmrmc5aujkx6twjchmyazpz7@yeo3kxgxnpda>



On 6/29/25 11:23, Uwe Kleine-König wrote:
> Hello Michal,
> 
> On Sat, Jun 28, 2025 at 04:38:15PM +0200, Michal Wilczynski wrote:
>> On 6/27/25 17:10, Uwe Kleine-König wrote:
>>> On Mon, Jun 23, 2025 at 08:08:49PM +0200, Michal Wilczynski wrote:
>>>> +/// From C: `#define WFHWSIZE 20`
>>>> +pub const WFHW_MAX_SIZE: usize = 20;
>>>
>>> Can we somehow enforce that this doesn't diverge if the C define is
>>> increased?
>>
>> You are absolutely right. The hardcoded value is a maintenance risk. The
>> #define is in core.c, so bindgen cannot see it.
>>
>> I can address this by submitting a patch to move the #define WFHWSIZE to
>> include/linux/pwm.h. This will make it part of the public API, allow
>> bindgen to generate a binding for it, and ensure the Rust code can never
>> diverge. Is this fine ?
> 
> I wonder if that is the opportunity to create a file
> include/linux/pwm-provider.h. In that file we could collect all the bits
> that are only relevant for drivers (pwm_ops, pwm_chip, pwmchip_parent,
> pwmchip_alloc ...). (Some inline functions depend on some of these, so
> some might have to stay in pwm.h)
> 
> I can address that in parallel, don't add this quest to your series. So
> yes, move WFHWSIZE to include/linux/pwm.h (and rename it to PWM_WFHWSIZE
> to not pollute the global namespace).
>  
>>> Please don't expose these non-atomic callbacks. pwm_disable() would be
>>> fine.
>>>
>>> Otherwise I'd prefer if pwm_set_waveform_might_sleep() is the API
>>> exposed to/by Rust.
>>
>>
>> OK, I'll remove all the setters from the State, while will keep the
>> getters, as they would be useful in apply callbacks.
> 
> How so? They might be useful for consumers, but my preferred idiom for
> them is that they know at each point in time what they want completely
> and don't make that dependant on the previou setting.

Oh, this is not just to check the previous state, let me bring my
implementation of apply from the v1 of the series:

impl pwm::PwmOps for Th1520PwmChipData {
    // This driver implements get_state
   fn apply(
        pwm_chip_ref: &mut pwm::Chip,
        pwm_dev: &mut pwm::Device,
        target_state: &pwm::State,
    ) -> Result {
        let data: &Th1520PwmChipData = pwm_chip_ref.get_drvdata().ok_or(EINVAL)?;
        let hwpwm = pwm_dev.hwpwm();

        if !target_state.enabled() {
            if pwm_dev.state().enabled() {
                data._disable(hwpwm)?;
            }

            return Ok(());
        }

        // Configure period, duty, and polarity.
        // This function also latches period/duty with CFG_UPDATE.
        // It returns the control value that was written with CFG_UPDATE set.
        let ctrl_val_after_config = data._config(
            hwpwm,
            target_state.duty_cycle(),
            target_state.period(),
            target_state.polarity(),
        )?;

        // Enable by setting START bit if it wasn't enabled before this apply call
        if !pwm_dev.state().enabled() {
            data._enable(hwpwm, ctrl_val_after_config)?;
        }

        Ok(())
    }
}

So the target state values are also accessed by those getters, not just
previous state.

> 
>> Will implement additional functions for Device i.e set_waveform,
>> round_waveform and get_waveform, and the new enum to expose the result
>> of the round_waveform more idiomatically.
>>
>> /// Describes the outcome of a `round_waveform` operation.
>> #[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> pub enum RoundingOutcome {
>>     /// The requested waveform was achievable exactly or by rounding values down.
>>     ExactOrRoundedDown,
>>
>>     /// The requested waveform could only be achieved by rounding up.
>>     RoundedUp,
>> }
> 
> Sounds good. Hoever I have some doubts about the C semantic here, too.
> Is it really helpful to provide that info? A user of that return value
> has to check anyhow which parameter got rounded up. If you have an
> opinion here, please share.

FWIW; In my opinion, it is helpful.

The 1 (rounded up) vs. 0 (rounded down/exact) return value provides a
simple summary flag for the most common validation case: ensuring a
strict requirement, like a minimum frequency, is not violated by
rounding.

>  
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

