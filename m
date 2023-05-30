Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8212471587F
	for <lists+linux-pwm@lfdr.de>; Tue, 30 May 2023 10:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjE3I3H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 May 2023 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjE3I3G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 May 2023 04:29:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8035A1
        for <linux-pwm@vger.kernel.org>; Tue, 30 May 2023 01:29:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5147f5efeb5so7023340a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 30 May 2023 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685435344; x=1688027344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrXV2pSkwAI+QAXUpRLRnlNnNfkWLFknVTLvl7bQmX8=;
        b=lD3LAqKUXnALaMMaXaoS9HvK65/b60q5KOMPNJKXq4x/yjBc62HmKwf3o9Ek9/zvHQ
         nSej9wJvmbV3bfAgAXlJTPbSihgkBsaVaLZWW84ogmPbszEAkkyRAsbDxX7QkaaR05wm
         Atu6SSxV+a1M+hAEsIrb1SZCYFf9sbuljS8M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685435344; x=1688027344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrXV2pSkwAI+QAXUpRLRnlNnNfkWLFknVTLvl7bQmX8=;
        b=BMwGVFMBii4RiamVxj0VbLcoHqi7kKOrx+7pNVeo10355YaeEBsxjjEoI0NkC/m9Gl
         CnvclsTfvkSYoqSW6YXqkDYJqUNfW1ST9ANJgM6agV78uJ4SZWzcTgfoP2R6b0lpKIDU
         nFemXTCLVmEdYwA7RQ1wrKv0nBJac2A1mKvCeq+nueqXFcqdu4Sf4U5D/59apwPctnnm
         YlL93/+3tVoxWetbM2k8pSd/CobcsPjStNRBqVHCAqMfDQbzwyPVFARqMAdOZN1FfeE4
         x1KPoS5qPoSURenuuKy1CUSaCQ5VflYiPgqcWEu19jh+QSHP/AV2jjoXWxxpiHW4AV5d
         FlnQ==
X-Gm-Message-State: AC+VfDyyb0Lt15E2/mOyXhvM6ujMB9lBrZWHoGefywkWBFFc7BNc2bju
        EagKtxFMgbY97DTcZj49esDdF36W47McRXQOiPw=
X-Google-Smtp-Source: ACHHUZ5+ec8AWHQEMuoaXpAPvj7HSRh9QxTiVOvdOfdZ2VeuHx2Ms99LYJbNWszZoYKFTpx6yYQOEQ==
X-Received: by 2002:a05:6402:1858:b0:506:7d65:c1fb with SMTP id v24-20020a056402185800b005067d65c1fbmr1062605edy.30.1685435344031;
        Tue, 30 May 2023 01:29:04 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7c41a000000b005027d31615dsm4040679edq.62.2023.05.30.01.29.01
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 01:29:02 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso28250985e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 30 May 2023 01:29:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3787:b0:3f6:1e6:d5a2 with SMTP id
 o7-20020a05600c378700b003f601e6d5a2mr946577wmr.4.1685435341339; Tue, 30 May
 2023 01:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230518115258.14320-1-shuijing.li@mediatek.com> <0ff74fff-9e48-e2a6-617c-13d4cfc2e157@gmail.com>
In-Reply-To: <0ff74fff-9e48-e2a6-617c-13d4cfc2e157@gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Tue, 30 May 2023 16:28:24 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhVrbaAh2u7rG-=-RubsxTZvMBRZO-t0NA8jG7M8187EA@mail.gmail.com>
Message-ID: <CAC=S1nhVrbaAh2u7rG-=-RubsxTZvMBRZO-t0NA8jG7M8187EA@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: mtk_disp: Fix the disable flow of disp_pwm
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Shuijing Li <shuijing.li@mediatek.com>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 29, 2023 at 6:43=E2=80=AFPM Matthias Brugger <matthias.bgg@gmai=
l.com> wrote:
>
>
>
> On 18/05/2023 13:52, Shuijing Li wrote:
> > There is a flow error in the original mtk_disp_pwm_apply() function.
> > If this function is called when the clock is disabled, there will be a
> > chance to operate the disp_pwm register, resulting in disp_pwm exceptio=
n.
> > Fix this accordingly.
> >
> > Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
>
> We are missing a fixes tag here.
> Fixes: 888a623db5d0 ("pwm: mtk-disp: Implement atomic API .apply()")
>
>
> with that:
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Tested-by: Fei Shao <fshao@chromium.org>

>
> > ---
> > Changes in v2:
> > Use
> > if (A && B) {
> >       something();
> > }
> > instead of
> > if (A) {
> >       if (B) {
> >               something();
> >       }
> > }
> > per suggestion from the previous thread:
> > https://lore.kernel.org/lkml/20230515140346.bxeu6xewi6a446nd@pengutroni=
x.de/
> > ---
> >   drivers/pwm/pwm-mtk-disp.c | 13 +++++--------
> >   1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> > index 79e321e96f56..2401b6733241 100644
> > --- a/drivers/pwm/pwm-mtk-disp.c
> > +++ b/drivers/pwm/pwm-mtk-disp.c
> > @@ -79,14 +79,11 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >       if (state->polarity !=3D PWM_POLARITY_NORMAL)
> >               return -EINVAL;
> >
> > -     if (!state->enabled) {
> > -             mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->ena=
ble_mask,
> > -                                      0x0);
> > -
> > -             if (mdp->enabled) {
> > -                     clk_disable_unprepare(mdp->clk_mm);
> > -                     clk_disable_unprepare(mdp->clk_main);
> > -             }
> > +     if (!state->enabled && mdp->enabled) {
> > +             mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN,
> > +                                      mdp->data->enable_mask, 0x0);
> > +             clk_disable_unprepare(mdp->clk_mm);
> > +             clk_disable_unprepare(mdp->clk_main);
> >
> >               mdp->enabled =3D false;
> >               return 0;
>
