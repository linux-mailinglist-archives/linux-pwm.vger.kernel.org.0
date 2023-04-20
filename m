Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4D6E90D5
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Apr 2023 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjDTKsi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Apr 2023 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjDTKsG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2023 06:48:06 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CC73C32
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 03:46:43 -0700 (PDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 087BE41B34
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 10:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681987588;
        bh=F3y8BN0jlMaf7/OefEZ2rjMsbi1pghhAI/wUe5Hh9AI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=no12jD7QtVp8Bwzu8I+pe6tt1FXahbR7q6zKQuZ3Ofq9xTu9N0gCArHN2tifxa2Ke
         KvRnxKT/zJXPbbIVM+K3MzZaiDKXEZlfgl3A1Jq7oB8jAFJbFdSzNS410VBemri1wm
         U5evEulrZy6s3/Gwd7hdsjuFx8hTmqla3VoG9o61InqVhhl1aRYJALCIW2f+kFJDpL
         8TOn1ct8rgMPI57qOlnoZsOEw0Z+KCmr7Ihoq9P+rCzR2u+M3cGu/tG1GgcfLdqM5r
         r109UntZkGlLNv6fwviJmH2u1Cp8Ta625baU1QUuieoaO2lDx9D+rFazea05o16irT
         Etp9wJIu1kZeg==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3ef2cfafed4so3307601cf.1
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 03:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987587; x=1684579587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3y8BN0jlMaf7/OefEZ2rjMsbi1pghhAI/wUe5Hh9AI=;
        b=CXtZnlkvO6tOoxbFpJNKz0qKtQRxLzxN5/tP4wb0QcHC2wTuTlGZx0xpnCz3FAiBxC
         xTpItlFE1pKTBKPmyrIOPS//jBauB1Irkp2TTNmcb1i6fbX6udkZK7lfL7wWsLv+yPLG
         T3EnoooadT5Kmht4LI8amsjHSVDDA/yybLmVbP3unooJaJfqgugDicddus2MyG3e43nd
         PtgoCmn48TN9uaXm8X3z96cDMQe1WMY/YwOPVF+uV/WKFI4ZDo+OSow9o2IgDjlVqV9e
         PLkN1RVzTUXW+wl0fWxdz+odJRMdFI/ZxXM2rvMzxbAmXj0JNPTQ4jLNdfZMlNC+W1RG
         OdWA==
X-Gm-Message-State: AAQBX9fD1PB1FoeHn28d32BXrDERoy8jI+k0dEtRa7J59XbkW/CO8+3t
        b7jn4vg8qrn0aK6UT9G7fECz8d40B+mYMImv0eATd0w0NrtpzBAFIZ+y4LxvJROvBCqPQR0IMsj
        7EROWdRlMQ8L7m/+MXPh3gpSZBUFE1hXqPrKJFVCxmmJn/TRw+4sqcg==
X-Received: by 2002:a05:622a:170b:b0:3ef:484e:7973 with SMTP id h11-20020a05622a170b00b003ef484e7973mr1456662qtk.14.1681987586889;
        Thu, 20 Apr 2023 03:46:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350aPYR7Fs/UFZEmSN2soKoZh191KzwTCbW7h0Z/qNLwNI/EkX6rPG4MJfxnGXHnvGnaLWVGWBBsurS54hcEETGE=
X-Received: by 2002:a05:622a:170b:b0:3ef:484e:7973 with SMTP id
 h11-20020a05622a170b00b003ef484e7973mr1456646qtk.14.1681987586654; Thu, 20
 Apr 2023 03:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230420093457.18936-1-nylon.chen@sifive.com> <20230420093457.18936-3-nylon.chen@sifive.com>
 <CAJM55Z-smXpgL+QyTSeAWt=B-RS_qtbrFZtJpP-cQS0gsQnDSw@mail.gmail.com> <CAHh=Yk86AV542Y7wG6rkHTc4va1Gof3uXtj84zzK5m+khL_Aiw@mail.gmail.com>
In-Reply-To: <CAHh=Yk86AV542Y7wG6rkHTc4va1Gof3uXtj84zzK5m+khL_Aiw@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 20 Apr 2023 12:46:10 +0200
Message-ID: <CAJM55Z9TPVyJyWwWAS2FznSc8FvnR7qMxQ412eMzBkD=5abp6g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sifive: change the PWM controlled LED algorithm
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 20 Apr 2023 at 12:41, Nylon Chen <nylon.chen@sifive.com> wrote:
>
> Hi, Emil
>
> Emil Renner Berthing <emil.renner.berthing@canonical.com> =E6=96=BC 2023=
=E5=B9=B44=E6=9C=8820=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:04=E5=
=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Thu, 20 Apr 2023 at 11:35, Nylon Chen <nylon.chen@sifive.com> wrote:
> > >
> > > The `frac` variable represents the pulse inactive time, and the resul=
t of
> > > this algorithm is the pulse active time. Therefore, we must reverse t=
he
> > > result.
> > >
> > > The reference is SiFive FU740-C000 Manual[0]
> > >
> > > Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86=
ed8b16acba_fu740-c000-manual-v1p6.pdf [0]
> > >
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > > ---
> > >  drivers/pwm/pwm-sifive.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > index 393a4b97fc19..d5d5f36da297 100644
> > > --- a/drivers/pwm/pwm-sifive.c
> > > +++ b/drivers/pwm/pwm-sifive.c
> > > @@ -132,13 +132,13 @@ static int pwm_sifive_apply(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > >  {
> > >         struct pwm_sifive_ddata *ddata =3D pwm_sifive_chip_to_ddata(c=
hip);
> > >         struct pwm_state cur_state;
> > > -       unsigned int duty_cycle;
> > > +       unsigned int duty_cycle, period;
> > >         unsigned long long num;
> > >         bool enabled;
> > >         int ret =3D 0;
> > >         u32 frac;
> > >
> > > -       if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > > +       if (state->polarity !=3D PWM_POLARITY_NORMAL && state->polari=
ty !=3D PWM_POLARITY_INVERSED)
> > >                 return -EINVAL;
> > >
> > >         cur_state =3D pwm->state;
> > > @@ -154,10 +154,13 @@ static int pwm_sifive_apply(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > >          * calculating the register values first and then writing the=
m
> > >          * consecutively
> > >          */
> > > +       period =3D max(state->period, ddata->approx_period);
> >
> > Hi Nylon,
> >
> > I don't understand this patch. You introduce this new variable,
> > period, and set it here but you never seem to use it. If you planned
> > to use it instead of state->period below, why should it be the max of
> > the old period and what is requested? What happens if the consumer
> > wants to lower the period?
> Sorry this was an oversight on my part, there was a line correction that =
didn't change to
> - frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> + frac =3D DIV64_U64_ROUND_CLOSEST(num, period);

I see, so then my second question was why period needs to be the
larger of the previous period and the requested period.

What happens if the requested period, state->period, is lower than the
old period, ddata->approx_period? Then the period will be changed to
state->period below, but the calculations will be made using period =3D
ddata->approx_period, right?

> >
> > Also above you now allow both PWM_POLARITY_NORMAL and
> > PWM_POLARITY_INVERSED but you treat both cases the same.
> I may have misunderstood what Uwe means here, I will confirm again here
> >
> > /Emil
> >
> > >         num =3D (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
> > >         frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> > > -       /* The hardware cannot generate a 100% duty cycle */
> > >         frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > > +       /* The hardware cannot generate a 100% duty cycle */
> > > +       frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> > > +
> > >
> > >         mutex_lock(&ddata->lock);
> > >         if (state->period !=3D ddata->approx_period) {
> > > --
> > > 2.40.0
> > >
