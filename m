Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D713B69F749
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Feb 2023 16:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjBVPBx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 22 Feb 2023 10:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjBVPBa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Feb 2023 10:01:30 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC53BD84;
        Wed, 22 Feb 2023 07:01:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cy6so26050256edb.5;
        Wed, 22 Feb 2023 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yN89DAJMRBXcVJVWoF647sPGNR5k1aPb4CYJyqyPfsI=;
        b=FuFZGNy7pX+t95imynP1lkrz40gOGA5ZzTtvPgFiAYCISthy8lxNE3YoHVqsxxV+Ex
         DT3rpldKsci1tcwzKXZRRS076maWBH8qDuEWAfUKiwkMN9fwgLEc23anls1RiUVhQIMS
         fHWlFzbE6EXvxSelKkIyJ38VlUap+4xJF4VCMvxLvE99JrIwIc4sQGJEDkLonHjElfly
         XDLMqSA1+n38So5Ogt7IL928vevQyjWGZVmuEz+9p8Y7CzXR0jcp1a3vx9PfDbKWc05A
         +uR9CupPXC3leO0dhtIhBNCAjNpXAYQJ3EXlMwrrsjDgpkVYipLySJiEGXmKj2tbGEUx
         JEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN89DAJMRBXcVJVWoF647sPGNR5k1aPb4CYJyqyPfsI=;
        b=hI7XqgJTdGkrY8cBZzgBE6l8r7eqjWTxqBZ67j5f5nDCU48ed2ErhZ4iyjrvpVVa2K
         W6x29EpdVivrOLkG3G9gme/ZZUK9OIU4uOH98FPtbHjWOqTQ8uTPRg5BE+tF9Uh3sJKo
         b8L2zn/SMOnFYOZkM7l5IN0J50/xJKufOImeRMN07kMb+ext6d+QNHTPXKCO2KlpSePZ
         8kc3er9bwhyB0IZHM3Yn1FLgo5VmwLoM1e8mkj9yoZhHATHue92a5WivCAj5Nicbol4L
         vimQnmZssu+H8oy2Tf9Yf0j9VnqPYObcbl/mV69hNBDYJSuWH/K5koCqtIPrqAl1Krww
         73Xg==
X-Gm-Message-State: AO0yUKX4OblJc52vTQ/GdiWo0VFtfbWR9+RfiRfSxqC/JmoTJ6nK4yhr
        lTzD52AVDXqJ8hZm159zr+w=
X-Google-Smtp-Source: AK7set+P7v0pcUhYROkp+tnbnV1UtvndPMUZHU/DOCFNvfgS5U3L/ZWNhvfrVvrdbbTqNh6LCW/G4g==
X-Received: by 2002:a17:907:6d03:b0:8b3:6da3:c788 with SMTP id sa3-20020a1709076d0300b008b36da3c788mr27810734ejc.51.1677078057740;
        Wed, 22 Feb 2023 07:00:57 -0800 (PST)
Received: from einstein.dilieto.eu (smtp.dilieto.eu. [188.68.43.228])
        by smtp.gmail.com with ESMTPSA id j16-20020a508a90000000b004873927780bsm3685433edj.20.2023.02.22.07.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:00:57 -0800 (PST)
Date:   Wed, 22 Feb 2023 16:00:54 +0100
From:   Nicola Di Lieto <nicola.dilieto@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
Message-ID: <Y/YuJoxkz+o0Omie@einstein.dilieto.eu>
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com>
 <20201211170432.6113-2-nicola.dilieto@gmail.com>
 <20210117130434.663qpp6noujptdyt@pengutronix.de>
 <CACRpkdawMpuznr-XC2uvZm8PvOj-jObpnbz6iptV-Q4OFxjesw@mail.gmail.com>
 <CA+TH9VnrsSQDUfvXk8c+q6Sx2Jc5TCN5XLYCRLtgv55-6voLWg@mail.gmail.com>
 <Y/YPtJK8nVBthCML@surfacebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y/YPtJK8nVBthCML@surfacebook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Andy

On Wed, Feb 22, 2023 at 02:51:00PM +0200, andy.shevchenko@gmail.com wrote:
>
>Seems not much interest neither from community nor from author. Maybe later
>people will look into this?
>

It's not lack of interest, but rather lack of time. I should be able to 
have a look at this sometime the week after next.

Nicola
