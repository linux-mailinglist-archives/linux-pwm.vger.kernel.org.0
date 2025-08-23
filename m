Return-Path: <linux-pwm+bounces-7149-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519CCB32829
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Aug 2025 12:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0628DA2130B
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Aug 2025 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E615123D7E1;
	Sat, 23 Aug 2025 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mk8o5ICr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37723909C
	for <linux-pwm@vger.kernel.org>; Sat, 23 Aug 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755944253; cv=none; b=Dvv7nQMi4mkmHvIj7WacvFcU4cS+eTr+jF4Ii4Kg+XoDJ/6rKQaaQrKndiE830u3DhVjuRX5k0NsWi4Ay/SFucUMQNRVW+7ByDcstNJJ0D7tn6gfq0/vEK5HH7Hb+IhmPYY885zWwyl3UjUjOASsAIecFnbcUFBr+b5Qf3mc7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755944253; c=relaxed/simple;
	bh=Tufb8gie+ZaoxUaiJZfFIXrT2KJOAwu322i87nMr4xw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=XGWl8oHhACIuKq/FVbyhJukWmbHKLmWWmI12SDebRym1Z3PoMMNX+ZfQICl8IB2/EIyMUF8m5Hcp+bYq5GxOjLLU74ReCuj5KixdINDrDz7OrVa8FSr+BWfsRTrIPYptBOA3H3dGH8o7ZnghIQzf5W88IhXH532WVQic6waqrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mk8o5ICr; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250823101730euoutp02c50e8339421001713da7216e89f5b806~eXf4OBAX-1775917759euoutp02j
	for <linux-pwm@vger.kernel.org>; Sat, 23 Aug 2025 10:17:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250823101730euoutp02c50e8339421001713da7216e89f5b806~eXf4OBAX-1775917759euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755944250;
	bh=D4wK6GdZ/4jViHNG+K4863aSZhyyAegTqee1+ujAQvs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mk8o5ICr2N9ZxC9HGU6/6YWKdkW5UkmQr0qiC+Rl79raEHOfYQ7n46l5Dw+hP6UkQ
	 9lvYAhqlHcqGzM9HRlQ6ehBppVoPixb+ymKBMhyTaVNizw9ji1d407LfGJdySDR5gu
	 Hbd6E/tPzuXo8DlRCd1ZIcDyNY8ZhQlLucqBg7gE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250823101729eucas1p2fecd1d04cdc29bd6cbb24bc73d07dbd2~eXf3F_K2b2217822178eucas1p2b;
	Sat, 23 Aug 2025 10:17:29 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250823101728eusmtip1059e9beb9dcc8db475e73c7644924bcb~eXf18dMid1939419394eusmtip1K;
	Sat, 23 Aug 2025 10:17:27 +0000 (GMT)
Message-ID: <8f63a814-1310-4edd-9394-38f71e017edb@samsung.com>
Date: Sat, 23 Aug 2025 12:17:27 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 7/7] riscv: dts: thead: Add PWM fan and thermal
 control
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: Drew Fustini <fustini@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
	Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, Benno
	Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Daniel Almeida <daniel.almeida@collabora.com>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Language: en-US
In-Reply-To: <3aa6f79e-2ebf-4aff-a23c-7e79929a85f9@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250823101729eucas1p2fecd1d04cdc29bd6cbb24bc73d07dbd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250820083548eucas1p2a40775d53dfd9f8608671cc20003fd7d
X-EPHeader: CA
X-CMS-RootMailID: 20250820083548eucas1p2a40775d53dfd9f8608671cc20003fd7d
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
	<CGME20250820083548eucas1p2a40775d53dfd9f8608671cc20003fd7d@eucas1p2.samsung.com>
	<20250820-rust-next-pwm-working-fan-for-sending-v14-7-df2191621429@samsung.com>
	<aKjXzyyYd9QneIKf@x1> <3aa6f79e-2ebf-4aff-a23c-7e79929a85f9@samsung.com>



On 8/23/25 12:13, Michal Wilczynski wrote:
> 
> 
> On 8/22/25 22:49, Drew Fustini wrote:
>> On Wed, Aug 20, 2025 at 10:35:42AM +0200, Michal Wilczynski wrote:
>>> Add Device Tree nodes to enable a PWM controlled fan and it's associated
>>> thermal management for the Lichee Pi 4A board.
>>>
>>> This enables temperature-controlled active cooling for the Lichee Pi 4A
>>> board based on SoC temperature.
>>>
>>> Reviewed-by: Drew Fustini <fustini@kernel.org>
>>> Tested-by: Drew Fustini <fustini@kernel.org>
>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>> ---
>>>  arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 67 +++++++++++++++++++++++
>>>  1 file changed, 67 insertions(+)
>>
>> Do you think it makes sense to coordinate this with the "Initial thermal
>> management for Lichee Pi 4A board" series [1] from Icenowy?
> 
> Hi,
> It seems to me like using the HW PWM is just a better solution for
> driving the fans. However as pointed in the discussion currently Rust
> requires LLVM, so people compiling with gcc will not be able to compile
> the driver for some time until the gcc support becomes better.
> 
> I think there is a way to express in Device Tree the fallback logic -

Sorry I meant 'there is NO way to express this in Device tree'

> if Rust not available then use SW PWM. So I guess the pragmatic way to
> go is to merge SW PWM temporary fix first, and later when gcc becomes
> better at compiling Rust patch it up to use HW PWM instead.
> 
>>
>> Thanks,
>> Drew
>>
>> [1] https://lore.kernel.org/linux-riscv/20250816093209.2600355-1-uwu@icenowy.me/
>>
> 
> Best regards,

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

