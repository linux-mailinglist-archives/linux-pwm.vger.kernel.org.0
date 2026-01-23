Return-Path: <linux-pwm+bounces-7997-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIlsMw5Nc2lDugAAu9opvQ
	(envelope-from <linux-pwm+bounces-7997-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 11:27:26 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B8744DA
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 11:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D215305EFF6
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F905339B34;
	Fri, 23 Jan 2026 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0h2SByq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F0226CF1;
	Fri, 23 Jan 2026 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163923; cv=none; b=qKotXmIlYZdq0jpP8EpdLx+isu0YccgTRNPJspVcb/kgYAfzaDzFseBppztXafXnvZePAYREPrsAmm8hGH1JE5y+9YAk3nHC7HVFBZbGPMwt2ND9Bj0FkLbbCrEFHSRIRa3Ae2v2XJQ31qTVUvXO+FBSQKBQDOqEgDp6EbBYO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163923; c=relaxed/simple;
	bh=rJ4PnEjQ92Juv7kZRzfOisQ3OCIKnD1ngLkVqecNc9k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=HdpLCjJok82RD/rCRt2m9RXFE9oQNNMEnDhk4PWzQdkVq6LXT2HRjNoqKCO18KuVnEbeu+eKES2VkhsSaaK7twKq5+URydmZM7GJYzIB02cSSRc4ZgNoz8PCHyJJcz0L5gBjYEmNbXMJ0wFWytLLFLqby2AZF40STEwRMnL3gcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0h2SByq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2C7C4CEF1;
	Fri, 23 Jan 2026 10:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769163922;
	bh=rJ4PnEjQ92Juv7kZRzfOisQ3OCIKnD1ngLkVqecNc9k=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=k0h2SByq5PfVLciYPhFHNrx7uY5AK0JigWp+8CNZ4ETAiuqQmj8SFs/zYtBJAw0ZA
	 QO9OCJDyziJ2dpVwP95QppS+/yf+vyXVIYff99i/OKJ6wfgGv+7Nn5PJuN/bDtOGYB
	 /CspVsbk73ZO02xc7gqWXpQsGFi6OuQ96PTC+OPNL+fBAuJfSID9Ic+0Dnhg4PkkMB
	 IkrRQxBlzTannrtwvJ9pYIH/qaUb9pDIsQDkmRsEg/OpYYbOIVr5dqXqfTm1EGAi8M
	 SnhJgnSyz0CogxKQ90MEoe4bIMRFXHgPQD9F2d4ctL3IvKm5X4nGqJlz+IfFEE+Uz/
	 bm1HG0hJwrkWw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Jan 2026 11:25:15 +0100
Message-Id: <DFVW9MS5YLON.CVJDBYQKJ0P6@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Drew Fustini" <fustini@kernel.org>, "Guo Ren"
 <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
 <20260119-thundering-tested-robin-4be817@houat>
 <aW4lCfUyumOKRRJm@google.com>
 <518D8B09-B9A1-4DB4-85CD-37A2DD3D5FB1@collabora.com>
 <DFSLCI9U4NCW.2HI2UPUI7G134@kernel.org>
 <20260119-weightless-pelican-of-anger-190db0@houat>
 <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org>
 <20260122-majestic-masterful-jaguarundi-d0abde@houat>
In-Reply-To: <20260122-majestic-masterful-jaguarundi-d0abde@houat>
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
	TAGGED_FROM(0.00)[bounces-7997-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F6B8744DA
X-Rspamd-Action: no action

On Thu Jan 22, 2026 at 2:44 PM CET, Maxime Ripard wrote:
> On Mon, Jan 19, 2026 at 03:37:17PM +0100, Danilo Krummrich wrote:
>> I don't see the issue with devm_regmap_init_mmio_clk()? It takes a refer=
ence
>> count of the clock and prepares it when called and unprepares the clk in=
 drops
>> its reference in regmap_mmio_free_context() called from the devres callb=
ack.
>>=20
>> That something we can easily do with the current API, no?
>
> The current one, yes. Doing that in the API suggested here would involve
> some boilerplate in all those drivers they don't have right now.

No, I did mean the API suggested here.

If you would implement something like devm_regmap_init_mmio_clk() in Rust w=
ith
this API, you'd have some object like

	struct RegmapResource<T: Backend, R: Resource> {
	    map: Regmap<T>,
	    res: R,
	}

and a concrete instance could have the following type

	RegmapResource<MmIo, Clk<Prepared>>

So, eventually you could have:

	fn devm_regmap_init_mmio_clk(dev: &Device<Bound>,  name: &CStr, ...) -> ..=
. {
	    let clk: Clk<Prepared> =3D Clk::get(dev, name)?;
	    let regmap =3D RegmapResource::new(..., clk);

	    Devres::new(dev, regmap)
	}

Of course, we would never design the API in this way, as we have generic I/=
O
backends and register abstractions, and we'd also not have
devm_regmap_init_mmio_clk() as a constructor for a RegmapResource type, but=
 you
get the idea.

