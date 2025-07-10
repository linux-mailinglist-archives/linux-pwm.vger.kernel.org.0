Return-Path: <linux-pwm+bounces-6804-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8BAFF9E1
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 08:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D323B9994
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 06:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D922D21D3E8;
	Thu, 10 Jul 2025 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kCwIMIX0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69772253FD
	for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 06:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129233; cv=none; b=cHgNJcoNQS79gmhhQX0XBa3cCOLaBpGXJRaFaU4SpXcqAZaIUmrhpk5X/F4OpCMnWdf1jQxTqSpE6OoyZHf3AuksI3VSPJH5yacZo9L96s9IrT4OfpboC37mSGu5j1gh8suLYfdGQ34GheF+nzCPsUsNC8z+EoRp2LgfTu87QvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129233; c=relaxed/simple;
	bh=fj6W66sPr7Ji9329jAkLIL1CrVKPhluEPji8nUmmCag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpvmpP4MNqIGZC/5vFkgAZhoCn202Sh/cKMImG2Qeyjs25lgiTcNB1tY3Np3uSRYYxZxHv6wnWcA43abgEyraYR96ViWLtEoznvavRS6Gn/Sam4Vt/fo4nVOSoLDSkv52WqSdDSVDwjIMuHM6P/RT8OYmtklQNMVEKqi3AbGe50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kCwIMIX0; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso494986276.3
        for <linux-pwm@vger.kernel.org>; Wed, 09 Jul 2025 23:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752129230; x=1752734030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOfKyTSrKEeE5mRVGbOkpddwy61Hvu8Xrql9GC0LhTY=;
        b=kCwIMIX0xI+FF4eyIrZKYmYLyUmzCNhlOe0IvNyklrooYhLtDrAxlbm5hlLdUagTrs
         szRok5kM5ROl3FWGYSBIQrA1CVZvKpqAMKvCeTKvm4bJ/qqAQWis9OT3yIu3cq68y+GS
         D3c6xDvvN/n5S8sAnEQZy4FGrNnKj1jWJVgfOKhpTJqa1qXM9gPcZhUi8aOcELee5LkM
         VnAHdnllVtJ8IEfO2FZ1fcqvV2oqgj/JvlrYbRPASCQcaMoH+zbbeQzYpBTmGaYl89uH
         0QCftfGvgIQvsA1Gt8eXf86EiqtIeVDeOxUXAqDmQcoBsqhLztsiVemdjl4o8PmyfOVB
         eXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752129230; x=1752734030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOfKyTSrKEeE5mRVGbOkpddwy61Hvu8Xrql9GC0LhTY=;
        b=IwW67GB03FhVEIFsk8xSbX+W2htoiWPDHTOIzUAePgF/uBMigiRkvMYr1Tk4BBfcbn
         0X5t0MS8rtHzYPHmNc444MRiuZ4vHYoGtUkoBYOZpvxd2d5rII8DAytGxCEsONCH5ktA
         Zbjs2Uv5i8U1f2siTxcsQ7/rz1MtCahw4W/gpHQJenvMKnAy4Qnh2iO99fDjNpTdZ0gI
         Ek8NgyPaxZBcxM8NG5g/2UHTU/Haa0R+//JvElE2hFu85XC+ClTa5Vx3Uo8UpVeTkzi+
         ZtZDQKQch100F8/FDZtS5lprASBZmec95JLw0n2h7I8lnCAkyQw6aNw966fEqNkv5vHW
         nkDw==
X-Forwarded-Encrypted: i=1; AJvYcCUk+7LsrLzSzIzExOcBkFlDqJyNpCKwxDBS8nzhynz+EshCxFQsG5s5MDhOlt+7h15yUfiT5WETJKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+ZgoAppnsQRTOdP/pWYElASwQ5WkQtNdbJ2r/E1a5e4dW6uQ
	8B8Q225+wXIVHXIXg5EhnA208rNgElj8YLKh8UJZOJ5mseRAC8yW0PGwrlGEaq0sK3yGoXckU7/
	JOYPG13HCg3zPeKUvZoAuCt1bnNlh6LCIpx249Lsvag==
