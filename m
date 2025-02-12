Return-Path: <linux-pwm+bounces-4863-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7240CA32048
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 08:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148683A1857
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB9204694;
	Wed, 12 Feb 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYC8xWpv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA371E47B4;
	Wed, 12 Feb 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346700; cv=none; b=tVIba9VN1FD/xB+L0QzESKC5U8HZHAe7A3XVRDs0JL5EgHno2Nb1WzOwSq+SAC5bc00nKLsATJpkyyCtDXpdzLdZwqLhrixMGhAHW/mPEUhUUkwcGqBI4buwjWNa/v0Z9pygdUybUrT/6ArjL5ZkkT9sepKpZeolEqdw9ukc8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346700; c=relaxed/simple;
	bh=PT4rGShEWh3DzWcWOCHpI21yltkgPZv4xIGMiqRgdQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3aPohMZDQgO7085R8z75TsfjEer4vgyGEi1+WlsJsQPcf3ecx6xhzwSH4YTUqspUfY5RfOLA+97pvbDGlVVqmdWzUbpLVtm0qJnmXd4fp0KEltIp4ajIcjfmiuFXHnzBW7ZB9RWqOgNsXT5lMkYPfjtjTZclGyUQLZlOQWqFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYC8xWpv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de64873d18so6795818a12.2;
        Tue, 11 Feb 2025 23:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739346697; x=1739951497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9m4RpcHMEGyjcSsbihXpefKBea9DX/lIwf1QjZ3ahQ=;
        b=fYC8xWpvM99pR1GEyWKijzw60uvQYl5ZObQybJwo7XYwUGNhmMv5niUZUjh6vDAO8C
         EBV6rBNOSH3CvdqYmAbOvuCSrpVSgAqx9o0UHDIoB/UuuLmQ4AfzRj5yvzUmXrda2pXB
         N7Wc5gGmIiecCGWAFSnOl6YNTEukltMGWN4sSnN3F5yVPvi9/cVhjmrra9wc+iUKePs+
         tboDxFIrHjESguOiInsDhPzjsRU83aswXjRZI+AyC6S/y1BidE8ckkPv1CEu+xoiQzFM
         rYfxuNdJTdPk1GymA6+EkqVwgWGE/AWLiHdmQctSaM6VJG3s24fuJIFkWMANpR5MJ7GV
         DpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739346697; x=1739951497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9m4RpcHMEGyjcSsbihXpefKBea9DX/lIwf1QjZ3ahQ=;
        b=Q7OaCWkyICXYKzF1IY6TOm9587Di5kas8mmGbx31FqjR3louuuUAMFRNdhWJg+5dUW
         YrNpOUnd161qFN7JTyfQhkAHhSSEfsAxYuJSTwIrSjsFTIq2v1wIs5Chv7qTRzWlFj2V
         il+2IByEmTl4/3BLIg98oWQVigz/w9IoDsx38pwJSMKV8LoAt6YGxRyzYPWRWjmuU93e
         vceuywJpHLwJ51MYsxBmv+or7KMbk89JP5/WAOWwnlRyjNjM8RT/KDEcrjEKDosOsi7G
         otfPuBIZFafG/9BBQkocLucxr1JSz6I6Lhg+QJGg7Nw0pD0t8+zbBynDuR8tLuX4qRh7
         ntnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Xbi5JrHI34PGpC74lZIL7hK7auWN9iJZ48QZysQf0GXkNfDd4dQv6RChFMZXLXQerc0RhE3/lXg+@vger.kernel.org, AJvYcCWFBt8WUBkTOkTWZR3OlvWb5BTDTxKp6Z3emNGEs63q7T2QFxuZrbpuzXcvvI3zLf22+4ghj91sGvr7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4B/n6r0wJ84shBXyk3Y3Asx+g1FyfffWNo8NvmUfEzSZyKpu
	vcV9tMtTudZEmnMT3D25Epjz8jLRQ1d6FFOyFH7AYReA3kJ1ajkTdgPD1mreiVz6ruw5bg1RYcv
	1zwuy/wwGoSYMAQxyqQcOpLtpIAs=
