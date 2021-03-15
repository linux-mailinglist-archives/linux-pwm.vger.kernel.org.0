Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8966F33A988
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Mar 2021 03:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCOCGR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Mar 2021 22:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCOCF4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Mar 2021 22:05:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6715AC061574
        for <linux-pwm@vger.kernel.org>; Sun, 14 Mar 2021 19:05:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j7so4905815wrd.1
        for <linux-pwm@vger.kernel.org>; Sun, 14 Mar 2021 19:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s0piWQtDSCNbIzU8n4S7bTdYYIdD8Y3AYdkii+EXSWI=;
        b=gLwvSuwLK0cZhCEkjUtdafrOy4a/3iCWyr86MWlw2o6MQlL8o3GeEVGoFAW5MioO65
         BABAdchRktAphSvzaGzMUXO/flcFE+zP2JoGB2HtAo16Pp9ZmF4StxSDXsKmbsCEWFhR
         ZTv0nA8RkuqwOyv0g8r9hptOv6vtVllNYMQxR50dvNb1wjRpqrSvQyTrCdUkwDfrAo0X
         VZQ/GdRbrbTOIPp+5ZfDtDO2ijM43CA6wSzDMAEUiiaPnHxQTWHpq7bYWDbCjTZyPIrp
         XKwZtJnkqoJM7kKNdDOcGiGZgzEScKoGPLaKdCRgJJDPO3ilIZMJNBdI2ndA6fZyB4We
         bDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s0piWQtDSCNbIzU8n4S7bTdYYIdD8Y3AYdkii+EXSWI=;
        b=m0Ch/cjft0EB5bQa0pKUWS6PlhaViWVU1CUFn8pJ9GBOsjnTKMW3DG22/CApy19kIq
         NAUDlTQ+GB+kRdD4EelDMKUl6b1i0MLu8b6ahGOqksXMTq9ftMjTohWhLXbbrFPejdod
         InPIMaGa6Jvim7JaWSso1jby5sd9GmqS9EhBg7OoCEuryFS0n60Fu6afxGPj/HvSiiGc
         XblyreRS4PgIRO9MkBZyL31WUK3EotuticsTLeizqlr9izsHymJcouD5OtJGDcMpYV4L
         a1g6ixxV77iphnTsHWmOH/Vqe7/ikH3rXDJVWKP66o4suCBMvWy1P2r1JO6vbYL3u1wt
         S5aQ==
X-Gm-Message-State: AOAM530Tup7vAYYW4Y31IHlZdR4TaGR1sYTcMd47gCBVLgJnzsq5uhua
        093oHVueOoTiZa/YZVg1fz0ND+/kqRfBNP9Fi3ZK4qmTVCo=
X-Google-Smtp-Source: ABdhPJwjZXuni6CCyN+pG2INGnh2FAe3Mg3gcXG3XSTGnzNcwJkpTj20+ebHUQ6oPBowHPMXFvGuyj7Pt6pbmiHPj9U=
X-Received: by 2002:a5d:4905:: with SMTP id x5mr24936889wrq.201.1615773954999;
 Sun, 14 Mar 2021 19:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210312085916.386422-1-u.kleine-koenig@pengutronix.de>
 <CAAfSe-uN-U8OqPErRUWmt8CUHGW+8PVZTZN1UACynozzWFA9Rw@mail.gmail.com> <20210312132840.ffusege6uat4jpat@pengutronix.de>
In-Reply-To: <20210312132840.ffusege6uat4jpat@pengutronix.de>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 15 Mar 2021 10:05:18 +0800
Message-ID: <CAAfSe-sB-2VxW3qeycT5AYhdOqCH-UVccFVpo-udRCK5S2QoTg@mail.gmail.com>
Subject: Re: [PATCH] pwm: sprd: Refuse requests with unsupported polarity
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 12 Mar 2021 at 21:28, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Fri, Mar 12, 2021 at 06:40:52PM +0800, Chunyan Zhang wrote:
> > On Fri, 12 Mar 2021 at 16:59, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > The driver only supports normal polarity and so should refuse request=
s
> > > for inversed polarity.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/pwm-sprd.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> > > index 5123d948efd6..bd6087cfb0b2 100644
> > > --- a/drivers/pwm/pwm-sprd.c
> > > +++ b/drivers/pwm/pwm-sprd.c
> > > @@ -164,6 +164,9 @@ static int sprd_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> > >         struct pwm_state *cstate =3D &pwm->state;
> > >         int ret;
> > >
> > > +       if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > +               return -EINVAL;
> >
> > Should we use EOPNOTSUPP instead?
>
> No, see 2b1c1a5d5148 ("pwm: Use -EINVAL for unsupported polarity").

Ok, and thanks for fixing this.
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
