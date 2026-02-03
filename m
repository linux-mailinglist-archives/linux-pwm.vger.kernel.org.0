Return-Path: <linux-pwm+bounces-8075-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOHCAQ9MgmnNRwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8075-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 20:27:11 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E56DE262
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 20:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62B8530981DF
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 19:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59FE3469E7;
	Tue,  3 Feb 2026 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="CNUreKwL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-g125.zoho.com (sender4-pp-g125.zoho.com [136.143.188.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B752BE621;
	Tue,  3 Feb 2026 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146828; cv=pass; b=k+wQ4/Lg9tU1TpkwYf/oz8UjDisiiRJVTNmMPmsbB/PmGwGN/FFhpV54famW8o89HGm9hNv2s3DPQ5PuJs4THocoP4h/MhyARg+E2BBdIe4rqvnsiIMDSP+JoG6dY3ifySSS4i6QtOSAXGDd2SyLjNGoO8F1AYm6j5DbofRgfkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146828; c=relaxed/simple;
	bh=4v+xWvkofJpryLSpiSaOWuqWiXRapdYambyxNbmoS6o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tq1EHC4io+13w2K5TKsaZRJkqbtNtQ72rzkZRvmcbQWFpEZ+/0r3A90Nk52/B86aV4dF5v1/kwsgKJCcBQihB9by8RA8QascQp/rOKeSnp65ylJPO30umBqp5WUwuipWADXddyDaYeDZc21Be5a2bYPg56tL8T3pAQ/j/++arrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=CNUreKwL; arc=pass smtp.client-ip=136.143.188.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1770146803; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jArGcWPUvr51HjSndXkxQsFSFBo/XWpFDH8zP7rcBIuN85VPd+cDfJ5IhBLQ0hpiD6/o6GRPoB6KiJeYlI3Tk9ZCMgsaa0Fv1ZG6sCRrZ7J6z+w3CFwfQXuZOvOoJxSMFREAZo2LgKDYf9Ix/5Js/JecLAhX4CSn8uaffhF5x4s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770146803; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ir2ovejfXxhACKMa1+xrpKhVj5sNO/6JMxcXVd/x19E=; 
	b=nqkXgNLF0rTg1cIEafpsgKTpHeK0k81+fRUZ09Xg3b2W04sspv2jbfqwZkj3YMJGznFkRt0+HPG0okOY6s1xheNVUfp0m3+qa8RRJEYfySKUDmv8oEg+clCbF+/9WFPcCXYPGs8J0uahSrAH4qnXUn8ZD2vSwPtHtdUq2p592bY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770146803;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Ir2ovejfXxhACKMa1+xrpKhVj5sNO/6JMxcXVd/x19E=;
	b=CNUreKwLIxNpQqS6Nj9US9lMrHuJkvgZCvFSHXY1lVHLShfQqCg/yIFEepMsIS7y
	XhaDRxH2YnusRbxNVwmbr4Z4GY99Fa2dmgk3+NvThoCutRDDUag+mlWXIIxrzRCmKai
	PfdR428k3dIrrI6qrK4xQYpSmECTZbJR6kBgdaPw=
Received: by mx.zohomail.com with SMTPS id 1770146801318166.33115821304864;
	Tue, 3 Feb 2026 11:26:41 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DG5HJPIYMS7B.152WPGG9MZZJ5@garyguo.net>
Date: Tue, 3 Feb 2026 16:26:22 -0300
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maxime Ripard <mripard@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Drew Fustini <fustini@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B94452FD-5F6F-44D4-80D8-4D4B7004C4B5@collabora.com>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
 <20260119-thundering-tested-robin-4be817@houat> <aW4lCfUyumOKRRJm@google.com>
 <20260203113902.501e5803@fedora>
 <E7286D12-0BD9-4726-B072-FE5A040312B1@collabora.com>
 <20260203150855.77c93e22@fedora>
 <4DD13AE1-C85F-450F-93F2-C7C75766E518@collabora.com>
 <DG5HJPIYMS7B.152WPGG9MZZJ5@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8075-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	APPLE_MAILER_COMMON(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70E56DE262
X-Rspamd-Action: no action


>=20
> I think it's fine to have all of these:
> * `Clone` impl
> * `enable` which consumes `Clk<Prepared>` by value and spit out =
`Clk<Enabled>`
> * `with_enabled` that gives `&Clk<Enabled>`
>=20
> This way, if you only want to enable in short time, you can do =
`with_enabled`.
> If the closure callback wants to keep clock enabled for longer, it can =
just do
> `.clone()` inside the closure and obtain an owned `Clk<Enabled>`.
>=20
> If the user just have a reference and want to enable the callback they =
can do
> `prepared_clk.clone().enable()` which gives an owned `Clk<Enabled>`. =
Thoughts?
>=20
> Best,
> Gary


I=E2=80=99m ok with what you proposed above. The only problem is that =
implementing
clone() is done through an Arc<*mut bindings::clk>  in Boris=E2=80=99 =
current
design, so this requires an extra allocation.

=E2=80=94 Daniel=

