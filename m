Return-Path: <linux-pwm+bounces-8004-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGS4FhvoeWkF1AEAu9opvQ
	(envelope-from <linux-pwm+bounces-8004-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 11:42:35 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBDF9F9F7
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 11:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56B8E30082A0
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 10:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C52D5410;
	Wed, 28 Jan 2026 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8Rbfl6v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O77F5XTI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD929B78F
	for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596952; cv=none; b=gg9MmMbcJ+XYWgeCvd6EruW+WoOt/JjqLhUaSAWSp6HzdILUKKQulsXC5XWgwTRKYU6tSvHqI614bF6hOO9yftg4jayPlcZ7XQKOCHN2g8SKKhT6/r3WirxYveOFsGAnY/EkFabSdhbA56DXD8Ovl0tZiY7ycx81lnK2tUs6g6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596952; c=relaxed/simple;
	bh=apf4mXXoipjS56AP9r5S3+Twz60FbazGZRWn7KRqwHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWp7CEvu9R4evTrNkVcXsCfV6WfSmlbUe1xSjZ1QpT5HzmfdjtfJWfY+EMsGBH0nGb21SEgA/dKC+lrr5unB9RZNoZ6rQOJB7Eb4S6UcVJ0JUHmTxuWwiJbEPKPkOmoNCU/T71T1PTC6CZ9Abc6bAWSCV6SI5svJhyrvKiyGeGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8Rbfl6v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O77F5XTI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769596950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=apf4mXXoipjS56AP9r5S3+Twz60FbazGZRWn7KRqwHM=;
	b=J8Rbfl6vWSNuY7THsUuC60hpMh+UTX4uTkWXjsepSfjm3bHKCWWTzv/28j5/ycyYTupSKW
	E9cAfQ2kb1HLjgcCF+sH5xBr6V6kj7pVp8zNltIBSCR/0ziS4iWwFthNzxsg78m+SdE0b4
	uf/DizDHMUV9s0Y36AvmFcGltZGgKY4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-E8er6AeqOxuDMGnKjhAGCg-1; Wed, 28 Jan 2026 05:42:28 -0500
X-MC-Unique: E8er6AeqOxuDMGnKjhAGCg-1
X-Mimecast-MFC-AGG-ID: E8er6AeqOxuDMGnKjhAGCg_1769596946
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4803e8b6007so49212505e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 02:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769596946; x=1770201746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=apf4mXXoipjS56AP9r5S3+Twz60FbazGZRWn7KRqwHM=;
        b=O77F5XTI8sYyzpN/m35Axr3F3tCstgI9hYX8W/wM5MJ92N4/VcVM9m0vjeq+44jFPX
         jmdqXCBQ/eccT73HITfPPUDMcP55ZLgoc24NRuJIBR7lUHSf4jtfMIErinhjq8O2ksaG
         pBnSpCaHPQCEDDTKVaO20n91c/6CPwXvJ+90hfgAikfOQkfiH6vMsBVIp5f3HkvjWeCH
         0Gjrqf8GTlarUngr2hFexE62/ouLvclccC7aGKIo1WvKa25Y9wcYtyqD6o8DrQucgNv/
         cU3Gaok2cKBRswk2BSfU1Rw46IXnwSsrf7SAsC0XDzgLBMgIl3yJU9Zr9rNbQiHe5g+a
         Sgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769596946; x=1770201746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apf4mXXoipjS56AP9r5S3+Twz60FbazGZRWn7KRqwHM=;
        b=W28CDfDPkks3s7awZn+iqqjH5a4SOwOjQS/Z1mx3KbVz2t8l+lkAZlekMtZ3qPFKG6
         5Lc2LRWVP2aVEv5kiCk95b09Gzxx3MLnwCDsDamDZXOmXP6f54LN+9iTCbExPqCcuc/t
         BnZRPP1hFEpt1NSxjvdjdlzT4SHmv3XVSL2UH3ye3IpWz3gNNs0z9uVzaAxTT9cWBt4+
         FCzGQ6VaDJfMrek3ighmwHl73101x9bvyMAialRUdVgOnMeznWeYaBC8PhW7/zxr7ejR
         X3XZmnCU3KAAASCTBuCd2JUSMiaP0OxW9hMVm9UILK+iMf36zvcwsiFcBCTBs4ZYaRJc
         cZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW7ER9vJ+w8qgADcQ+VY15orqL8BgqMDTiw+pHPptooyCTpHqeAgnCdwy8IicZ2tl3c/d3Pl0z3Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9iwMqfukMO9vrRD5DXGFco/ynX8qi8EzKF1HlYdVKSNEuni9L
	ltMo3mvTGJ/QwdmmKcnFb5u8SnerBuTfoeD/nUCaJ+wnBH65fq3wG+wHdpYL3pJrN2DNp2aqsAe
	wzu3PJgdB0pc+pJG8bkY4tsZYgj+RFgcF6rOAJ6ieoRJC2CSh6g7lMM7a+ualPQ==
X-Gm-Gg: AZuq6aKIWsdhpiSGAigYbCBZxnZZMABRtRLrF/+cxu83po+nLEs3M5evmZ3suO9ue0t
	fu08dGBduqeBuefShFUjb/ORtMy4KIhKOMjP4fDywm9DJJi5Lurf08xQOKOFSq5S5+gSlvOP89f
	FzI+vsxA1LKhuGlYFuO0Tr0AL3HzydwRQAU30A+MM23nRojEHT3YBPs155DaYglZyPv6HkVoMTQ
	sUtDdH2ZA38HlIsugfhJrtKppRTv7ZIHJ608MAwKaw699hSngFiq6WkgI1qBb0n63ljimYF6Y5M
	wK96b48LyhVQUAsoZcoSifrSaCcletEha8kCbRJvY0YYlZDedVCo0nKrcvzi0A==
X-Received: by 2002:a05:600c:871a:b0:47d:8479:78d5 with SMTP id 5b1f17b1804b1-4806c00bf4bmr47198635e9.7.1769596946168;
        Wed, 28 Jan 2026 02:42:26 -0800 (PST)
X-Received: by 2002:a05:600c:871a:b0:47d:8479:78d5 with SMTP id 5b1f17b1804b1-4806c00bf4bmr47198185e9.7.1769596945495;
        Wed, 28 Jan 2026 02:42:25 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cd8fadfsm51703425e9.0.2026.01.28.02.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:42:24 -0800 (PST)
Date: Wed, 28 Jan 2026 11:42:24 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Richard Genoud <richard.genoud@bootlin.com>
Subject: Re: [GIT PULL] pwm: Two fixes and a maintainer update
Message-ID: <20260128-splendid-complex-mouflon-8f3dff@houat>
References: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
 <CAHk-=wga8Qu0-OSE9VZbviq9GuqwhPhLUXeAt-S7_9+fMCLkKg@mail.gmail.com>
 <20260122-bold-sticky-wapiti-1dffa2@houat>
 <CAHk-=wheQNiW_WtHGO7bKkT7Uib-p+ai2JP9M+z+FYcZ6CAxYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="feuizyhgjj4dalgk"
Content-Disposition: inline
In-Reply-To: <CAHk-=wheQNiW_WtHGO7bKkT7Uib-p+ai2JP9M+z+FYcZ6CAxYA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8004-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mripard@redhat.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCBDF9F9F7
X-Rspamd-Action: no action


--feuizyhgjj4dalgk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GIT PULL] pwm: Two fixes and a maintainer update
MIME-Version: 1.0

