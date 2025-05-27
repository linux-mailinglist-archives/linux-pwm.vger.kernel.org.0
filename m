Return-Path: <linux-pwm+bounces-6141-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DD1AC4740
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 06:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65F0188F4CC
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 04:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB8C1D86F2;
	Tue, 27 May 2025 04:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="QU+GPxSv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852A1474CC
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 04:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748320607; cv=none; b=n/pSLBToEqF5NtY+qJLwu6ONX4om55gaJM6z5VUC5Ucs2fAlfnSIcIEnUE5jwDnruu4JZqIURN5kccgrmkbts2ux+AF4da303SyZCvxnnMFJTDGEBClSgohs7EPvXdQW0dMIoz1/UpOVlMFSt5BWS4od7p/JhWBtBlZKawF9ufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748320607; c=relaxed/simple;
	bh=rvrIyHHXNp53veEtFKTuGweTwWvdMYYsxGORAMmxxLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYS422o4k6gY7kJsPck7BAAALDFeXkKknFAxMJGoXz4szXd7jZj5dBfru23WlqI8APNzJ/ZicerRzp9gPeoUwVvAHCgfhLxdEvmq2qIfUgLAX9PVSRbp8hFMmAnFdnV0SQiRZRHUKj7hpVdWidw8ZPFx+fKPXLcVPqXZMWOExgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=QU+GPxSv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad545e74f60so381134766b.2
        for <linux-pwm@vger.kernel.org>; Mon, 26 May 2025 21:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1748320603; x=1748925403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ff6UC8ZTNe+I+eItze3lLHep9njcdURbGAHAI1WTvXE=;
        b=QU+GPxSvV9flQQnqGnMe2uEczvj4zlUquFph7rLYHDSjQZ5XiW/+Jni2G3Mb/OZgV7
         h3TYG5lchNWQPknIEpL1jF+LFIjtp7SfbfRtZy0zqmPO1YHoS1Gci70VHQiLp7Y6C8ap
         pv+70fVR/UjfII8DCABBjrZcxVgb3E2BRg7AVCb4z8n9Vt5qUBIwyxK/iTfM6W+b67MQ
         Kzgk4m3xuHIgoL9Qc1sgz95XUtZzlp/FXvVkFSMHNgzGDA+FlrbAAFlG7nSLKJuTQStL
         AbO9vy+gUIBNOJmY9ylYDWfECcSBtBdKeBFKk4/0rn0krQGvmb1YkyJ7zUrFBXWzN3Ez
         1kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748320603; x=1748925403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ff6UC8ZTNe+I+eItze3lLHep9njcdURbGAHAI1WTvXE=;
        b=WgWQX7eYUO0gWfwkiLUD1itq2yiWCMF9BC9kIlSrNIDvcl9MwbwAIDoD6Fx73VqGFc
         R9pX3Eq0OFTOIhf0kwqxTk0hQ6D1f/mVupa3qS2+sLO31EEXAwZMNA+UDgBD2J9ixhEJ
         tWGxWazEG4NE3M4McdB4JXFkZNFwCw9ovWz6tfJrFvAfbp/OJ7KVlfkkCzICbWs4XDS5
         UvSFb4+epzKtc2CzS9bNMLiYXNax2SBxTYklkZW7T3MQOqNddarZ45NOeYawngFUsG7S
         GCgAAREMf7vXE+pKD8cQ6i2Q6arSSgB/TmWW7l8/OpIFx/kQvyORbLwjzPPdv24SfYb5
         nxPw==
X-Forwarded-Encrypted: i=1; AJvYcCXzqCWxPogIbfLou/T2GnD21K9Z9P61KLS8T/QMa5iSSW2yO3wQ1KZri5G7G0edBCfmP9EvCvOyRKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXoK0V7ZqDYrnj8HXFGxfTJHjxjF+pW48ZsGoxWIEaPwrhiha
	Vt31nY7WUpjHtf6tradQktkJD0rttjp8emYP9byMzVzZ4xvB35ch3rdgrKa3TjPiVB3RV38kYby
	yw2ve0E9YHmlTZOZXiF1EvtcGWHM0BjFCmVBxDE53BQ==
