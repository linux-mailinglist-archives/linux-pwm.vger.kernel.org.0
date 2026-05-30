Return-Path: <linux-pwm+bounces-9213-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHxHM48kG2pm/ggAu9opvQ
	(envelope-from <linux-pwm+bounces-9213-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 19:55:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5BE610A7A
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 19:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13A5F30234DB
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7003346E55;
	Sat, 30 May 2026 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TZs3VqHf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE08304BCB
	for <linux-pwm@vger.kernel.org>; Sat, 30 May 2026 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163368; cv=none; b=fduNhA724Oz4JgECbmdlaiAqNNZJMvHGER8t85Io/NVz8nvpTJjVyu/DUn86BM1fkm7sqauRTnYAVyI81vKnu0j7UQialzbNZaqxAe5ldOdjusIj6nhSzkGg1rjokaU5sKDFubMu4iPVzU38y3rxisyl1vAtvXsWYw320A1v6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163368; c=relaxed/simple;
	bh=UyJOXarCGRXmDIUZlOVYj8xbuJzNlD5g254qIE/U4bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Av9bKjC22AmEtihjN/rsAYGAXD6cWMyinpEK4pTsa5705QsS3n9guVNT8kuvGGMWTvhwiREXQjw9yMwsYSIQ0v7nEqk8tx6ydQJtxZeOFJwavfScJ4XeJ3Un+RBpPWoJOm5ZPPX3OBocCwNZybJLg7j7fd6cPtjPcCZ1chqnfOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TZs3VqHf; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260530174923euoutp02648ae182e5da41626b1b96a860ae6643~0aSW9AGjJ0742607426euoutp02K
	for <linux-pwm@vger.kernel.org>; Sat, 30 May 2026 17:49:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260530174923euoutp02648ae182e5da41626b1b96a860ae6643~0aSW9AGjJ0742607426euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780163363;
	bh=EbVO9J2kBmD3bmjr66FDYqyfGc2oM0Qu91oggGlNoeE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=TZs3VqHfo74uDw3aR/pa37Zn8EoyvExyG7aSGbJXMpXUDbn+8xlmRezTjIUYQgZWo
	 4CjQ6jcd57zlwxum7A8KtCFO9BcfYKnB7EcUKtEJ5XXC+UKjMv+fsgZ66BitpxrnjS
	 mLx6FjqhSxoC+ImqsjyAKKbP7vVp6yk3r6tUQdFc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260530174922eucas1p2d7a4ec1d5c18adaadd06ec1fbb7a779a~0aSVw8Ylj1076310763eucas1p2A;
	Sat, 30 May 2026 17:49:22 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260530174921eusmtip2f3133531530bba41a6405761c3e14640~0aSVDTyTP1888418884eusmtip2Y;
	Sat, 30 May 2026 17:49:21 +0000 (GMT)
Message-ID: <c17631cc-77a3-464d-b4b6-fc3521acca5e@samsung.com>
Date: Sat, 30 May 2026 19:49:21 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rust: pwm: use pin_init::zeroed() to initialize
 pwm_ops
To: Francis Laniel <laniel_francis@privacyrequired.com>, Miguel Ojeda
	<ojeda@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
	Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
	Krummrich <dakr@kernel.org>, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260529153821.126823-1-laniel_francis@privacyrequired.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260530174922eucas1p2d7a4ec1d5c18adaadd06ec1fbb7a779a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260529154838eucas1p25f3bf881090a8a80556bc2f1dfc278b4
X-EPHeader: CA
X-CMS-RootMailID: 20260529154838eucas1p25f3bf881090a8a80556bc2f1dfc278b4
References: <CGME20260529154838eucas1p25f3bf881090a8a80556bc2f1dfc278b4@eucas1p2.samsung.com>
	<20260529153821.126823-1-laniel_francis@privacyrequired.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9213-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wilczynski@samsung.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fireeye.com:url]
X-Rspamd-Queue-Id: 4F5BE610A7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/29/26 17:38, Francis Laniel wrote:
> Replace unsafe block containing core::mem::zeroed by calling
> pin_init::zeroed().
> This is safer, as this function is guarded by trait contrary to
> core::mem:zeroed().
> Also, we can call this because all fields in pwm_ops, i.e. function
> pointers in Option<> and usize, are Zeroable.
> 
> Link: https://protect2.fireeye.com/v1/url?k=c68066dd-991b5fb8-c681ed92-000babff32e3-8cf7da03bc5f790c&q=1&e=7bb43a54-acba-4578-8682-f88365e5bdf6&u=https%3A%2F%2Fgithub.com%2FRust-for-Linux%2Flinux%2Fissues%2F1189
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> ---
>  rust/kernel/pwm.rs | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 6c9d667009ef..3427b7d93a03 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -494,9 +494,7 @@ pub(crate) fn as_raw(&self) -> *const bindings::pwm_ops {
>  /// This is used to bridge Rust trait implementations to the C `struct pwm_ops`
>  /// expected by the kernel.
>  pub const fn create_pwm_ops<T: PwmOps>() -> PwmOpsVTable {
> -    // SAFETY: `core::mem::zeroed()` is unsafe. For `pwm_ops`, all fields are
> -    // `Option<extern "C" fn(...)>` or data, so a zeroed pattern (None/0) is valid initially.
> -    let mut ops: bindings::pwm_ops = unsafe { core::mem::zeroed() };
> +    let mut ops: bindings::pwm_ops = pin_init::zeroed();
>  
>      ops.request = Some(Adapter::<T>::request_callback);
>      ops.capture = Some(Adapter::<T>::capture_callback);

Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>


