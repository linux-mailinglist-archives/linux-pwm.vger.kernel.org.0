Return-Path: <linux-pwm+bounces-9120-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EDmOIdeFGqgMwcAu9opvQ
	(envelope-from <linux-pwm+bounces-9120-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 16:36:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 485E85CBCB9
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 16:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AD82301DCDE
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4CA34D394;
	Mon, 25 May 2026 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qBKb45Kz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0463F1654
	for <linux-pwm@vger.kernel.org>; Mon, 25 May 2026 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719789; cv=none; b=tEXhh8e9KyCBLOIhE2FhsyQWTsF1mnJubsfuu/mXUpkMlt/lczMmOWspoUzMIpqrA+ZjtYXaK0Ll2xp4utlXv6erqzAjc4lFyg/e6iO4hSg8fFMzIV1zm+9+CVWp+hWniHgvwxDQshm3QLtoOTDv9Lt8vfOsjXylIM5Yrsiqwr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719789; c=relaxed/simple;
	bh=2DXKWMNDJAI9HNt7QnF0PHuivwgYiT+bam1Lc/9t9C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jTELa+0z6vLsJiQ0yZlgUz3MVU1ksrrf106260xc4Dp2ceQ7BdsOyrma/ft9HaV/6gUzIHsZ2vS9/ZN3zQIBk51BivdEf4BB6Wh3pZXSL0KEBt67SDwpSSOl7+WiT5vtCdkDLcGB/OOsasHTdN6drpYat2KGbp3B15xR6JPxscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qBKb45Kz; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260525143617euoutp02d0e1fdd32b617baea81ba99e39a217e7~y1bVFjc4C2605526055euoutp02M
	for <linux-pwm@vger.kernel.org>; Mon, 25 May 2026 14:36:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260525143617euoutp02d0e1fdd32b617baea81ba99e39a217e7~y1bVFjc4C2605526055euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779719777;
	bh=ihliREZgMzReUYNbym7+k9r3BOHcnboQjI39K8/coEA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qBKb45KzlYodRsq1ggqya+gyQ1dvTuRoBHimsXpeTiXtd8fDvhJe4HKeDZAWzJMBo
	 XLboiRqMklGRmoFTEQhyuIcWuAQ/2AJAv4iz86BrCt1qqdURNZVAJsQNy8QymqXxBH
	 3kSz8vYiqjniLQt1am7/ZKP983nS/cQZhW6HIWmo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260525143615eucas1p185f94e18bbc0a8f178354df3559e8e64~y1bTGZ3s_3257432574eucas1p1q;
	Mon, 25 May 2026 14:36:15 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260525143614eusmtip2d4576676ff0d43b22887b9deb3631a72~y1bSZgOpC2236822368eusmtip2e;
	Mon, 25 May 2026 14:36:14 +0000 (GMT)
Message-ID: <8857fc45-b787-4661-b27b-8976e655f7c9@samsung.com>
Date: Mon, 25 May 2026 16:36:14 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] pwm: th1520: Remove requirement for
 mul_u64_u64_div_u64_roundup
To: mhi@mailbox.org, Drew Fustini <fustini@kernel.org>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260525-pwm-th1520-fix-v1-1-814e537c6812@mailbox.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260525143615eucas1p185f94e18bbc0a8f178354df3559e8e64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260525131112eucas1p1d7e4836f71c81686e1f71e4007e344ec
X-EPHeader: CA
X-CMS-RootMailID: 20260525131112eucas1p1d7e4836f71c81686e1f71e4007e344ec
References: <CGME20260525131112eucas1p1d7e4836f71c81686e1f71e4007e344ec@eucas1p1.samsung.com>
	<20260525-pwm-th1520-fix-v1-1-814e537c6812@mailbox.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9120-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[mailbox.org,kernel.org,redhat.com,garyguo.net,protonmail.com,google.com,umich.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wilczynski@samsung.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:email,samsung.com:email,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Queue-Id: 485E85CBCB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/26 15:11, Maurice Hieronymus via B4 Relay wrote:
> From: Maurice Hieronymus <mhi@mailbox.org>
> 
> The cycle register is always u32, so cycles_to_ns() can take a u32
> instead of a u64. With that narrowing, cycles * NSEC_PER_SEC is at most
> u32::MAX * 1e9 (~4.3e18), which fits in u64 without overflow. The
> saturating arithmetic is therefore no longer needed, and the ceiling
> division can use Rust's u64::div_ceil() directly instead of the
> open-coded numerator/denominator form.
> 
> This also drops the TODO referring to a future
> mul_u64_u64_div_u64_roundup kernel helper, which is no longer required.
> 
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Hi Maurice,

Thanks for sending this.

I agree that this optimization makes perfect sense when looking at the
TH1520 driver in isolation. However, since this is currently the only
Rust PWM driver in the tree, it serves as the reference implementation
for future drivers.

We need cycles_to_ns to remain a generic blueprint. Many PWM controllers
have 64-bit registers, and in the C API, it is standard practice to use
helpers like DIV64_U64_ROUND_UP regardless of the register size (e.g.
axi_pwmgen). Resolving the TODO by assuming 32-bit registers removes
that generic capability.

At the time this was merged, the equivalent Rust math helpers didn't
exist yet, which is why the open-coded saturating math is there as a
placeholder.

To move forward, we should fix this by implementing the proper generic
64-bit math helper in the Rust abstractions, rather than narrowing the
types here. Are you open to looking into adding the Rust equivalent for
mul_u64_u64_div_u64_roundup instead?

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

