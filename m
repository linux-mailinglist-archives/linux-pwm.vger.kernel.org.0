Return-Path: <linux-pwm+bounces-6841-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267DAB02048
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 17:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4C73ACF86
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 15:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7752E4252;
	Fri, 11 Jul 2025 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X7shbcxo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110C274658
	for <linux-pwm@vger.kernel.org>; Fri, 11 Jul 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247167; cv=none; b=fks8z4LqcwsuprWiq623oj/lWKfD/x/qldyFfmGmXr2qN8yLMoW/ocHuh3coL7c0y84Us279CRSNcB9Zt4PV3Ha1+t+zZ+JfexYpTa5yKL8LB67HS29ShbmiK6x/t1dhLXrk1mmsbMKdWWCVhRjOfua6oRvDGdBCi8LryqLhDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247167; c=relaxed/simple;
	bh=6eTk+Rez1Dx2t25BtPQK5sIIRmyaEOyXGPPSgCgLmA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=gvnvmo3s0l9ynxnan6iaIkHdahYHb8rnLFU8ofD6KqLh3f4JBZt7kG/lgD7p43rLOURPSCLXzK4MpLaLYGrMqBPlwXxP92K3EqRelOX2M1NvsEDl77+s6+aaLU2nJ1CpO7ZrrzBppkmKgdE9vFu7BnMMMF+7GukAx5A7Vb6kjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X7shbcxo; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250711151922euoutp021915a1dbd9a12f603a0cc6a0170bb07e~RO4LFOL_z2996929969euoutp02J
	for <linux-pwm@vger.kernel.org>; Fri, 11 Jul 2025 15:19:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250711151922euoutp021915a1dbd9a12f603a0cc6a0170bb07e~RO4LFOL_z2996929969euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752247162;
	bh=fcewOa5OLVmZ08COtX/6ELxglwPgWvCAwEjTgpYJRbc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=X7shbcxoHz4/uuqF31DM3XkNqucBXTZUladGlprSDimOpHNXkHJJ3JjmjhCu+/fFb
	 wmMNyvRmvQNaPuS9ZhG1VC2An5K1xFx+I+4LV6xE6UvvQ8pWIFb8F+z2W+2Sh4Icz9
	 lVSSRl43P5tpHNLREEzpRtG1cSMv7z/r1YS4Hah8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250711151922eucas1p14c32b8004eb7275d4af8efe31dd9c678~RO4Kgc8GB1992419924eucas1p1J;
	Fri, 11 Jul 2025 15:19:22 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250711151921eusmtip1884570ece80ba5dfe41229c79334008b~RO4JY_dRl2903329033eusmtip1f;
	Fri, 11 Jul 2025 15:19:21 +0000 (GMT)
Message-ID: <8acb5b54-c01b-4427-9ada-596897b96a10@samsung.com>
Date: Fri, 11 Jul 2025 17:19:20 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
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
	Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Krzysztof
	Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <i5ee2u45kmcb2su743th744ofnmk4lkfq44iqvfwdjwscv3bz7@pjakppae22na>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250711151922eucas1p14c32b8004eb7275d4af8efe31dd9c678
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6
X-EPHeader: CA
X-CMS-RootMailID: 20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com>
	<20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
	<e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com>
	<ipvaegqlkco5qinhvn33mqvg7ev2walvs74xtzvhimxsfsfzhv@gcmpxcdtetdn>
	<e77eab1c-446f-4620-95be-d343684d1e95@samsung.com>
	<4hmb3di5x2iei43nmrykrj5wzlltrf3vrnqvexiablonbscn57@4bbsz5c76t63>
	<ad17dc8a-80b7-4344-a1be-6cf780567aaa@samsung.com>
	<i5ee2u45kmcb2su743th744ofnmk4lkfq44iqvfwdjwscv3bz7@pjakppae22na>



