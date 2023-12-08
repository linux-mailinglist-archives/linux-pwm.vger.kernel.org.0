Return-Path: <linux-pwm+bounces-454-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D1380A01A
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 10:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138C21C2096B
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0A12B7C;
	Fri,  8 Dec 2023 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gzWDDHpC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E510D8
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 01:59:23 -0800 (PST)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D66643F62F
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702029561;
	bh=I52L/k2w6kzXxbOVc+fYqImvkAobF6tbLpZYc1bLRtI=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=gzWDDHpCnWPDKIQtHZPq1GV+X2lGTpE1+TNqphz9vYHYe6RSIbN4KeV6Z2p6NnLCP
	 QwE4hAwPk33j3R3Gk7RFbqRpiABDz6u+kyIhTTHYN3KhiBvBu9OPCHge5MgRlZX6DI
	 jgkbqHTIlkLRIQZM917MG+E402bt19xwWdu5KH3Qkokc//AhMMhMRbyPQlxg1HvRPA
	 toDrRy6Lehops0O6PxxeZPhXiISlxJDBpXdFN1/ZbkW2eRR4y2kfM7gfthboZg4eHc
	 ImohpmJjrNskkAyMtKYdJemYtpjdAxS61yRzqMk6TiKJm+hMeturRuG82a0zC7MmBe
	 dlyKOHYjc2cow==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42595dc46e3so12678431cf.0
        for <linux-pwm@vger.kernel.org>; Fri, 08 Dec 2023 01:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702029561; x=1702634361;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I52L/k2w6kzXxbOVc+fYqImvkAobF6tbLpZYc1bLRtI=;
        b=krlL1x4E9TK8a0niiRIlVPEWpxUg0Lz6jfM2/u5XJD6A2IitJgvAT+VyUAvaQnf8s7
         L47MwVxlO/Z2dE+8UTDp2ZSWhOcr4ePIGbVDb22fhyEET99fDtvuRrN655TKKA2yhGoj
         8nJ8bpv1//iWOvATSR/DkAsUaAYfOEtaz6pYBbVdvxkFrK62WhOzwslLosC7DaUS4rNc
         U4sfa158tIkyICtItPaaaTuaBWu6B8GsXHCxABosKd3UCGTMV5ZnO+nhZxs+yugH9OLl
         YywCkti40iQtZ8Jweo2qOjpc+OGa2XgMWcJVakCMg3ua7wleIbKypmWwWk9CmeVhtU8a
         yk3w==
X-Gm-Message-State: AOJu0Yz4aAnZp3SNNo8sHN8drkPlZnoLfZdL8XsHmvSgA0GHTlfvV7o/
	WMTCAC1E1Ho66i7Oe3EvibQPAWN9sQiLqORtNC42ZI1EfYnY06O8xbC5lx7y+g5gsSiOXplwmOD
	RRiKSPQnwB29mDVeh8eIUqUwiBs83Yj/5Ueveh0eBqj0rcfjugFZtBA==
X-Received: by 2002:a05:622a:1008:b0:423:8b3d:dd27 with SMTP id d8-20020a05622a100800b004238b3ddd27mr4183378qte.10.1702029560952;
        Fri, 08 Dec 2023 01:59:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK8eoihgg97ExCkr3OG2Sr5b6BsJh1tAmO9Er2+RJwXVOO4OAd2ySjPhBoRcqunDFdRDE1XU6j8lKsfr0sfyU=
X-Received: by 2002:a05:622a:1008:b0:423:8b3d:dd27 with SMTP id
 d8-20020a05622a100800b004238b3ddd27mr4183362qte.10.1702029560654; Fri, 08 Dec
 2023 01:59:20 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Dec 2023 04:59:20 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231208095252.w5n33rf5s2uzycqm@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
 <500a4f39531bd5fc61eb8ac0092e34d4b1ae2cc0.1701860672.git.u.kleine-koenig@pengutronix.de>
 <CAJM55Z9sUTNKR5EGmPOio8Uh_1+wfs0-aiKcsngUKF24JcO-QA@mail.gmail.com> <20231208095252.w5n33rf5s2uzycqm@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 8 Dec 2023 04:59:20 -0500
Message-ID: <CAJM55Z-3+6bZkP3gb6rj2gU-6TNvLizcBOv-wMspzRPygJ1K=A@mail.gmail.com>
Subject: Re: [PATCH v4 089/115] pwm: sifive: Make use of devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>, kernel@pengutronix.de, 
	Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig wrote:
> Hello Emil,
>
> On Fri, Dec 08, 2023 at 04:30:41AM -0500, Emil Renner Berthing wrote:
> > Uwe Kleine-K=C3=B6nig wrote:
> > > This prepares the pwm-sifive driver to further changes of the pwm cor=
e
> > > outlined in the commit introducing devm_pwmchip_alloc(). There is no
> > > intended semantical change and the driver should behave as before.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/pwm-sifive.c | 28 ++++++++++++++--------------
> > >  1 file changed, 14 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > index c1b412905d9e..cf3fcffe7b3a 100644
> > > --- a/drivers/pwm/pwm-sifive.c
> > > +++ b/drivers/pwm/pwm-sifive.c
> > > @@ -41,7 +41,7 @@
> > >  #define PWM_SIFIVE_DEFAULT_PERIOD	10000000
> > >
> > >  struct pwm_sifive_ddata {
> > > -	struct pwm_chip	chip;
> > > +	struct pwm_chip *chip;
> >
> > In patch 43 you do ddata =3D (void *)chip + sizeof(*chip). Shouldn't we
> > be able to get
> > the chip pointer from ddata using chip =3D (void *)ddata - sizeof(*chip=
)?
>
> That would work, but I don't want to use that implementation detail in
> lowlevel drivers. Also it's a bit obscure because not all drivers use
> the driver data located after the pwmchip. Another difficulty is that
> starting with patch #111 the memory layout changes and you can only
> determine the chip from the driver data if you know the value of npwm.
> (So you need information from the chip to get access to the chip. huch)

Ah, yeah it would of course need wrappers so drivers won't need to do the
calculation, but the last past definitely makes sense.

>
> > >  	struct mutex lock; /* lock to protect user_count and approx_period =
*/
> > >  	struct notifier_block notifier;
> > >  	struct clk *clk;
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

