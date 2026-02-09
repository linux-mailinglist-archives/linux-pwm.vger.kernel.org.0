Return-Path: <linux-pwm+bounces-8106-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJRUHOSniWk0AQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8106-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 10:24:52 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F2810D820
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 10:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5F2B30045A9
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Feb 2026 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6079835D5EE;
	Mon,  9 Feb 2026 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YsAlTuFa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73827363C51
	for <linux-pwm@vger.kernel.org>; Mon,  9 Feb 2026 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629089; cv=none; b=rMW0qAYGKVeG9gT13Ucy45C5qOJK80/Inyd0HCx2kef0K7RquYyhoeCSwPt7pVt0ty7jYl4VVZGzEAatQN9n0IiJ0suhsA5xWhYQpcm4ZDu9hMHWijzHU9qn/FsjeW6qabB0+UkH5Fd5x6SKnwGJIca48g6ilK4fLF94l2J0sw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629089; c=relaxed/simple;
	bh=XCybjjRlATwkkRYEOhpYbFY55cfMbblBjqPGWhErD2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Z1lqE6OlHybgWN8x78Thx99NNr9rt7s/v3AocDEopt26PCHy7SmEuyz+cyycEN3G+KJPvvQBEBnFYwvUj0XDDL+27HZ3kGa6CFExLFJFLsu4Id9NwmEjwKoRscJ1eVwXF8QUhNuuphFY/eAmfBP177+yVmiH0Rv00u8vuUOYwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YsAlTuFa; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260209092439euoutp028bbde313c3abf19625de0974def12efb~SicRN65v71525115251euoutp02L
	for <linux-pwm@vger.kernel.org>; Mon,  9 Feb 2026 09:24:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260209092439euoutp028bbde313c3abf19625de0974def12efb~SicRN65v71525115251euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770629079;
	bh=Yg65QpvqB2HJv2/a96JfNi6PVWJKkv4zQcF3Q3T/5kE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=YsAlTuFaZD9NcYx38vryleR5Modk95FuLL6T0EtmFUar6SJBP9QOCDPX3qmoBPoFl
	 nrc5F7L+/Kuo6Rf21lzPdSTrGLqR7lcC2zuFVzKDZ1KElU0V4s0V+fzIFH52oAaCOv
	 mKtYaLbI+0AK5KQrHFsTPDyunzI6Y8D6BOP/rC/Q=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260209092438eucas1p156e66a9eaba6af88ac5fd5dede932436~SicQg12A41795617956eucas1p1b;
	Mon,  9 Feb 2026 09:24:38 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260209092437eusmtip2a51af5d68e14937533a7edf95b5d10c5~SicPW4Yzg2096620966eusmtip28;
	Mon,  9 Feb 2026 09:24:37 +0000 (GMT)
Message-ID: <4e843ff5-89f6-41a0-8a35-b4e31291e621@samsung.com>
Date: Mon, 9 Feb 2026 10:24:37 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: th1520: fix `CLIPPY=1` warning
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Miguel
	Ojeda <ojeda@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, linux-riscv@lists.infradead.org, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>, rust-for-linux@vger.kernel.org, Mark Brown
	<broonie@kernel.org>, linux-pwm@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <aYmgjEWaLrdsubKM@monoceros>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260209092438eucas1p156e66a9eaba6af88ac5fd5dede932436
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260209085719eucas1p262f0590167a1193533dd0a55cbff063e
X-EPHeader: CA
X-CMS-RootMailID: 20260209085719eucas1p262f0590167a1193533dd0a55cbff063e
References: <20260121183719.71659-1-ojeda@kernel.org>
	<CGME20260209085719eucas1p262f0590167a1193533dd0a55cbff063e@eucas1p2.samsung.com>
	<aYmgjEWaLrdsubKM@monoceros>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,lists.infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8106-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wilczynski@samsung.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rust-for-linux.com:url,rust-lang.github.io:url,samsung.com:email,samsung.com:dkim,samsung.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fireeye.com:url]
X-Rspamd-Queue-Id: D6F2810D820
X-Rspamd-Action: no action



On 2/9/26 09:56, Uwe Kleine-König wrote:
> Hello Miguel,
> 
> On Wed, Jan 21, 2026 at 07:37:19PM +0100, Miguel Ojeda wrote:
>> The Rust kernel code should be kept `CLIPPY=1`-clean [1].
>>
>> Clippy reports:
>>
>>     error: this pattern reimplements `Option::unwrap_or`
>>       --> drivers/pwm/pwm_th1520.rs:64:5
>>        |
>>     64 | /     (match ns.checked_mul(rate_hz) {
>>     65 | |         Some(product) => product,
>>     66 | |         None => u64::MAX,
>>     67 | |     }) / NSEC_PER_SEC_U64
>>        | |______^ help: replace with: `ns.checked_mul(rate_hz).unwrap_or(u64::MAX)`
>>        |
>>        = help: for further information visit https://protect2.fireeye.com/v1/url?k=4a8755d5-151b7cff-4a86de9a-000babe598f7-51498316c06f2766&q=1&e=b527c3ac-a0b8-4074-9bc4-c3497f7913a5&u=https%3A%2F%2Frust-lang.github.io%2Frust-clippy%2Frust-1.92.0%2Findex.html%23manual_unwrap_or
>>        = note: `-D clippy::manual-unwrap-or` implied by `-D warnings`
>>        = help: to override `-D warnings` add `#[allow(clippy::manual_unwrap_or)]`
>>
>> Applying the suggestion then triggers:
>>
>>     error: manual saturating arithmetic
>>       --> drivers/pwm/pwm_th1520.rs:64:5
>>        |
>>     64 |     ns.checked_mul(rate_hz).unwrap_or(u64::MAX) / NSEC_PER_SEC_U64
>>        |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: consider using `saturating_mul`: `ns.saturating_mul(rate_hz)`
>>        |
>>        = help: for further information visit https://protect2.fireeye.com/v1/url?k=7fd7ef65-204bc64f-7fd6642a-000babe598f7-c6165289323e3bed&q=1&e=b527c3ac-a0b8-4074-9bc4-c3497f7913a5&u=https%3A%2F%2Frust-lang.github.io%2Frust-clippy%2Frust-1.92.0%2Findex.html%23manual_saturating_arithmetic
>>        = note: `-D clippy::manual-saturating-arithmetic` implied by `-D warnings`
>>        = help: to override `-D warnings` add `#[allow(clippy::manual_saturating_arithmetic)]`
>>
>> Thus fix it by using saturating arithmatic, which simplifies the code
>> as well.
>>
>> Link: https://protect2.fireeye.com/v1/url?k=3f9f72c4-60035bee-3f9ef98b-000babe598f7-ce3556202281f48e&q=1&e=b527c3ac-a0b8-4074-9bc4-c3497f7913a5&u=https%3A%2F%2Frust-for-linux.com%2Fcontributing%23submit-checklist-addendum [1]
>> Fixes: e03724aac758 ("pwm: Add Rust driver for T-HEAD TH1520 SoC")
>> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>> ---
> 
> Looks good to me. I'll wait for Michal to add his blessing and then when
> picking it up tend to drop the Fixes line. Or do we also care about
> CLIPPY-cleanness in stable?

Hmm I'm pretty sure at the time of the writing building with CLIPPY
didn't trigger this warning, so I guess it's either a newer version of
CLIPPY that I used or in the meantime CLIPPY was updated.

Anyway 
Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>

> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

