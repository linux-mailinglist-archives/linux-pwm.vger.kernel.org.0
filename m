Return-Path: <linux-pwm+bounces-8401-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NOwJ5nWyGm4rQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8401-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2026 09:36:57 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02429351214
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2026 09:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 005AE3028B18
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2026 07:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F452D5A01;
	Sun, 29 Mar 2026 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WCULEEZw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030C2765ED
	for <linux-pwm@vger.kernel.org>; Sun, 29 Mar 2026 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774769795; cv=none; b=dPfViR+bgi/wAHhesZC8q1Xayu4YafpQReWbtWZavRc6Q/5SCb4OpH+kXx+ax/5QQcNaseNo+ldl4TaZqnI4lpyNN7GqzkYmwVs6tiJQhhA9b18kTclpZKRppbrN1dvqQuB/2QIphTM9l6mbkhJAGXv1lUd8C+kdnkigq2Msm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774769795; c=relaxed/simple;
	bh=YGQAEjmAzZmM43FCjwJ92AtwcCRmR31MyKsLDZHjdfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufB5IxpZpG6ZgWOtX2fXq2x0WO4TjTVbERi7VQZLNGg9CxPPo9jfLqZzldaS6+9XJLOylK18TvlZcqZ8/FAiWzM9RcecnxE6TABgk6jgl2pTALqvY1knB6u7TfYMAxS9TVzNCpAmJIiPeAWIk/gMZQ+gxXtYoiMK7ac2d7ltbJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WCULEEZw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486b96760easo38066655e9.2
        for <linux-pwm@vger.kernel.org>; Sun, 29 Mar 2026 00:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774769792; x=1775374592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGQAEjmAzZmM43FCjwJ92AtwcCRmR31MyKsLDZHjdfE=;
        b=WCULEEZw/Q+x/gorA7XZF9o6umSdxkXcQvzEq4euXgZ4lpCiLXtYRXLJXpCKO4phpP
         UFgs+NyEgyFqHzey92FGMhHFqc6OybgfYWzQ63CjNrfQecEmBQwk2rq9dA3jARGiWIhh
         qpIgV8nkplBMtFF/DieZEY3U0OmaQu33YRy5PM9fw2I58+B2aXGUJ80pqHmdqcHxz/eX
         wf4nZJOQea4JOUpnEzmwNkBskxut4HkozSNf2K51TXA9uB8xX8PHHrvHnpu+HcJ6SZpU
         OBQxj0+vGTQdlv/ns3zxP26dPaN5a4GVH8x2lfwT4zxkjNH1p0OT1z3RQjXfPfCm3/lv
         Bq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774769792; x=1775374592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGQAEjmAzZmM43FCjwJ92AtwcCRmR31MyKsLDZHjdfE=;
        b=fw4ifme/46CbVkkHBo10L58ZsX/k0PTzvdmIrYoIw3DHPr49/6i0skobcZWUKXCoHM
         19XMXMnzoqwKtneyTa7LCdEZvWcrjr0QJLgIPCtxB9D+CEqD+HJ3rS/gqlawdi17+osn
         Nh4xCSFKFajvEmKUEDVXk3JbOE/j9KXjOtOF+j9C3CXl4LX3qkFzjZC8ynazntbKmREq
         edgdL1PgdoE1F48Rq4D1FP+Y6eplfJBUvoHNkwnNfuX0subTjDW5Tisaj2pkLkIQ0vLY
         sOMbCJxKrC7x6MrsNQT2b0Bz+Lclg0B4NpTiyu1bR/DTdmCefqr78/UEvOtCrlIBTt88
         zp1w==
X-Forwarded-Encrypted: i=1; AJvYcCVQIH75n1ra8v2GVs4S9OoNOeqxLID3rk2JMOYu4isEBMM3jLU0PlTGHTQmPEyuS+xwvliCjPwRbBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcbF82I6aTP5E5hAphdyFXiZofgg/80j9M0qTFEiaaEgxHHJ6O
	DkOWGevqjWLIhznh4igw89l97grr5dFvBzaSN8exzs+fN8y/qiWqPuZcWpP6L3pY4oI=
