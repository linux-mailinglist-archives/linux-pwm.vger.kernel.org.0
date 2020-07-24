Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC522D1C5
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Jul 2020 00:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXW1e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 18:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgGXW1d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 18:27:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8A5C0619D3;
        Fri, 24 Jul 2020 15:27:33 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c10so3293602ejs.5;
        Fri, 24 Jul 2020 15:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4hf+QcXjlYFII3kXRk/O+OAgoKCkXx1KoxT9fj98uM=;
        b=bPXXLRhx/DBJLBzy31tbfdnreP2A/3C7EQXsJBdEhJmi13ZsBr74iEsirnR0coTvB3
         EHv/+fNAmwyKxos/sgQRInDoBMFAIJsvMBjA3NLRA3EYeDjvQgCzEmV034yykv/a2ajE
         28neU/RPcrOUoE5O03me8XuYtoUSQ8leEmSb1L08tKbSNEZWGaqlxEq4jgvmaXxEBs5z
         YR11gOEKP1u5TUdcq8CTIOa1nfZExCRnUuQhjaJA56gKf9LRaFPJlJ4nHiGKjneE2Vgs
         cCr4w6EROVSXSpF9UMTOE/U4vxAAzR6gkEdZxpR+CSznmH5Z65rGChOZ+m9aUSwjx9WS
         42tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4hf+QcXjlYFII3kXRk/O+OAgoKCkXx1KoxT9fj98uM=;
        b=lVwowZ5vHv8hllRqdTE3kDW+3VsPTfGy7PWJYBB9m5hplq9ynj2AVM7ji96WiT9xZu
         jZsTl2rnUY9MU/gAGiajfgLAQPpPoBEF4dRGkDFEiaHHESv/r0HLwEo5cTisQ8/zSuon
         0D92UBAEMaDljI/lIAw6TWWao2zwUAkU90YzXu5ji2qTeACnK3B9r6GIY7jszTs2MsA2
         XR1G1SeEnr0IyhtfTMJazey/S6FtkxVXm3PwgduU80XhV6vZiSilOhuHtd98U2YY1B/h
         H20yO/Ghe+kupCi8zJYNkkN6y6EYfac35THreS25Y5Nz6prM91IJe3BTM6m9YDb9RomJ
         CrWw==
X-Gm-Message-State: AOAM533OcdIZqHt2q/zj1OeW40oUJ0VjLyztQHrcacx3gtWJlflxHF0e
        Mht9HdD4ES8GtNUfOUR6Ef8mDLarBHUNeOwMz98=
X-Google-Smtp-Source: ABdhPJyr1DTsH/bA8sD09MlUURcHYnx3ZityhfcMVaAp+YaHiCg0at8CxoAPgraUolFiRIvc4HPvFnk8U1iR9tJs5uo=
X-Received: by 2002:a17:906:1c0d:: with SMTP id k13mr11603383ejg.477.1595629652224;
 Fri, 24 Jul 2020 15:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com> <20200724220516.GA21965@amd>
In-Reply-To: <20200724220516.GA21965@amd>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Sat, 25 Jul 2020 00:26:57 +0200
Message-ID: <CADQ2G_Fvyyh6-foswczkQgX54rH6oH-m8xyS6Qp2yS6D5L4Q9A@mail.gmail.com>
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

Hi,

Dalsi cech co hackuje LEDky?

Nie. Slovak.

Bindings should go first, they may need to be converted to yml
(devicetree people will know).

OK

Can generic pwm driver be used here?

I have not tried to do that. But considering it's custom chip from
Qualcomm then it's unlikely.

This is for RGB modules, right? It will need to use multicolor
framework.

This is for RGB LEDs in phones that are connected via pmic.

Is this for phone, btw? If so, which one?

Yes it is. And it's for many many phones actually. I have done this
mainly for SONY phones (Xperia 10, 10 Plus, XA2, XA2 Plus, XA2 Ultra).
All of them use these drivers for generating the PWM and controlling the LEDs.

P.S resending because i sent it as HTML apparently.
Best Regards,
Martin
