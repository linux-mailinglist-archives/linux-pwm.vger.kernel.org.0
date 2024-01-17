Return-Path: <linux-pwm+bounces-823-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A51C830033
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jan 2024 07:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A09D1F25377
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jan 2024 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148C8BFC;
	Wed, 17 Jan 2024 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hgBxX9gg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F42BE4B
	for <linux-pwm@vger.kernel.org>; Wed, 17 Jan 2024 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705473465; cv=none; b=TgMgqf41dna+9fyG9Myjcgi9j1OB1F1IBDL7M8Dy2jR9NXsvmIt2ornSp+ORYk7GUBxpyUPZ3MJYMN95ZFpUGQiXFfPEhG8LuAItAb+Fbby1z93YfL8MLjlOuaxcUCxKTUXklMYkUO2rCzwyDAukkl+dd05H/aT8ydpAtgcu528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705473465; c=relaxed/simple;
	bh=LTeE/mqnWiVhvUUWjvdKUrRjy41JL2x7cpg5UntPi/w=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=aXviNOgiivwLbOa43e8G/TpeWwZFgL349fkEAxLvtMr8y6iVUVavcNAb9J7h/6O/qa07zFwE+4s4HVJTUV8KR46GuYqgOU4k36ETeITJ2JND0NrkLIb0oFCwU6afgNbhykQs6QRnq4Vqcp+dW35K8IWZq8Sfsm+vfmWmFFAjov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hgBxX9gg; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ff45dc44d1so19418087b3.2
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jan 2024 22:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705473461; x=1706078261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MjS89mx0sQXy2eTiKmRoWh0TgEsc77yp3/tG8fkBm0=;
        b=hgBxX9ggpFPAjQaLWUzITDG+iFQ0/t5S7zqEW3eIun443YWPGac9ikSbPDpxRCAXWc
         ypmk/vcG7cmQTIbcrZBXxmNT2QQZcC1M+jWAzLEVpMWpjBmSCmFUKPSb8DWq/e081FWB
         FRK9jMJ1DSLn3NFdld3Kj6PGRdIDBBVmOPDahNr01MFac2lHM5r8RjASCiVfG3zrO+wG
         XefQ6fCBrFjX/aFmLKKv6gywp88DhGpVCncpZQYZ+AOOOVMdT5HM6nu5/mqELJSpnZM6
         upefClyn35gMHaYPX6NtssZvLLCL7JTaC9MfGfc7/aBokk+cXKnufyPMAzOEAfZTFnvI
         L+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705473461; x=1706078261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MjS89mx0sQXy2eTiKmRoWh0TgEsc77yp3/tG8fkBm0=;
        b=g97m77JnFUOr09hM4dD4ly77eUeDXk1YNZ+R6hQJSt/U/wXd+FnjevqYf4OdrUjWMo
         UfZfayhv2jecgZ15dgjDuR3qC+tSFzppbbCDnO/8xO8MKaYyqsdHqrGjWGkDFgyq2GNn
         yF2Emb6i5FlDmcNZHKpSMoORLOgUWYik0YVihX+nEs7wQKDZ0NUTXmPef+T2XuH5Ckq6
         x8be1Nd0cIhPwCA005ee9fMI06KFtycjrgakHkyi0evHUSoFss9RQiFTVQu8eyoq8OTx
         +bq0JmhtwI17kz9Kbsj1e2tbjJLXgvblfqs9Puvmke6ufGe/sRy7mIvlFuoje69tAkko
         03iw==
X-Gm-Message-State: AOJu0Yx5NuR/2VsFOeSsyS0dh7dW3AwiySq30mtIu16Lpe7pYltJoAmB
	muCMAGFO4AcYD3ZqOLoG5UIfPH3iw2e6YQEO6UjR0m4H/jroXA==
X-Google-Smtp-Source: AGHT+IFEMyWcAcqOEFbcyT/yrtYZJx8PYnYGhp0KuSEal/fflTbBO9CbsaFUxysMnyygE2daNgRd/NjFO6m06R+oiAo=
X-Received: by 2002:a25:ab52:0:b0:dc2:3bb2:61 with SMTP id u76-20020a25ab52000000b00dc23bb20061mr367501ybi.90.1705473461632;
 Tue, 16 Jan 2024 22:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116041054.11641-1-nylon.chen@sifive.com> <20240116041054.11641-2-nylon.chen@sifive.com>
 <CAJM55Z9ZbmbPKaJ8LJ5KyoCW9fAEJaT3Q4PbcadwLNCq1NXbxA@mail.gmail.com> <20240116-custard-drew-9a02e83d538a@wendy>
In-Reply-To: <20240116-custard-drew-9a02e83d538a@wendy>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Wed, 17 Jan 2024 14:37:30 +0800
Message-ID: <CAHh=Yk_dye_KMXbug1VwYXU0Wm-mZgx_t-oJx1N0uYVByb1z7Q@mail.gmail.com>
Subject: Re: [v6 1/3] riscv: dts: sifive: unleashed/unmatched: Remove PWM
 controlled LED's active-low properties
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com, 
	aou@eecs.berkeley.edu, zong.li@sifve.com, vincent.chen@sifive.com, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Conor Dooley <conor.dooley@microchip.com> =E6=96=BC 2024=E5=B9=B41=E6=9C=88=
