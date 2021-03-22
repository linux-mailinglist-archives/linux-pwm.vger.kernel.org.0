Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A604C34409E
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 13:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCVMP4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCVMPY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 08:15:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AE2C061574;
        Mon, 22 Mar 2021 05:15:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u19so8488934pgh.10;
        Mon, 22 Mar 2021 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vLVQEbCaZ+2sASCPIVc5025gzMbQRYGdD6fBiIA+ogw=;
        b=YalbtbL5Ay1s/ZY6TELzy+l6vTrHk4GpwC/So/VQe+M9PKSXMfimPwO01NBzNedoAI
         Yew7Ce6fMBMV0IJpQOxrk8jvF8dmgwlrIRC87/+3rbMyCYB38L4q/Po3To948VmTFjaq
         fPJuIiYXjP8nKbgftyAxtAUyXDt9y4kwbVGSBVA0wXHvMQ4qM7Ba5ZYEQ/NEEg0ikw5S
         VaRZLXWvWesNNdOHxTBqew3QIZJUPPU6b/gtXrmT5QSUXSL5XjzVkkm3zz0jhDQaP4n6
         rrooTdjksXTNwEdAXQDndBD2bPlwmJrqBw/631TRMYYPJyq72UdIvBMG8Grv/QuVQ1mA
         eexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vLVQEbCaZ+2sASCPIVc5025gzMbQRYGdD6fBiIA+ogw=;
        b=DJnRB9j4WjEU1sAdlre3kunRP/KGOVzlqlsQ1f9kNTn6edzNL4AO4FPLb0UFq5MM2i
         y/zv00/4FeJkgJFw3Utsb9H060uZzcQim3hcNVMDsx8bwjHhiizFDwDnaHEmVlE7Rtzc
         oDr5dKV4ZQE2qf9EttOMRsgcPkcGW2rTzA62ZgXCHUWXOTfkZ0sLFBBOsX9xCOUMWWpT
         a4mAKxM8U2yeIRCoT9EpYFi5b+dcY90ZUTXeUMWPVXRUvWxgilgbzv3eOGVE/8OAkzH/
         XjiyRvohx+ejha4dNRcj1K6Dw5XPcATmoZ7v/zceJVWGPGBbSr0tMuFbkw+Sx4yE+6Xt
         bs6g==
X-Gm-Message-State: AOAM532g0/aI6bEoJSnG7mfRYmmGsigTX85nFpUAPB7Tb8+CM9ahpKkw
        S1O3BSwOU3LhMj7NnU54HB+pvsdW6mTJ7a4OuAk=
X-Google-Smtp-Source: ABdhPJzlKo/A09nKXiQQboNC8DZc588++KuJB0rfw2lzeEj9hNgD+0r20jDxOgfKccUB6QBb5dZyJvVycnGDab3Cgh4=
X-Received: by 2002:a62:e50f:0:b029:214:8e4a:ae46 with SMTP id
 n15-20020a62e50f0000b02902148e4aae46mr12024153pff.73.1616415324021; Mon, 22
 Mar 2021 05:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <X9uYqGboZg5DuEtf@workstation.tuxnet> <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet> <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet> <YFhhGpiHDELxIo9V@orome.fritz.box>
 <CAHp75Ve2FFEMsAv8S18bUDFsH2UkiQ5UvgcRtZ=j30syQtEirw@mail.gmail.com>
 <20210322112254.5mjkajkq3wnhgnd5@pengutronix.de> <CAHp75VfedZyFF46koLOg13t_TzMbwj5zBYU2zBA52vRRtb202g@mail.gmail.com>
 <20210322114826.ahwhbqxjxfg3nmrf@pengutronix.de>
In-Reply-To: <20210322114826.ahwhbqxjxfg3nmrf@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Mar 2021 14:15:08 +0200
Message-ID: <CAHp75Vc6YnHJdt0HhV9AZtpLHLapHZb08O5ygg++PX+u04m--A@mail.gmail.com>
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

On Mon, Mar 22, 2021 at 1:48 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Mar 22, 2021 at 01:40:57PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 22, 2021 at 1:22 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Mon, Mar 22, 2021 at 11:38:40AM +0200, Andy Shevchenko wrote:
> > > > On Monday, March 22, 2021, Thierry Reding <thierry.reding@gmail.com=
> wrote:
> > > > > On Fri, Jan 29, 2021 at 09:37:47PM +0100, Clemens Gruber wrote:
> > > > > > Thierry: Would you accept it if we continue to reset the regist=
ers in
> > > > > > .probe?
> > > > >
> > > > > Yes, I think it's fine to continue to reset the registers since t=
hat's
> > > > > basically what the driver already does. It'd be great if you coul=
d
> > > > > follow up with a patch that removes the reset and leaves the hard=
ware in
> > > > > whatever state the bootloader has set up. Then we can take that p=
atch
> > > > > for a ride and see if there are any complains about it breaking. =
If
> > > > > there are we can always try to fix them, but as a last resort we =
can
> > > > > also revert, which then may be something we have to live with. Bu=
t I
> > > > > think we should at least try to make this consistent with how oth=
er
> > > > > drivers do this so that people don't stumble over this particular
> > > > > driver's
> > > >
> > > > I guess we may miss (a PCB / silicon design flaw or warm boot case)=
 when
> > > > boot loader left device completely untouched and device either in w=
rong
> > > > state because if failed reset (saw this on PCA9555 which has a
> > > > corresponding errata), or simply we have done a warm reset of the s=
ystem.
> > > > So, we also have to understand how to properly exit.
> > >
> > > I don't think that not resetting is a real problem. My argumentation
> > > goes as follows:
> > >
> > > When the PWM driver is loaded and the PWM configuration is invalid, i=
t
> > > was already invalid for the time between power up (or warm start) and
> > > PWM driver load time. Then it doesn't really hurt to keep the PWM
> > > in this invalid state for a little moment longer until the consumer o=
f
> > > the PWM becomes active.
> >
> > But this won't work in the cases when we have a chip with a shared
> > settings for period and/or duty cycle. You will never have a user come
> > due to -EBUSY.
>
> That's wrong, the first consumer to enable the PWM (in software) is
> supposed to be able to change the settings.

If it's a critical PWM, how can you be allowed to do that?
And if so, what is the difference between resetting the device in this
case? You may consider it as a change to the settings by the first
consumer.

--=20
With Best Regards,
Andy Shevchenko
