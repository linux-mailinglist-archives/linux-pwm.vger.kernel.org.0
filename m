Return-Path: <linux-pwm+bounces-7971-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIJNMFrbb2n8RwAAu9opvQ
	(envelope-from <linux-pwm+bounces-7971-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:45:30 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF464AABE
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0453D887198
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F76D44A707;
	Tue, 20 Jan 2026 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK1PfLxV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273132C33D;
	Tue, 20 Jan 2026 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931978; cv=none; b=mgfAYQ2K9ZmK1kENtHN7m8wwBlH10/m605CmARXpXEta11NHurjp6tt6n0drJ9Av/oKLS5LqTiv1VI3r/xQqdb5RyBfdkCKSI3je1WTXDlXp79jpc3IYrjA6yEClMcuNB4N1rNBkoW3qhzP9DxFx5cwRXfDpHUr/DdE2xu8PEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931978; c=relaxed/simple;
	bh=im6rTGdtAHVoo9gMGfLRhHqPzagovRFiPRrkny9SMiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOYKPETiMBGxJY6UR8mbmvp10iHE04eVrTNYDnIf3AyRDkH7qNxZh94JgD5QAuPYfwdR5IEl3Qagcqd2BDGd5t5hQDIKIvC+RRxXErWRiFLriW+IqMIkBtJfMbhlSdFy9T19xwTjqln2Lf557D4+kgHjhltQYNn3+2va5eR+5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK1PfLxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A76DC16AAE;
	Tue, 20 Jan 2026 17:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768931977;
	bh=im6rTGdtAHVoo9gMGfLRhHqPzagovRFiPRrkny9SMiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aK1PfLxVNKN1Ua0nUF6yXjbvl3bTts6+0P3a7FwemeqYInCPOqLMe7egQMKlgbamx
	 jT0re+ddTMJQgS5KCw6K2n7fXjEhOQkpKKa9vlCB5ojDJv9D1C/L4BNg0PxsRo0xYK
	 Dyz35tJWDs3fL6E+r5qBynAYWCGKSBzddr0Yne+MK0e3sLlpkw3rimWL92hHjZNRWL
	 xiOGokhX5tSM0xxdKY3flR4dWii61ZPfK3Z1kGl/bteabDPKbZ/EVCdNm6UnzKpxbS
	 4FE2Y1Z9/W3Dg9aBlM6qa7swT/o+nmgD1SI6FKvAYOdgDqBBowaFng7Q1zXMc+DSBO
	 +S3hrb2+x56Nw==
Date: Tue, 20 Jan 2026 18:59:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Kari Argillander <kari.argillander@gmail.com>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] rust: pwm: Fix init error handling and tidy style
Message-ID: <6fwrwklfywcofk3pb7cn6fllk2ndekcrrfyifrb55u2dt4tzuw@zlpbxgs7lhak>
References: <20260102-pwm-rust-v2-0-2702ce57d571@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="muncmzujuwzhebe7"
Content-Disposition: inline
In-Reply-To: <20260102-pwm-rust-v2-0-2702ce57d571@gmail.com>
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7971-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[samsung.com,kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6DF464AABE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--muncmzujuwzhebe7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] rust: pwm: Fix init error handling and tidy style
MIME-Version: 1.0

On Fri, Jan 02, 2026 at 09:51:40AM +0200, Kari Argillander wrote:
> This series contains two small updates to the Rust PWM bindings.
>=20
> The first patch fixes a potential memory leak on an error path during PWM
> chip initialization. Someone needs to decide if this goes to stable.
>=20
> The second patch is just style-only cleanup.
>=20
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>

I applied these with Michal's Ack to
	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next
=2E

For now I don't intend to send the first patch to Linus for 6.19 and
queued both for the next merge window. Please convince me otherwise if
you think this to be wrong.

Best regards
Uwe

--muncmzujuwzhebe7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvwoQACgkQj4D7WH0S
/k6JswgAmWFOKTXa0Hy6P8v8S4w1IF6Y4/KJ5gc9noW2QnhlGY0DESZ2/1QOEbmt
02ZxTWc8NDukwoM+/b+hFa/RsrWYATA3yfbdLVd5/0MtQHcbHjCfmWfRGA+VnUou
rIrZzaF+Ocflpa7mzcVxQ/AdXuT2Dp7ggLM6AduDqy3ZeLzlUhhnLBoWQPioq9j2
5yU95K2nrzPaELGArWRRjwJYkAuLsCsIoTUvzwP5kY4PvQbG8pVmRpuoWq5Zol5O
whk4T7/i3H6Q2j6eYrVIORhPRePGiCSe+4Xarnl5J4nAGi2+OJ9By0h1WxrpInPF
ZxMmULoi7gSa2lCQ6Od5nTS/KRVLgg==
=mJu7
-----END PGP SIGNATURE-----

--muncmzujuwzhebe7--

