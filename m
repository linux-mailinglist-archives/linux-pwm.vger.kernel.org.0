Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0314C426E02
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Oct 2021 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbhJHPsm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Oct 2021 11:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhJHPsj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Oct 2021 11:48:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF5C061762
        for <linux-pwm@vger.kernel.org>; Fri,  8 Oct 2021 08:46:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m26so8607036pff.3
        for <linux-pwm@vger.kernel.org>; Fri, 08 Oct 2021 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ctiMOgcKNZbwO+I+bqoe2efiKehJePIhv+cYstntJA=;
        b=wV8L3vXA4wnMlHP7d3ZvnoXIXRXMZHy83oyPI01WT63WO4HeMg59TXqtqkMjJ8Cq5f
         +ykidzi9ffxYunMNLRGqPC4miH6GYlkaGrEpgdF7V1RwvaxIjdOeCX+Qt1X7N1dKlBkg
         uRrLa8DMbtQ4uiAGXXGqM4aEynitnk4bVHeZokSjKJg63i8W4t7OOGwvtwWMGRUPudbE
         YfT+I3P9KPIZ2/rVaRgyhzwAB0M23xNbsaUzDbPcgHFlq0vWkZc01Db6SindT0urkgD6
         GInkOuzUuLk5G2Lc7Mv9KRcsUKtSVQbtVKX3GUMQ8Hpyu4OYLSQsIu3bgjJ1+VdYH2hL
         /4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ctiMOgcKNZbwO+I+bqoe2efiKehJePIhv+cYstntJA=;
        b=SNEJJFp+7Nr0cLaFQVWQxE6pxcdqq73JObNPqHc9jgK8Wo24A5VV9qX1F3vkEY3DX1
         dSLTXgWO/pRJ+34aOaKBLCzUiAo2kxOX1X2o5dyEh0nhT/Hv0RIHfb8hGFlN31DfdJ/O
         LGlU8XRU4i5sx0PuQAPdS5Oar2FvYEajGfHIe8lhsCEgd8wgMFyP5+gOKR9ETEjtkCYE
         HfTroyNsQFEWYwUTLzt7xDMBPX7UTm2wMDbuo+ijPF6ye4StWTh2f2oXS28rxtQpF2v+
         4pzQDE6avVQbwhMlnjYCaSagCHPcRcNhKz4cdw06Rf0ZBAkAQ2ruIDkaHvnKwU35O+KX
         pOrQ==
X-Gm-Message-State: AOAM5318+9ADHIW3y4Bzn/O0JjCIlU40FVVhhrks9C8UzSQL4VbzzxgU
        RhtbWQpEMaaS3CKUmuxBP2o821CY+R2rfHnZ9kQsVw==
X-Google-Smtp-Source: ABdhPJxCIs63N1AEVoE9JLiVqD8Rt3LAnvm0WoiU5xo+0y+SBYvO324mUTInFk7lVWtwvrA/Z8x2JuqxPbscKJasGn8=
X-Received: by 2002:a63:3643:: with SMTP id d64mr5395570pga.110.1633708004080;
 Fri, 08 Oct 2021 08:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210930030557.1426-1-bjorn.andersson@linaro.org>
 <20210930030557.1426-3-bjorn.andersson@linaro.org> <YV5vIyhy+m+Nx/gQ@ripper>
In-Reply-To: <YV5vIyhy+m+Nx/gQ@ripper>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 8 Oct 2021 17:46:33 +0200
Message-ID: <CAG3jFyuP_QDKP6iUZmte3u4s=HbxBPx2iDTR8uh=Sc=24hguVA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, MSM <linux-arm-msm@vger.kernel.org>,
        Doug Anderson <dianders@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 7 Oct 2021 at 05:51, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Wed 29 Sep 20:05 PDT 2021, Bjorn Andersson wrote:
>
> > The SN65DSI86 provides the ability to supply a PWM signal on GPIO 4,
> > with the primary purpose of controlling the backlight of the attached
> > panel. Add an implementation that exposes this using the standard PWM
> > framework, to allow e.g. pwm-backlight to expose this to the user.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Any feedback on this?

I think this series looks good, and passes all of the normal sanity
checks. So I'd like to merge it.

Uwe: Can I have your ack on patch 1?


Rob.
