Return-Path: <linux-pwm+bounces-8073-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH2zN+s4gmmVQgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8073-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 19:05:31 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42DDD4CE
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 19:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C9E310A534
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 17:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA135D5E1;
	Tue,  3 Feb 2026 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYV88Kq/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6F2F5487;
	Tue,  3 Feb 2026 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141599; cv=none; b=Vnp5H9s3zS1qlZOKrcepOged9ffMXyCW/2PLLXN242ViOOAgDANf5hfvviMJLybLDnj/MiFDjni++B2FVlrylY+cFQA7pHTVrWDWEgYj/5ZLJkMlfoQSdHsb2rVVMorGn87mijVQLTp9TjF0HiRBn4uqUh16iOMGEierLeLG+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141599; c=relaxed/simple;
	bh=djqumMHdPK4b2u3nULQU7T3jLxiGWNZFX/0cO0Gwfkw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dO2LbATlHGsGCID83eTy89SJ4L0sCv5BDy+t7huGLJmUsYeljYjf8ibJ6q7Fr+2avg4m2GH6+uld14D/fT/jaQjspsmaXL1ivUwp5OtqDh0H8DQMx4QFm61fOdQXnxO9HsqEEpwAMNQPk1DNT8cr2jlYSx/YgflC5AMXZR8BCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYV88Kq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A12C116D0;
	Tue,  3 Feb 2026 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770141599;
	bh=djqumMHdPK4b2u3nULQU7T3jLxiGWNZFX/0cO0Gwfkw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=HYV88Kq/dyKjYqxpquD1Bii3I/VinqzaJv27QlmKDIPb203qKq+IpgQ1TPX3xBKQk
	 mzpoLx5emOj08xtP/v74kc/s1UzGgDPoaR1n4VFUUDp8ziSaXMEci6LvD6JhiGU7DP
	 qJq/4+8v6RgCvO9pVDF0jJyeCgKyagUz+onwSbfUQgb7VmsRKExcHgZMeOYPHl2drr
	 DXsSnWOMkgjubIy9fp66MiUnS9rz74YL/46NOI0725ZpHOF6SqtG+Q0edJJnN571yQ
	 BENoAHDmhTOF/HpmSiKzZhcmVM7HkmEJTDoveN1eoYCxrfgauITSrcjde7rRoJw+zc
	 ZOs4JLlALIvjg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 18:59:52 +0100
Message-Id: <DG5ITP7I2CQO.DOQM3MZKKPS9@kernel.org>
Subject: Re: [PATCH v2 6/6] soc: qcom: socinfo: Convert to Rust
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Matthew Maurer"
 <mmaurer@google.com>, "Bjorn Andersson" <andersson@kernel.org>, "Konrad
 Dybcio" <konradybcio@kernel.org>, "Satya Durga Srinivasu Prabhala"
 <satyap@quicinc.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-6-d6719db85637@google.com>
 <2026020315-conch-trickle-2d84@gregkh>
 <DG5H119NY68Q.TWLCK3W36CM5@kernel.org>
 <2026020347-sneak-embark-1b36@gregkh>
 <DG5HGZG62NNS.18BCSOO6TR70G@kernel.org>
 <DG5HX5K2T371.3JGY5PQIV554K@garyguo.net>
In-Reply-To: <DG5HX5K2T371.3JGY5PQIV554K@garyguo.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8073-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,quicinc.com,gmail.com,protonmail.com,umich.edu,collabora.com,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B42DDD4CE
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 6:17 PM CET, Gary Guo wrote:
> PS. Personally I think this check (and the one in Devres::access) should =
use
> assertion rather than `EINVAL`, because it is a bad driver bug when this =
is hit,
> and adding failing code path for something that is a bug is something I r=
eally
> dislike... It should at least be a `WARN`.

I don't think we should panic in this case, as it can happen too easily.

	// Let's assume the resource is owned by the parent.
	fn foo(adev: &auxiliary::Device<Bound>, res: &Devres<Resource>) {
	    let res =3D res.access(dev.parent()); // OK
	    let res =3D res.access(dev.as_ref()); // panic()
	}

Printing a warning is probably a good idea though.

