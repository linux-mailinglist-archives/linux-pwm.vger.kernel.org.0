Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368D22F914B
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Jan 2021 09:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbhAQIBW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 Jan 2021 03:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbhAQIAp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 Jan 2021 03:00:45 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BA1C061573
        for <linux-pwm@vger.kernel.org>; Sun, 17 Jan 2021 00:00:05 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q2so25178358iow.13
        for <linux-pwm@vger.kernel.org>; Sun, 17 Jan 2021 00:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z1Zmgy23OZU14Gtu/GVkoRjETwLoSMU8SPd/pgiAr2k=;
        b=q9g6RIpIPuyYOpXh5BsAX6U1Q7xfEQcWoR137Y+OpfCW3dLlBbMH/mXSTYFd5wObOO
         LnDZBttWZVCT6pauWU7eGiRP8NpTLoyzs/cbwG8I4NZOgt7FnAx+ZBTI5F15/9gntPC1
         4XFOtbevUnCUsWe9m5OIXo8llAoKL7IVNAtcTOwJn+lwmjk4LjYoxJRwX4M96h/M02DV
         72NBINYsCEIe9W1u0A7arAPHilJMCc5wLAQelnTkQc6joCgV6fDRoeChxmyPuY9iAZvR
         oARBvYlM1K1apId6aqqZo+9hNNAsek8FRJVB7IQo2vlB5OTaKpOsVRGM0/fpi2newhLt
         j6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z1Zmgy23OZU14Gtu/GVkoRjETwLoSMU8SPd/pgiAr2k=;
        b=LR0w2jg6mZzS2jR/F39RoQZyXkxK07Cfq+moHI5mT6JSp4CICgC7UxY++CDchulrLV
         3XotMocX9jB1NyKlCRweRjU4GxmNlBzKfbCh8mOC7NdPBmd30Rp81kwbWL1Bnyvacq1E
         SfG4hQ9/Riu4qIZbNA99d6SnnZKDeFfgWJvJWLX4IiEyoAF6msPNfs1NERwWjt/hReYB
         Ua1RZsMCHUZQi0UnrB/SbBC4PusIdUHHVk+6VVSdYy4T7mZkJ4TL8CtWaAMOm4oBN4Ze
         44Sw+MfmCsTcBjWYREptx5nf0Jvsa2ha7b7mdXjuLKQwURyRSwOWCVCudFimMCzJZ8Cn
         EsLg==
X-Gm-Message-State: AOAM530dQHoelHTusb5yC7ZhYA0Tqi1qOSLXlNWGpW6rhcgZ+sYN/ozJ
        bT1DHctI3EDAgMYEP8f2BPk=
X-Google-Smtp-Source: ABdhPJyn2LaNYp/YkSpBCi3UIPmcSyRxi0siWPWZAtfoB2xTXuV+7vf3fVJZ9v0VS321wG+XKhLAeA==
X-Received: by 2002:a02:494:: with SMTP id 142mr3053861jab.65.1610870404745;
        Sun, 17 Jan 2021 00:00:04 -0800 (PST)
Received: from einstein.dilieto.eu (smtp.dilieto.eu. [188.68.43.228])
        by smtp.gmail.com with ESMTPSA id n11sm6289908ioh.37.2021.01.17.00.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jan 2021 00:00:04 -0800 (PST)
Date:   Sun, 17 Jan 2021 08:59:59 +0100
From:   Nicola Di Lieto <nicola.dilieto@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: pwm-gpio: Generic GPIO bit-banged PWM driver
Message-ID: <20210117075959.gd7lyi47vuhy5ejf@einstein.dilieto.eu>
References: <20201222213325.2656124-1-angelo.compagnucci@gmail.com>
 <20210115081318.ig76unyfp3fqhu5z@pengutronix.de>
 <CAL_JsqJpm28hvXepfE499Xrdt400sGN6+ZtTboVifi+hYqB44A@mail.gmail.com>
 <CAL_Jsq+ArehEEnuwC1kfeYiO1UzPnSvfr+OqhkawiPkvyy_dGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+ArehEEnuwC1kfeYiO1UzPnSvfr+OqhkawiPkvyy_dGw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jan 15, 2021 at 09:08:31AM -0600, Rob Herring wrote:
>And there's a 3rd one from Vincent that I already reviewed:
>
>https://lore.kernel.org/linux-devicetree/20200902121236.20514-1-vincent.whitchurch@axis.com/
>
>And one from 5 years ago...:
>
>https://lore.kernel.org/patchwork/patch/612159/

These 4 patches are in my opinion a clear indication that such a driver 
is needed and useful. I hope it won't take that long to have at least 
one merged upstream. You guys just have to choose which one...

Regards,
Nicola