16=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:45=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Tue, Jan 16, 2024 at 02:20:57AM -0800, Emil Renner Berthing wrote:
> > Nylon Chen wrote:
> > > This removes the active-low properties of the PWM-controlled LEDs in
> > > the HiFive Unmatched device tree.
> > >
> > > The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-sch=
ematics-v3.pdf[1].
> > >
> > > Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7b=
f8453f8698_hifive-unleashed-a00-schematics-1.pdf [0]
> > > Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e6=
8ce76f4192_hifive-unmatched-schematics-v3.pdf [1]
> > >
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Co-developed-by: Zong Li <zong.li@sifve.com>
> > > Signed-off-by: Zong Li <zong.li@sifve.com>
> > > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > ---
> > >  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++----
> > >  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++-------=
-
> > >  2 files changed, 8 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/ar=
ch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> > > index 900a50526d77..11e7ac1c54bb 100644
> > > --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> > > +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> > > @@ -49,7 +49,7 @@ led-controller {
> > >             compatible =3D "pwm-leds";
> > >
> > >             led-d1 {
> > > -                   pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> > > +                   pwms =3D <&pwm0 0 7812500 0>;
> > >                     active-low;
> > >                     color =3D <LED_COLOR_ID_GREEN>;
> > >                     max-brightness =3D <255>;
> > > @@ -57,7 +57,7 @@ led-d1 {
> > >             };
> > >
> > >             led-d2 {
> > > -                   pwms =3D <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> > > +                   pwms =3D <&pwm0 1 7812500 0>;
> > >                     active-low;
> > >                     color =3D <LED_COLOR_ID_GREEN>;
> > >                     max-brightness =3D <255>;
> > > @@ -65,7 +65,7 @@ led-d2 {
> > >             };
> > >
> > >             led-d3 {
> > > -                   pwms =3D <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> > > +                   pwms =3D <&pwm0 2 7812500 0>;
> > >                     active-low;
> > >                     color =3D <LED_COLOR_ID_GREEN>;
> > >                     max-brightness =3D <255>;
> > > @@ -73,7 +73,7 @@ led-d3 {
> > >             };
> > >
> > >             led-d4 {
> > > -                   pwms =3D <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> > > +                   pwms =3D <&pwm0 3 7812500 0>;
> > >                     active-low;
> > >                     color =3D <LED_COLOR_ID_GREEN>;
> > >                     max-brightness =3D <255>;
> > > diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/ar=
ch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > > index 07387f9c135c..b328ee80693f 100644
> > > --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > > +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > > @@ -51,8 +51,7 @@ led-controller-1 {
> > >             compatible =3D "pwm-leds";
> > >
> > >             led-d12 {
> > > -                   pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> > > -                   active-low;
> > > +                   pwms =3D <&pwm0 0 7812500 0>;
> >

Hi Emil and Conor, thanks for your feedback.
>
>
> > Here you remove the active-low property, but you don't above. I'm not s=
ure
> > what's the right thing to do, but I would have expected the same change=
 in both
> > places.
>
For this patch, all "active-low" should be deleted. This is my
mistake. I will fix it in the next version.
>
>
> Just to note, the original version of this that I acked/reviewed removed
> the property from all led nodes. I then apparently didn't look closely
> enough at v5 and left acked/reviewed tags on it too. It did not remove
> the active-low properties but this change was not mentioned in the
> changelog for the series.
Sorry Conor, I apologize for any confusion I may have caused.
>
> D4 on the unleashed and D12 on the unmatched have the same circuitry
> (modulo the placement of the series resistor) so I don't get why the
> property is being removed from only D12.
>
> I rescind my ack/review until that is clarified and/or fixed.
>
> Thanks,
> Conor.
>
>
> > >                     color =3D <LED_COLOR_ID_GREEN>;
> > >                     max-brightness =3D <255>;
> > >                     label =3D "d12";
> > > @@ -68,20 +67,17 @@ multi-led {
> > >                     label =3D "d2";
> > >
> > >                     led-red {
> > > -                           pwms =3D <&pwm0 2 7812500 PWM_POLARITY_IN=
VERTED>;
> > > -                           active-low;
> > > +                           pwms =3D <&pwm0 2 7812500 0>;
> > >                             color =3D <LED_COLOR_ID_RED>;
> > >                     };
> > >
> > >                     led-green {
> > > -                           pwms =3D <&pwm0 1 7812500 PWM_POLARITY_IN=
VERTED>;
> > > -                           active-low;
> > > +                           pwms =3D <&pwm0 1 7812500 0>;
> > >                             color =3D <LED_COLOR_ID_GREEN>;
> > >                     };
> > >
> > >                     led-blue {
> > > -                           pwms =3D <&pwm0 3 7812500 PWM_POLARITY_IN=
VERTED>;
> > > -                           active-low;
> > > +                           pwms =3D <&pwm0 3 7812500 0>;
> > >                             color =3D <LED_COLOR_ID_BLUE>;
> > >                     };
> > >             };
> > > --
> > > 2.42.0
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

