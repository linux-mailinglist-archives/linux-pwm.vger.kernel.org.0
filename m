Return-Path: <linux-pwm+bounces-5748-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6714FA9F146
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 14:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55D716452C
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5101C3314;
	Mon, 28 Apr 2025 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="m5IuVScB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CDF9D9
	for <linux-pwm@vger.kernel.org>; Mon, 28 Apr 2025 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844426; cv=none; b=mOCtn+/CuYY+MsYT0kSDUZIFqoEsPgnHGcYLDJOsBXhmgUrN6yxYu2bAV+rIqzMRinD1n1TijpKXYUZsthyrqT8PZuD7jlHFOwwELJ4ZHFkqmRgFaXowlwbYSmQ0oDP+JjdvCPGYt2s/zpqutwDrnm7/uy1rkzOBNFftYXVORA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844426; c=relaxed/simple;
	bh=shKL21xOdXscttpIoQ70VuZ/18DPNvHC/sw5ErEbgtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptxOyvwfqVWpBBTlxHA65TAMZbwNvE+m4KSzoPlupJTV7byian0LGQ//EMyBO+woHM45rRSDhuGpOdjB96EnHodTYPQcJ2PWrXD8X39wkfO1ijRz31gW14ViZLg1by298zFpOXmnt2qV8E96/k0pV3rPJry0So61AUfjo8i9vyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=m5IuVScB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso787912466b.1
        for <linux-pwm@vger.kernel.org>; Mon, 28 Apr 2025 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745844422; x=1746449222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoDbPOw1p4YqIw8f4N+AkxYNr205WVYeWbe3sl8vltk=;
        b=m5IuVScBHK2urRNPaWJurSVvS4eRt0r04iIhJhY5p87r8BW8XT7Cfr2bhNuC9uz37j
         jzxax/n7avQGJEBQG9zPq7BA4Ypmk4xjFkRDDJaGPORuT5ys6G52WMK5D4xkO5ygH9MO
         aUlXPxhaUiafua7YU79+HR8wDgBdi+tQy2zR2RtgvQ+V2vMOFifttMlxTjHeOHOFaHaw
         wqeHwA9bFnrpwfTrQz4ruYTNkeuLaZ6i41PUYWXB+F890Sk91SolUkQRjsptTmX5jyRA
         r0vFnQ0PnSU5vqOB5syF7wml3b6sGQ9tXSi85mf/QQ/fWpQSMimrOZd2CDBU0SxLPH71
         4FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745844422; x=1746449222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoDbPOw1p4YqIw8f4N+AkxYNr205WVYeWbe3sl8vltk=;
        b=wRLHayZ19hxMKqWdFTYuYxqSBzu55tCghmH3JlGNistI0LlSLTLAMorc5NGd5TBaOE
         jk2W1GUk9Xg7/8lYPeLzmqdvtYo2wgjRLjo6XjgPDxwPMnwEKDGHzr4wm7Z0z/ELUwLk
         gYwTX0j0tcMivd4qnI4QqDDmOaJVfci5HIdNCMvGpON9eyM/91shVmBiOBa08ixSXPcs
         SI261+fRlaD5N5+/ugtIp0UjlYOs2djnus8L2POASO2U4mWXIabQdVNK8Lh1AMrHe8zb
         tH2hh5+airwJBnyusMuNsqdsQTyGd8cF3lfjRTK1PI+uc7NQdxsk748oTOU70hmCTwFL
         bhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKaAB6MUhkBA138oZGnFHrny+bEYBTAQGcYBcKsFURzZx+WFbNmwYDT43+zrDZd0rcgV4Mxr+fdlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzse/b6YlavVLgqwdWM2fBar1RwkM60O1XnpPZbAkI7ee/oXDhe
	zq49C7StyAzwBPTnR/A8VwBpQ3fSH+LunBG0LhM18bklgNDb6r8Vj7V+2KxZ5CYNYe/Wl04QBw0
	UkrhKhkdfaoqbapQIuHQH3VggHotACszyTyDUOQ==
