Return-Path: <linux-pwm+bounces-9214-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBetOTMnG2qS/ggAu9opvQ
	(envelope-from <linux-pwm+bounces-9214-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 20:06:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A76261102D
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 20:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43CCA30F756E
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71CE3BE175;
	Sat, 30 May 2026 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DLs/iq2U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A7261B9E
	for <linux-pwm@vger.kernel.org>; Sat, 30 May 2026 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163644; cv=none; b=WuG3HmmugB7sSA8C1w2xw0ERv+Uyb9ZwN1F71r+u3l0viSTlGw13h3dpNW3r58eqXampcMkqkjjAQ0FcADpeg4znXahi77EyO5QcZEzK//lqR5eTgs09AEywQTZsjLZeUO3zF7r0mGTys8MIYrsZligcopgsg76pxgOMY3Vrkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163644; c=relaxed/simple;
	bh=LMcisw0sAT9zsAN9m+1zmDIoWcCr1nxRW3JQAJUBrVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=NqVWfeEiR9NpE4lHahtRCFLJHbFpR/9frKnYginlwxFImlVrJUHfcv1YlLHO+8fXmdSz3a43yT8a2ui0L9Y5MU4+rIsdn3c+xDFiVrquHfzTUuGSOSPz4d+oTuyPU6d3CqCFEJfLyeAOPqv0PLQ0aAQzhvSt3bYmij7S4YkaHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DLs/iq2U; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260530174528euoutp02bf050b760456bb663194c40a87917e53~0aO71jNaC2437224372euoutp02u
	for <linux-pwm@vger.kernel.org>; Sat, 30 May 2026 17:45:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260530174528euoutp02bf050b760456bb663194c40a87917e53~0aO71jNaC2437224372euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780163128;
	bh=bTDLJmGkDlSze5mlnTF045Cqf4W18oFetb77eOLT1x8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=DLs/iq2Uwd2IhWSAOl+8zQZEeaib+dwK5qtDl8BZ4AU2+3T/pSGDx1aF9gXo7O0HK
	 VkRIL0LPY6BsX7sl67Qr83Or1QN/glU4oeJpEbhIV97qJpmMSabbSXl6iDrAkVqhWp
	 4Ib6DZUVsKH6CGfEXBYY06PTJCCzj+dh3D70XYtE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260530174526eucas1p1c3685340ad4d1f8d44f7c77408102f2d~0aO5_XT4K2399623996eucas1p1y;
	Sat, 30 May 2026 17:45:26 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260530174525eusmtip1b099a5e622db8c74e1c2c6e57e01ef74~0aO41luc40897308973eusmtip1C;
	Sat, 30 May 2026 17:45:24 +0000 (GMT)
Message-ID: <5c017479-0d1b-434c-a859-7f52b25d7dfc@samsung.com>
Date: Sat, 30 May 2026 19:45:24 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] pwm: th1520: Remove requirement for
 mul_u64_u64_div_u64_roundup
To: Maurice Hieronymus <mhi@mailbox.org>, Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
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
In-Reply-To: <47062326dcf87b605cf4def9835394551645caa5.camel@mailbox.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260530174526eucas1p1c3685340ad4d1f8d44f7c77408102f2d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260525131112eucas1p1d7e4836f71c81686e1f71e4007e344ec
X-EPHeader: CA
X-CMS-RootMailID: 20260525131112eucas1p1d7e4836f71c81686e1f71e4007e344ec
References: <CGME20260525131112eucas1p1d7e4836f71c81686e1f71e4007e344ec@eucas1p1.samsung.com>
	<20260525-pwm-th1520-fix-v1-1-814e537c6812@mailbox.org>
	<8857fc45-b787-4661-b27b-8976e655f7c9@samsung.com>
	<1f550af5b8d1fa2aaa9936d5b0010c156e0cb455.camel@mailbox.org>
	<58245ce0-7271-4b07-b866-0037ff68d92c@samsung.com>
	<47062326dcf87b605cf4def9835394551645caa5.camel@mailbox.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9214-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:email,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Queue-Id: 7A76261102D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/30/26 12:41, Maurice Hieronymus wrote:
>>
>> Apologies, I have to correct my statement from before after
>> discussing
> No worries!
>> with Uwe. The reason the macro was used in the mentioned driver is
>> NOT
>> that PWM controllers have 64-bit registers - Uwe isn't aware of that
>> being a real pattern either, and I was inferring it from the code
>> rather
>> than from hardware reality. The actual reason the macros get used
>> isn't
>> unified across drivers and we should pin that down separately rather
>> than block your patch on it.
>>
>> So please hold off on the Rust helper for now - your initial patch
>> might
>> be the right direction.
>>
> Is there any further conclusion which direction is right? Can we merge
> my patch, does it need some change or are we going down the road with
> the Rust helpers?

I think this patch is fine to move forward.

We were wondering if there would be any noticeable difference in
execution speed between the 64-bit computations and the mixed
32-bit/64-bit computations. I ran a profile on the platform, and the
performance with and without the patch is identical:

Here's the test I ran

WITH PATCH
# hyperfine --warmup 2 --runs 40 './pwmtestperf'                                                                                                                    
  Time (mean ± σ):      3.370 s ±  0.069 s    [User: 0.069 s, System: 3.313 s]
  Range (min … max):    3.271 s …  3.547 s    40 runs
 
WITHOUT PATCH
# hyperfine --warmup 2 --runs 40 './pwmtestperf
  Time (mean ± σ):      3.368 s ±  0.051 s    [User: 0.058 s, System: 3.326 s]
  Range (min … max):    3.278 s …  3.516 s    40 runs

The delta is completely within the margin of error, confirming that
64-bit math is just as fast as 32-bit math on this architecture under
standard loads. It is worth mentioning that to get a more meaningful
performance measurement, pwmtestperf would probably need to be modified
to stress this specific code path much more heavily.

That said, fitting it into 32-bit where appropriate makes perfect sense
from a code quality perspective.

Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>

> 
> Thanks!
> 
> Maurice
>>>
>>> Maurice
>>>
>>
>> Best regards,
> 


