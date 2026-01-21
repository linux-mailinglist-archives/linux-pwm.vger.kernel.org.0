Return-Path: <linux-pwm+bounces-7985-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIZbG5W1cGndZAAAu9opvQ
	(envelope-from <linux-pwm+bounces-7985-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 12:16:37 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D51755DB8
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 12:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CAF6688301
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0268947ECCB;
	Wed, 21 Jan 2026 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtaVkvCU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DEE47D92D;
	Wed, 21 Jan 2026 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993558; cv=none; b=WiLFqx5EWYak2Ku3oRcua8Yh2XkR4x5IfRhHkV99Yg7MrwL4n2h5tauGpp3RDR21ahJCD8nvHGXmOw/5NFutAZgVimFjgofvd15Ht6NKWbsttJWOQSR9ZWqI36R3rGUADZ7C2M75yMcI1Y97M4+C65bHufOHiyRdxS/80y61Aks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993558; c=relaxed/simple;
	bh=OSBeBnGHkX8xyHUtAxcxKCNGZMo/j2CMejwl6KhZ23w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjCmiJNQCpxcWQYtZI7GU0qr0mzsxHoKk9drKwtFNxc+0TYRFdMJL3zlKQMQOx3PCf5Qyl2h0eqNjYmar+/O/7cJ6Saeb1UxvsIHKLAVnyHd2wop0aIvTm1n/wblJ80qPRaq/oI1M6XHzJIZk0/ljDxzkhBflrgLsu3F0oUUn8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtaVkvCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1613C116D0;
	Wed, 21 Jan 2026 11:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768993558;
	bh=OSBeBnGHkX8xyHUtAxcxKCNGZMo/j2CMejwl6KhZ23w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HtaVkvCUkTJnXsfAIybqc+b/a3zDn4yIkCyeK9ytM0M8Tg0vTUCSFP0EkDHoVy/7/
	 Hm5v8hDwkb3XkdYa4WpG+SCkOtBPiSuqG+1VAlfRLWESP8hWSOSt8FidC3JdxahHRU
	 yzXeP0ixTB44o4Hm0hjBwdiblq98fBl5aIVjdnMJtqPpaFEJBZawJnxfgdLxLXzt8w
	 oPYB2Zah2d7JszhNGOx2ognrzb7m90iMMa/2nBvcPFtTizAH9AIEiBVHsx+lkDcitF
	 PuB6sCPoMoUTyHtjRHvZB6lL8DIJW9Nv3rAruqI8zdHw4PM/fSOY7/Ah8WSw+QuZcE
	 4inyE8zHQfnbw==
Date: Wed, 21 Jan 2026 12:05:55 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
Message-ID: <jmdkabxocbq7grui7qvepuymmrygmfps3pcb65wxflnbo75whc@dtvypglu7o4m>
References: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>
 <o4uvwymm73wnehs5zb7lqgv3mjv235jpprfqrsb6oxscxhmmjh@25u7wrb7yo2i>
 <CAJ-ks9=USrGECVS1qMqs+iCKUqvOdfcjA6phAjaF0wfcTkQt_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gkkdphhfqabbpivp"
Content-Disposition: inline
In-Reply-To: <CAJ-ks9=USrGECVS1qMqs+iCKUqvOdfcjA6phAjaF0wfcTkQt_g@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-7985-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,lists.infradead.org,vger.kernel.org,samsung.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4D51755DB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--gkkdphhfqabbpivp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
MIME-Version: 1.0

On Tue, Jan 20, 2026 at 11:15:56AM -0500, Tamir Duberstein wrote:
> On Tue, Jan 20, 2026 at 3:39=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@k=
ernel.org> wrote:
> > (Side note, b4 told me:
> >
> >           =E2=9C=97 No key: openssh/tamird@gmail.com
> >
> > . It's not clear to me how to verify this signature. My experiments
> > include:
> >
> >         $ b4 kr --show-keys 20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.c=
om
> >         ---
> >         No keys found in the thread.
> >
> > and looking at
> > https://lore.kernel.org/linux-pwm/20251222-cstr-pwm-v1-1-e8916d976f8d@g=
mail.com/raw
> > where I see
> >
> >         X-Developer-Key: i=3Dtamird@gmail.com; a=3Dopenssh; fpr=3DSHA25=
6:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc
> >
> > which IIUC isn't enough to verify the next mail signed with the same
> > key. Am I missing something? I very appreciate signing your work, but if
> > there is no way for me (or anyone else) to verify it, there is no gain.)
>=20
> Yep, you are right to call this out. My usual setup uses SSH keys for
> commit signing, which are not part of the kernel web of trust. I
> promise to start signing kernel work with my GPG key soon :)

While I notice that the trend goes to using ssh-keys, I still prefer
OpenPGP. So +1 on your plan.
=20
> In the meantime if you trust Github you can verify my signature
> against https://github.com/tamird.keys.

OK, for the record:

	$ curl --create-dirs -o ~/.local/share/b4/keyring/openssh/gmail.com/tamird=
/default https://github.com/tamird.keys

makes `b4 am
CAJ-ks9=3DUSrGECVS1qMqs+iCKUqvOdfcjA6phAjaF0wfcTkQt_g@mail.gmail.com`
emit:

	  =E2=9C=93 Signed: openssh/tamird@gmail.com (From: tamird@kernel.org)

This looks a bit strange (because there is gmail and kernel.org), but
better than before.

Best regards
Uwe

--gkkdphhfqabbpivp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlwsxEACgkQj4D7WH0S
/k6vvwf9E8mLZeboBuVh8CdCIfb5AMi5+tIcVmJ5hPOx4Tr+sZI9ATfYiWXV75oI
UGyBCcZm2n05j1KHBmZpKANCtBTPxFIRW/H5nViualdUjNSTUerWw7s5SK3NcQTt
JSEGjjTK4/JpX0kTO4dUGs57xkegcr300fp4nAJqUdaJx+QhlWw3uIl5GbabrAYs
120Zd3xFlPjIh2TksByMeh1R55sRhv6vQi/r5Isen7CYqMK7pFS2h5DLZvSibldm
JscOK/sTW2ZcV0o6v/ElFRH4noxet9qskBNhoUfrZurdXGwjHnzrgnBXt2oruaTU
OSGhDhKnShDIu6kc1t05ZH8agT9JSw==
=L/eL
-----END PGP SIGNATURE-----

--gkkdphhfqabbpivp--

