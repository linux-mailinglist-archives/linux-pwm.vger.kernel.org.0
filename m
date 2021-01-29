Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DFE308F3D
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Jan 2021 22:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhA2VZA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Jan 2021 16:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhA2VY7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Jan 2021 16:24:59 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F69EC061574;
        Fri, 29 Jan 2021 13:24:19 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id z16so5554190wml.2;
        Fri, 29 Jan 2021 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZSbREg1PJwuWmIxRUAU5UQQlfQNrYrnIjGANdzroo8=;
        b=RcwcKdDriUu/A+/wM1On/mAt+3RQX6aoYhSYaL4VGJH7TM/NUfP/eHfXEkmZLzYY8A
         E7quiYuueaOm6a2g6QBTveRFdvaS6guvdvmzYzpojilHeMs4oZeEG8Gin89x+vkdOKJu
         nMzveC/3KjoeRiU/5p+2//4vmgWE/Fts2I42WxbbX9w4C3TR5UKIoRqy3c/NsDF+/fx0
         mxrlBZ2v/K6CXBepITzL/H+s3BNKJxk5ZhD7x1d1ebLB+BIrNK746HLsiJsDE/cSIsbm
         3ANuHRdIVV2ewWge/9yVNBqS4R+vRCZQ6wmTjoKIFQaOhMJaeME0RS0ARux8RHw1/AkN
         VgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZSbREg1PJwuWmIxRUAU5UQQlfQNrYrnIjGANdzroo8=;
        b=UXy4IaNW8o+hjQFsDKiHxZ6BXFFsP7ZmabwRoj2/hp7UggWPNRtqIU1wQCk2OH0Vmd
         rfyjwXxK6bvYwj5MsK+e3+HFo4YO7b4AM0jMzlPCPX2BpDyJotQD59qIQsxQQUusXTGx
         yDLdbFkSWlaFpsf20juWTDg406e6XMZ5d/6XMv/s/qQ3ceMnGyw/xoe1MhAr5iGU7j9h
         m2CmYhyeStCS9KvGWAGjnBICItB4G4XHAE9l6OFrc0lg3GEQV02QpRZndMTccGjbCC1K
         hpYR0fvsEsk1ofXSJ7m4Ps0FWK1+Ax6qTBxP2JYij92dVMai1Uuu2dputYvd9KXv3A2e
         OvCg==
X-Gm-Message-State: AOAM530S3q2v1jnDO2CzqRBzDEjKhLDkaSdV9AwFoICm0tG1hDvg13c6
        caP58bqoFrbJ2X88viPtCoZrTez0Hu+m+JJqxyy9O11c77Y=
X-Google-Smtp-Source: ABdhPJxJFjpp3lFHphg3TdU/6LbJCxJlX5Hzc6dpGn8ssHbFgt1ZfxIE1iuvWfLplKgcUkRuSh2aCV1jy4TiVIMK8No=
X-Received: by 2002:a1c:4e:: with SMTP id 75mr5568115wma.150.1611955457839;
 Fri, 29 Jan 2021 13:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com> <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet> <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet> <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet>
In-Reply-To: <YBRyG0vv3gRzygSB@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 29 Jan 2021 16:24:06 -0500
Message-ID: <CAGngYiXxfz7rtsw4zSj5QX7Lj7hvnoESqyUE_2__=oDaRmGGJQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Clemens,

On Fri, Jan 29, 2021 at 3:37 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> Is the driver really responsible for bootloaders that program the chip
> with invalid values?

No, but it's responsible for correcting invalid values. Otherwise the driver
doesn't work.

> The chip comes out of PoR with sane default values. If the bootloader of
> a user messes them up, isn't that a bootloader problem instead of a
> Linux kernel driver problem?

Invalid values are only half the problem. The other half is that two valid
values might produce the same output, e.g.:

LEN_ON = 409, LED_OFF = 1228 and
LED_ON = 419, LED_OFF = 1238
produce the same result. you can't see the difference between the two
when scoping the channel. there are probably more ways to do this,
some might surprise us. It's a tricky chip.
