Return-Path: <linux-pwm+bounces-6148-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31266AC4ED9
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 14:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6EA17E15A
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6711853;
	Tue, 27 May 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LoaE5J21"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135326D4C0
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748349903; cv=none; b=C+rHjzlkMjydFyceigHioWu8hc2g8Nzyb0z01VPHcisHQSBifV1KpMERAT9/4hV/5jT31jvnIK6mzh80+p+UJxKL/1k8mHrI7yzsHdBleBm5xIBINOBQwnOO2/Mf6Joctd21Q0yC8HC+Q/qvO4zc5h871DeLOXeDVmUyGpLxnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748349903; c=relaxed/simple;
	bh=TEoSJj5pG0vAhGRt8hK9p/l05yeh2Xc+ll+l5NCgMYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=F8Itq2n1uxvMHWuX18RJqOJOcvJuRFFjKyDPjI+UT2SNKusJyn13KUBEcmck//hySk/2T7C5PxqvJy7bNMqodmYKgCY3yaTTOf3iFr17guXADRU5ZxG5gnEUVv+br+jT6ESEezpPCt+5jbb8pLMrLbB60rEMXFfUID4bQjzbdQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LoaE5J21; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250527124459euoutp01b7a9360693b624d5c2e33a839fae2988~DYvh72Npj0912209122euoutp011
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 12:44:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250527124459euoutp01b7a9360693b624d5c2e33a839fae2988~DYvh72Npj0912209122euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748349899;
	bh=6MggDmUhFkhh0YiQ7gVTaOXRvovvaDJZMhoGzqh3YHw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LoaE5J21GKq0EsZodbMoZpJbZvU0a5uNptGWSRSgSekRchtrp2tIQ2LPkMcb9v3oF
	 Pg+9Mszs4+XXEMBDXqEQwhypatxb3S7Kq8zQCZUIETx6Xg00huVKuyaBE73vDhBl7d
	 hyfcKZOFoVLct4kcKiLIaiuT5nGdYZXao/PWF6+U=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250527124458eucas1p25fc02c83cc0febc8bfccb24116a38937~DYvhIbmaK2867528675eucas1p26;
	Tue, 27 May 2025 12:44:58 +0000 (GMT)
Received: from [106.210.136.40] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250527124457eusmtip1e773e74c7b1946257de1f317c434a396~DYvgQd7GN1338813388eusmtip1I;
	Tue, 27 May 2025 12:44:57 +0000 (GMT)
Message-ID: <db8e34c9-daff-43d9-b79b-8ec1bc98a00f@samsung.com>
Date: Tue, 27 May 2025 14:44:57 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/6] pwm: Add Rust driver for T-HEAD TH1520 SoC
To: Danilo Krummrich <dakr@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
	Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Drew Fustini
	<drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob
	Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
	Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Language: pl
From: "Michal Wilczynski/Kernel (PLT) /SRPOL/Engineer/Samsung Electronics"
	<m.wilczynski@samsung.com>
In-Reply-To: <aDMHEcpJn8nyJHFV@pollux.localdomain>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250527124458eucas1p25fc02c83cc0febc8bfccb24116a38937
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0
X-EPHeader: CA
X-CMS-RootMailID: 20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
	<CGME20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0@eucas1p1.samsung.com>
	<20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com>
	<aDMHEcpJn8nyJHFV@pollux.localdomain>


W dniu 25.05.2025 o 14:03, Danilo Krummrich pisze:
> On Sat, May 24, 2025 at 11:14:56PM +0200, Michal Wilczynski wrote:
>> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..4665e293e8d0bdc1a62a4e295cdaf4d47b3dd134
>> --- /dev/null
>> +++ b/drivers/pwm/pwm_th1520.rs
>> @@ -0,0 +1,272 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
>> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
>> +
>> +//! Rust T-HEAD TH1520 PWM driver
>> +use kernel::{c_st
>> +
>> +struct Th1520PwmChipData {
>> +    clk: Clk,
>> +    iomem: kernel::devres::Devres<IoMem<0>>,
> Why IoMem<0>? If you put the expected memory region size for this chip instead
> all your subsequent accesses can be iomem.write() / iomem.read() rather than the
> fallible try_{read,write}() variants.
The size of the memory region is not known at the compile time. Instead 
it's configured
via Device Tree. I'm not sure why it should work differently in Rust ?
>
>> +impl Th1520PwmChipData {
>> +    fn _config(
>> +        &self,
>> +        hwpwm: u32,
>> +        duty_ns: u64,
>> +        period_ns: u64,
>> +        target_polarity: pwm::Polarity,
>> +    ) -> Result<u32> {
>> +        let regs = self.iomem.try_access().ok_or_else(|| {
>> +            pr_err!("PWM-{}: Failed to access I/O memory in _config\n", hwpwm);
> Here and throughout the whole driver, please use the dev_*!() print macros.
> Drivers have no reason to use the pr_*!() macros.
>
>> +impl pwm::PwmOps for Th1520PwmChipData {
>> +    // This driver implements get_state
>> +    fn apply(
>> +        pwm_chip_ref: &mut pwm::Chip,
>> +        pwm_dev: &mut pwm::Device,
>> +        target_state: &pwm::State,
>> +    ) -> Result {
> I assume those callbacks can't race with pwmchip_remove() called from driver
> remove()? I.e. the callbacks are guaranteed to complete before pwmchip_remove()
> completes?

Yeah this is my understanding as well - this is something that the PWM 
core should
guarantee. Fairly recently there was a commit adding even more locking
1cc2e1faafb3 ("pwm: Add more locking")

>
> If so, this function signature can provide the parent device of the pwm::Chip as
> device::Device<device::Bound> reference.
>
> This would allow you to access iomem more efficiently.
>
> Instead of
>
> 	data.iomem.try_access()
>
> you could do
>
> 	data.iomem.access(parent) // [1]
>
> which does get you rid of the atomic check and the RCU read side critical
> section implied by try_access().
>
> Actually, I should have added this comment and explanation to the abstraction
> patch, but forgot about it. :)

Thanks ! Appreciate your review !
Michał

>
> [1] https://gitlab.freedesktop.org/drm/kernel/-/blob/drm-next/rust/kernel/devres.rs?ref_type=heads#L213
>

