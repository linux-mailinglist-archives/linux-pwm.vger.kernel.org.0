Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5504722E68E
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 09:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgG0H36 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 03:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgG0H36 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 03:29:58 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1047EC0619D2;
        Mon, 27 Jul 2020 00:29:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b13so8975173edz.7;
        Mon, 27 Jul 2020 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/SS2tH+znVFwsX6rkJmypmxpV9S8bPpCHrpiOj20R8U=;
        b=qH2CjItsOC8efLdB17RxpsOOHLZm4nhmPZjXQjWEBhOQnAdYEy0Innx9mODaTuBUsL
         lc4Xx3skXLxB5fc4ds5e9RXXaqbf1vA8cpt5xXaFPWEswgwnFVu2TjEwy+NZcFikUED7
         qXRQFwRtJTJaQSUu9Fb/33Y5OfAOUm021ySeRYyVGDbcOcpPpCBiJ2gL13LA1DZplcjH
         IE2yFB33XhnLfuXMunOTgjVcXLmihi47JbQau27elL2GS7lNiyg5PHiG7dcf1HTM0/va
         rvraSilnxV3oG0xgMrXubRYQR4pxejYUfAw78qdYbfu0VcPNJApCrwQNbFnzqoC6mMz2
         wQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/SS2tH+znVFwsX6rkJmypmxpV9S8bPpCHrpiOj20R8U=;
        b=HAwMD0PgohW3DIAun89Ce6IwMNnygeM1oraF8nOnGPatTKBuXbxxaM2Uk5RXWn8N6t
         jRaAHvh3RKm7yx5KpQCucMOMF7X/OjrVh2aS56aPYcFLXGDzhXKjIOdiiCnIgr98jIZL
         DCvK/6HyEB0VbRBHHSLMUeuk653A6GmoZC/N+7/TsvkBYPP51uiRQIVsXghdcLjvEeiD
         G76NXxDjRuCAR2xXEpyQYqLtnWKLD8e0E5+p+LG39gKHzlePM48AlDRYZx899qMInLXZ
         3dL5SF8FDcLygFg2VNi0CiMaOf/FqjYObUe+KEPhcuhOVOPLuf0KFypTpeKFIumtUJtg
         onRQ==
X-Gm-Message-State: AOAM533jpvaUpXe80Lo8GIoWalLJCSk8MzVglAGW0venLXDWioYxUZiB
        ypxSxa9tAFTrhE1NXgZ/xUD/bAY/so39mktu9p4=
X-Google-Smtp-Source: ABdhPJx3zAe7GHpQ50dWJVcLEvnofVYIk9+W7vz3pQLvKKXzZ14wYkHL2FIwpfb1D6I8xQVjFIllx4rqnAGOS7GoibU=
X-Received: by 2002:a05:6402:84e:: with SMTP id b14mr7308362edz.322.1595834996797;
 Mon, 27 Jul 2020 00:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-3-martin.botka1@gmail.com> <CAHp75VdJ14p+_+XqxrgRrjXF7m6L4nGr5vB03NTM=0xjgw4c7Q@mail.gmail.com>
 <CADQ2G_HkiAZx8OhfQ_jeizveMaB-QN9dfN6Tcwfk9XuF97rmOg@mail.gmail.com>
In-Reply-To: <CADQ2G_HkiAZx8OhfQ_jeizveMaB-QN9dfN6Tcwfk9XuF97rmOg@mail.gmail.com>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Mon, 27 Jul 2020 09:29:19 +0200
Message-ID: <CADQ2G_HYTE6cd=PM2JzCTadkPe2DDb8dxObPdPJtz1626ktE9Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] pwm: core: Add option to config PWM duty/period
 with u64 data length
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Sat, Jul 25, 2020 at 09:12:23PM +0200, Martin Botka wrote:
>> > Note there is already a series that changes these values to u64. See
>> > a9d887dc1c60ed67f2271d66560cdcf864c4a578 in linux-next.
>>
>> Amazing. But isn't there the same issue with it as this one where this
>> would fail to build on 32 bit architecture?
>
> In theory all these cases are coped for. I didn't see any problems yet,
> so I still assume also the 32 bit archs are fine.

OK then all is fine. I will drop the patch in V2.

Also Uwe i just realized that you sent the original message and also
this reply only to me and not to anyone else.
Could you please send the messages also to everyone else ?

Thank you.

Best regards,
Martin
