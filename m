Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FC9308C1B
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Jan 2021 19:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhA2SGJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Jan 2021 13:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhA2SGH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Jan 2021 13:06:07 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9861C061574;
        Fri, 29 Jan 2021 10:05:26 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id e15so7878937wme.0;
        Fri, 29 Jan 2021 10:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TUmFsIXMj99gpVwAwuKHWnYGYjhbCT8uRiqDmlEl0U=;
        b=U+awAkYPZ/5PjCF3LZpLShMgbJhZ7YWMXxANLLBz+8ZPsdewtGhwFiAtFbNO8Wi0nL
         lr/1sE8CbeqbgBMKetYx7NdpBxuEj8RMzI7yc1cXvMQqN5m/Y+qG/YlQ2a72xMmJ+Cwy
         OsfPx3g0YlPUT56gyGoP9d4/fRjf7xCbXoudM23VRJAeCoMaOhtmcEjSnPRstMPEtNXA
         puCTpHmhfBlfXsbjyYmX0OdBuV6nFYU6zHdAu+O2DqRToYZtzUwSdBUtEJ/iolNoZ4N5
         DDk1IloWN8RKiB41jzitmz6P11xXmWLEaKJVLmFt0Kp8Aw0m4ppoDC2Ca5BuExG2c7qw
         5/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TUmFsIXMj99gpVwAwuKHWnYGYjhbCT8uRiqDmlEl0U=;
        b=jEFoiXlcqwSr+57aPaqYCBs0/If6NX7BPXfksO394WFHHMpeS0zFOaGi8dkqE/fjsD
         aMlHitgJHivZKCQ+HVbgghABXfglR454QfyTpsilUAXuYoU1kpPf2Xf0uM23bvJ84NW6
         uTC+nXOiI/qA+KVAJJCYsknDuLrEzK710ZcNmqYnMRvRo/9vwBz/P+SBgmiVisN+3X+8
         jFlp+0jnlCacSXWNixnZhl6JLkzgm+ubWUs/je74kPBxplwW96Gj6ppjcxspQulid2Ix
         E3KSyi0PbjlZPzA1TOBB2UlZnBTiiIOwW6r9b09qB3VOyTOUGSNMY1CQs6RjfTW9l4v0
         wdHg==
X-Gm-Message-State: AOAM531185YntYM67hiGVvH43uXlDQoQS+RhgmSMmKsKgW5my9jIjCOp
        Q+Lly6UGZ4rTMtX9mVNd5gblVqC92ggBOpgDMSY/6FRFZNU=
X-Google-Smtp-Source: ABdhPJz57Wo636UJ1TTuTVqXE7kVcZcMkXpgzTYHQOxY1NGXalEo1Bv33mIUjnES6ByErwMmYPxp6TmTNJfff+iKTHg=
X-Received: by 2002:a1c:4e:: with SMTP id 75mr5003263wma.150.1611943525234;
 Fri, 29 Jan 2021 10:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com> <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet> <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com> <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
In-Reply-To: <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 29 Jan 2021 13:05:14 -0500
Message-ID: <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 11:31 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> Ok, so you suggest we extend our get_state logic to deal with cases
> like the following:

Kind of. We can't control how other actors (bootloaders etc) program the
chip. As far as I know, there are many, many different register settings that
result in the same physical chip outputs. So if .probe() wants to preserve the
existing chip settings, .get_state() has to be able to deal with every possible
setting. Even invalid ones.

In addition, .apply() cannot make any assumptions as to which bits are
already set/cleared on the chip. Including preserved, invalid settings.

This might get quite complex.

However if we reset the chip in .probe() to a known state (a normalized state,
in the mathematical sense), then both .get_state() and .apply() become
much simpler. because they only need to deal with known, normalized states.

In short, it's a tradeoff between code complexity, and user friendliness/
features.

Sven
