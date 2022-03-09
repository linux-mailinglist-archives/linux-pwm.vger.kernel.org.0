Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59EE4D3095
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Mar 2022 14:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiCINyn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Mar 2022 08:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiCINyl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Mar 2022 08:54:41 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0420B3E70
        for <linux-pwm@vger.kernel.org>; Wed,  9 Mar 2022 05:53:41 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id t14so2020100pgr.3
        for <linux-pwm@vger.kernel.org>; Wed, 09 Mar 2022 05:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ovut23uayW/dOdtWDs48IgggZZNTYQQls77E5j7ziJo=;
        b=VIbYQAPb5RgoGgeAmm6IcIn34FSd/45TsQD5QpOmlspgU2+VrP96K3dsSWJP8m9JuD
         UxUWdVtN6W+s0x7ONlSzJMnYdQknafc4EYiVvCwGbT85eGhBU3gk7EfC3hghMWzVns8D
         p2JVOEiIgLCFslyAuFCU0ftqrzhHjuFIQzjrC/xzSf/40+ITXctmK1RiQDf0515ROaOp
         K520bIOqwp3w/xIO4U7iMcJhcs6czKueeCQ15Rvl4bIXe5B/ILWxW6J2vB8pHQr2/5mJ
         qeerGdcPbZdA9ESvHdjgZqdkBErURJuwmnD36r0wApRiYNrh4MxRPER65QzEUwhH4ZAf
         43Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ovut23uayW/dOdtWDs48IgggZZNTYQQls77E5j7ziJo=;
        b=hVlDNru5M3K86clNeSqhhtY0yipbunwiT8du5q38slteN3wuiLq7MFR/syGIeu/YYG
         OAQ7dYZH+2lJyfy/L74CHSzWUWRpMqy3ZsdmdoqNyxFYtI0BMUHTbpDQpC+bsL29TumK
         0LQU2h0m1PwdBlYR5mgdGBEEkyI5FkkJNTZs/jl+jKI6G898fUO2eg2zqLYgt6mYf2Nt
         NVanJdCJu8AE3Vvp4S+pYmjKVuUJuXppOsbALQu0IgF+JBSfTA8BdvH+LNVsSrGHHC7+
         PsOabqVjNCiV8lodJG1mhHl81DRZtEzCGkeGX1B1yELmFPR1aU5WjMkUEIMfLQGPn60L
         jZLg==
X-Gm-Message-State: AOAM5315NPG6NaerLct4Q4iuaZd8H2cCN1cEIHKjzF0X2iyrFt6tahhp
        OVxpdkG5aRNl8C+Fdj1ZrXNAmJEVi8EwdiQkhSvy0A==
X-Google-Smtp-Source: ABdhPJyjDkbzTtT/IWdlit5fMgUxFD/5gMRctZhnTrPtEVnm6o5Bd+AYivSovav9lczEHpwiGcWbWq4H/k4r+8kqHVI=
X-Received: by 2002:a05:6a00:24cf:b0:4f7:38ea:9fd5 with SMTP id
 d15-20020a056a0024cf00b004f738ea9fd5mr6810052pfv.0.1646834021278; Wed, 09 Mar
 2022 05:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20220228183955.25508-1-jose.exposito89@gmail.com>
 <164609067646.2361501.15747139249939190799@Monstersaurus> <20220303183720.GA334969@elementary>
 <164634476693.3683041.3124143336848085499@Monstersaurus> <164639597452.3492470.16590890112062103735@Monstersaurus>
In-Reply-To: <164639597452.3492470.16590890112062103735@Monstersaurus>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 9 Mar 2022 14:53:30 +0100
Message-ID: <CAG3jFytLEHbzOHoGSoTk3WSHUBDns64aZWPwUFmhrUrQzncXGg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: switch to devm_drm_of_get_bridge
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        andrzej.hajda@intel.com, linux-pwm@vger.kernel.org,
        jonas@kwiboo.se, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, thierry.reding@gmail.com,
        laurent.pinchart@ideasonboard.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, maxime@cerno.tech
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 4 Mar 2022 at 13:12, Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Jos=C3=A9
>
> Quoting Kieran Bingham (2022-03-03 21:59:26)
> > Quoting Jos=C3=A9 Exp=C3=B3sito (2022-03-03 18:37:20)
> > > On Mon, Feb 28, 2022 at 11:24:36PM +0000, Kieran Bingham wrote:
> > > > Hi Jos=C3=A9
> > > >
> > > > Quoting Jos=C3=A9 Exp=C3=B3sito (2022-02-28 18:39:54)
> > > > > The function "drm_of_find_panel_or_bridge" has been deprecated in
> > > > > favor of "devm_drm_of_get_bridge".
> > > > >
> > > > > Switch to the new function and reduce boilerplate.
> > > > >
> > > > > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com=
>
> > > > > ---
> > > > >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 8 +-------
> > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/=
drm/bridge/ti-sn65dsi86.c
> > > > > index dab8f76618f3..fb8e16ed7e90 100644
> > > > > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > > > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > > > @@ -1232,15 +1232,9 @@ static int ti_sn_bridge_probe(struct auxil=
iary_device *adev,
> > > > >  {
> > > > >         struct ti_sn65dsi86 *pdata =3D dev_get_drvdata(adev->dev.=
parent);
> > > > >         struct device_node *np =3D pdata->dev->of_node;
> > > > > -       struct drm_panel *panel;
> > > > >         int ret;
> > > > >
> > > > > -       ret =3D drm_of_find_panel_or_bridge(np, 1, 0, &panel, NUL=
L);
> > > > > -       if (ret)
> > > > > -               return dev_err_probe(&adev->dev, ret,
> > > > > -                                    "could not find any panel no=
de\n");
> > > > > -
> > > > > -       pdata->next_bridge =3D devm_drm_panel_bridge_add(pdata->d=
ev, panel);
> > > > > +       pdata->next_bridge =3D devm_drm_of_get_bridge(pdata->dev,=
 np, 1, 0);
> > > >
> > > > Yikes, I was about to rely on this panel variable to determine if t=
he
> > > > device is a panel or a display port connector. (Well, I am relying =
on
> > > > it, and patches are hoping to be reposted this week).
> > > >
> > > > Is there expected to be another way to identify if the next connect=
ion
> > > > is a panel or a bridge?
> > > >
> > > > Regards
> > >
> > > Hi Kieran,
> > >
> > > I'm getting started in the DRM subsystem. I couldn't tell if there is=
 a
> > > good way to access the panel pointer... I didn't manage to find it, b=
ut
> > > hopefully someone with more experience can point us to a solution.
> > >
> > > Since you mentioned display port, I'm not sure if in your case checki=
ng
> > > "pdata->next_bridge->type" could be good enough.
>
> Actually, it is. And I think this is actually cleaner (both here, and in
> the series I'm working on).
>
> > > Anyway, if this patch causes you problems, please go ahead and ignore=
 it.
> > > I'm sure the series you are working on are more important than removi=
ng
> > > a deprecated function :)
> >
> > If it's deprecated, I don't want to block it's removal. Hopefully I can
> > resume my work on this tomorrow so I can check to see what I can parse.
> > Thanks for the lead on the bridge type, I'm sure I've seen that around
> > too so hopefully that's enough. If it is, I'll rebase my work on top of
> > your patch and retest.
>
> So - my series is now working with a bit of adaptation to run on top of
> your patch, and I think the overall result is better. So:
>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>

Applied to drm-misc-next.
