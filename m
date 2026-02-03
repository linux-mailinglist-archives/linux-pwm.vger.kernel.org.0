Return-Path: <linux-pwm+bounces-8066-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K2IDMUogmnFPwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8066-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:56:37 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA93EDC5D3
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A49D3303C2EF
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0B23D3494;
	Tue,  3 Feb 2026 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUDHFMxN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1670B31AF24;
	Tue,  3 Feb 2026 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137782; cv=none; b=ZFxDoV59akTTEm33YTOlk+a75Pdn/oJshMhOkv5iWl7J8snUUZjIJGF+ZHqEEBuQHoN5d4auojaN9fIei7glCNhbIVl4admfl226Oz1IOE2oHtvrjQqcaZUvg6mlA/p7zBtWBhvqOeNy7RNrRyZv04OH+qoL8TsPv4lHnYgJ4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137782; c=relaxed/simple;
	bh=3o+HnSL/yemF534lAHzJX1t72kQ8B3Rca8FZN+3UoX0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=oisgsqlaMMpmx86bApYYPD75/ZCi6+GKn8btjmLzBpYsobgJRUrgImvEr/fzfYAahY2uuhbx5IiSxtCkm0lo0A7oBY2JoJUQJQKTtPnKj93Bf0mchUH005F+4JuBHKKY6rX78CizIsVLP7BQTNcozveSlQIIJgag7phpGo3xDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUDHFMxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712A2C19421;
	Tue,  3 Feb 2026 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770137781;
	bh=3o+HnSL/yemF534lAHzJX1t72kQ8B3Rca8FZN+3UoX0=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=YUDHFMxNw6lAofOeJqwURs4woN614vkGOuIawtIXD/qJk3JMKP5xvSobnw/hDeFho
	 5Js7V1r8vKutjeCrccZyY8jVvGwtFHVELkd3AsLMxFqiSCJFyhM35ZEcSENCpPrxLl
	 jdyZDvHeYELVaSulsJu2fE9NJyY8rHGjg9y3xrUt3y4DfvreyazkR0HAXr8JjCJMuI
	 YiNPTA4cqSFg4FFHDop2IvaRMj+qbAY0sdgLcA6EcRlRVyT+3msNH2CX+cue/65gjY
	 OJw6LqKvDAfvQ45W3FG14TrAkKsUJi9ZZVzT+K0aKyWTsRAeEzSx8BSh9jemxgiBj+
	 fbF4gf8TGqNIA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 17:56:14 +0100
Message-Id: <DG5HGZG62NNS.18BCSOO6TR70G@kernel.org>
Cc: "Matthew Maurer" <mmaurer@google.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Satya
 Durga Srinivasu Prabhala" <satyap@quicinc.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Trilok Soni" <tsoni@quicinc.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 6/6] soc: qcom: socinfo: Convert to Rust
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-6-d6719db85637@google.com>
 <2026020315-conch-trickle-2d84@gregkh>
 <DG5H119NY68Q.TWLCK3W36CM5@kernel.org>
 <2026020347-sneak-embark-1b36@gregkh>
In-Reply-To: <2026020347-sneak-embark-1b36@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8066-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_TWELVE(0.00)[28];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DA93EDC5D3
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 5:48 PM CET, Greg Kroah-Hartman wrote:
> On Tue, Feb 03, 2026 at 05:35:24PM +0100, Danilo Krummrich wrote:
>> On Tue Feb 3, 2026 at 5:28 PM CET, Greg Kroah-Hartman wrote:
>> > On Tue, Feb 03, 2026 at 03:46:35PM +0000, Matthew Maurer wrote:
>> >> +impl Smem {
>> >> +    pub(crate) fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Op=
tion<&'a Mmio> {
>> >> +        if *dev !=3D *self.dev {
>> >
>> > How can this ever happen?
>>=20
>> You are right, since this resource is local to the driver, it should not=
 be
>> possible to have another devce from somewhere else (especially not a
>> &Device<Bound>).
>>=20
>> However, from a Rust perspective I think not having this check would be =
unsound,
>> as the method by itself would not be able guarantee correct behavor anym=
ore.
>>=20
>
> I don't really understand this last sentence, sorry.  If this is "not
> possible" why would that at the same time be "unsound"?

It would be considered unsound because the function itself can not guarante=
e
that it does not produce undefined behavior, i.e. it would otherwise become=
s
unsafe.

But I'm not an expert on this, I'll let Benno and Gary jump in.

