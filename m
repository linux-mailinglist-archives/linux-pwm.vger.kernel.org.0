Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFC29D517
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Oct 2020 22:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgJ1V6n (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Oct 2020 17:58:43 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:46865 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbgJ1V6m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Oct 2020 17:58:42 -0400
Received: by mail-ej1-f66.google.com with SMTP id t25so986436ejd.13;
        Wed, 28 Oct 2020 14:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/13x8uXcmP0RSb/AY9uXg38hhHOvXL0srgmQ+7f0V14=;
        b=AgKMYEclUPAWjXD9qeKWuBS1023RTygB1pv6LYOgL2knEVUrWB8vuVVFX2eXx0j2zH
         +cKRip7bnt4gLEPXghdD9Eoq/E9DaE6qSBQYYUYnbQrsuEMlbV845YlXX2eQefshm5T3
         Xxp2lP8wkPOu4VGPIZ5tUW/o/mCorPW5rZJVxukbxj/eIabo0JxqEjrumxgQOilkr3em
         p94tH6FIlTx2UegEXhbw+/p8i8UlOPwzGSfMCeXV79m9Jj4aajRNSYRrarCXsh0Mvnxz
         cuDMiWNplhMSE8I/qavNELKMNguB21LS9uagU5mjoEWmx8sOzQjLSbN/hAMTfYxF5rlz
         I4PA==
X-Gm-Message-State: AOAM533eys6ilvipDHBFKh/vvhjpwPHSJZZZbBD5NiIpHAlipCGw3e2C
        J6QwjNolKAUUQq1frhnA+CQ=
X-Google-Smtp-Source: ABdhPJz1JqAdCFHZAw9ZuMgkmuda1lhmzhAkZhNRojS5hnXUaIzQVHpug2udFLH1WOn+Ej3PrKF5Kw==
X-Received: by 2002:a17:906:430a:: with SMTP id j10mr1111807ejm.21.1603922320150;
        Wed, 28 Oct 2020 14:58:40 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id f13sm412571ejf.42.2020.10.28.14.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:58:39 -0700 (PDT)
Date:   Wed, 28 Oct 2020 22:58:36 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/4] MAINTAINERS: move Kyungmin Park to credits
Message-ID: <20201028215836.GB269525@kozik-lap>
References: <20201016151528.7553-1-krzk@kernel.org>
 <20201016151528.7553-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016151528.7553-2-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 16, 2020 at 05:15:26PM +0200, Krzysztof Kozlowski wrote:
> Kyungmin Park maintained and contributed to some of the upstreamed
> S5Pv210 and Exynos4210 machines - as described in commit 10ffa96407b2
> ("MAINTAINERS: add maintainer of Samsung Mobile Machine support").
> However the entry in maintainers got slightly twisted by
> commit 004bbd3c01d4 ("MAINTAINERS: remove non existent files") -
> the directory matching pattern was changed from specific machines to
> the entire S5Pv210.
> 
> Anyway since long time, all S5Pv210 maintenance is covered by the
> Samsung ARM architectures maintainer entry and Krzysztof Kozlowski, so
> move Kyungmin Park to the CREDITS.
> 
> There was also no activity on LKML regarding other maintained drivers:
> https://lore.kernel.org/lkml/?q=f%3A%22Kyungmin+Park%22
> 
> Dear Kyungmin Park, thank you for all the effort you put in to the
> upstream Samsung support.
> 
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  CREDITS     |  4 ++++
>  MAINTAINERS | 13 +------------
>  2 files changed, 5 insertions(+), 12 deletions(-)

Applied.

Best regards,
Krzysztof

