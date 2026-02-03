Return-Path: <linux-pwm+bounces-8058-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKIOCVMjgmnPPgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8058-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:33:23 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA40DC043
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D787F3076D6E
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012B3D1CBA;
	Tue,  3 Feb 2026 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Vaohwio6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CEF32142F;
	Tue,  3 Feb 2026 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136145; cv=pass; b=RnUeVDtOhBP5tIsG0sqwkwKHhO+pc5A0TVGnQINDuqvsZ1FhiZqwdGHgb5XD5nhFHy1sJw/8df8OGBw8/z25ul3WtLflw/x+RV+d3Pkyp1vR2fjb/PGnK+yfXyMu89MOqjW8NbHKgx93khf8E1Yai3nuST1Ot8PVCtlNhpI0uAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136145; c=relaxed/simple;
	bh=MvAXXwjbLzEYizLJ1X48DkAzqjrenQBxPAIxNR4c3ZQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s/4vTEECepAxJfoEX0z3Y/H2s3D0LIFD6xslK4hKUgtqvakVYZp6ytr6hu85bU0U7mlmp5VEvyQyQriIRka6+1qER0gc2v6KrPpbZVePLMFp/RIVgpJXSosn/zaZHCVrNjsHDuVczYgDMjwkLokNLdfoSzEwPr/QrTO6g3ugenQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Vaohwio6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1770136118; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lLkAncyetA37sc/HLFwEKT9Cqga2bbfnvmVihfzHkmqajAmyRsiq6JC9FcK2A8hqdurM/F4aMjZUh51/NVgMBiu2qu+oXKMaAm9l9wDmMjBeR5Ufq1bT2kC1QzGnWOZ0ncvbBXh94p3s7uOqk7p1dMZy9VLGCX8tiykydSyR8Q0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770136118; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mcpQ6BHdtlmcJP+6sUHzKp/HKqU2X/+4lbxQzskRA/8=; 
	b=mtdzdD9lE65ZdW3lERr1djKK6k9RzPFv0ppHVYzAr8YCubzOnLynnBSdLz6T0bMMprfgNlCAa5tEI093fendJnYCPtHidl7FupFhvGQxPUpqJdMp6hUD4PFT1bQP2dOZrqx64SNaE6nky/GaW567pJnBDrn0UaErjUkwBH1abGk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770136118;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=mcpQ6BHdtlmcJP+6sUHzKp/HKqU2X/+4lbxQzskRA/8=;
	b=Vaohwio60p4BO1VObvEdiCCH1LCnW2Snk0CPfKC9EeKEQ6/ThqJr7X0R6eP2mxpI
	MoXy/OuxN2rNIq4upnh03oXvE2nll/jit27nzX9Eqbr5egP1RCpMMFjwmY6fGLK83Cf
	/Hnfo4IKgwI7yeQLDAIUDWJGXnCpZIRHV9eZ5x08=
Received: by mx.zohomail.com with SMTPS id 1770136116210986.0414403743216;
	Tue, 3 Feb 2026 08:28:36 -0800 (PST)
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
In-Reply-To: <20260203150855.77c93e22@fedora>
Date: Tue, 3 Feb 2026 13:28:15 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
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
 Gary Guo <gary@garyguo.net>,
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
Message-Id: <4DD13AE1-C85F-450F-93F2-C7C75766E518@collabora.com>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
 <20260119-thundering-tested-robin-4be817@houat> <aW4lCfUyumOKRRJm@google.com>
 <20260203113902.501e5803@fedora>
 <E7286D12-0BD9-4726-B072-FE5A040312B1@collabora.com>
 <20260203150855.77c93e22@fedora>
To: Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8058-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:mid,collabora.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEA40DC043
X-Rspamd-Action: no action

<snip>

>>=20
>> The problem with what you have suggested is that the previous state =
is not
>> consumed if you can clone it, and consuming the previous state is a =
pretty key
>> element in ensuring you cannot misuse it. For example, here:
>>=20
>> let enabled_clk =3D prepared_clk.clone().enable()?;
>> // do stuff
>> // enabled_clk goes out of scope and releases the enable
>> // ref it had
>>=20
>> prepared_clk is still alive.
>=20
> That was intentional in this example. Think about a prepared_clk =
that's
> stored in some driver-internal object, because you want to keep the =
clk
> prepared at all times between the probe() and unbind(). Then you have
> some sections where you want to briefly enable the clk to access
> registers, and immediately disable it when you're done. The clone()
> here guarantees that the initial prepared_clk stays valid.
>=20
> If you were to disable, unprepare and put the clk when enabled_clk =
goes
> out of scope, you'd go

>=20
> let enabled_clk =3D prepared_clk.enable()?;
>=20
> and that would still work, it's just not the same use-case.
>=20

Ok, let=E2=80=99s have clone() then.


>> Now, this may not be the end of the world in this
>> particular case, but for API consistency, I'd say we should probably =
avoid this
>> behavior.
>>=20
>> I see that Alice suggested a closure approach. IMHO, we should use =
that
>> instead.
>=20
> The closure, while being useful for the above local clk-enablement
> example, doesn't allow for passing some Clk<Enabled> guard around, =
like
> you would do with a lock Guard, and I believe that's a useful thing to
> have.


Wdym? You=E2=80=99d still get a &Clk<Enabled> that you can pass around, =
i.e.:

   self.prepared_clk.with_enabled(|clk: &Clk<Enabled> | {
       ... use registers, pass &Clk<Enabled> as needed
   });

This is now not about clone() vs not clone(), but more about limiting =
the scope of the
Enabled state, which would cater to the use-case you mentioned IIUC.

=E2=80=94 Daniel



