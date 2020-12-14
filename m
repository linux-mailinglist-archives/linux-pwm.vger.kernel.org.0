Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E992D9CB4
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Dec 2020 17:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440254AbgLNQ2f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Dec 2020 11:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440035AbgLNQ2d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Dec 2020 11:28:33 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F86C0613D3;
        Mon, 14 Dec 2020 08:27:52 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id p7so9280963vsf.8;
        Mon, 14 Dec 2020 08:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/dJ41wzQrS/fWmX/gkz6e3GWIPT1AAo3V7XT47RGng=;
        b=fslF4tMbpOitLsJRfkkBKoFxLpSKhWEt9WX/324yk1nvhB0tmNwCCApaQtFKPqWKdB
         WphoU84CP2QxH1LtVP3TFmKQE+GLsjoYERJv8KDEZE/ewFFZmB7Ug5BdKJyhV8FillAN
         FW/0/Xf1+mrBUABHKmCsO2J4QgqimNV1eq7nZnHXxsuLs8wnMj7SD0NA2WiWzRdrgV+L
         PJqua/Jzo9asbAwsh2aPIjZ1jYxKmsJgEtDnVqb10WeSvqSO28DNlAG6Hs/ZaL46rsZC
         KLowZRMniPho9TvsQN37nTdHAbXhNKW+ykZ8bFiWbTCea8nRT4KCgyc09+lvy/m7jLMO
         5UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/dJ41wzQrS/fWmX/gkz6e3GWIPT1AAo3V7XT47RGng=;
        b=qNTeLc/av9PsVcq6oEPjZO9qyM9WhAomVfYOfHxVzMp+81O5eZUiEwxg+bl3vWxcXM
         MmUe1Azlmdasix+Jf1wTPgxyslMzdN3ecPd3p3XapZCz1E4DHGRexC/lSks6gP6GOG5I
         natbnpuEOsC6xOoRrykdk/ut9vsrhGrLNcKcjhCvaJLF9weEI2cDluObDq3j9MV8/RWt
         HsCIQhRHypmMoErrz+3pJGjF/DQK8cAyRqvEcVC2l0WEiEgOtFmEyqrl2OD2vdHpY61R
         fZ4dRizF/A6mpnfZl6b1m0wHwFPDuSoPTcMhc3GLtjrvuMoWZ68pGq3vQquYsVMxpxf8
         9bDA==
X-Gm-Message-State: AOAM531ezzbyzriHBRtXblkcvTjWdB/GXRJh+ysZYpxABInFKlR9bYnU
        le/VIqi+hEeisMXdsboFCEHyzYFPOJrqjTc5SAgKsJSLBzNv9A==
X-Google-Smtp-Source: ABdhPJwHKK/CJW0eTYTcAnQRCmAWgqmzjoKjM6MqRY3PKgdImcNPLMUx9XjXz84oLs5X197+nevI2fPPa/Y/U+s1i7k=
X-Received: by 2002:a67:507:: with SMTP id 7mr17555159vsf.42.1607963272063;
 Mon, 14 Dec 2020 08:27:52 -0800 (PST)
MIME-Version: 1.0
References: <X8+DI7ZN7mXtsxv9@ulmo> <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo> <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
 <X9EDGHySNYb7CxcW@ulmo> <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
 <X9JWlVPb9ZGdB4q9@ulmo> <20201210203926.ouzrq3ff5k6zhlvt@pengutronix.de>
 <X9Mu8zrJjFTe6fJq@ulmo> <20201211103454.tqcfzy3ayn2gz7k4@pengutronix.de> <X9d2iFCzSkqLu8zR@ulmo>
In-Reply-To: <X9d2iFCzSkqLu8zR@ulmo>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 14 Dec 2020 11:27:40 -0500
Message-ID: <CAGngYiUMP8P=8nEJu2weaR11PoZ9B2OGEdaz=DEeDsLoh3gmCw@mail.gmail.com>
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

There are many reasons why a driver may not appear in the devicetree.
In my specific case, I backported the PCA9685 driver to a 4.1 Android vendor
kernel. This is too far behind to upstream. Also, the company regards the
devicetree as a trade secret, which it is entitled to do, as devicetrees
tend to be dual-licensed (GPL and MIT).

More generally, I believe that the PCA9685 is quite popular in the Raspberry
Pi world. Raspi devicetrees are not part of mainline, for various reasons
that we don't need to get into here.

Example:
https://learn.adafruit.com/adafruit-16-channel-servo-driver-with-raspberry-pi
