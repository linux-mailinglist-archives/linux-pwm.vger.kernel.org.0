Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B1E6B6B02
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Mar 2023 21:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCLUWp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Mar 2023 16:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjCLUWo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Mar 2023 16:22:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239BC302B3
        for <linux-pwm@vger.kernel.org>; Sun, 12 Mar 2023 13:22:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s11so40855904edy.8
        for <linux-pwm@vger.kernel.org>; Sun, 12 Mar 2023 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678652561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vgKQykf8brlyi2LczfMpXiOtdb7XUjoPCnvpJA0pRs=;
        b=YT8RIQLwpR+tSYlk+sID86w7gAf88qf1mwYjMQGZq/3DjPZxCc4/18g2C+SETqngso
         znC29F8dqIU9jU6JpYoiziU+bjyurLKdVySoGWGjynYrFTxAKjlp5kfMgr2qJUaWrHnD
         IS3j5O8KOoyC+9rtFQVTDcIyNVclxyElqzfhBPwbshReVv5ocAfKRavoKjmmLwuTx35Z
         kGB6xIDN4IhjussmxbbcsbgzuutPBGfIkscXraUXjhWEhIz5OsubQ5QF99vFVLW3Ut68
         KRxV/eTxAAdbj/zINgG4dJKP/6m3lkh/963JpGXNtlOugPyBdIi/BgUSFeHL9saxYIv8
         fE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vgKQykf8brlyi2LczfMpXiOtdb7XUjoPCnvpJA0pRs=;
        b=T4U/ne+FKKhQwddepaqt56tIiCbyU55UGxsWfXi8u1c5jbUTWSmsyMZdGnKi3w4+Yr
         5xGyICriu6iARmnJYIPE1+/49b12M3MCJCz+8WjHTxCXWC9fhWpzOD5TmMTbGhD5JmQc
         6GCEyRqMnAqLJTYAmFrhaLPWxHhazoPGDk93Qn5spWQ9K6sgXschuwtST0Zfxx0bxEnE
         QUjvgYgYpjaGVD6aIlqicbp5d8D1F8E51Dbfp/IU0BMEyo8O+cCGn8vDYISEKXiHVw+o
         oWqDMW+z5VcBmM57r0ieKF+ytXyvJy03QgIYZD1Pi8a0RuXWEFvDCFKR5P2Q1GHWTyNK
         u7fw==
X-Gm-Message-State: AO0yUKWBEuJgnrt1RcqwTT7Xr2S120W4ed4Ojg/rMHNPAD9RgqpYFirs
        GgHhpZBrl36UAj+YWPeZ1r8eLUCpeEOVh5P+TmU=
X-Google-Smtp-Source: AK7set/qNs3L4eRqxYEPRVan4gRI7HN4pAYdNAoLm6Zm7ma4MQdbrxQCfljfgh/mN9ImyMV604xueQF8Dz1mt7ZDiN0=
X-Received: by 2002:a17:906:e58:b0:922:ff34:d814 with SMTP id
 q24-20020a1709060e5800b00922ff34d814mr2004946eji.6.1678652561372; Sun, 12 Mar
 2023 13:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230310191405.2606296-1-u.kleine-koenig@pengutronix.de>
 <CAFBinCCfqgBkHq2fFy=d+8C6nwq=wehu9nzePfwuY5ndfLMWoQ@mail.gmail.com> <20230311214437.tdv5wl5a6qgsewd4@pengutronix.de>
In-Reply-To: <20230311214437.tdv5wl5a6qgsewd4@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 12 Mar 2023 21:22:30 +0100
Message-ID: <CAFBinCAVSjNWytfCfxFmS_OfVNNyzzwfxh3i_9+ufaw6qwDdbg@mail.gmail.com>
Subject: Re: [PATCH] pwm: meson: Explicitly set .polarity in .get_state()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Mar 11, 2023 at 10:44=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Sat, Mar 11, 2023 at 10:00:50PM +0100, Martin Blumenstingl wrote:
> > Hi Uwe,
> >
> > On Fri, Mar 10, 2023 at 8:14=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > [...]
> > > There is a complicating fact, that the .apply() callback fakes suppor=
t
> > > for inversed polarity. This is not (and cannot) be matched by
> > > .get_state(). As fixing this isn't easy, only point it out in a comme=
nt
> > > to prevent authors of other drivers from copying that approach.
> > If you have any suggestions on how to fix this then please let us know.
> > I don't recall any board needing support for inverted PWM - but they
> > may be out there somewhere...
>
> And that's the problem. As the hardware doesn't support inverted
> polarity there is no way to implement it correctly. The only right way
> would be to return -EINVAL in this case, but this might break some
> consumers.
>
> I have an idea how to evolve the PWM API. That's by introducing an
> .offset parameter to struct pwm_state. This would describe the following
> PWM signal:
>
>
>    ___________/=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF\___=
____________/=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF=C2=AF\____
>    ^                         ^                         ^                 =
        ^                         ^
>    <------ period ---------->
>    <- offset->
>               <--------> duty_cycle
>
> This is more general than polarity: It can describe normal polarity
> (.offset =3D 0) and inversed polarity (.offset =3D .period - .duty_cycle)=
.
>
> Then the policy to implement a pwm_state like that would probably be:
>
>  - Pick the biggest period not bigger than requested
>  - for that period pick the biggest duty cycle not bigger than requested
>  - for that period and duty_cycle pick the biggest offset not bigger
>    than requested.
>
> With these rules in place it would be allowed to configure normal
> polarity for a request with inverted polarity, but not the other way
> around. Then the algorithm currently implemented in the meson driver
> would be allowed.
>
> A consumer that doesn't care about the offset (i.e. most drivers) could
> just pass .offset =3D .period - 1.
>
> To be practical for consumers who care about polarity, we first would
> need a way to test the capabilities of a PWM though. I have an idea for
> that, too, but today this is still vapourware.
In my opinion your proposal makes sense. I don't have the time to
implement it myself at the moment though. I can help test on some of
the Amlogic SBCs that I have (and use a cheap signal analyzer I have
to look at the generated PWM signal).


Best regards,
Martin
