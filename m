Return-Path: <linux-pwm+bounces-7527-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90A5C19ED8
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 12:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D843A4ABC
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602483128BD;
	Wed, 29 Oct 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YpDVt42i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2532DF12C
	for <linux-pwm@vger.kernel.org>; Wed, 29 Oct 2025 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736068; cv=none; b=tsfqKBhVfNBbnR723ZAyVhjQccn1w3gcRQUI2c9r8qpt7KUtRdSXiSoCpFaB2xPKSbsvy8kWzXwvfnEUBif7UEgoR80gOnFxCOrsfGQfjd9+4M3y7RQn23ij52KIWnaK4Tu/P8Nyw3GoGcq+DDQlt6NNpdteQ8OZux39f0CxsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736068; c=relaxed/simple;
	bh=ahR3HRSJo8qKD60jg5w+z9uYVqi4L0q68depQWcBYVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=P4Fb+STd0AGXAfV5d1qcAXbT0ZQr2CQ1BLXXHWz4rOuGNOdo7qR1yg63XvqgTdy55JTvzGK3BWVbv3j0v+0o4JsHiXLhAK5zhpyXnOlNym0iOpdxfp3m2s8bA5ajpLtCTuIs8wCz2vVs0rFkk+CDRkVvsCwmZ/DVTpz9PRVDY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YpDVt42i; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251029110744euoutp022776528b44c8fcb6220b5d6a05b72747~y8Z3iMs9p0900309003euoutp02N
	for <linux-pwm@vger.kernel.org>; Wed, 29 Oct 2025 11:07:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251029110744euoutp022776528b44c8fcb6220b5d6a05b72747~y8Z3iMs9p0900309003euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761736064;
	bh=lPkyz42wIiMyZmus3DHo3oNI5NGGYmhnJqmDuHgt9uk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=YpDVt42i6ENE90ifkPIK8ff7mUWGpAs48GVM277YEUpoZdL0YMzvdGQlg7soPU+ee
	 I3u7UjbsCTWJYGcObN4COCMicvvRC/pdHqUUE66u6Y85gah/knLAPkzS9ghrGTF3m3
	 +5DAIIXEouCH3JTqnFtJzw5Xi3WcKuGw1kKf3lIs=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251029110744eucas1p2f95c4c628e2ff2b2366972eda79aa4c0~y8Z3GEnOl2119121191eucas1p2v;
	Wed, 29 Oct 2025 11:07:44 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251029110743eusmtip2db58b6b7ea6eca6ca55bb0d62e38368f~y8Z2VSdww0319503195eusmtip2j;
	Wed, 29 Oct 2025 11:07:43 +0000 (GMT)
Message-ID: <df1827bd-628b-424f-80a6-63cea6bf7a39@samsung.com>
Date: Wed, 29 Oct 2025 12:07:43 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Introduce import_ns support for Rust
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Stephen Rothwell
	<sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <2dedlnknikkrwg5f6ocuvjrogdjuqyg4sg6zkkao4w4yyvvsje@dkt7rco3fen3>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251029110744eucas1p2f95c4c628e2ff2b2366972eda79aa4c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5
X-EPHeader: CA
X-CMS-RootMailID: 20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5
References: <CGME20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5@eucas1p1.samsung.com>
	<20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
	<2dedlnknikkrwg5f6ocuvjrogdjuqyg4sg6zkkao4w4yyvvsje@dkt7rco3fen3>



On 10/29/25 11:04, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Oct 28, 2025 at 01:22:31PM +0100, Michal Wilczynski wrote:
>> This series addresses build warnings reported by `modpost` for the Rust
>> PWM driver (`pwm_th1520`) in linux-next:
>>
>> WARNING: modpost: module pwm_th1520 uses symbol pwmchip_release from
>> namespace PWM, but does not import it.
>>
>> These warnings occur because Rust modules, like C modules, need to
>> declare their dependencies on C symbols exported to specific namespaces
>> (using `EXPORT_SYMBOL_NS` in C). This is done by embedding
>> "import_ns=<NAMESPACE>" tags into the module's `.modinfo` section, which
>> `modpost` verifies.  The C macro `MODULE_IMPORT_NS()` handles this, but
>> the Rust `module!` macro lacked equivalent functionality.
>>
>> This series introduces the necessary support:
>>
>> Patch 1 extends the core `module!` macro in `rust/macros/module.rs`
>> to parse an optional `imports_ns: [...]` field and generate the required
>> `import_ns` tags in the `.modinfo` section.
>>
>> Patch 2 adds a convenience macro `module_pwm_platform_driver!` to
>> `rust/kernel/pwm.rs`. This macro wraps the standard
>> `module_platform_driver!` and automatically adds `imports_ns: ["PWM"]`,
>> simplifying module declaration for PWM driver authors.
>>
>> Patch 3 updates the `pwm_th1520` driver to use the new helper macro,
>> fixing the build warnings.
> 
> Given that for now the pwm_th1520 driver is the only user, does it make
> sense to merge this series via my pwm tree? If it goes via a different
> tree, I'd like to have a tag to merge into my tree to hand over code
> which is free of warnings to Linus in the next merge window.

Hi,

I agree with you. Hopefully we can get an ack from the Rust maintainers
and the series can go through your tree.

> 
>> Patch 4 includes a minor clippy style fix for the `pwm_th1520` driver.
> 
> If you could mention the command that makes this warning visible, I'd be
> glad to add that to my repertoire of build checks.

I'm using the following command to compile the kernel:
$ make ARCH=riscv -j20 LLVM=1 CLIPPY=1

I guess you were missing the 'CLIPPY=1' part.

> 
> Thanks for addressing the issue
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

