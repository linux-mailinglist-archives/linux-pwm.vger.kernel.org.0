Return-Path: <linux-pwm+bounces-8175-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG6zH9g9qWmn3QAAu9opvQ
	(envelope-from <linux-pwm+bounces-8175-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 09:24:56 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF72B20D68F
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 09:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97F4F30166FA
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F961374E66;
	Thu,  5 Mar 2026 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esq7gGZU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111D4374724;
	Thu,  5 Mar 2026 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699077; cv=none; b=hyNq5AbVusukj5HY0dIsT6wxGLEn553i84xDXFCCv6T995GQ0ioOwQN+zIq0ygLIdkzfh/2FPjvR1obHagSF17f0JIpOeuumGE3aguT6JS8skzms42vAQiplyBAyb2Hq382vSOSlDi+nJp1K05YaoGHkhGAvpl9eITbUNHdgzcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699077; c=relaxed/simple;
	bh=v9aqov2TRju92BUkePwYkzbYjnrsweKBt5HjUS1ipP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlCkrskXtOetMZpTkYx7XtZVqTclHi4Kr6F8VHY+JgHIlYdl6dBZJXwlzV2j/3MGA0fdqhyBQ9EC6e61wW18+0TTk+0ZFTxlc1efqb/x3Phly9dDFnthHf5HNRVA9mYj+EFyqOPhqf/YG/+3N/7v6I+m+FuWpRQ2kOOhLkFR8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esq7gGZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFFBC2BC9E;
	Thu,  5 Mar 2026 08:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772699076;
	bh=v9aqov2TRju92BUkePwYkzbYjnrsweKBt5HjUS1ipP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Esq7gGZU0KXs35RQU+pRlI1hgRQdxYIiLM86nXyEIyCQU01GYI19QdoSxNiwazxtb
	 amix2JoNVwSw4sHwRX3GaRsSGHP3oMYdlKSU2WBjkb5dY8S+Z/qMrUI0igGiit/ebl
	 EpQYoux7iIB/RdepnrDkfAXKEPEl9C1XqqRL/UnEIROc9kL4kuSOGfrCE3T61m8xtC
	 mhfz6afBq6fQwsKYcva3+3WIGl4XWrNfxbUL32wxY79TmAi1f0EQl3VDDWv+huynVD
	 r/g0D1cAC8Lggqh/H7lVjcJ/nM4kvBuAHF13ttzcQ5ww/I1MaSPwikStFIfZh/4Xg0
	 MGUlxzUri/dKA==
Date: Thu, 5 Mar 2026 09:24:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	Michael Turquette <mturquette@baylibre.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: th1520: remove impl Send/Sync for
 Th1520PwmDriverData
Message-ID: <aak9ZBJenK1DSCEt@monoceros>
References: <20260113-clk-send-sync-v4-0-712bc7d94a79@google.com>
 <CGME20260113151335eucas1p157cd966c5f0f4e477fb11272810a0ae8@eucas1p1.samsung.com>
 <20260113-clk-send-sync-v4-3-712bc7d94a79@google.com>
 <90657b83-1cff-4c7d-adde-9b560c2be7c2@samsung.com>
 <3cfeounnaphhezvjpz5igswml6iu3b6jhwhjn2g4ziimjdoefi@ge4ezxx6jxlr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ygr7vi7eyprc7gqk"
Content-Disposition: inline
In-Reply-To: <3cfeounnaphhezvjpz5igswml6iu3b6jhwhjn2g4ziimjdoefi@ge4ezxx6jxlr>
X-Rspamd-Queue-Id: EF72B20D68F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8175-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[google.com,baylibre.com,linux.intel.com,kernel.org,redhat.com,linaro.org,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--ygr7vi7eyprc7gqk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] pwm: th1520: remove impl Send/Sync for
 Th1520PwmDriverData
MIME-Version: 1.0

Hello,

On Tue, Jan 20, 2026 at 09:48:48AM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Jan 19, 2026 at 10:45:56PM +0100, Michal Wilczynski wrote:
> > On 1/13/26 16:12, Alice Ryhl wrote:
> > > Now that clk implements Send and Sync, we no longer need to manually
> > > implement these traits for Th1520PwmDriverData. Thus remove the
> > > implementations.
> >=20
> > I thought this was already merged :-).
> >=20
> > Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>
>=20
> If I understand correctly this patch 3 depends on the first patch of
> this series so I cannot pick it up via the pwm tree *now*. There is
> another patch pending for the th1520 PWM driver, but as of now git seems
> to cope well when merging the pwm's tree for-next with this patch.  So
> it's fine for me if the series is picked up for 6.20-rc1 via the clock
> tree.

That didn't happen (with s/6.20/7.0/), so this patch is still open in my
todo list. Is the first patch still considered for the clk subsystem?
What is the plan for the pwm patch?

Best regards
Uwe

--ygr7vi7eyprc7gqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmpPb4ACgkQj4D7WH0S
/k6AYgf+IFbJpwiUp9P8Rmry4DJdrF6HeXt7L7+0cSOAtSjz8246LrMcqOZN03RB
YAi8NxU8tZw4Ib54H+GNZUp+gf4jryjO+ry/HXrbC9giXxYVAPBzNhRLgpLUXsm/
dIJFq7MwB5s7zFnJ6F/u2kD/cCvzCgokFftc831AAAOI7oFD0yZx6nHS/FT60M9B
eK4cNPn/MEB3vgaxHub02lpr0ctEd+s9sPzbmUobR5KI4yqf60VKycdMGfZtu/m6
h/nZTyq/u+CEZP92L59gx7GPKTnJZ2XcHKXJSw5wgPiNCYRWn4s1EbKXA6uvKQV5
r6wXppJz8sU18n8EljYkeht9uPMW0g==
=NxJx
-----END PGP SIGNATURE-----

--ygr7vi7eyprc7gqk--

