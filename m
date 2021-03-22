Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFADA344008
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCVLlU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCVLlO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:41:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE68AC061574;
        Mon, 22 Mar 2021 04:41:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso8362928pjb.3;
        Mon, 22 Mar 2021 04:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EIQgvdeDjnmWWKbsRqKq4n3TDYblw0NK5hlNUEV3b/s=;
        b=LYrpjYaHyqQft0gjUeIevpjw7UDx+Zj4qCfxZCTVZIYFLK3+TcZMp6ZbahHww0+ZE9
         vq2Dw4rwYLDVCsoYgYs+W7Kl08BIMzHMMOilro1Cn+P6hVT6hz05fWicAdYV48eeor0s
         iZpjZ6Zef063THkojd290tZMnVDj+ngoqLJYxdY20M3YF40EaviKBP5I4ZG0S9/d1csY
         CLO2kkVduTdV5RHz5OkofEBwt0Cg5pLsyobW3RhHpX7q0GWmkLNj2NibJ6Dfj6OMr2N4
         tw1QJztOVq+M2srsqC7b5Z0RD3k6zVDOqz4NKH5w3saWwVZUIuT8yRn+gMY8+JkVgHlH
         3pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EIQgvdeDjnmWWKbsRqKq4n3TDYblw0NK5hlNUEV3b/s=;
        b=bo5rYBqE8Lf8AOaa7Cfe1DoO3Exg00W/oVQfC8xGcefG3tpyhazS2cKZRqISP7aGAB
         COBI1x6TXbk+r9P6wu1LJx2hG0DL7fTQt6AeayTIZlxztjEwdnFqnZxnjG5rdIfo4Bh0
         IiQlaOv6Zje6CCtKvEPs+/h4OoxlEXGaY9HrS8Tj+txHiOpOwUVrYubvv2jP8ka8jPhN
         eYChJrSYrpj4d04baHZW5XVtj1vx81J38nncae0UUypv0vfN2WaRh0JmHQ6grN/shfXF
         ADzD2pBJNtzC1KAl05lbK6OKxGHKFr7kQi8RHAvFfb+CArl9jrUo4iiN9OYCiHXngvvW
         Rzlw==
X-Gm-Message-State: AOAM5314tTvAvZPNntd2wS7FlV1G5gJkGbLRe+FNlFG/B5YQamUumVYd
        KcxyiU10mKOCevKZsiwzyYw8SPA6Gqdex4EOCeQ=
X-Google-Smtp-Source: ABdhPJxfjPKgvozlOLyt5jcPGePmSkCaYvi2C3TVI/zNmmiZNbWViVwKep+U2TurIaCcylZkDA1GYZhv+dxu8zyEgbY=
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr13271988pjr.228.1616413273374;
 Mon, 22 Mar 2021 04:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet> <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet> <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet> <YFhhGpiHDELxIo9V@orome.fritz.box>
 <CAHp75Ve2FFEMsAv8S18bUDFsH2UkiQ5UvgcRtZ=j30syQtEirw@mail.gmail.com> <20210322112254.5mjkajkq3wnhgnd5@pengutronix.de>
In-Reply-To: <20210322112254.5mjkajkq3wnhgnd5@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Mar 2021 13:40:57 +0200
Message-ID: <CAHp75VfedZyFF46koLOg13t_TzMbwj5zBYU2zBA52vRRtb202g@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 22, 2021 at 1:22 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Mar 22, 2021 at 11:38:40AM +0200, Andy Shevchenko wrote:
> > On Monday, March 22, 2021, Thierry Reding <thierry.reding@gmail.com> wr=
ote:
> > > On Fri, Jan 29, 2021 at 09:37:47PM +0100, Clemens Gruber wrote:
> > > > Thierry: Would you accept it if we continue to reset the registers =
in
> > > > .probe?
> > >
> > > Yes, I think it's fine to continue to reset the registers since that'=
s
> > > basically what the driver already does. It'd be great if you could
> > > follow up with a patch that removes the reset and leaves the hardware=
 in
> > > whatever state the bootloader has set up. Then we can take that patch
> > > for a ride and see if there are any complains about it breaking. If
> > > there are we can always try to fix them, but as a last resort we can
> > > also revert, which then may be something we have to live with. But I
> > > think we should at least try to make this consistent with how other
> > > drivers do this so that people don't stumble over this particular
> > > driver's
> >
> > I guess we may miss (a PCB / silicon design flaw or warm boot case) whe=
n
> > boot loader left device completely untouched and device either in wrong
> > state because if failed reset (saw this on PCA9555 which has a
> > corresponding errata), or simply we have done a warm reset of the syste=
m.
> > So, we also have to understand how to properly exit.
>
> I don't think that not resetting is a real problem. My argumentation
> goes as follows:
>
> When the PWM driver is loaded and the PWM configuration is invalid, it
> was already invalid for the time between power up (or warm start) and
> PWM driver load time. Then it doesn't really hurt to keep the PWM
> in this invalid state for a little moment longer until the consumer of
> the PWM becomes active.

But this won't work in the cases when we have a chip with a shared
settings for period and/or duty cycle. You will never have a user come
due to -EBUSY.

> Together with the use cases where not resetting is the right thing to
> do, I'm convinced not resetting is the better strategy.

I'm on the opposite side, although I know the cases that resetting
maybe harmful (to some extent).
We definitely need a hint if we may or may not touch 1 or more
channels of a given PWM.

> > Another point, CCF has a bit =E2=80=9Cis critical=E2=80=9D, and u guess=
 PWM may get the
> > same and make the all assumptions much easier.
>
> So I think complicating the PWM framework for this isn't the right thing
> to do.

Again, I'm on opposite side here b/c see above.

--=20
With Best Regards,
Andy Shevchenko