X-Gm-Gg: ASbGncv4iPjddfTTaogl290lS5F/z4OIPU5VcXHBV9dagNxzpV6x+6xSb0pis90IHkw
	Mdnn1KOgrvNBu9BbLR/YQ+mAjo17QTNIWDPw0g5j3MisR9q3JF0jcR55V2T9AcKpFE1pUtC8vOd
	za50p9LlAx47VVOAApugsW6TGvwbwpwaUrtw==
X-Google-Smtp-Source: AGHT+IGo6E8NJmIu7lDX7Br9+8Vm3DHhMozHXP52l3uoUCX6XeCyxyt49ZP4sGWmptiI89VtoPx732i1dLPzVdepgQc=
X-Received: by 2002:a17:907:7faa:b0:ad8:9084:4ec0 with SMTP id
 a640c23a62f3a-ad89084517emr53114066b.35.1748320602960; Mon, 26 May 2025
 21:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429085048.1310409-1-guodong@riscstar.com>
 <20250429085048.1310409-5-guodong@riscstar.com> <paasmwjel652r25nxobidydtpxfjy7emerilmwqhvhtgrrtg6v@gowpzqdzvlfz>
 <20250526215243-GYA53128@gentoo> <CAH1PCMZhS4_u3nTdAQDfTTRVJ_61n-OYjmMuv2m4DHYDzGE0XA@mail.gmail.com>
 <20250527032701-GYA55693@gentoo>
In-Reply-To: <20250527032701-GYA55693@gentoo>
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 27 May 2025 12:36:31 +0800
X-Gm-Features: AX0GCFsJEcR3EmfV6Iyccb0DPbXPaPY_2_j3czeJ2Y8-ennyhBu-Ez1iIOffJ7g
Message-ID: <CAH1PCMatGM6y2AhQB5e=DMu9kD8nxJ3Xv9AYy7Y=E8JhMV=Z8Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
To: Yixun Lan <dlan@gentoo.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, 
	hal.feng@starfivetech.com, unicorn_wang@outlook.com, duje.mihanovic@skole.hr, 
	heikki.krogerus@linux.intel.com, elder@riscstar.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 11:27=E2=80=AFAM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong,
>
> On 10:48 Tue 27 May     , Guodong Xu wrote:
> > On Tue, May 27, 2025 at 5:52=E2=80=AFAM Yixun Lan <dlan@gentoo.org> wro=
te:
> > >
> > > Hi Guodong, Uwe,
> > >
> > > On 18:54 Mon 26 May     , Uwe Kleine-K=C3=B6nig wrote:
> > > > On Tue, Apr 29, 2025 at 04:50:46PM +0800, Guodong Xu wrote:
> > > > > diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/=
riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > > > index 283663647a86..195eb8874f3c 100644
> > > > > --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > > > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > > > @@ -20,4 +20,11 @@ uart0-2-pins {
> > > > >                     drive-strength =3D <32>;
> > > > >             };
> > > > >     };
> > > > > +   pwm14_1_cfg: pwm14-1-cfg {
> > > > > +           pwm14-1-pins {
> > > > > +                   pinmux =3D <K1_PADCONF(44, 4)>;
> > > > > +                   bias-pull-up =3D <0>;
> > > > > +                   drive-strength =3D <32>;
> > > > > +           };
> > > > > +   };
> > > >
> > > > There is a newline expected before the pwm14-1-cfg node, isn't ther=
e?
> > > >
> > > Right, I could amend this and fix it while applying this patch
> > > (so if there is no other serious issue, no need to resend)
> > >
> >
> > Thanks, Yixun.
> >
> > By the way, do you plan to take patches 3 and 4 of this series into
> > your tree? They only apply if the SpacemiT reset patchset is applied
> > first.
> >
> Yes, exactly. The dts patch will go through SpacemiT SoC tree, and we
> have to wait untill reset patch series applied.
>

Appreciate you taking care of this, and thanks for the update.

> --
> Yixun Lan (dlan)

