Return-Path: <linux-pwm+bounces-7953-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F574D3BA45
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 22:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD51F302781E
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 21:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1192F745E;
	Mon, 19 Jan 2026 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rEXc5uaA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF627A10F
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768859317; cv=none; b=mtE4trd5aO29OuuDT+wAFrChd6GrzSLySwaxG9d2knNviA+1fdatkpYrzrVUKEoJOqfwcKgchN3jNsvdr8r43yiH51QCF3TPryMSl8De3amWvnZ+TcoPQkd1nWFAxSWtJr1GuikBXjRFyCjE+lIn/dquor+Au5R+w8/2epabEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768859317; c=relaxed/simple;
	bh=klbSmY0qsQPALpgJ60l5L8WyXnj16r+ej0MQ5Dv+QYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=E1b0yVQ7GKtQErHvgj3OcqHChLu+/qq0gL8ZhGR+0kyOKX89cx8Dh0bjVjSB/8vXu2ymMA3nUWBqS0qAhZF/pjS1ewEUarWt/Yjq1iwKCFjrf38VN6O2bBNjYX/Y2VJvIV+4ONpDyxHmC1WYo5ECVWjzZuHJO8ZFQv0gM0GPsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rEXc5uaA; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260119214833euoutp01caa34c4cceb9afd8de2d9704e735b492~MQCxhu7HE0782507825euoutp01O
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 21:48:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260119214833euoutp01caa34c4cceb9afd8de2d9704e735b492~MQCxhu7HE0782507825euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768859313;
	bh=cCm71GD0cs8rUf+b/+Yue313FKPYNV9mxHzm/pCITyE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rEXc5uaAZUh3C4E0l7XA5sknffFZQjzYlguMbXAt4FInYJTkNIsMIf60gIZ6IBAOI
	 zh63b2PoDfQx2/vpg8EGR2AHwCoGY9pE+U5QtDabBQRyrcbyqMLo5QOXenS2MC0lOT
	 NQ0lVGrnoa68zCzgy4AQYCibXu68ADOWVLnVBGdk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260119214832eucas1p167fdf88f95104f679bcddca93e2042e5~MQCw7jTSn1492514925eucas1p1m;
	Mon, 19 Jan 2026 21:48:32 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260119214831eusmtip14c7fc135b79501a10d3681c98444622b~MQCwEMDUo1429314293eusmtip1f;
	Mon, 19 Jan 2026 21:48:31 +0000 (GMT)
Message-ID: <2cdba52f-9bec-4550-912f-d61c58e2852a@samsung.com>
Date: Mon, 19 Jan 2026 22:48:30 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Tamir
	Duberstein <tamird@gmail.com>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>, linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <2wmijhs5pbrynsgxuropvlxuozsubk7euybxzwc5ox2a3izfci@v6hzmzs5pmml>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260119214832eucas1p167fdf88f95104f679bcddca93e2042e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260119165319eucas1p23ae598d689d6a25d631f7c74368156d7
X-EPHeader: CA
X-CMS-RootMailID: 20260119165319eucas1p23ae598d689d6a25d631f7c74368156d7
References: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>
	<CAJ-ks9mrpcLaeiGjBcXNqTUwo00Y2MhhHWnWauou6exU1y920Q@mail.gmail.com>
	<CGME20260119165319eucas1p23ae598d689d6a25d631f7c74368156d7@eucas1p2.samsung.com>
	<2wmijhs5pbrynsgxuropvlxuozsubk7euybxzwc5ox2a3izfci@v6hzmzs5pmml>



On 1/19/26 17:53, Uwe Kleine-König wrote:
> Hello,
> 
> On Sat, Jan 03, 2026 at 09:30:31PM -0500, Tamir Duberstein wrote:
>> On Mon, Dec 22, 2025 at 7:24 AM Tamir Duberstein <tamird@kernel.org> wrote:
>>>
>>> From: Tamir Duberstein <tamird@gmail.com>
>>>
>>> C-String literals were added in Rust 1.77. Replace instances of
>>> `kernel::c_str!` with C-String literals where possible.
>>>
>>> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>>> ---
>>>  drivers/pwm/pwm_th1520.rs | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
>>> index e3b7e77356fc..8ae8f852ec02 100644
>>> --- a/drivers/pwm/pwm_th1520.rs
>>> +++ b/drivers/pwm/pwm_th1520.rs
>>> @@ -22,7 +22,6 @@
>>>
>>>  use core::ops::Deref;
>>>  use kernel::{
>>> -    c_str,
>>>      clk::Clk,
>>>      device::{Bound, Core, Device},
>>>      devres,
>>> @@ -327,7 +326,7 @@ fn drop(self: Pin<&mut Self>) {
>>>      OF_TABLE,
>>>      MODULE_OF_TABLE,
>>>      <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
>>> -    [(of::DeviceId::new(c_str!("thead,th1520-pwm")), ())]
>>> +    [(of::DeviceId::new(c"thead,th1520-pwm"), ())]
>>>  );
>>>
>>>  impl platform::Driver for Th1520PwmPlatformDriver {
>>>
>>> ---
>>> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
>>> change-id: 20251222-cstr-pwm-c9b9a4701157
>>>
>>> Best regards,
>>> --
>>> Tamir Duberstein <tamird@gmail.com>
>>>
>>
>> @Uwe could you please have a look?
> 
> I did, but given I'm more or less rust illiterate I would welcome
> feedback by Michal Wilczynski. I only now notice that he wasn't on Cc:
> up to now.
> 
> Best regards
> Uwe

I think the patch is correct. Thanks !

Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>


