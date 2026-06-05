Return-Path: <linux-pwm+bounces-9265-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2zdTJAS+ImoQdAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9265-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 14:16:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 027BC64801F
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 14:16:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hB+BrAF3;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9265-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9265-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9292302B3B5
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2026 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09864D9918;
	Fri,  5 Jun 2026 12:08:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF62C1595;
	Fri,  5 Jun 2026 12:08:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661283; cv=none; b=b1JHKIBR4wSPMrBBlsuqPLd0hrjgjeG0fSg9pcF0J319kPRfCMKQojXxP5lrd8OdRqhZqlZRpJo7voglwveaR6aK0DLh0T06ckwqcA8/dgNDDTTtUVqnXbGmo7zlrITgY5m4j6KFvEEBNq5B2socjk5UqD6FHqZbrBLFKvYbBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661283; c=relaxed/simple;
	bh=87M3kBakEBJVQQ4M0v2n+8FD2QjfthNbE3uBbHgwWWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYFSpJGmkAu35o4ri/JpAaePfx5dQgYmVOwdc2mnTN/Kztc9r48RawalYGSL5vOy+paP4gEHzemV1CJO3+GvaL71Hozt3wBf+JITrc5cLsyAcG/bfTqNKk9OR1FcMjbxSF1eBrbHY1oRHvugJfRSgIQEve+0LpVFbqkWl3aHDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB+BrAF3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 592CE1F00893;
	Fri,  5 Jun 2026 12:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661282;
	bh=87M3kBakEBJVQQ4M0v2n+8FD2QjfthNbE3uBbHgwWWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hB+BrAF3+R5c1NEuBb/NrRCTTQsVA3PghmjDLi3rsyIajeXQ48OUQkTQ2+1B/Td67
	 DichNuHaIDLGezakbz2Yg7EF6VcfOAXNOJuPATAZXJ4LAb1QBFbgIJy/Pe7h3N5Uca
	 Rm7Aj80rYylraNt4JOldab5Hzj/EyGjKcLE3HDpX/m2Nusowv4XOu6HxNBSErg7FXm
	 pSoH9O3BxMadxmu/+5ujbjhszft7bKRzAMq4UyovFbh+dMgYKEZMfax6wdimh7xuhL
	 tlid06yV591Bn/P/jhthHwhpbvJVqrWk/xQnVT/aAO1U7+THXg5tybthh/aCB6c8cR
	 dDDqbtbeyMHHA==
Date: Fri, 5 Jun 2026 14:07:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] pwm: th1520: Remove requirement for
 mul_u64_u64_div_u64_roundup
Message-ID: <aiK7i_bblFzHDiH2@monoceros>
References: <20260605-pwm-th1520-fix-v2-1-5921e3a595f7@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gqwi5irkxvviovzj"
Content-Disposition: inline
In-Reply-To: <20260605-pwm-th1520-fix-v2-1-5921e3a595f7@mailbox.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9265-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:mhi@mailbox.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,samsung.com,garyguo.net,protonmail.com,google.com,umich.edu,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 027BC64801F


--gqwi5irkxvviovzj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: th1520: Remove requirement for
 mul_u64_u64_div_u64_roundup
MIME-Version: 1.0

Hello,

On Fri, Jun 05, 2026 at 09:03:59AM +0200, Maurice Hieronymus wrote:
> The cycle register is always u32, so cycles_to_ns() can take a u32
> instead of a u64. With that narrowing, cycles * NSEC_PER_SEC is at most
> u32::MAX * 1e9 (~4.3e18), which fits in u64 without overflow. The
> saturating arithmetic is therefore no longer needed, and the ceiling
> division can use Rust's u64::div_ceil() directly instead of the
> open-coded numerator/denominator form.
>=20
> This also drops the TODO referring to a future
> mul_u64_u64_div_u64_roundup kernel helper, which is no longer required.
>=20
> Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Thanks
Uwe

--gqwi5irkxvviovzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoivBsACgkQj4D7WH0S
/k7R6wgAuMzZA+55AkXQeRINO6VINuOHL8cJptc2DiHB8jHkCpe/lCHO6md0D9SA
0WQQrBea3pb9DGRf1z0u8iWJpaMzFL0tg3SCUyM1MjHnr9uj37y7O+37ahRiWogT
ovotIzIy3UAZdUel9DA+9yxbooZ6JpkvH77chf9rYYIwtmtorfa1/LSKKryueJ7i
46K3fN5hYuGbkV/QnHLtt6AqEtPv1Hvo5RuZC4ynvE0aIN68NVcvLnahDqGwaRcg
2Dcwq3dOWNzxAuylmH7fa0oR5ur/O5YydLDELBX8++m2Zm4+9I1codmLjeYkF0tX
PHV64hYGR7riLxW3UnGBGX6WFD6fnA==
=lOKo
-----END PGP SIGNATURE-----

--gqwi5irkxvviovzj--

