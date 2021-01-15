Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A273C2F7F10
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Jan 2021 16:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbhAOPJZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Jan 2021 10:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbhAOPJZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 15 Jan 2021 10:09:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D70D23884
        for <linux-pwm@vger.kernel.org>; Fri, 15 Jan 2021 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610723324;
        bh=VDIPlwJtu+K6am39Q9BZQndomEMA77aX9f5oKEP1I8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iKf+4AEHVjX0EZWnPYhZKBy8/CSzfMD2gePIssbuPoEO5C2oqQF2/Mcy96QMZKrv/
         dnAbxM0SvB1SFenQl+1PWHwTBAnU7vDoaaZTH7+2W9Yss5oJplgtxJrcleAgT78Y9c
         mrkM+oXF/YGjCQbI9lTdyoHN/q2+Gfuwi8k3WdBQp7OiIEQctIrArI8G4q9ojSK/oZ
         cc7zrHEwrx2xgijWjcxVurJlMxlOJYteaKOYQasDVsDB+Lkd8/lukUGp/mN+I3DPj7
         eD+T6EnDL5FWPobcyF/XlzaEv/S8VnQ/nN5qEGeY4z1IlyoQGY9dSO9HXdKOVT+CNE
         IKU8LnVTcKkkQ==
Received: by mail-ej1-f45.google.com with SMTP id n26so13735084eju.6
        for <linux-pwm@vger.kernel.org>; Fri, 15 Jan 2021 07:08:44 -0800 (PST)
X-Gm-Message-State: AOAM533LrU1dPL46YXoFfgqiMWog/RyOQJVbZfenvR6oRQ0hT/zcOEuD
        NJQlOP9veirdF95mPzUV1mROxikJiTUpXwfvBA==
X-Google-Smtp-Source: ABdhPJwrFqtI0r4iSvGITLJSoZcTq/mDjtIKclvoRQLrQfTpiBhGQKtOA+cbGpd0is9ZFKxxPBkWLlPpteEYXhu43y4=
X-Received: by 2002:a17:906:31cb:: with SMTP id f11mr9436316ejf.468.1610723323014;
 Fri, 15 Jan 2021 07:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20201222213325.2656124-1-angelo.compagnucci@gmail.com>
 <20210115081318.ig76unyfp3fqhu5z@pengutronix.de> <CAL_JsqJpm28hvXepfE499Xrdt400sGN6+ZtTboVifi+hYqB44A@mail.gmail.com>
In-Reply-To: <CAL_JsqJpm28hvXepfE499Xrdt400sGN6+ZtTboVifi+hYqB44A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 15 Jan 2021 09:08:31 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ArehEEnuwC1kfeYiO1UzPnSvfr+OqhkawiPkvyy_dGw@mail.gmail.com>
Message-ID: <CAL_Jsq+ArehEEnuwC1kfeYiO1UzPnSvfr+OqhkawiPkvyy_dGw@mail.gmail.com>
Subject: Re: [PATCH] pwm: pwm-gpio: Generic GPIO bit-banged PWM driver
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Nicola Di Lieto <nicola.dilieto@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jan 15, 2021 at 9:01 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 15, 2021 at 2:13 AM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello,
> >
> > there are currently two patches with the same goal ready for review on
> > the linux-pwm list:
> >
> >   - https://lore.kernel.org/r/20201211170432.6113-1-nicola.dilieto@gmai=
l.com
> >   - https://lore.kernel.org/r/20201222213325.2656124-1-angelo.compagnuc=
ci@gmail.com
> >     (i.e. this one)
> >
> > In my eyes the former is the better one, so @Angelo: Maybe you can join
> > forces with Nicola and work on his patch set.
>
> Neither one went to DT list, so they're not in my queue. Though v1 of
> Nicola's did go to the list.

And there's a 3rd one from Vincent that I already reviewed:

https://lore.kernel.org/linux-devicetree/20200902121236.20514-1-vincent.whi=
tchurch@axis.com/

And one from 5 years ago...:

https://lore.kernel.org/patchwork/patch/612159/
