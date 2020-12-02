Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625CF2CC3AC
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 18:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389129AbgLBR1C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 12:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389280AbgLBR1B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 12:27:01 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B84C0613D4;
        Wed,  2 Dec 2020 09:26:20 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q3so1499429pgr.3;
        Wed, 02 Dec 2020 09:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+ImcfZLvvBHYTsDO30kABBGCYuRzWZL4tNLUXZUAuvg=;
        b=MAQoRwiVDhTQ6Ub6BSmEB45rRexBqKhTBoqOebc0RP+LnrSgRXwxM68WZwNwl1UHNW
         UJYMjaX3bXAjVzGfXz7DG+Zzm+9Jx8XWvy/L1MUbQIhv625BAbzflWfXSUUS48fVHNFD
         eApJoZ+qchvmIPi21of4/K11CrOmV/yZpk12TmoiV2UaUlnszyUYLORhWLSeBrzam7HI
         NhlYDfAumfunnJX6BCpzPmkzRCWqS55BC8Kfx0Y3UmVv1hOjFn3A9e400Fpe3ArJb2HY
         FyebhMDtYqtyojkj0gyOMdZ6A7qy93Co51f77Zppx7pInGPb0ZpoJjXY4Tzsm1r1Hwjx
         vahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ImcfZLvvBHYTsDO30kABBGCYuRzWZL4tNLUXZUAuvg=;
        b=Cva+rXvOL4MoUu/spp3cKuKh059KfPmugxtXWvP/SRFrmOwv0/MaEUACZTkHMgI9Tu
         mE17ekLreMsPWXlmloA4tqjMhkg+ANQ/NCP/I7jKFPBMg+mKNEgh+sjKw6Mfh0ZLwt8m
         W8DM8pQWBhIobPli5Dx7UJW+JZDz/A4Y7fzzRUCEev0//8TQjzcs0VXIItyZoG9ur7dG
         uHoVF3xMXGydWOY+YtTJ+j0LfNaDj0TWjwFIOQgPr8gTEuz+D2u1FlNNXQ/IoiuCheqr
         9HUhddM+CCmwJ95jVyn7Yze3FBk4bgrCad4evFti9RofPe1qA6RSM1L2QYyNcbtWEe8b
         1WDA==
X-Gm-Message-State: AOAM532NA7sOl1xojScsjSha35cO1T3Unx0jPtSesiK55A8pD0coabgz
        MRaA60e8RF/XfLfsCqXkTII=
X-Google-Smtp-Source: ABdhPJyxF+Y0NQAkwkYnU2mgmQOhTo1yEH5GDBb1+SLp7aPVK2X1GOo8Gie7sldyvHPUZqw2992YFg==
X-Received: by 2002:a63:5a22:: with SMTP id o34mr776276pgb.187.1606929980486;
        Wed, 02 Dec 2020 09:26:20 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y21sm424018pfr.90.2020.12.02.09.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 09:26:19 -0800 (PST)
Subject: Re: [PATCH v5 01/11] firmware: raspberrypi: Keep count of all
 consumers
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, wahrenst@gmx.net,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-rpi-kernel@lists.infradead.org,
        bgolaszewski@baylibre.com, andy.shevchenko@gmail.com
References: <20201123183833.18750-1-nsaenzjulienne@suse.de>
 <20201123183833.18750-2-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e78cde23-5a5e-5e46-fde4-a299629ec6d6@gmail.com>
Date:   Wed, 2 Dec 2020 09:26:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123183833.18750-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 11/23/2020 10:38 AM, Nicolas Saenz Julienne wrote:
> When unbinding the firmware device we need to make sure it has no
> consumers left. Otherwise we'd leave them with a firmware handle
> pointing at freed memory.
> 
> Keep a reference count of all consumers and introduce rpi_firmware_put()
> which will permit automatically decrease the reference count upon
> unbinding consumer drivers.
> 
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

This looks fine to me, just one nit below:

[snip]

>  /**
> - * rpi_firmware_get - Get pointer to rpi_firmware structure.

Is not removing this line going to create a kernel doc warning?

With that fixed:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
