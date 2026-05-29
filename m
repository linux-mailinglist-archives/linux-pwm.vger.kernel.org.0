Return-Path: <linux-pwm+bounces-9209-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO8eCHPFGWoIzAgAu9opvQ
	(envelope-from <linux-pwm+bounces-9209-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 18:57:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24137606062
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 18:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A4D53053B33
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90663F23B6;
	Fri, 29 May 2026 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlauHNj0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB2359A66
	for <linux-pwm@vger.kernel.org>; Fri, 29 May 2026 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073123; cv=pass; b=c+e/8AVtE5YqmbkMOj/zJuDdSEmfYsUxNTYUarlvU0u4HYJAkqSjWaa9qnZo2zehH5J3mDG25thBC05aXKfx70oFh29yZt6WAPk4OFKcExksb+SjOWmRwqkHxXt2o7vM0gvCOXJ91uvIeSrQKFqVVdCHd7cbuH83rgrjN4/K8+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073123; c=relaxed/simple;
	bh=QCZOkqcwEr9LZyCCKBh8a9RlChOA57zOW/UhtnSAJoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCh/f3bQnTogQODjLGtqbQFXPZMD81JuBKLXEUwE3LyO6o7sE9hDhoc816sKUYDR/jrUtNpm0bP+jWKWttSBFFiktb+x+xKAIiZn5ZVXAWO5yPXxDOIL1d5koJkaXCKJTCtNnNUu24LDs4gstYdo1Bs1Rzy/NaoGQKZD2lDODjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlauHNj0; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3042a99f0ceso855691eec.0
        for <linux-pwm@vger.kernel.org>; Fri, 29 May 2026 09:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780073122; cv=none;
        d=google.com; s=arc-20240605;
        b=R4A0csieJvaujaN/sL1NDo7DlIrl4k3MXMUbGUyhm3VyNxcL0lkSL2rry8yRhcfKNq
         BPrQU1VYIyxKqZ262grfwr1PghSs4invxFEq5e+NOByRoO9YBFUsLTOFXelBi/fYBtoE
         2w99fAcZ3mGwgFAms6qYmNbvkAfsE2Sic4P6/1cBzgEgg1N7kwPjiJXwG2oQKGIUtD0I
         +RbvNIIQw0zA+zHBnsE7s5hRw68lwx2wkwdtsiHQmYFTUBdTgGWUsDrQkWLUjQYwShKB
         yJU7sJYZX/fsoMMdwQRwo1GCA8kxJJuABRBTF6xzKD+eXUmn3TZtdwBdbgnZeyxwKQsc
         zHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jUlJ3VcCq6+l4y78pcrfJDXSNKNSZtDLFvQc/c/d0Nc=;
        fh=R2Eik/+RHN3deje1hvnRrWWOMmXaw3spqlO9JlosXHQ=;
        b=FCPMFZQE0xGOfAOhjr+SPV1IEfTNwJp2hkhOgLUa0eDuSZZwBoUHjtwytiu4aByVrf
         cQqeSgMMVioP89DoPjlf5SVpuFNEJ7KvMAcGnB0CR49Sf5dUaPoDQuQloWBEARVGZ9tn
         HcqCn51sp5zEPWLBfeGdmJkmQ4d1hRsxeQAHboyFbxle/pKg4y1gxXNOGuhlJS2wCHI3
         4HtNHLRgtEf0zW07RdVMyLt049D3SODJGb+Gc0V23+V58A+LnUyzrmIgvOKOOOtRDqQF
         njF3sSytfpVWMcET6Jt42A6Hb7WR33BIpzE+2oRq1UMv8AtOeJI0k/9K0S7QTVTpBuUx
         u5Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073122; x=1780677922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUlJ3VcCq6+l4y78pcrfJDXSNKNSZtDLFvQc/c/d0Nc=;
        b=BlauHNj0mLco/XPgbXh1BZaM10PBthipV570T1bjZpFxqLYPERH3kV+b3bMlbAyyi1
         bDkmdW1krwfPGC3qdkQTlO9vqjTi7KoeVxwBriVV6PtD77CqqEpPp6Z36S9BCyOYHv9O
         k2JGY/OPHSvtcm8AAJIZjd4oeJ1+5Y1bSkEztiPeMcRSOTrpIBdqtiM6UEWbeMb46vTY
         q66ju7kjMFH0OdyS6f1yYYkIs2x0R+qp0z6n+u2/eBsxH+sJ506+z6VGda6ipndJoR3v
         6nh3HyajHyGlfyUeLnV1w5SHFBhF7ovbGDMWZO2SsAd3rmCLqahU97jQJCkSJ9WNgqvt
         GLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073122; x=1780677922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUlJ3VcCq6+l4y78pcrfJDXSNKNSZtDLFvQc/c/d0Nc=;
        b=CEq1IT9hV2jhlWC7gTiRovdIOekdifz/UBs0LabX/36ip6//qm91k5VyLmG/dqjTzu
         I4qgwpzKO1qjI4vQItlbFVX1lay9hgjrGY6s6iTIBQkLX5ICzJ9aC4nOesXjlcxHH9Dj
         yp1B5wApMuB1mTug87qYWEPxJRDjDTxKnsNvz8+7NkP+ykGWugYTMs0koznPIAD8NKqY
         /YSNJrfQr0yxt45MK2BvhTvl2sI1kc4/gB0KRfm1I6N3Rb562rnpc9SrRYAZoQp+AVat
         l6BucWm3OQ+Q4Vypi0yx4eQNt+/oUHgyVxPLaJB1NS3JfEH83GMApzluzXu1xmNfZoXD
         RrNw==
X-Forwarded-Encrypted: i=1; AFNElJ8rNC5HYr2yqopAqWIE6VNyVj5O4Ajwuc/m74s08yyYPdIQuctEOa0yezKenivsQdWaHjwV5MrtfNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiT+gkEQg3x4ek7gOdm6+nLSXllJ/L8WQoufKgQbbAnn/GbQIK
	CoQNPwvuALh43olgFyrShNYcFdHKyQ0FJ7SoSTEcRECIz0ru1T0DWFnVnkfWlQNE5PM3tFea9tu
	c/v4+CtTQczu1kt+Q2GJEQEsmKycdZZY=
X-Gm-Gg: Acq92OFaLGtz0lhFzZ/GFsQHC7bWk6w0epd+QCBzJ0q/ladI2ddeE/jUdmHxu/49Pww
	f1KtojBXQsk82vyBRTpiTpJV22wczrvyPpUit4v0CJfddaNNitHycuPewMUAnVwmpHAE1J/iSpZ
	ALuPCrxl+MYgPs/bReM+bFO3JDX3ugX/VKbZiYgPKXd/7glBdttzJrY57dUS3F2bjxo0vs+Kc+9
	pnV+h54sqFE9X2cZS8sDGnOvN9aDfuZvHZy3kgO6UeAylDiRYgcvaD/unKaJUFGZtbeGMoIyRCq
	cL7xU7bW4WDleBSAc62+csCr0WFh0NMeT6RFbxc6CShobbyAc7Awx6tZqB/XDO9mVRQDFV2QkHd
	f1M3Kt2aqOcq2XsKLYfni2kYABY367eUc+A==
X-Received: by 2002:a05:7300:ef83:b0:2f3:3835:2005 with SMTP id
 5a478bee46e88-304fa67adabmr129194eec.6.1780073121435; Fri, 29 May 2026
 09:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529153821.126823-1-laniel_francis@privacyrequired.com>
In-Reply-To: <20260529153821.126823-1-laniel_francis@privacyrequired.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 May 2026 18:45:06 +0200
X-Gm-Features: AVHnY4K39U7uwop-a1na9ijJOB-HC56J7AlF1na1rF9vrlLNm1Vm_81IYCkq-Zw
Message-ID: <CANiq72=DK_qr96K7V=akgHqm0z4msymJ+VRxY0f1uqmyDmbZkw@mail.gmail.com>
Subject: Re: [PATCH v1] rust: pwm: use pin_init::zeroed() to initialize pwm_ops
To: Francis Laniel <laniel_francis@privacyrequired.com>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9209-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[samsung.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,privacyrequired.com:email]
X-Rspamd-Queue-Id: 24137606062
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 5:48=E2=80=AFPM Francis Laniel
<laniel_francis@privacyrequired.com> wrote:
>
> Replace unsafe block containing core::mem::zeroed by calling
> pin_init::zeroed().
> This is safer, as this function is guarded by trait contrary to
> core::mem:zeroed().

It is definitely safer, but it is actually fully safe, i.e. it is a
safe `const fn` after all, which is great. I would say removing
`unsafe` code is the justification, even if of course the function is
able to be safe thanks to implementing the trait only for certain
types. (Also missing `:`).

I would suggest reusing Benno's commit message from the series he
links in the issue instead, e.g.

  https://lore.kernel.org/all/20250814093046.2071971-8-lossin@kernel.org/

> Link: https://github.com/Rust-for-Linux/linux/issues/1189

Please use Suggested-by like the issue mentions :)

Suggested-by: Benno Lossin <lossin@kernel.org>

Thanks!

Cheers,
Miguel