X-Gm-Gg: ATEYQzykLlBY1Gvydq4isRddGnv7W0sqU0BGYwFsYOQY5KOmUtgKkzBV9LUITcH+Udm
	33LT6saIftTu8gVZQI/k6VulIddH7D+Sf+XsUTVn+K0c5gDjogd+XUCO6BioOyBSpHrpwRretOH
	bvotL01p6NY1lxUr/ikAwNrQe6iMDsOhKiCu3tRiKfpruc4+nmZgG5CgF/E3PvclkX/jXqcWH7b
	r4b3ChKx7QUA3dXn2O7FCduidUlQ+XwiSIbMRjSvGUAchqiA9SjGHjpMTX1x2aO6nrxfb+vQWmL
	wzLLLtXE4l4olCcxEh0nv9OfyzqwKJW5UAPdL5PTH2v2fvA3e3vUYSLZopZZHbE1CAB0TxwtxCh
	Xm6Iu4SbpAiYC89Um/MDc+g6onSCtMRd3omnd9FZBDeMlEegKyUKaELs1TgpJiY8rAvel40Zrs8
	oYB4l7/CoRUeRX6kJOCn2qDyqLSfbb
X-Received: by 2002:a05:600c:1f13:b0:487:169:9f64 with SMTP id 5b1f17b1804b1-48727d73709mr136213455e9.12.1774769791514;
        Sun, 29 Mar 2026 00:36:31 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48725fc4827sm50781685e9.11.2026.03.29.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:36:30 -0700 (PDT)
Date: Sun, 29 Mar 2026 09:36:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	rust-for-linux@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: th1520: fix `CLIPPY=1` warning
Message-ID: <acjVGgDLnYAg1UAc@monoceros>
References: <20260121183719.71659-1-ojeda@kernel.org>
 <aYmgjEWaLrdsubKM@monoceros>
 <CANiq72kk_UJVNbQ3aKuV4_LPFm-a0xjZqZyk57ZpkHp8yX8jzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v5mkeeaofiokcizu"
Content-Disposition: inline
In-Reply-To: <CANiq72kk_UJVNbQ3aKuV4_LPFm-a0xjZqZyk57ZpkHp8yX8jzQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-8401-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,redhat.com,lists.infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.961];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ozlabs.org:url]
X-Rspamd-Queue-Id: 02429351214
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--v5mkeeaofiokcizu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: th1520: fix `CLIPPY=1` warning
MIME-Version: 1.0

On Sat, Mar 28, 2026 at 02:53:17PM +0100, Miguel Ojeda wrote:
> On Mon, Feb 9, 2026 at 9:56=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > Looks good to me. I'll wait for Michal to add his blessing and then when
> > picking it up tend to drop the Fixes line. Or do we also care about
> > CLIPPY-cleanness in stable?
>=20
> Do you plan on picking this one up? Michal already reviewed it.

Hmm, I guess I missed that because that patch isn't on patchwork. I
don't even find it in the list of patches that don't require action.
(e.g.
https://patchwork.ozlabs.org/project/linux-pwm/list/?submitter=3D83457&stat=
e=3D%2A&archive=3Dboth,
or
https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D&submitter=3D=
&state=3D*&q=3DCLIPPY%3D1&archive=3Dboth&delegate=3D
)

Applied with s/arithmatic/arithmetic/ in the commit log to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
now.

Sorry for the delay
Uwe

--v5mkeeaofiokcizu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnI1noACgkQj4D7WH0S
/k5Flwf+KzKsAaEdMl6wSc4xOfiDF7nzYo0AsBFHTxGvoBdXye3ZU33stEw3kA3L
Ugumdo7+UHnF+8b/QzgIXeLtcYyHxgPN52c7nxxsXInEd0L5w//y/W2WdSQ6HbJu
icpbYEBGCM0GvLemMP8P42cnchR7+5a6G5fbRqygGXgJn+8Zlyf/jzWaZYmPAEvW
gZ47q1NgiKby1TaIKgnEPKe5Gqa98+zOxQF908RJ2/43/TPFFsVIfP4koBGqEd17
64ocAOTcKSQokKnMN68C5BZGaO7eZufI/IvunxoHu8R1oRC3iJU4zxrVOMX3vt37
lZN8EC7XTOHJ5xkFaPi0T2XNqeVFtg==
=5n6k
-----END PGP SIGNATURE-----

--v5mkeeaofiokcizu--

