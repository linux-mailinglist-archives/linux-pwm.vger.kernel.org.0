Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75E92C2B4D
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Nov 2020 16:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbgKXP3v (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Nov 2020 10:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388503AbgKXP3v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Nov 2020 10:29:51 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B4FC0613D6;
        Tue, 24 Nov 2020 07:29:51 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id e5so347021vkd.4;
        Tue, 24 Nov 2020 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzMqDvn4KCnfzXBTlcAoQbSfLAaegHquLg6q24ZZ/YI=;
        b=dGEk4Hi7F2l12u6eb8YVQkLX1URP0izv4ilJuRCROid1La6R6MacmiEcwTo64C5/iU
         RX+JEybc5Kg9/585BNtOlrXsQ1laPqISGWepkJjg3jNC+xU4sNfXNX9hCY0mDTRONtso
         0X/+il8OfT+Cqu6HOtmJmfD6UDXNNLqgfIbEW96gYJrzSWzli8rt6yJJMgASdA4VGxl8
         cdcr+RSLZRKk6UUbtvFV/gzpATDjwWdiYLwGA8jcmz6qtWfdi731nEEFq2udQirDL9sA
         M1Sg0OH23Oem9bYq16UG4tnh6POs8DDftj+ndMOHKOQhucS86EXXXnr9UcyCuWvF/2Kf
         RNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzMqDvn4KCnfzXBTlcAoQbSfLAaegHquLg6q24ZZ/YI=;
        b=grZKhlc/ya2V24Q1L60Eq2K4rjbaC0q/2P9m7tvtgW870fmBET80BeRBM828mQ4nsb
         XSItOgXIsfvrG/wGSY3bxRH8Odn1wpXiJj9YKC3Tqe0HZwRoo2f2JkVSsfAmJPeAH0Vx
         9kDhueDIp2OOCFNkFEhTFdlFQwDAuftCfJzlUkSjQPEThh9LZ/qaDxViDGC9hwn7dfG4
         hDlGkqTyt4P7LOodv3whqD0ModBkX+UZgpksXnPzhhEg5eBhOFGp43v8JcphbA+1h5sH
         XwRR7wo94Ll6gAJybVAXH8Z7TgyuPIPyuHNwWzB3Y9Bh8Es4wqu5hcK7QJ+AsLtabZLg
         1avw==
X-Gm-Message-State: AOAM531GWFksUaqliJqz/of/StObSYsurE9ATfY5mA61uavXAUuBz9Fm
        8x1Nd9t36QCO4zODXZIwbsb2fBpfwSYcA8FcqGAyFZLc
X-Google-Smtp-Source: ABdhPJz1KzCoUiEQK0fAdjB0ewfv1XOwemUUeib/iOMWNcRTi4vCXyKsGYNzw8mSdOo9rzYgjSy4cMUiEUBjGKGMAho=
X-Received: by 2002:a1f:e7c2:: with SMTP id e185mr4185463vkh.23.1606231790317;
 Tue, 24 Nov 2020 07:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20201123163622.166048-1-clemens.gruber@pqgruber.com>
 <CAGngYiU8M0urUogQJf5-GS_rWmPa85TAVxdRD1EfkRK-EGQ7_w@mail.gmail.com> <X70kjlZpIaN1T1ml@workstation.tuxnet>
In-Reply-To: <X70kjlZpIaN1T1ml@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 24 Nov 2020 10:29:39 -0500
Message-ID: <CAGngYiVkzm=D=hX=k7jL-ikApV4Xc0q+jzebMbqbQVoSAzSWYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] pwm: pca9685: Switch to atomic API
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 24, 2020 at 10:19 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> Thanks for your review!

My pleasure ! We are fortunate that you take the time & effort to improve
this code.
