Return-Path: <linux-pwm+bounces-8060-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDHXMyAmgmnPPgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8060-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:45:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E432DC2CD
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A3D8301570D
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E523B8BCA;
	Tue,  3 Feb 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgf9TuzE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A82652B6;
	Tue,  3 Feb 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136531; cv=none; b=fokvl3DUM9zpysRPI2h+laN/u5OWImW7DF13AAGLyW3eeMjsm/IKtF533Y8jjeP61kujOsrE8LFaeuX+xGbGvV0n8TqKid7dUpEdiUIFIsB5RccMZuaGE7WRQcPSV6EB7ADvxMMgRyBrJIOS1P5oSq5ZZT0zypF5bz0nzmhUwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136531; c=relaxed/simple;
	bh=svcm0GrCFCCWTCUqWcGBWZZ/Zew4ni38dBsP6egJUg0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ILk+I0AhMytyYkOz5lP6PZybFe7meDNLRn+JsNY97xpwvNSeUCPwmPRGdi72LC5dPbzyFJ2ePKanVRa1l9y4LfZLw99GZB9W28geXYAL3ef45PgLSjCG3oyFT238Le8Skc3LxNk1/n48Ub0dYBj4FuzuOGPIbqZ7VnroXyhCkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgf9TuzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B96C116D0;
	Tue,  3 Feb 2026 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770136531;
	bh=svcm0GrCFCCWTCUqWcGBWZZ/Zew4ni38dBsP6egJUg0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=rgf9TuzEcnLQ6TkQ7G9ARzcgwvlIUXEuyhtBrvQ9hBHxZBgg0fn8Ax6Yj4qLtVRAY
	 t5j+/29jVgL/JUK6N1iTkIulIwvvzFVhU5QVa8SymF7sjI+icGRtpv5phgU9OvCSrr
	 /7PrnUtus2rOVjiJeA0Vf/A6TH4WrPmi1SAU1kaHXWlCLwqaqb6meSyOZZKF+08a/1
	 UOs96GhH66/a+ykPToHDTXENcOKfixoRYRgICh3OUmWPAxUxVu0d3eKN/KCkGjZx6j
	 RRbm4IOiV2kw6b5HZTJiCfxeXQUKW8NeOOcZ9BzuCL7CVhhL4ca3wS8owJsAG+92Hk
	 5Iyl+kBYwJ34Q==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 17:35:24 +0100
Message-Id: <DG5H119NY68Q.TWLCK3W36CM5@kernel.org>
Subject: Re: [PATCH v2 6/6] soc: qcom: socinfo: Convert to Rust
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
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-6-d6719db85637@google.com>
 <2026020315-conch-trickle-2d84@gregkh>
In-Reply-To: <2026020315-conch-trickle-2d84@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8060-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_TWELVE(0.00)[28];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3E432DC2CD
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 5:28 PM CET, Greg Kroah-Hartman wrote:
> On Tue, Feb 03, 2026 at 03:46:35PM +0000, Matthew Maurer wrote:
>> +impl Smem {
>> +    pub(crate) fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Optio=
n<&'a Mmio> {
>> +        if *dev !=3D *self.dev {
>
> How can this ever happen?

You are right, since this resource is local to the driver, it should not be
possible to have another devce from somewhere else (especially not a
&Device<Bound>).

However, from a Rust perspective I think not having this check would be uns=
ound,
as the method by itself would not be able guarantee correct behavor anymore=
.

