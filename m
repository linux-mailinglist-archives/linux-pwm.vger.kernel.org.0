Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E507529D48F
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Oct 2020 22:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgJ1VxG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Oct 2020 17:53:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33872 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgJ1VxE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Oct 2020 17:53:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so689709wro.1;
        Wed, 28 Oct 2020 14:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ZnXxaz23SCoShQOgk04jnieqtpf5ln6p39aeLgtVB8=;
        b=LKW9u5UBBiaiMvt1+yJ6p89g8Y0Vrto+YLj98F6E6vKMeTnt6b6rob47hBju4kLsaU
         J2JArWFhNPXUYJcD8nvBMEy2Ae2pTchacut8ubTUQH9bmHwqKxpS86MdE7ZpFpD0Cd6U
         ENnWKkSAvW0htcwWvpe5M3+9rH3xIGraGsPDwlkeHCSHdoApeIKE25rtKwDh6bcD3A7S
         PpP11SO/mES9AZvAYwIPZYypEsbcKdMkWU3cmWeGgXjlT5L1JPUJQib04l7wUdCyHcmY
         GgiVtm++VwyLSgVdjZuwm8AAIypD6+p6M7fgwhRc1UvxIiwRs3zS7eISM3uzjNKks6cj
         oeug==
X-Gm-Message-State: AOAM5325aa4CwuKey/lFPpv3kx6PPCuwqIwjxPFPB/FFnlX7kdZ2aRnX
        v86ZZjUrxD0rxva8YxZ80yA=
X-Google-Smtp-Source: ABdhPJx6PPpAmbXbui196s2L7gRKKwN9GgVw23nSKqFPGMzwAEuM+i4FQGV8bGHvzHBeLrjYddOkng==
X-Received: by 2002:adf:a501:: with SMTP id i1mr1586091wrb.162.1603921981824;
        Wed, 28 Oct 2020 14:53:01 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id x1sm1250159wrl.41.2020.10.28.14.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:53:00 -0700 (PDT)
Date:   Wed, 28 Oct 2020 22:52:57 +0100
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
Cc:     Kamil Debski <kamil@wypas.org>
Subject: Re: [PATCH 1/4] MAINTAINERS: move Kamil Debski to credits
Message-ID: <20201028215257.GA269525@kozik-lap>
References: <20201016151528.7553-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016151528.7553-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 16, 2020 at 05:15:25PM +0200, Krzysztof Kozlowski wrote:
> Kamil Debski has not been active on LKML since 2017:
> https://lore.kernel.org/lkml/?q=f%3A%22Kamil+Debski%22
> 
> Move Kamil Debski to the CREDITS file.  Thank you for the effort you put
> in to the upstream Linux kernel work.
> 
> Cc: Kamil Debski <kamil@wypas.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  CREDITS     | 6 ++++++
>  MAINTAINERS | 4 ----

Applied.

Best regards,
Krzysztof

