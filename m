Return-Path: <linux-pwm+bounces-8008-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEaECpdBemmr4wEAu9opvQ
	(envelope-from <linux-pwm+bounces-8008-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 18:04:23 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2302A681B
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 488B730A609A
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C37080E;
	Wed, 28 Jan 2026 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6MBlL8W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B451308F1D
	for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619164; cv=pass; b=jtoHk/NSWTyhsQX/fQRum/SRw+Fml3qtawsTfwM1wgTwsfBxXnkO01Qivp5d49WCmRBU8FPg8a78zFC5AtZwmqrsBT1FjFgYLybyIi9wrXY5e8q9dNn7ooKVz6U7GX9mdCmsGWNChxh29ejvltTbfwRvAPEcLyFYQioyedtBzEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619164; c=relaxed/simple;
	bh=TpCucwmKAK2k086DcpFd+VvfN1GaOQ0WjNJ+vGCA69U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNs1W6Uk25zZ8YesJEgqiPd/q0aCfbXsEhlQQtn1tUEykbmbKNSKSNq0feT9zOAWyJ7sEQ+ccMsh4K6rn39MDez0ODYLXiE42UO6KnwSa2i9+n5JQB09ByQ70+KutTD1AmsQM7LvxYXYhdX0f6PFAJ/6B5aPoxELjXA5NFJk/7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6MBlL8W; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29f2676bb21so7875ad.0
        for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 08:52:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769619162; cv=none;
        d=google.com; s=arc-20240605;
        b=TUByWlYeKB64oLOdQXzrqMuekBydvdRXwtfsxGxbz4j86JyLr48GlrpogWlPEM1/p7
         tdIAuO2xWqKG7AG64eF1HHj42JxRSJQMWNFL+2WCmDTp5fmDtsxP4BCT7VfYEycQ1QAX
         gosDnLP5PqgLWHjwVVBEPrqXHMpsrDHv+B9ffd3CTc09a6eQjc+ZWyUMNra36w5rsiaa
         PYjVfF3Yi+cYCM0nuq0HoWSJM/QSXrisgq/+qAujEHNDtECjnYgLkXZG6iL51SMd3SPR
         /OVQjg42IlG2iYS+eXgUWiqNGmU/cOmy78kNfyiMVR1ftd9afD9YK71SbgsAcnLQjFDl
         7v2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LX9gDx3KFBF5yxVstQOoU+G8u/eBTnZN64aCXHiziSg=;
        fh=jbzPQf5g1LsfBY7stOfkTuWI/60DnJ66ZEgAyu3bovU=;
        b=dU9JaaYbkgYNf4a/7M/a83KN2AFoGYDs+UwjgH9XWXlKbVxxR+zYtkdhfph6O5jlzX
         07fxzn6yy2SttDD5MWhSei8m8wjDQzC8tsAZ1k0oFuAh1TQlE8DySFPR6Xwf8jVMLwme
         kOv+BTQ9TI5Dofqo9eOHhfrzzLShKt1ffJnyiZN9YSqrV7fXp+feB0Cf4e2VEOJuW/02
         VHmk2X9K5P+NJePn1zT1d/1wxiU9dDgDEPyepqk2Fra8JdA3TPWKqCSfXefyyYecqN1x
         p6Wdwio/13BLFxAnncoUD51kr5qXPETwM+mvS88mfZ4PdecaCR9ezWv/mMAwDJYdUoh3
         Wnpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769619162; x=1770223962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX9gDx3KFBF5yxVstQOoU+G8u/eBTnZN64aCXHiziSg=;
        b=f6MBlL8WIhAFafLJ4DAT4Qk50DyvXWHd74MpB3ulde8nHx4dpYcJboAen5DZPrtJzQ
         lOqwPZrmxS35O1Nlq31pE+DHZTc6fcD+sGMO2dOHOwfhfnz27iloilRinJFB/ACpt0S9
         sb/4wof6twWUqMk/3Pz9x5hv21Av6BLTgIUm9PnIk83/RH+dltp9mNsvr4kFqZvlBQ0I
         5Ve++Wk9WtkpJAx9yE1FeT2Lu7eiYw1bYDnbDoNlko5jwNwSj9Tn8mvZFD3S+bYi5l6V
         Nuve8bAO++/eiHCTO1FHyFnTnyxm0EFGzKSCc+nHCgs9FO4BtlYM40nv86B+hCO/7CtK
         usKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769619162; x=1770223962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LX9gDx3KFBF5yxVstQOoU+G8u/eBTnZN64aCXHiziSg=;
        b=OqHC8it14Fp+2VEzO0H8XZBdubPwVafDldZHz5C0xCX8PKZsBb5rfOPwmqYc55/tE/
         gq/ENeunOyChLtoZp2xZ0XukMhUgw+qHi0rf++7NCJOUc60resSfOkq2mLILBL3Zm53W
         lrl3c3CwETn4g/OWwhoIAdQOJU3dwy669YEHTra3Zq6GUfC1zQfSomj2NfeY1LZeTNEv
         8DDcidOtuXxHmW1bb/BP+KzzuX0x57PQt4zYr4KklsumGBKVZrTU9A3rMgCQ5FSbT8Mx
         RGP/i0XTv2Rz47fKu8NkHO6z1VkevfZqviPyXVWC9Gr+IF5NgJPpTofSZFEcZ9b5K71i
         dWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWveMMVlZk4OyzdtEtpcgNNtOKj+3YKNpMUOGvVhNo7nZ2OM2/lXoJaHCjrMIq1tBfaEwv1RMbHNg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1kCCqF/cz6RI2aWfpDdka8pfXN/NzrzY7cOt8WdSRrz/xi1Cz
	mjKw7OwQiUs34cQzkQEZkYwLieKeukKOCQIZLZ1gRghbJIKR8zVcBPukPGOMceO7hgd9A7tCoQt
	L1sh8IhmNizrES33S+DUkryLthzxj76EPEqPuqLgTbE4=
X-Gm-Gg: AZuq6aLo9jqMm1mnddT1TwCEMvM//KEMRGeZJn20WKyNmwT4HXhVhz0fMO/XF+ktEE5
	tBfH+5duENs4rLSBu5qNTI+peRJ6ivtHQxaDqDBIvCJ2OFWCIiNfS72lk6jDxAClFaIXl4nxdMP
	0bqibPbP3jLHHUGHIY1yewnQ2DtkwP0f+b9Jk6ZWLpMM11r7V7bJGcNYMbeXwNY7wREejQMrEhD
	U+KJ1+u4UyloYJ4pgOu7hadHOogd3MXXNZBFVnHizxzt696tnoE1FagAYzoWVQxaBmJIgTK
X-Received: by 2002:a17:903:249:b0:2a5:99e9:569d with SMTP id
 d9443c01a7336-2a870d6483fmr54239625ad.18.1769619161524; Wed, 28 Jan 2026
 08:52:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427142500.151925-1-privatesub2@gmail.com> <aXJTqzZaBrCMnTvv@shepard>
In-Reply-To: <aXJTqzZaBrCMnTvv@shepard>
From: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCo0YPQsdC40L0=?= <privatesub2@gmail.com>
Date: Wed, 28 Jan 2026 19:52:29 +0300
X-Gm-Features: AZwV_QjtfqpOuCyYtNE1xKe0593NpcMxJ89wFPIBopBcRc0tp-flqstJbbXGRk0
Message-ID: <CAF4idN=h9u2LX8Oa9_LcyM9ANUNtLbPTMyn_pHbZVBCXc5Orvg@mail.gmail.com>
Subject: Re: [PATCH v12 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8008-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,csie.org,gmail.com,sholland.org,sifive.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[privatesub2@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RSPAMD_EMAILBL_FAIL(0.00)[paulk.sys-base.io:query timed out];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,paulk.fr:url]
X-Rspamd-Queue-Id: E2302A681B
X-Rspamd-Action: no action

Hi Paul,

Thanks a lot for the detailed review and for testing on A133 - great
to hear it works there as well.

Good point about the naming. I can rename the driver to sun8i-pwm and
send a new patch series.

Thanks again for the pointers and the context.

Thanks again,
Aleksandr

=D1=87=D1=82, 22 =D1=8F=D0=BD=D0=B2. 2026=E2=80=AF=D0=B3. =D0=B2 19:43, Pau=
l Kocialkowski <paulk@sys-base.io>:
>
> Hi Aleksandr,
>
> On Sun 27 Apr 25, 17:24, Aleksandr Shubin wrote:
> > Aleksandr Shubin (3):
> >   dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
> >     controller
> >   pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
> >   riscv: dts: allwinner: d1: Add pwm node
> >
> >  .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  84 ++++
> >  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
> >  drivers/pwm/Kconfig                           |  10 +
> >  drivers/pwm/Makefile                          |   1 +
> >  drivers/pwm/pwm-sun20i.c                      | 379 ++++++++++++++++++
> >  5 files changed, 486 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun=
20i-pwm.yaml
> >  create mode 100644 drivers/pwm/pwm-sun20i.c
>
> Thanks for your work on this driver!
>
> For context, this PWM controller seems to be a second-generation design f=
rom
> Allwinner, which is found in the following chips: V5, A50, H616, V536, T7=
, A133,
> V833, R329, D1/T113, R128, V851, A523 and A733.
>
> I've tested your driver on A133, which works fine too. It seems that H616=
 uses
> a similar (but slightly different) register layout.
>
> In case you've missed it, there's a follow-up series adding H616 support =
at:
> https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D409036&arch=
ive=3Dboth&state=3D*
>
> And there's also a standalone effort (which I've redirected to your serie=
s) at:
> https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D485644&arch=
ive=3Dboth&state=3D*
>
> Now given that the new controller was introduced with the V5 (sun8iw12) f=
rom
> 2018, I think it would be a bit confusing to keep the sun20i-pwm name.
>
> How about renaming the driver to sun8i-pwm instead? That would be more
> consistent with how other second generation designs from Allwinner are us=
ually
> called in Linux and makes it more clear that it also targets sun8i and su=
n50i
> chips, in addition to sun20i.
>
> All the best,
>
> Paul
>
> --
> Paul Kocialkowski,
>
> Independent contractor - sys-base - https://www.sys-base.io/
> Free software developer - https://www.paulk.fr/
>
> Expert in multimedia, graphics and embedded hardware support with Linux.

