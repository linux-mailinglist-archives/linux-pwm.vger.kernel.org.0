Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECDF2B6943
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Nov 2020 17:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgKQQBS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Nov 2020 11:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgKQQBR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Nov 2020 11:01:17 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F46C0617A7
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2020 08:01:17 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p22so3748964wmg.3
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2020 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZgH/N6mYWhDCoyFl6noMveCuC9qdA1oQrCHI6Be4/O0=;
        b=jjlttYG6IQC31dMZ14jB1N1t+o/y64mwNqlUUgR395EpocMaqgaplT3X2k4IAQ7LEz
         YJxAi0oK8N1vTgGGVkqSSyM/sas/I0DMTpVsM1AUZn9dxqRiFgToPuIdyPGUMc4u13ns
         Hf9ggBIL2Y1odExKxByo1Dc2vaEKKI/7oui6AEwnVIe/F1MUgVQCddJBXvp8aw6x/L82
         kNLZ/SYen7+mbwd/cv5b7ydYnHzGKoTAAmN4upFES5n8UhxoOx1Y4g9Iicp/9IU+IgaQ
         Mf6fsYiHA+WPwVe2fAC2SJD0pTjr/OO3pTDMGbC6JduTqgKv3qbkO0OzqYg3Uj3GPnMJ
         uOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZgH/N6mYWhDCoyFl6noMveCuC9qdA1oQrCHI6Be4/O0=;
        b=ACNQUJAhtJgx6I/woyFH7ieUGCg4W4WX8fGiTs4ev09Eh0uujXvZn1s0pPX4j1PfDo
         apVzPt5ZqweFlqr8jwFc8KN244LK62ReDfve628lnK0Ky9LT5pyzx/+ZYCzdct/X0Cxe
         /jcJxux22VjKT2Wbpf/XqWPG4pqskolturLIfJx3VHByVhF/cFh6AK2uDjVZtDmnzXuM
         KaZHqgKo25/SjP6WiIC4NlAgDvivvjuKg9yLE95pEe1MZCor3S09qBES6bb7nBuU/ClP
         x0uervp0+Cif/vFIh4JrZH1ektamMF4b92+RE9PG2H0bAhCAjBWLRCtmaA6b3SclRtm8
         fRCA==
X-Gm-Message-State: AOAM530UTWlc413THBzbsa+tmBc/qHMHhwdeOj84Juv0uzs9dgbC3+al
        5rjmu5gmVr5ZQbpzXbCYnPpUKw==
X-Google-Smtp-Source: ABdhPJw+IJui6xmfuWvFKYQIozIBKgjgneFFocPgBjc2qQfRc8skQL8WXrJCSSa1HiXfx8uKpXIo3A==
X-Received: by 2002:a1c:208f:: with SMTP id g137mr342521wmg.116.1605628875733;
        Tue, 17 Nov 2020 08:01:15 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id d8sm4077249wmb.11.2020.11.17.08.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:01:15 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:01:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andrew@aj.id.au, albeu@free.fr,
        f.fainelli@gmail.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        Eugeniy.Paltsev@synopsys.com, hoan@os.amperecomputing.com,
        fancer.lancer@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, vz@mleia.com,
        marek.behun@nic.cz, matthias.bgg@gmail.com,
        u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, grygorii.strashko@ti.com, ssantosh@kernel.org,
        khilman@kernel.org, manivannan.sadhasivam@linaro.org,
        p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] drivers: gpio: use of_match_ptr() and ACPI_PTR() macros
Message-ID: <20201117160112.GI1869941@dell>
References: <20201117154340.18216-1-info@metux.net>
 <20201117155401.GC2589875@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117155401.GC2589875@ulmo>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 17 Nov 2020, Thierry Reding wrote:

> On Tue, Nov 17, 2020 at 04:43:40PM +0100, Enrico Weigelt, metux IT consult wrote:
> > The of_match_ptr(foo) macro evaluates to foo, only if
> > CONFIG_OF is set, otherwise to NULL. Same does ACPI_PTR with
> > CONFIG_ACPI. That's very helpful for drivers that can be used
> > with or without oftree / acpi.
> > 
> > Even though most of the drivers touched here probably don't
> > actually need that, it's also nice for consistency to make it
> > the de-facto standard and change all drivers to use the
> > of_match_ptr() and ACPI_PTR() macros.
> > 
> > A nice side effect: in some situations, when compiled w/o
> > CONFIG_OF/CONFIG_ACPI, the corresponding match tables could
> > automatically become unreferenced and optimized-away by the
> > compiler, w/o explicitly cluttering the code w/ ifdef's.
> 
> Isn't this going to cause a lot of "defined but unused" warnings when
> built without OF support, for example?

Yes, it will.

It also looks like there are some whitespace changes in the patch,
unless of course that's just Git playing tricks!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
