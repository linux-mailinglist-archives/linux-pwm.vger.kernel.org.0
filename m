Return-Path: <linux-pwm+bounces-7133-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC1AB30D80
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 06:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1C17A4CAB
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 04:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE02874FE;
	Fri, 22 Aug 2025 04:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfHejMS3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160352773FC;
	Fri, 22 Aug 2025 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836423; cv=none; b=V6fTJfayrBJxJzVS6Stwm3Z92tZi+Y5dbt637r3UYzOf0YhvPGZZneXgsFCEL+saP+N1CLM2J3qZsw1UoMjrAmN0egupHmNqb8K2RRMbhcVs4MvG6jv5P+tIPU+3w8nnGlRvXbg6L+wULzBlXTmogyxBf5csjgyYMmAsT832cjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836423; c=relaxed/simple;
	bh=c7clcNTOHnVcV07Jm6ADKttVFlAb0YyQm3vN5dktUpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=carpggXQ1ZZIkm69mbZb/xpiAcq6LqrWJj4lDg07WqU5LsRe/2HBqwmrkwH0b5PVUoWxmuPRiMTpENv0ue9dlLElTW65rs74Dw2krXtv9Xs5W4cldfrB0Xq5qQLmkBxXTikaf8hmEyDZF1xomSlCLlDECq4baR+jv51+fzgDomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfHejMS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25A8C116C6;
	Fri, 22 Aug 2025 04:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755836422;
	bh=c7clcNTOHnVcV07Jm6ADKttVFlAb0YyQm3vN5dktUpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MfHejMS3/kC/l1yCAHnY+47xjpP5rb6wfuaWiF49btZG1JnH0gjDQ+YGaQwqOAZya
	 sygSadTTL7Tbp+CMyh0z8BzQkDtXqxjEVa0HKcE/SswJncjsSXPwdvPoGl1AOYBYEQ
	 yKhyTzEMNo6EOdP97vPRNHKanemN9Kw8z3MuG51VeJJBnC3Hp3LFc0J1q6GhFiftlN
	 xbNZAiTL5d0iAxpaC4e2ZqRDPiZdYfx64frG3Iu6ReFk9fVhGQH2pTjFrJN3Ts3LAe
	 s1i/qj1x8jrbXitMO704qhslnF1UZ26hx2px42Oerxy6Br7IxhHzqhODebwK3sVwpu
	 Suv3P2vnBgOrg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61a2a5b0689so2857340a12.1;
        Thu, 21 Aug 2025 21:20:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGqANko8bWC/cGOuQQFrPKGF6bjpZqMCmMjo33Ipo0HTSz6k53IhciG/i2ApHkgVbdjJtX12Ojhcx2fQg=@vger.kernel.org, AJvYcCXx+iLf5zWJVeTKWu7ZcE3uGW/Z5SNnZOCZ44Ex2DX7rfycxhKj8Oe3ObIMFavRAQlibF43w1SltMKQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzZRSEUEmWUHp15hRskncMc4nC8YvXcl0753qGqR9dybWRxbl6x
	HfkcEz9+OuurMzhOMaNNyS1J5g/0vTsz77sCSzzw5SsCJqKPspgMc3UPKvuWd2CMQLFq6Fh8e0M
	JpmeavrmqQlK7mBsdfI41R27IMKLDab4=
X-Google-Smtp-Source: AGHT+IEG3XkMGLYYUFNOnIxHgEkEqaiYWX1wQiOsPjrFST1kTMeIwA+nNlaOja9ZvgqsjwhgJp4TpgO6Va/IT9Y7QQ4=
X-Received: by 2002:a05:6402:44d2:b0:61a:8941:2686 with SMTP id
 4fb4d7f45d1cf-61c1b41157bmr975277a12.15.1755836421285; Thu, 21 Aug 2025
 21:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816104904.4779-2-xry111@xry111.site> <n5kdswq7oduruqiruyup4rcdwrs76tlinz26swotzeqklterey@off5cbv5i4e5>
 <CAMpQs4LqEWSoMUZpcbyknuEvf48FMMgra+Jffk0AXvTiZYjANg@mail.gmail.com>
 <bssxtcjtp4pnt3cymcrqnuwdzgdhwk5udnqwsh3xvmo2kkd567@5ovlk34bb4or> <CAMpQs4+GHczLuu6dAE=Qo2sRXWZvQYktMPSgx6FFjnN5SO8BDg@mail.gmail.com>
In-Reply-To: <CAMpQs4+GHczLuu6dAE=Qo2sRXWZvQYktMPSgx6FFjnN5SO8BDg@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 22 Aug 2025 12:20:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4TixH+zuprLotf_MYkN0G3E1gcccySU=GbySWohMVnkw@mail.gmail.com>
X-Gm-Features: Ac12FXyquurfJfvK0OIRoUdcY4Q7806urVYoobaIeT8YSAGQRYyHCc5mOrVIOb4
Message-ID: <CAAhV-H4TixH+zuprLotf_MYkN0G3E1gcccySU=GbySWohMVnkw@mail.gmail.com>
Subject: Re: [PATCH] pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Xi Ruoyao <xry111@xry111.site>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Juxin Gao <gaojuxin@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, linux-pwm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 3:34=E2=80=AFPM Binbin Zhou <zhoubb.aaron@gmail.com=
> wrote:
>
> Hi Uwe:
>
> On Wed, Aug 20, 2025 at 2:36=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@k=
ernel.org> wrote:
> >
> > Hi Binbin,
> >
> > On Mon, Aug 18, 2025 at 05:38:34PM +0800, Binbin Zhou wrote:
> > > On Sun, Aug 17, 2025 at 6:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig <uklein=
ek@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > [adding Juxin Gao to Cc:]
> > > >
> > > > On Sat, Aug 16, 2025 at 06:49:05PM +0800, Xi Ruoyao wrote:
> > > > > Per the 7A1000 and 7A2000 user manual, the clock frequency of the=
ir
> > > > > PWM controllers is 50 MHz, not 50 kHz.
> > > > >
> > > > > Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
> > >
> > > I have confirmed once again that this was indeed my mistake. Thank yo=
u again!
> > >
> > > Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >
> > Thanks for your confirmation.
> >
> > My gut feeling is that this isn't very urgent and taking this as merge
> > window material for 6.18-rc1 is fine. I still applied it to
> > https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/=
fixes
> > and will send it along if something more urgent pops up. Please tell me
> > if you think I should bother Linus with it and get it into 6.17.
>
> I don't think it's urgent either, so just take it as the merge window
> material for 6.18-rc1.
My opinion, if there are other pwm fix patches, this one can go into
6.17 together; otherwise just go into 6.18.

And if not too late, just add
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Huacai

> >
> > Best regards
> > Uwe
>
> --
> Thanks.
> Binbin