X-Gm-Gg: ASbGnctsnPyXVVQ+E4Bbcg1ovibzrSzFxQI2Uvsr0tGd8DxFVbOQeLqaJZ2R7kp+rAM
	xgn32OEo4fET2UzJmX93gnbFbDEV6x70DRCnfleco7sToD81SjzTtZ3Uq9XqroDEbNTum6b6JCa
	c5W4QMNVn+0O+DlD0+D+qksnkFxr/qmVqxFnuxUCVT3pYGdV6Z38RdqQVPmLEAch6U
X-Google-Smtp-Source: AGHT+IEUEuXYe+AiRoP9sKK+Q2LJ7hkbYYZRPRjU65Kj1Wu6nsLtbs1bxTc1Gn9tJMDj6XgH3uwUSmTRPbmjpClz12M=
X-Received: by 2002:a05:690c:7405:b0:708:16b0:59c3 with SMTP id
 00721157ae682-717b1a8aa20mr78370367b3.33.1752129229913; Wed, 09 Jul 2025
 23:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429085048.1310409-1-guodong@riscstar.com>
 <175198458423.86859.5882458274157023095.b4-ty@gentoo.org> <20250709063738-GYA488894@gentoo>
In-Reply-To: <20250709063738-GYA488894@gentoo>
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 10 Jul 2025 14:33:37 +0800
X-Gm-Features: Ac12FXzWKaYp6y1oSJwNCeBf8VLK9_pLF6KbvY2LESuIM6jHvBvBU0Xdd6tceRA
Message-ID: <CAH1PCMaZYaRgUoaMfDLyqwTv3n3NUaUL8tHr8SoTq=4ayuvyhA@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 0/6] pwm: Update PWM_PXA driver for SpacemiT K1
To: Yixun Lan <dlan@gentoo.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, drew@pdp7.com, 
	inochiama@gmail.com, geert+renesas@glider.be, heylenay@4d2.org, 
	tglx@linutronix.de, hal.feng@starfivetech.com, unicorn_wang@outlook.com, 
	duje.mihanovic@skole.hr, heikki.krogerus@linux.intel.com, elder@riscstar.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:37=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong,
>
> On 22:33 Tue 08 Jul     , Yixun Lan wrote:
> >
> > On Tue, 29 Apr 2025 16:50:42 +0800, Guodong Xu wrote:
> > > This patchset adds support for the SpacemiT K1 SoC in the PWM_PXA dri=
ver
> > > and updates related device tree bindings. The changes enable PWM
> > > functionality on the K1 platform through driver enhancements,
> > > configuration updates, and device tree additions.
> > >
> > > Functionality has been verified on the Banana Pi BPI-F3 board using P=
WM14,
> > > configured as a pwm-backlight. Per community feedback, the actual
> > > pwm-backlight node is not included in this patchset but can be found =
in
> > > patch 7 of the v1 series, with modification of pwms property to 4-cel=
l
> > > format to match updated binding (#pwm-cells =3D <3>) since v3.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [3/6] riscv: dts: spacemit: add PWM support for K1 SoC
> >       https://github.com/spacemit-com/linux/commit/9aebdfc21f755e0d2766=
683aa251435fb656ea47
>
> found have to re-arrange the nodes according to ascending order of unit a=
ddress,
> so here is new version I've pushed, just FYI, please check (should have
> no functionality changes)
>        https://github.com/spacemit-com/linux/commit/66f56c7a6421394834152=
1b5310064586a05c80e

Looks good. Thanks Yixun.

>
> > [4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
> >       https://github.com/spacemit-com/linux/commit/8709d51024068d4c81dc=
785d63169d283d147cf3
>
> --
> Yixun Lan (dlan)

