Return-Path: <linux-pwm+bounces-9219-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFTGAVWCHmo3kAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9219-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 02 Jun 2026 09:12:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C53D2629656
	for <lists+linux-pwm@lfdr.de>; Tue, 02 Jun 2026 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A83723015A57
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2026 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363835674B;
	Tue,  2 Jun 2026 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="IqJLEOjs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB233B6FB;
	Tue,  2 Jun 2026 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384335; cv=none; b=GtLSrNMSyjgfNBBFmcBFxCRcmkNVsMNmaaYEIfY/Ge7kSONpGLx7J+RrUhpA423u+vT0q2mvRKfJ262nsQlYWeMaDUCceCOrV6dXnsKAwAE2vI9JPO9uugOiishPDwQXLsNw6CtVTeZMq8TmoJlR1BrPSG+BLcKnWuiRtYafMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384335; c=relaxed/simple;
	bh=P8lh701jT9yZmofB7hy7w97sJuyJLPaeQffJywe9s6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YraVl6ZvIv5GX+eLeMjC3N6K/18cFKV4j4E+iMrNf5kE6BDBr2fBMMVRa6O/iOFTQWO+Tg5J9v4F0EvPIaWYS7+G+RU/PoEXAwjrmLX5I90R9nOMFIgDtCCQLksn7CMFvnVgPa9PWgnupXuXfB2Gu656HbNVF1Pk8j/V3sOw1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=privacyrequired.com; spf=pass smtp.mailfrom=privacyrequired.com; dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b=IqJLEOjs; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=privacyrequired.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=privacyrequired.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
	s=stigmate; t=1780383886;
	bh=z0jmVNzZvirhy3R+tfL9bbf+f442BGqrfXEemWbJb9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqJLEOjsiXnW2zkyrLbvMKHHaE0+D1wVk7aSiasGfF/mxbTdcO7MkQOF29YeIXIYn
	 ysy7JJ2gNSdc/DlQWj01fd0WscuyrwtVkAfJjs8sD6/TYVJQhhJgEWoJ4UZix4hK3g
	 3uhawK0I8knHFo1iiTEdOU0D4ZdoCtYCXi9QLzNw=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gV1zf2bk4z11HB;
	Tue, 02 Jun 2026 07:04:46 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gV1zd112Nz11H5;
	Tue, 02 Jun 2026 07:04:45 +0000 (UTC)
From: Francis Laniel <laniel_francis@privacyrequired.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Boqun Feng <boqun@kernel.org>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v1] rust: pwm: use pin_init::zeroed() to initialize pwm_ops
Date: Tue, 02 Jun 2026 10:04:43 +0300
Message-ID: <2833204.mvXUDI8C0e@pmachine>
In-Reply-To:
 <CANiq72=DK_qr96K7V=akgHqm0z4msymJ+VRxY0f1uqmyDmbZkw@mail.gmail.com>
References:
 <20260529153821.126823-1-laniel_francis@privacyrequired.com>
 <CANiq72=DK_qr96K7V=akgHqm0z4msymJ+VRxY0f1uqmyDmbZkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[privacyrequired.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[privacyrequired.com:s=stigmate];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9219-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[samsung.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laniel_francis@privacyrequired.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[privacyrequired.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,privacyrequired.com:email,privacyrequired.com:dkim]
X-Rspamd-Queue-Id: C53D2629656
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Le vendredi 29 mai 2026, 19:45:06 heure d=E2=80=99=C3=A9t=C3=A9 d=E2=80=99E=
urope de l=E2=80=99Est Miguel Ojeda a=20
=C3=A9crit :
> On Fri, May 29, 2026 at 5:48=E2=80=AFPM Francis Laniel
>=20
> <laniel_francis@privacyrequired.com> wrote:
> > Replace unsafe block containing core::mem::zeroed by calling
> > pin_init::zeroed().
> > This is safer, as this function is guarded by trait contrary to
> > core::mem:zeroed().
>=20
> It is definitely safer, but it is actually fully safe, i.e. it is a
> safe `const fn` after all, which is great. I would say removing
> `unsafe` code is the justification, even if of course the function is
> able to be safe thanks to implementing the trait only for certain
> types. (Also missing `:`).
>=20
> I would suggest reusing Benno's commit message from the series he
> links in the issue instead, e.g.
>=20
>   https://lore.kernel.org/all/20250814093046.2071971-8-lossin@kernel.org/
>=20
> > Link: https://github.com/Rust-for-Linux/linux/issues/1189
>=20
> Please use Suggested-by like the issue mentions :)
>=20
> Suggested-by: Benno Lossin <lossin@kernel.org>

I read the issue too fast! I will send a v2 with the corresponding tags and=
=20
new commit message! Thank you for your suggestions!

> Thanks!
>=20
> Cheers,
> Miguel

Best regards,