X-Gm-Gg: ASbGnctFvVrV6ySkw7A0Gf/C3+k7XL3Sz3K8vOl8V0MQIKNuLmemBnvmRt4egJEkkkO
	jz/Rs/IlWFmhmDVry5ChKzZ2za6a1z77jzliHKHlJqn8sJfFJa1Gdg3ISzbq23xBmwAQo4QACgC
	Zgv56vmhff4YN2JnnBXTZcG4gOP8bt6lE9HA==
X-Google-Smtp-Source: AGHT+IGk5TDZtIZeyBrVJJpzccoOP1uFny6dcETQUFtcD2er4S/mHnZ1uSMgcYFWUm241dVvRYAz/RFBf7vixx+9hnA=
X-Received: by 2002:a17:907:1b0b:b0:ac7:4d45:f13e with SMTP id
 a640c23a62f3a-ace710a0eacmr1048006166b.13.1745844422192; Mon, 28 Apr 2025
 05:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420070251.378950-1-guodong@riscstar.com> <20250420070251.378950-4-guodong@riscstar.com>
 <kftfye2zn2ogyvuv7diuyrv5qkp43csbpkcqfcms2xp5lsuubm@z2kocdzkb7qk>
In-Reply-To: <kftfye2zn2ogyvuv7diuyrv5qkp43csbpkcqfcms2xp5lsuubm@z2kocdzkb7qk>
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 28 Apr 2025 20:46:50 +0800
X-Gm-Features: ATxdqUH6-_RHeS-1gOEkcXcvrWC9i9ud1F8bZVmjThNvU434y3rwyRGiOnAAjoM
Message-ID: <CAH1PCMZC5xrX07rd5bo+06zJoJDiAH3UNHqH5catwEALNJL2dQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] riscv: dts: spacemit: add PWM support for K1 SoC
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com, 
	inochiama@gmail.com, geert+renesas@glider.be, heylenay@4d2.org, 
	tglx@linutronix.de, hal.feng@starfivetech.com, unicorn_wang@outlook.com, 
	duje.mihanovic@skole.hr, elder@riscstar.com, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 4:18=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> Hello,
>
> On Sun, Apr 20, 2025 at 03:02:48PM +0800, Guodong Xu wrote:
> > diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts=
/spacemit/k1.dtsi
> > index c0cc4b99c935..e7dba623e877 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> > +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > @@ -556,5 +556,185 @@ sec_uart1: serial@f0612000 {
> >                       reg-io-width =3D <4>;
> >                       status =3D "reserved"; /* for TEE usage */
> >               };
> > +
> > +             pwm0: pwm@d401a000 {
> > +                     compatible =3D "spacemit,k1-pwm", "marvell,pxa910=
-pwm";
> > +                     reg =3D <0x0 0xd401a000 0x0 0x10>;
> > +                     #pwm-cells =3D <1>;
>
> I want to make all pwms use #pwm-cells =3D <3> in the long run. Can you

Sure. I can do this.

> please use that for the new binding? (Of course this needs adaption in
> the binding doc, the code should already be prepared for that.)
>

I got what you mean. The code change for that is already integrated into
v6.15-rc1.
Commit 895fe4537cc8 ("pwm: Add upgrade path to #pwm-cells =3D <3> for users=
 of
of_pwm_single_xlate()")

Now, if I change this #pwm-cells from <1> to <3>, without the dt-binding do=
c
changes, I would expect to see warnings (" #pwm-cells: 1 was expected") dur=
ing
  make dtbs_check W=3D3

Any suggestions when the dt-binding changes will be merged?
or I can add your patch as a dependency.
https://lore.kernel.org/all/cb799d8a5bb284cd861785a691b8d5e329300d99.173884=
2938.git.u.kleine-koenig@baylibre.com/

> > +                     clocks =3D <&syscon_apbc CLK_PWM0>;
> > +                     resets =3D <&syscon_apbc RESET_PWM0>;
> > +                     status =3D "disabled";
> > +             };
>
> The error that the build bot reports happens (I think) because CLK_PWM0
> isn't known.
>

Yes, thanks for checking. This patchset depends on the clk and reset.
I will add them as prerequisite.

-Guodong


> Best regards
> Uwe

