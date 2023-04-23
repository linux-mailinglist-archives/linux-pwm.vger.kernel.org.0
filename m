Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB56EC185
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Apr 2023 19:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjDWR7z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Apr 2023 13:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDWR7y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 23 Apr 2023 13:59:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B22E60
        for <linux-pwm@vger.kernel.org>; Sun, 23 Apr 2023 10:59:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-958bb7731a9so179782566b.0
        for <linux-pwm@vger.kernel.org>; Sun, 23 Apr 2023 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682272792; x=1684864792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C64A0dsE3cz/VSxxzDX9cD4SWqMcPZ5sOUVKtV/7k14=;
        b=V+cHIDG6x/qtvEaBgAvD+5TiN/RlOxI2/koCW+pkpWGvr+JR/DiJ8N9mPpdgBZ7g0u
         s8dITIz6jTFqHocpokqgwVg+gkB4HyukW/CX5vxlNJHMhNF1b7GIhFdQ1WEQvRhpS0sh
         XpjmbTMwH+x6OcpNhkilFUuQfGD+V3lOX9cJz2Y+3j7vUOGglA5JNtYNGGRUcOwZZeXP
         6yiT6YThiRbZuK22db96MZU0/5K7TO2phC2wYjaZ501DuJeKlRdRUDA0JxCIN0BNZdZm
         59mlEdO+mtqOmBqmmKfpNRFep1dNGvJJcr/CCWDW1lQPo60m/RBzercm6gzsl13yDVFC
         CbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682272792; x=1684864792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C64A0dsE3cz/VSxxzDX9cD4SWqMcPZ5sOUVKtV/7k14=;
        b=kBzsBvmR6IlTRNxR1h8KQDS9yYM+u9+yDvvQ6akZWFmb2DlzbNXktrUhU4FDAwbfO6
         l4w9imUZ363TbY8GTrWNEdG+xei9yZF2Z9JWLfBhtqFHcB+L/HQOEgQUeFK33qaHFXxX
         YHciA0gynzqlMj25DUQgAEb82ctR54HmTqx8PPdY+TdC+aJLiDoL+ADnYxSotFv5vKJQ
         bz2tipl1EjWlpcwkgGoySyaFmJf/6HyyieuxeBhzOylvehw5mlPYwTw6MqJaJ+8CXiiZ
         kIeOcS23Ys8RKtOWXVuoMZO6rM/9euQIDKro/omNR/cznU1D1XKmhPz1LsAn0f+6E00D
         wG0Q==
X-Gm-Message-State: AAQBX9cKj5fjrBodM+DUgoc/8K7qi0pIC0F3dkGARSC5QzZJlYq4CvPF
        S3w4OhXwQWYt41O+9/WFerh3dgZkkyToA259lLo=
X-Google-Smtp-Source: AKy350YDbpNGHB6yJxs24uoSutOLtuIogeMZt2ANhq1PG1ddyqqXndVZ4QEUuAtvzsrZhzyHhxcSR0su7uVnbDEP0Jg=
X-Received: by 2002:a17:906:1498:b0:94f:322d:909c with SMTP id
 x24-20020a170906149800b0094f322d909cmr8196354ejc.34.1682272791598; Sun, 23
 Apr 2023 10:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <5a5920db-4c32-25e8-d1e3-bd2f724dd242@gmail.com>
 <20230421145723.oq7zqbhhz4fhkmyj@CAB-WSD-L081021> <5b1a84ee-1f96-1585-5167-4f4e266a7fb7@gmail.com>
 <20230421191416.yg5tbkm6n2mg2kpg@CAB-WSD-L081021>
In-Reply-To: <20230421191416.yg5tbkm6n2mg2kpg@CAB-WSD-L081021>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 19:59:40 +0200
Message-ID: <CAFBinCDUT6EG1ZqEu=c-MGM1+DVUN+uGHqmbBU5m5iWzmni0RA@mail.gmail.com>
Subject: Re: [PATCH] pwm: meson: simplify calculation in meson_pwm_get_state
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org, kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Apr 21, 2023 at 9:14=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
> > > Inside this patch, in my opinion, you have not only simplified and
> > > optimized but have also modified the logic. It is important to provid=
e
> > > more details on this modification. Previously, in cases where
> > > (channel->lo !=3D 0) && (channel->lo < channel->hi), period and duty_=
cycle
> > > were not calculated. However, in your patchset, duty_cycle and polari=
ty
> > > are calculated and returned to the caller in such cases.
> > > Can you please share the details of why this is the right solution?
> >
> > It's the obvious solution. I see no reason to return all zero's for
> > lo < hi, and also the commit that added this calculation doesn't provid=
e
> > an explanation. It just references the calculation in meson_pwm_calc(),
> > however I fail to see that lo < hi is treated differently there.
> >
> > c375bcbaabdb ("pwm: meson: Read the full hardware state in meson_pwm_ge=
t_state()")
> >
>
> Actually, I don't see any arguments to bypass the case where lo < hi,
> so the current implementation of get_state() is questionable.
> I think it would be better to wait Martin's opinion why meson_pwm_calc()
> logic was inversed with such conditions.
To be honest: I don't recall why I did it like that. So please go with
Dmitry's suggestion (to update the patch description that this
"optimization" is now gone).
