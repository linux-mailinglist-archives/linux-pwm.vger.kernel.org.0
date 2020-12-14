Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B28D2D9CE9
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Dec 2020 17:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406169AbgLNQpk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Dec 2020 11:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405265AbgLNQpb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Dec 2020 11:45:31 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC01C0613D3;
        Mon, 14 Dec 2020 08:44:51 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id b190so4049695vka.0;
        Mon, 14 Dec 2020 08:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ts+4deDUbfaCD55Txrp+h4pS1G+LQIOElLBlsDcKu2c=;
        b=aREAYtXD4AkiWUFdELuBl0Qz79hppDfczkKRBz95xe/6OJTuFO2buvAmNmwmlwDvDu
         K6eri/ghcTOVS9DD8bJonEX8zeZL5jsqSKlq7w1jYUnqfjYrDvN51bZvXnnQtSso7KlJ
         8iUwdzRzGCJ+XAVdhN7HB0OUA2mS3BemeaPq28t0rpzL6mhAm9jFlN80EYgpIVireW6k
         Hj813kxEWpkqVqcC6myjk8tOwpxZYz9cYotNW6tMGgky+XeBPO+2N1dAMU2h5Ti9ICIW
         sMGhLCKxtmHfdDMJypXMDFlFfx35OcSSGmNLIQgLkBhhfKVg377+FXylZGkcDnykR3pI
         t1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ts+4deDUbfaCD55Txrp+h4pS1G+LQIOElLBlsDcKu2c=;
        b=pAjFqQkYRFHmihYbY9mugRTd+ayth6zAc4yUnTgsWsjJmQgVOrlP6fU71TiV5Ibcvo
         wxc7LG72vHxruEx0047U2YpBScbHMFTU3X/WC1hk64Y4NhDARgMDHvIACEhTbxAdL2I7
         ltwO33h/FZx04qiiGTa9veXi8HoovtTZKvAxU/NLlv9UfWC7O2D3L3UdAlblXpjpbKdu
         PhUjr1UmOAe/AdQg6Qd3BJh/JPa6kiYbArKh0xoELO7eBepPuuuo/0fzezYjgy60eRn9
         jwdw1DeYY6PcjNDzcO8IzFY3WVP272bicbfiqD7vbrSgQCkeBHpZRhW7uhUUhbvjYdSB
         OQeA==
X-Gm-Message-State: AOAM532ir9zfLSKgIAI4WPm+1TMJDgQ/fSHm6Ndr41S7vQWct73nNXnC
        vB4Vvir8LQs1pPIjctNElZkuaF0x3umg6EYmjG0=
X-Google-Smtp-Source: ABdhPJyC5TiCREgYrTnLAkj/pKa80m0ovqTKHZSHR+qU0lIChFfggiyTtODg+j9seOOjeJLuL/HazCPKoVcAcaEBgyQ=
X-Received: by 2002:a1f:9987:: with SMTP id b129mr24526507vke.5.1607964290281;
 Mon, 14 Dec 2020 08:44:50 -0800 (PST)
MIME-Version: 1.0
References: <X8+DI7ZN7mXtsxv9@ulmo> <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo> <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
 <X9EDGHySNYb7CxcW@ulmo> <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
 <X9JWlVPb9ZGdB4q9@ulmo> <20201210203926.ouzrq3ff5k6zhlvt@pengutronix.de>
 <X9Mu8zrJjFTe6fJq@ulmo> <20201211103454.tqcfzy3ayn2gz7k4@pengutronix.de>
 <X9d2iFCzSkqLu8zR@ulmo> <CAGngYiUMP8P=8nEJu2weaR11PoZ9B2OGEdaz=DEeDsLoh3gmCw@mail.gmail.com>
In-Reply-To: <CAGngYiUMP8P=8nEJu2weaR11PoZ9B2OGEdaz=DEeDsLoh3gmCw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 14 Dec 2020 11:44:39 -0500
Message-ID: <CAGngYiW8CaYQ+x0C-OevvCvtFeBqdzAYGQzTTa3nxEYUS7RMTw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

On Mon, Dec 14, 2020 at 9:28 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
>
> Perhaps Clemens and Sven can shed some light into how this driver is
> being used. There clearly seem to be people interested in this driver,
> so why are there no consumers of this upstream. What's keeping people
> from upstreaming device trees that make use of this?
>

Also, there's this section in the driver:

#ifdef CONFIG_ACPI
static const struct acpi_device_id pca9685_acpi_ids[] = {
{ "INT3492", 0 },
{ /* sentinel */ },
};
MODULE_DEVICE_TABLE(acpi, pca9685_acpi_ids);
#endif

Which means there might be arm64 or intel devices out there that define
presence of this chip via an ACPI tree. Which exists only inside bioses
and would not show up in any devicetree.