X-Gm-Gg: ASbGncvkYIvtdTvl6TIZPTiOS+zQNBt/+p4lSrRFlmXZ3fTc7LJ/g6HvKgFSpMaYZk/
	VU0FITJIV3NGt1Na9he2zuNi/eDJTYscQaOGDzEICmjvyJh/sijlnCL5Sc80xLFdxdlVE3/U=
X-Google-Smtp-Source: AGHT+IFTu3gb3HC/gTL7ZO2Hkvnwgt7SCIv2ukWCJdf5Hv2sq1C8t89CjBEo0ofNGytsdWZNMj3FBLTzqpa6ZVtjQZA=
X-Received: by 2002:a05:6402:510f:b0:5dc:113c:46c3 with SMTP id
 4fb4d7f45d1cf-5deade0429dmr1666658a12.21.1739346696982; Tue, 11 Feb 2025
 23:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733823417.git.zhoubinbin@loongson.cn> <be76165d1ab09ec41cdfd4e5fbdae1b415f516b9.1733823417.git.zhoubinbin@loongson.cn>
 <obegtfup7f6w6erh4arubk2fkk2wrcum5frs5kbqa4uniexmr5@6uti3d3hv7np>
 <CAMpQs4+nVSorAeR92F22T5dnzyh1h4BDR6UqrZbTSUhEyWbGyA@mail.gmail.com> <vyth3k4smtsp4qvbkugi7vkhaqii3gysgjmenzhl27iy74fy6w@rleajhaork2j>
In-Reply-To: <vyth3k4smtsp4qvbkugi7vkhaqii3gysgjmenzhl27iy74fy6w@rleajhaork2j>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 12 Feb 2025 13:51:24 +0600
X-Gm-Features: AWEUYZndaGkxnP_eAs8RjoY9H_Ss2OZaz6eBH_mYhYyxveHw2EhylSheiy1pMgQ
Message-ID: <CAMpQs4+r0zHsheF5qC1Jj-JMmV-J8DWicHVsx2aB91Eexfekfw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] pwm: Add Loongson PWM controller support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe:

On Tue, Feb 11, 2025 at 11:36=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
>
> Hello,
>
> On Tue, Feb 11, 2025 at 02:02:03PM +0600, Binbin Zhou wrote:
> > On Tue, Feb 11, 2025 at 12:26=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleine=
k@kernel.org> wrote:
> > > On Tue, Dec 10, 2024 at 08:37:06PM +0800, Binbin Zhou wrote:
> > > > +static int pwm_loongson_suspend(struct device *dev)
> > > > +{
> > > > +     struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > > > +     struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(ch=
ip);
> > > > +
> > > > +     ddata->lss.ctrl =3D pwm_loongson_readl(ddata, LOONGSON_PWM_RE=
G_CTRL);
> > > > +     ddata->lss.duty =3D pwm_loongson_readl(ddata, LOONGSON_PWM_RE=
G_DUTY);
> > > > +     ddata->lss.period =3D pwm_loongson_readl(ddata, LOONGSON_PWM_=
REG_PERIOD);
> > > > +
> > > > +     clk_disable_unprepare(ddata->clk);
> > > > +
> > > > +     return 0;
> > >
> > > Is this needed assuming that before suspend the consumer stopped the
> > > PWM?
> >
> > Actually, I don't quite understand the problem you're pointing out. It
> > seems to me that the register and clk operations are required
> > regardless of the state of the pwm.
> > At least from the experimental results, the logic is now as expected.
> > Of course, I may be missing some critical information.
>
> When a PWM goes into suspend it's expected that its consumer already
> disabled it.
>
> Until I come around to do that properly in the core for all drivers, I
> think the right approach in a driver is:
>
>         for (i =3D 0; i < chip->npwm; ++i) {
>                 if (chip->pwms[i].state.enabled)
>                         return -EBUSY;
>         }

OK, I will add the approach into pwm_loongson_suspend().
Since our pwm is single channel, it can be changed to:

+       struct pwm_device *pwm =3D &chip->pwms[0];
+
+       if (pwm->state.enabled)
+               return -EBUSY;


>
> and if you then know that all PWMs are disabled, maybe you don't need to
> store all the registers you did in pwm_loongson_suspend()?
>
> Best regards
> Uwe



--
Thanks.
Binbin

