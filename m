Return-Path: <linux-pwm+bounces-8728-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGegLd3g72kHHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8728-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:19:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7345247B531
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA05F301C8E2
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9F34DB6C;
	Mon, 27 Apr 2026 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCSOdWN5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333CA191;
	Mon, 27 Apr 2026 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328188; cv=none; b=VKIt/Cx2TXpK8/GgamSTk+bHeTrnRLwWtyjn0Mvh8k6SwIUYxD1TIUsCwZPbdWuGzdJ0h3Y0MFAgJK0BmoIVxI4Lr34m1aM6gNlSf7htx92eDlQXlkJ3ztEFQcd4vYo7DFB1A5p2vijQE/IsZHNNNQrnIdDg8H27j2Po0sKjf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328188; c=relaxed/simple;
	bh=PGxVViMhHB03sAijAlxNGF7mgYEJwbY2rwD26gbYrHs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=GvO1ZToLKjGNXbWNcls3xIaQaZmEoRMksM0cTGYeUxmMoyqGunojToaN21pohTYuP7uUy5KijXohO91+J6HZ0rFIjFti6NZlUOjd/H/rW3prruJaoMisrCpy4MfcTtdKFFR4ce+objgPrNqEhKqVO7Nrm/dxBvQacik0gthQcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCSOdWN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAAFC19425;
	Mon, 27 Apr 2026 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328187;
	bh=PGxVViMhHB03sAijAlxNGF7mgYEJwbY2rwD26gbYrHs=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=gCSOdWN5D78SXVP+wRiSah70WX8vRhFWzTMxldjJDoEzDh6ADKZ+QjTRz0r2SqQ5W
	 jsnRgoXUP5yPTSYZ/Dv68rQFrSs/MnSnT7/KCoxEiJZe0882jXgk2PPazeiNotutr9
	 CGFSPYFy3CIZf7rdd0Xky9gMP+hXeMZtsd2CPmIvGyVi6JJV6AO/IPHpFvXsagP9za
	 AbTQbRn0Wn7ykefDrvhM3Rqlvl/Bb/uMpFVzoyYbXCtnA/FzlV5XljmA88Wr1ORiRq
	 ORqJK2J+jrYSlZFhzq4oLqrwuQh5tUOWOiMJTxC4U774y57AvoJEzxd0ThPOzhGvWt
	 ZBbqvlZ6TwevQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 00:16:20 +0200
Message-Id: <DI4A9AFPGL3D.16M7U97LU7B4R@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 02/24] rust: types: add `ForLt` trait for higher-ranked
 lifetime support
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-3-dakr@kernel.org>
In-Reply-To: <20260427221155.2144848-3-dakr@kernel.org>
X-Rspamd-Queue-Id: 7345247B531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8728-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:email,docs.rs:url]

On Tue Apr 28, 2026 at 12:11 AM CEST, Danilo Krummrich wrote:
> From: Gary Guo <gary@garyguo.net>
>
> There are a few cases, e.g. when dealing with data referencing each other=
,
> one might want to write code that are generic over lifetimes. For example=
,
> if you want take a function that takes `&'a Foo` and gives `Bar<'a>`, you
> can write:
>
>     f: impl for<'a> FnOnce(&'a Foo) -> Bar<'a>,
>
> However, it becomes tricky when you want that function to not have a fixe=
d
> `Bar`, but have it be generic again. In this case, one needs something th=
at
> is generic over types that are themselves generic over lifetimes.
>
> `ForLt` provides such support. It provides a trait `ForLt` which describe=
s
> a type generic over lifetime. One may use `ForLt::Of<'a>` to get an
> instance of a type for a specific lifetime.
>
> For the case of cross referencing, one would almost always want the
> lifetime to be covariant. Therefore this is also made a requirement for t=
he
> `ForLt` trait, so functions with `ForLt` trait bound can assume covarianc=
e.
>
> A macro `ForLt!()` is provided to be able to obtain a type that implement=
s
> `ForLt`. For example, `ForLt!(for<'a> Bar<'a>)` would yield a type that
> `<TheType as ForLt>::Of<'a>` is `Bar<'a>`. This also works with lifetime
> elision, e.g. `ForLt!(Bar<'_>)` or for types without lifetime at all, e.g=
.
> `ForLt!(u32)`.
>
> The API design draws inspiration from the higher-kinded-types [1] crate,
> however different design decision has been taken (e.g. covariance
> requirement) and the implementation is independent.
>
> License headers use "Apache-2.0 OR MIT" because I anticipate this to be
> used in pin-init crate too which is licensed as such.
>
> Link: https://docs.rs/higher-kinded-types/ [1]
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Signed-off-by: Danilo Krummrich <dakr@kernel.org>

