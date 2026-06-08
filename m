Return-Path: <linux-pwm+bounces-9269-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H7kxMJqWJmreZAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9269-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Jun 2026 12:16:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C9654F27
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Jun 2026 12:16:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=cLoF5su3;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9269-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9269-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7BEA3046CD6
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2026 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D9E38B148;
	Mon,  8 Jun 2026 10:08:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BBE1CAA68
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jun 2026 10:08:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913323; cv=none; b=iTbCx1an0CIpAV8+XVVjERFShzHzT7ZuAIAHOKIqFeWOqW+uwPWWhmaKFbkorFRQ4cO/jvJyo+GQk13X/BlTGlwUUpRdMryce3OvvPTbazcmY+7cmYGvVfbF7H9IQUURMbFhFUsuzOGZHRvfTDY2bd1c54due0pKy5PfX7H+mv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913323; c=relaxed/simple;
	bh=UaS8P+BnNs30Wx3OCTtg2sP9AlLlbx00rCICGw91jA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=TIK1PYrO0LvBZQBr7C16qMQwLJnGPH/f2Z5h3ZOoA4B8kRKcvmkJBzFpV5pBW3GymX+nF84oqYBzLgeEG1qVl3sLiMMFgsjoUzrgBVp71NsR1DLxW7jBfuen+HMmGKHjeGCVL527OuWUtK9adcj8O9uqe5F8rce+DKUt2mEjZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cLoF5su3; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260608100839euoutp013529edb0cdfff2fad1be3da197844d85~3Ezp4nAQ42057420574euoutp01J
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jun 2026 10:08:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260608100839euoutp013529edb0cdfff2fad1be3da197844d85~3Ezp4nAQ42057420574euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780913319;
	bh=ScX6tmH+TYFIA4SdeDcX5TAQpdwZEO/9NVN1KgaB3hw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cLoF5su3stWT+hb6nfTtHwBwrrKHZLRDbQwUroh5t+iFCfiCUD0Z8tIlOkamuIlxG
	 qeOHzEJ58YbyS317GkjyofK7fQ13HHHwF0legf9LOkfvpwVI1TCV7BT/w9fiu/TkE8
	 lOCBfrOUmSVswJYFE8RtOExm4LjdPdpKByrpZFPY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260608100839eucas1p26efb0e1085dba36943f16284a4fee98b~3EzpgqhjL2726127261eucas1p2t;
	Mon,  8 Jun 2026 10:08:39 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260608100838eusmtip2364ad82459e2916175d35315bdcac074~3EzoopYD61119811198eusmtip2K;
	Mon,  8 Jun 2026 10:08:38 +0000 (GMT)
Message-ID: <2c036c0e-8246-4e55-90b0-97ba8ef46115@samsung.com>
Date: Mon, 8 Jun 2026 12:08:37 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pwm: th1520: Lock clock rate with
 clk_rate_exclusive_get
To: Maurice Hieronymus <mhi@mailbox.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Drew Fustini
	<fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260605-rate-exclusive-get-th1520-v2-2-695640bf7249@mailbox.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260608100839eucas1p26efb0e1085dba36943f16284a4fee98b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260605070115eucas1p14ef31f75a9597be42bda6c6597fc7e38
X-EPHeader: CA
X-CMS-RootMailID: 20260605070115eucas1p14ef31f75a9597be42bda6c6597fc7e38
References: <20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org>
	<CGME20260605070115eucas1p14ef31f75a9597be42bda6c6597fc7e38@eucas1p1.samsung.com>
	<20260605-rate-exclusive-get-th1520-v2-2-695640bf7249@mailbox.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9269-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mhi@mailbox.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[m.wilczynski@samsung.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[mailbox.org,baylibre.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wilczynski@samsung.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:email,vger.kernel.org:from_smtp,samsung.com:mid,samsung.com:dkim,samsung.com:from_mime,samsung.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B7C9654F27



On 6/5/26 09:00, Maurice Hieronymus wrote:
> The driver derives period and duty cycle from the clock rate read at
> probe, so a later rate change would silently miscompute waveforms.
> Switch to the new ExclusiveClk wrapper to hold the rate for the lifetime
> of the driver data and drop the corresponding TODO.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---
>  drivers/pwm/pwm_th1520.rs | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>