Hi,

On Thu, Jan 22, 2026 at 10:07:56AM -0800, Linus Torvalds wrote:
> On Thu, 22 Jan 2026 at 06:39, Maxime Ripard <mripard@redhat.com> wrote:
> >
> > >
> > > Obviously some changes are more likely to be user-visible than others,
> > > so people should take that into account in how careful you need to be
> > > about a patch.
> >
> > Where do we draw the line then, if there's any?
>=20
> Users complaining is the only real line in the end.
>=20
> So something like a test-suite complaining is then often a *very* good
> indication that maybe users will hit some problem, and test suite
> issues should be taken very seriously just because they might be the
> first sign of upcoming trouble, and the earlier something is caught
> and fixed, the easier it's going to be.
>=20
> But a test-suite error isn't necessarily where you have to draw the
> line - it's a big red flag, but it *could* be something like "the
> error checking was done in a different order, and the error number
> changed in some situations, but it doesn't actually change behavior
> except for the error message that is printed".
>=20
> So then a test suite failure is a "let's ignore it, but keep an eye on
> it in case some program really did care about that *particular* error
> number".
>=20
> But a user complaining should basically result in an immediate fix -
> possibly a "revert and rethink".
>=20
> So a user complaining about some kernel change breaking their flow is
> when you don't even start arguing. The issue is over and done, and the
> change needs to be undone.
>=20
> There are _very_ few exceptions to that rule, the main one being "the
> problem was a fundamental huge and gaping security issue and we *had*
> to make that change, and we couldn't even make your limited use-case
> just continue to work".
>=20
> The other exception is "the problem was reported years after it was
> introduced, and now most people rely on the new behavior".
>=20
> But starting to argue about users reporting breaking changes is
> basically the final line for me. I have a couple of people that I have
> in my spam block-list and refuse to have anything to do with, and they
> have generally been about exactly that.
>=20
> Note how it's not about making mistakes and _causing_ the regression.
> That's normal. That's development. But then arguing about it is a
> no-no.
>=20
> So in the kernel tree, we don't argue about regressions. We fix them.
> That's basically the only really hard rule I have.
>=20
> Almost everything else is "just explain it, we have various rules for
> development, but rules are meant to be broken". Not the user-reported
> regression one.
>
> > Should we just consider those drivers "wrong", treat it as a bugfix, and
> > expect userspace applications to request the format they actually rely
> > on? Or should we continue what we've tried to do and try to support the
> > right format, and the old format for backward compatibility?
>=20
> If it used to work, and people relied on it, you add a new "right"
> format, and keep the old one around. Possibly with some hack to only
> affect some particular special case, with the hope that the special
> case and hack can be removed.
>=20
> Now, if it's one or two users and you can just get them to recompile,
> that's one thing. Niche hardware and odd use-cases can sometimes be
> solved that way, and regressions can sometimes be fixed by handholding
> every single reporter if the reporter is willing and able to change
> his or her workflow.
>=20
> But the basic rule is: be so good about backwards compatibility that
> users never have to worry about upgrading. They should absolutely feel
> confident that any kernel-reported problem will either be solved, or
> have an easy solution that is appropriate for *them* (ie a
> non-technical user shouldn't be expected to be able to do a lot).
>=20
> Because the last thing we want is people holding back from trying new
> kernels.

Ack, thanks a lot for your answer. We'll keep working on
backward-compatible version then :)

Maxime

--feuizyhgjj4dalgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaXnoCwAKCRAnX84Zoj2+
dgWpAX4qRYZrIRntzPOrPSpAw7kAd/ZPYumEXm6uqC5hdPmy/O/Kh5wKnocu5aVV
TG8AL5oBfR1DX7rI0Hp9bUCb5ckCVjTV6Veup+ifBDa+ZrNV2jmqssNd42SyP+Yq
TSB4QDDyEg==
=j21N
-----END PGP SIGNATURE-----

--feuizyhgjj4dalgk--


