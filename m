Return-Path: <linux-pwm+bounces-8419-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABc6DpFRymnO7gUAu9opvQ
	(envelope-from <linux-pwm+bounces-8419-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 12:33:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1E5359627
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 12:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27DCE301D6C9
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 10:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28553BA240;
	Mon, 30 Mar 2026 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sak1P2kU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CC274B46
	for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866465; cv=pass; b=Ay9BCiwVByzqzA9kBwo/a8HhbDOinQA6DB26VerLVExCnWyl4p4GyYCQ953VuWKerJDULA7UHdM1PmX/1kMYRWp+HdZlFr8CmxoqB1ahPjwMzUjl4GQRLpVxlGc+6tkr4R5ifYQeavPac8NSY4Q0wBg5U8kcAF+oMsJKfybUV1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866465; c=relaxed/simple;
	bh=d9y55bKppxCwu8kQEd9JuS1z3KUYYcK2BoJdPrGox3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAB6CbkMbi7yyX2bkkJKAy2CJIgd+4asSVICpXJ5VlN3Prj4DOzlBsIuUGvTCniX1ZK7Nx9m00HQDvzgIr4qlHyROr+8f9ayOGaLOcNVwB9rSipcXYcOXdKrMAILwqtc9m8AXPbRIEXaDJ/pZAisRHFu1JiZncJFITDcOh3jUA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sak1P2kU; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-124b07e5fe4so142961c88.3
        for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 03:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774866464; cv=none;
        d=google.com; s=arc-20240605;
        b=hPZheOM1xQK7Nmym8BwnrDkXnYGtLoY/19gSK71PZVfdc9GTqsamV2mZ5AwcM1FdnE
         EBNQfrQy+aX5TiiOrHiaCcHNKoINPRoyNP6hs8O0eQfEjosYz2246IF6HhRlJPzqTHwF
         IVoheBxHCjJJlYQc4I1ldNoGdF6itQgSIlY14IsrkRyf2WbN7TP2et/5D5UhRZDK2Al4
         UAauNiTp9HXKiHwVoJ4g4rOdtOct0zBtGnxOgHcHoUIojuDD8O++v6hvCz/RctlXxWwc
         X5HS/I3ZYpUxyJf6A7vJAq1XWwCG9ztJxRSMJ5VJ76pV/hWoHKvGTH1WNppCle0akWlr
         bsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d9y55bKppxCwu8kQEd9JuS1z3KUYYcK2BoJdPrGox3E=;
        fh=W96f88bCRalj1NzvKmn7bgB37tyAYPMKnXeMY50aPe8=;
        b=k3s0QDs4LmCWk6hKKCp+PtTyWLX0vFhHyyQGOwd30V2ndfPEE2LI5HnbdE9/aLfB6m
         saWalahtf1XrZZXDahyTp/pW0bzdF8ckwpAzGBewCStZpxe04uqfSxSW9vHH7sPgTgHU
         JtSUXSb7AkEmT1PqDmhiVvsjrDHgj/j+j51XkZVh88EgdDuVFaasivqyC62y+2n++Rj6
         jPkXfRZnzPQErDsCMmay9SqAEQrv3wSwis0XH9VrMjCnATpBuzXILCfH04ia3OXMiMgZ
         lNUb6V7DnCUIDvXBT97gDHZX2MHomr10pzFy0NabIjntYr87bVlILNSRSCnEcT2pnZC7
         XwmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774866464; x=1775471264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9y55bKppxCwu8kQEd9JuS1z3KUYYcK2BoJdPrGox3E=;
        b=Sak1P2kUGPLJ+21jHok2OEvJKwsqygZFcoRoNDqjwKyu2I5I+z9Nrx2jqFrXyx4J74
         Qxtwh5n8S61HpPbGorLzdfZzH776mp21LsQNRJUYE3PlhxjoJu1xfi/c5F7eEbTU0/0d
         oygWt6qGvliVrAe6U219gLY9yBHsLq9Z3EGnfae/MXyzvBjSG1F/5+oFg1PawnrxzzIo
         j5skVCFiPM8x9aM89S4tBUSU0rtR2s/35ShIQlxIb6mc8gEGrlHWoOopMpZzIV2VhsvQ
         yVWT6p0W8i2dTg0zjY1Xc6vV7qYFAfigtaIltCdBezOr9iadgWS97kEc4fcB3rscOTZV
         YjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774866464; x=1775471264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9y55bKppxCwu8kQEd9JuS1z3KUYYcK2BoJdPrGox3E=;
        b=oH3ZOmHFNAEg9m0tJoobBdqK7/3VbGnO05N3pWFirTKJkgdTm4rsMMNP2DWJMg3bib
         82SQPI5Dj9/nCfrc+9tdKqTbCDh20zNu9R2WSh87OwbmvI8VdNFRjCXYFtqX+yrzonzx
         48YO0UQVKTUGoAvWKkPNia3xalbau5Lppis8OSo1Hxx80cZc6kyOQNRYS8WqB0fT2gaz
         Itm86XxFV8JFYBs+45EG6QGr7S5w5TIK9TUy2CrhbNcLyuzu41kNqV4++ZPIUqY8podM
         174mSSmruemcdAxYBc2o/dAJZLJQXNRT8yNhtqxWA+C5fZ6EBqHTPlz0IgLsRvkos6M/
         5NCA==
X-Forwarded-Encrypted: i=1; AJvYcCVcfop2JiduqzGhxNJTG8wFrJho/PJ8pg5o92P2wtpds8xdo6xacFTnRSVZh2aVR4bagzN/i84+qdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEAz+9HqlV4bIxNUiu9zNH40lm5vfV53vDzWZzGIYrY/xctaU
	1ovfJSuIiQ2COQ1CuY6lKlTgB/85smqOQch6I/i8H4t1cYPNa4jzWcTvPgY+VpLgWJxg4S3S9KA
	+Os6wyyrSnuc8s9A/dQM8Y3OJ/SdjUfo=
X-Gm-Gg: ATEYQzxVkIv+2qLJpjy7fmdRNA1iGVydntLePQVFkUgb+Ng+4l1iot/7zERGO/TacjW
	FlBC9vT+LJdrRpP/0oGFlNv+7GWT6cgFtUn6NGZMkgMjAEY9Vsf1UdNgk6UBLXcQl5MgA1wzMS6
	dvL9R1IVi6gUp/VlL3yJpg+odalPjvdWhUq4G+Uzzc/+GkmiBlgMrS9G2RlXe6EgFaDnQXAuezD
	iu1ssZhjy1rNcDpzhXBMHZsLS00Ky4Dj3snNMH9mL7gjVVQbcB9pHfgheRDjBox28Ah40sDS96e
	BxHL0gAbrnG67aovbePDYi9sHf+HSx9rCgqjNb6tpcaT1IWXJ4SoP04XyktmF4TxDdPinY78xqN
	znTOifFOxGgSE4GcriNOJL2w=
X-Received: by 2002:a05:7300:f794:b0:2c5:704f:7157 with SMTP id
 5a478bee46e88-2c5704f7c1amr684174eec.2.1774866463645; Mon, 30 Mar 2026
 03:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org> <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com> <acoq7E8NH-ihCq1K@google.com>
In-Reply-To: <acoq7E8NH-ihCq1K@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 30 Mar 2026 12:27:30 +0200
X-Gm-Features: AQROBzBw2zE5e8wBGjGUmjeI3w5sXAYU-mC5MJEbQZIxPhWtE3tBZZKIxgdi_Gk
Message-ID: <CANiq72=b6bFQ=OFEXMedO1JoL4qckRmTPYzFrXGCzgxZZOmbuA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Alice Ryhl <aliceryhl@google.com>
Cc: Brian Masney <bmasney@redhat.com>, Maxime Ripard <mripard@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org, Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8419-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,baylibre.com,linux.intel.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DC1E5359627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 9:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> The drm-rust-next branch has closed now that -rc6 is out. If we don't
> hear from Stephen, do you mind picking it up Miguel?

Yeah, I will pick them -- I talked with Danilo about it a few days ago.

Cheers,
Miguel

