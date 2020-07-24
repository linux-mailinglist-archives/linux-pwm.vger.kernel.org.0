Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB74B22D1FC
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Jul 2020 00:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGXWte (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 18:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgGXWte (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 18:49:34 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBE5C0619D3;
        Fri, 24 Jul 2020 15:49:34 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f12so11453592eja.9;
        Fri, 24 Jul 2020 15:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ruy2+B9ZZKH4K6WjRKkPrWIIYd3py0bPMSuod75K2xg=;
        b=OVdocFiJ3RunCCxhcQyhF1JxaPYTN52ibTYsTQVyKg7pDxB7rspwF+lt9dc70gDacK
         w+caEqA5XVQ87C5Fx8cyphtZgDZggqme7c1YK9RzCt611B5PzZV7fbNDf1E+w84ejSsD
         /RUD0YHYS88ecsYQPhBDQmFKMeL3C6hWxSbA4Kz5azHoZ+ivtS2UC6gf77/HaH4OpnB8
         4xRtpv1IcbvVHWiRSRqsXr5zyesuEgR2MPJonelH++tQuOxsN4BlJJ/Pcz4Mn1SgL5iE
         0BH2quN/DfL97zTvwiZRttoIGfFMiJGjCIaVclfkv4nIqgE79Hmey5k9JKfbgjKtmeCX
         ledA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruy2+B9ZZKH4K6WjRKkPrWIIYd3py0bPMSuod75K2xg=;
        b=s03POVoRI0n/DlH4xB2uC2Abp3AUgJbiLF8vLUJCOrWJ4whz+6JMyrQBikR5Wip9qx
         p1qenlZVjbZlJ8fS3OzuBo8PsNxlEbUYO/qDGGAFMmaurcEdhFN+VDuZlK5c9vhZ/A0z
         y70ZK3+FXYlulGsdu54Vb6ivLm91xm8P+cbpBg8BvQ6Ciyub0ST2COCkUPbc+XeF/Tw7
         OIv5Ge0xBJyFAxRzMMwrAEm/51L7BWlmBuZn0O50+Je4WyIbU0L2mxFqmqzx62t7HHA5
         uSZtv8iD0eOJFvhY3rcZcwHVUJqfMJk1S4YKsGMQGHubyTLtzgM9CbTleinj2K/qb2+Y
         98Tw==
X-Gm-Message-State: AOAM533so+n8bK31ONviDn8HVadxo2jMGOeG/WG2EAJ15Eiw04qKZgYZ
        3FTGMB6LoaNCuYkzgNLHEMAXouGARbGsXre5h3s=
X-Google-Smtp-Source: ABdhPJy5TKAFOGKYV5rdBfG7ETfl4Br479kihtuWYEdoj1AtvocztuLNqhM2LdQk5RdTaNnDHorCfmenJcZMA2qBVTA=
X-Received: by 2002:a17:906:b787:: with SMTP id dt7mr10649901ejb.320.1595630972919;
 Fri, 24 Jul 2020 15:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724220516.GA21965@amd> <CADQ2G_Fvyyh6-foswczkQgX54rH6oH-m8xyS6Qp2yS6D5L4Q9A@mail.gmail.com>
 <20200724223252.GC21965@amd>
In-Reply-To: <20200724223252.GC21965@amd>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Sat, 25 Jul 2020 00:48:58 +0200
Message-ID: <CADQ2G_FD6CuexZ2NBWnNnh_rLRDtZj4_Jzwt673CDB75z-6ZXg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Add QCOM pwm-lpg and tri-led drivers
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> First copy was ok. Second had broken formatting. Both were plaintext
> AFAICT.

It's just that gmail was telling me that it didn't send it to some of
the email addresses because i forgot to check the "Use plain text" in
Gmail.
