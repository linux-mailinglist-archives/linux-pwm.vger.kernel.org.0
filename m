Return-Path: <linux-pwm+bounces-6139-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D0CAC468E
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 04:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE3A3B4B76
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 02:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46001922F4;
	Tue, 27 May 2025 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="cBaG4EKJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA115B971
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748314113; cv=none; b=AYTqLh+cm6VjYaTm877dyXkFSNKkpczThPxsXW/szBJ80SLFzGoUwOvuOaOkXxTpHd0w7ug888DZbyFOTnhx4zDeN6dNGu/DW6Q8HMwMqxw+W3/SSnuXkXxPknkDHfg+nMGDpSuam+FExieAMIBIJHCBckZpi4PhkBYY5Wq3/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748314113; c=relaxed/simple;
	bh=1sIkGvLRc4q9F0wAGlww0AgdOxuNbiq/W5VJZQg3ebE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICd+JDYn4wCK3exJHsNadcpFKEEU30MSbIrrJ8IF3Lkq4SItqWBy/134eRc4/8hRV4SMJ5CuZXydyxr2KquamgQX8CV9BDezrgUfW3N29WHl1+TzAHOsXEaDn4Wo91d8HkjHV2qNA40Rqs72eCFXDWf9qRvv6vCXXzVOxQbht/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=cBaG4EKJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acacb8743a7so514409966b.1
        for <linux-pwm@vger.kernel.org>; Mon, 26 May 2025 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1748314110; x=1748918910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxISWGK2XQPkm4Hhr1US0gvD1FZ3zYyiGOuHAQJE5eo=;
        b=cBaG4EKJNl3cuWB6pIdbTLbU184LMPx1S8Le/UTPlp9DXIT30STkIaS18O1u3dGVlH
         OzQYiG6Lxb7QkaC4Ss6xiXLamwysKiCmv5hTntRJY4/oFKT3VoRV2TMRukOA8BZYe1gk
         tXRxLO3X/i+dvdzQ0DsjlzPcoODAdIbATiDjchNRO5f1BA0tyF1h3V9HNyvwZ2d23av8
         PgUWib1fFQ8MxDAXmJjWUyoAx3XMeT7Kqw1kPDoe+wenMN3M0K0ZfdZvY2rZKJ6QDoAv
         DeN6fKLGUu1bw35d5DoaqDhx4DAGNsUwAbqYs8v9K1f7MEINOliAyJ/l5H1LxJOG/9vq
         LNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748314110; x=1748918910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxISWGK2XQPkm4Hhr1US0gvD1FZ3zYyiGOuHAQJE5eo=;
        b=o8dR4dZXN3PP+w0Tl8okaS8zjwuZIWn+PNR3n5MM8YpoPI2Avj3CxF5dErHnxjzEfZ
         c4QaT2oWaknk3SuAskdmjnLG+oBFQrhagCRCbpgHpAemFdnhfSkn2804w/nZq0Z7mpH/
         YDcAaeC3hu8XCVPklgrpnMx/GYfAnt7fzGDHQvDYJhrhO+RXJhtWJJCuVu8cNyDtSfNb
         VnVb7Qg5KBFUPRDJFM+iGkATeN7U7RoRvvyZgwi7NTR6zvzc/WEmjeh2aHDDeBgh62LQ
         6JC0tx1DEVxypIiE/9M9bwOZp7VznM0FR7CErOeSCx/UuLCnhNpQO/4apP1NvgJ3xcV1
         gwCg==
X-Forwarded-Encrypted: i=1; AJvYcCXwJ0MsJX0you6r3rnTh+fPB4jGj1TdNUuuBvQQtkRiuMVBaCK8NVobJjj06cu/bbonywEr0MzR05c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKIFCdLhC1zebQ2Y1N6spz+8hv5en9zUCH+k341SwAKeFMcD9I
	TUKp+OZPhGwehykn7rt8XmQjdwzXQHra1gygX+EZKmvFZUdNgwbCUU6BsJgXweofguBTtvCumsu
	vLjsrxHNMaCQL4y+mrUhuLR6WyJ7pELp0IIhqA0SOIg==
X-Gm-Gg: ASbGncvH74okHYDHXpHlc4PyMYjRRiViEsjG8kTL9vJvjAR0YqVxm9jgPfibSMsnBn3
	9Tng4MZDQIn9BD2SR1dQQHZSo8KsEm1FdwXFFe2oBFM0DKsxZJpCZt33cf95a8VV2fFsJFnHAkh
	M0+/fdsAvXhdGWBe8VfdNy7hlynYCTsEcexg==
X-Google-Smtp-Source: AGHT+IGlQnBA51IfLDQtlV4Tsj0DcivukafO3WpRjoRYo7aZ2XNkgT/ISpHO9OKoKdboUS/Oi+TdrQgc1gVBGNRrhUg=
X-Received: by 2002:a17:907:9303:b0:ad1:d0e7:a698 with SMTP id
 a640c23a62f3a-ad8596d8c4emr1099084466b.2.1748314109982; Mon, 26 May 2025
 19:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429085048.1310409-1-guodong@riscstar.com>
 <20250429085048.1310409-5-guodong@riscstar.com> <paasmwjel652r25nxobidydtpxfjy7emerilmwqhvhtgrrtg6v@gowpzqdzvlfz>
 <20250526215243-GYA53128@gentoo>
In-Reply-To: <20250526215243-GYA53128@gentoo>
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 27 May 2025 10:48:18 +0800
X-Gm-Features: AX0GCFvI_6k3vBVjk-TWBpWmMUcHskFmulTKZz7Kxcz7kFRTgK5PHEc_K-e3F1M
Message-ID: <CAH1PCMZhS4_u3nTdAQDfTTRVJ_61n-OYjmMuv2m4DHYDzGE0XA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
To: Yixun Lan <dlan@gentoo.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, 
	hal.feng@starfivetech.com, unicorn_wang@outlook.com, duje.mihanovic@skole.hr, 
	heikki.krogerus@linux.intel.com, elder@riscstar.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 5:52=E2=80=AFAM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong, Uwe,
>
> On 18:54 Mon 26 May     , Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Apr 29, 2025 at 04:50:46PM +0800, Guodong Xu wrote:
> > > diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/risc=
v/boot/dts/spacemit/k1-pinctrl.dtsi
> > > index 283663647a86..195eb8874f3c 100644
> > > --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > @@ -20,4 +20,11 @@ uart0-2-pins {
> > >                     drive-strength =3D <32>;
> > >             };
> > >     };
> > > +   pwm14_1_cfg: pwm14-1-cfg {
> > > +           pwm14-1-pins {
> > > +                   pinmux =3D <K1_PADCONF(44, 4)>;
> > > +                   bias-pull-up =3D <0>;
> > > +                   drive-strength =3D <32>;
> > > +           };
> > > +   };
> >
> > There is a newline expected before the pwm14-1-cfg node, isn't there?
> >
> Right, I could amend this and fix it while applying this patch
> (so if there is no other serious issue, no need to resend)
>

Thanks, Yixun.

By the way, do you plan to take patches 3 and 4 of this series into
your tree? They only apply if the SpacemiT reset patchset is applied
first.

BR,
Guodong

> --
> Yixun Lan (dlan)