On 7/10/25 22:39, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Jul 10, 2025 at 06:58:41PM +0200, Michal Wilczynski wrote:
>> On 7/10/25 17:25, Uwe Kleine-König wrote:
>>> On Thu, Jul 10, 2025 at 03:48:08PM +0200, Michal Wilczynski wrote:
>>>> On 7/10/25 15:10, Uwe Kleine-König wrote:
>>>>> On Thu, Jul 10, 2025 at 10:42:07AM +0200, Michal Wilczynski wrote:
>>>>>> On 7/7/25 11:48, Michal Wilczynski wrote:
>>>>>>> The series is structured as follows:
>>>>>>>  - Expose static function pwmchip_release.
>>>>>
>>>>> Is this really necessary? I didn't try to understand the requirements
>>>>> yet, but I wonder about that. If you get the pwmchip from
>>>>> __pwmchip_add() the right thing to do to release it is to call
>>>>> pwmchip_remove(). Feels like a layer violation.
>>>>
>>>> It's required to prevent a memory leak in a specific, critical failure
>>>> scenario. The sequence of events is as follows:
>>>>
>>>>     pwm::Chip::new() succeeds, allocating both the C struct pwm_chip and
>>>>     the Rust drvdata.
>>>>
>>>>     pwm::Registration::register() (which calls pwmchip_add()) fails for
>>>>     some reason.
>>>
>>> If you called pwmchip_alloc() but not yet pwmchip_add(), the right
>>> function to call for cleanup is pwmchip_put().
>>>
>>>>     The ARef<Chip> returned by new() is dropped, its reference count
>>>>     goes to zero, and our custom release_callback is called.
>>>>
>>>> [...]
>>>>>>> ---
>>>>>>> base-commit: 47753b5a1696283930a78aae79b29371f96f5bca
>>>>>
>>>>> I have problems applying this series and don't have this base commit in
>>>>> my repo.
>>>>
>>>> Sorry for the confusion. Base commit doesn't exist in the mainline
>>>> kernel or linux-next, cause I've added some dependecies for compilation,
>>>> like IoMem for the driver (uploaded full branch on github [1]). The
>>>> bindings however doesn't depend on anything that's not in linux-next.
>>>
>>> The series didn't apply to my pwm/for-next branch.
>>>
>>> Note that the base-commit should always be a publically known commit.
>>> See the chapter about "Base Tree Information" in git-format-patch(1).
>>
>> Hello Uwe,
>>
>> Okay, thank you for the clarification. I understand the requirement for
>> a public base commit.
>>
>> My intention was to include the TH1520 driver primarily as a practical
>> demonstration of the new abstractions. However the driver can't be
>> merged as is, since it depends on the unmerged IoMem series and won't
>> compile against a public commit.
>>
>> I will rebase the series on pwm/for-next and drop the driver and its
>> associated device tree patches for now. I'll send a new version
>> containing just the core PWM abstraction patches, which apply cleanly.
>>
>> I will resubmit the driver patches once their dependencies are available
>> in a public tree.
> 
> If you base your tree on (say) v6.16-rc1, then add some Rust
> dependencies up to 47753b5a1696283930a78aae79b29371f96f5bca and then add
> your series, you just do:
> 
> 	git format-patch --base v6.16-rc1 47753b5a1696283930a78aae79b29371f96f5bca..
> 
> . This results in a base-commit line that I (and maybe also build bots)
> can use and a bunch of further lines listing the commits between
> v6.16-rc1 and 47753b5a1696283930a78aae79b29371f96f5bca that might be
> findable on lore.k.o.

Hi Uwe,

Thank you very much for the detailed advice on using git format-patch
--base. I appreciate you taking the time to explain the workflow.

I investigated this approach, and the difficulty is that the IoMem
series [1], which my driver depends on, is itself based on an
integration tree rather than a clean public tag.

This means that to create a series based on v6.16-rc1, I would have to
include a very large number of intermediate commits from linux-next,
which, would not be helpful for review.

Therefore, I believe that dropping the driver and its device tree
patches for now is the best path forward. This will result in a much
smaller, self contained series for the core PWM abstractions that
applies cleanly to your pwm/for-next branch.


[1] - https://lore.kernel.org/rust-for-linux/20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com/
> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

