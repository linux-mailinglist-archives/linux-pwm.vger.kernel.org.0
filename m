Return-Path: <linux-pwm+bounces-7455-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE942BE0004
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Oct 2025 20:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86F354EEF39
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Oct 2025 18:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADD4301719;
	Wed, 15 Oct 2025 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VPO5zguY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE33016EE
	for <linux-pwm@vger.kernel.org>; Wed, 15 Oct 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551631; cv=none; b=RDUwVvaiUnH4QdVyEFtiWuuY7c72PWKZHuP8dEiAY5WzcZzMP7D5DBFZ345RB5FAxjCKAaiVYpI7A8w262lAgoD8LsnY4OzbMjsA19aJfjYjNiTaYHpeF+U5GIb8criRjqNWzZ4S4uY4kWNzcbz8uzKk1mPIRoViJSFwIsry7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551631; c=relaxed/simple;
	bh=pB57hIiFPwCLApeodBVwZjuaklMNrPippJeaU883e0k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=lWpItUnVC9q35BTa195eqGEDqAr+gpwtBAJtzXmPBHpxKqOrkhzYE9SXNYJX9f1BP0nOILY7Q/VOLDDGjtw7XAhR52Xg3CKhvnKe1nRLHIVwZTCDxjNtSXdoXq0T2KkjX+x6nt9w2fyx4/GVWnnF9qkPbhzdB/DPwbTKBsLqSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VPO5zguY; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251015180707euoutp02d71058133eadba6de7fca7167ea86564~uvGCRCOyj1473914739euoutp02Z
	for <linux-pwm@vger.kernel.org>; Wed, 15 Oct 2025 18:07:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251015180707euoutp02d71058133eadba6de7fca7167ea86564~uvGCRCOyj1473914739euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760551627;
	bh=1unSNZI8VVG1hZT1k2vqCzNyKxvx74sReaYy4ZaeWcg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VPO5zguYIuPc3B21jKCzpb0qhISKYcuWR+BTY97+2WnhUCqsJUWtDKzyeMMsrWZjG
	 bmokn3srqhoHGqfKNvDbBSfI22W+K0pwXmH3SZ5rgGppmvZWTE3uTQgmKujT9pA8/k
	 +3DI6mQ+7L4Dr7MQQeowNoSnv4GyKEAVLXkpTb0M=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251015180706eucas1p2a2d2e1bcde06b30e15194fe089f1b980~uvGBhsboA1744017440eucas1p2B;
	Wed, 15 Oct 2025 18:07:06 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251015180705eusmtip1e1fd7a667aef662fa645684ccf6bfd3a~uvGAWHpMN0945709457eusmtip1P;
	Wed, 15 Oct 2025 18:07:05 +0000 (GMT)
Message-ID: <0da1d4cc-1984-4813-9265-7f10aa1542f2@samsung.com>
Date: Wed, 15 Oct 2025 20:07:04 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
From: Michal Wilczynski <m.wilczynski@samsung.com>
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
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Elle Rhumsaa
	<elle@weathered-steel.dev>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Content-Language: en-US
In-Reply-To: <99a41538-ce1a-4130-a093-d0c600e63d16@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251015180706eucas1p2a2d2e1bcde06b30e15194fe089f1b980
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250930122729eucas1p2c4f1c07a4a504a59ba691b407a39420d
X-EPHeader: CA
X-CMS-RootMailID: 20250930122729eucas1p2c4f1c07a4a504a59ba691b407a39420d
References: <CGME20250930122729eucas1p2c4f1c07a4a504a59ba691b407a39420d@eucas1p2.samsung.com>
	<20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
	<ayuqnx7fjfe3zwicvdbdr3qsgb4w6s2gwjt7r3m5ikzrylmium@hsrxazwelnvp>
	<99a41538-ce1a-4130-a093-d0c600e63d16@samsung.com>



On 10/15/25 19:52, Michal Wilczynski wrote:
> 
> 
> On 10/13/25 18:48, Uwe Kleine-König wrote:
>>
>> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
>> index c9fd1d8d17bc..a5666052b7ce 100644
>> --- a/drivers/pwm/pwm_th1520.rs
>> +++ b/drivers/pwm/pwm_th1520.rs
>> @@ -121,6 +121,7 @@ fn round_waveform_tohw(
>>          wf: &pwm::Waveform,
>>      ) -> Result<pwm::RoundedWaveform<Self::WfHw>> {
>>          let data = chip.drvdata();
>> +        let status = 0;
>>  
>>          if wf.period_length_ns == 0 {
>>              dev_dbg!(chip.device(), "Requested period is 0, disabling PWM.\n");
>> @@ -141,18 +142,13 @@ fn round_waveform_tohw(
>>          if period_cycles == 0 {
>>              dev_dbg!(
>>                  chip.device(),
>> -                "Requested period {} ns is too small for clock rate {} Hz, disabling PWM.\n",
>> +                "Requested period {} ns is too small for clock rate {} Hz, rounding up.\n",
>>                  wf.period_length_ns,
>>                  rate_hz
>>              );
>>  
>> -            return Ok(pwm::RoundedWaveform {
>> -                status: 0,
>> -                hardware_waveform: Th1520WfHw {
>> -                    enabled: false,
>> -                    ..Default::default()
>> -                },
>> -            });
>> +            period_cycles = 1;
>> +            status = 1;

Well status and period_cycles need to be mutable obviously, will change
that.


Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

