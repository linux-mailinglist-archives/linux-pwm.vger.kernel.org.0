Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2BA2CC068
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 16:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgLBPK3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 10:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730380AbgLBPK2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 10:10:28 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB8C0617A6
        for <linux-pwm@vger.kernel.org>; Wed,  2 Dec 2020 07:09:48 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so8944151wmb.5
        for <linux-pwm@vger.kernel.org>; Wed, 02 Dec 2020 07:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oOSicCWhNpoN2Xb8hfcdhiDNzylSo2X/NngolxOC8vQ=;
        b=VDelKcaY4dVlNWOPXMkFf5mSXUkNLpgLiq61inVRo15dob72+uGh1D9f5e4VkqWOzI
         u0EHXHU0xohcCj4fmAeQeKP3TXa+vjSI8eNdR74HCDe+UHd9U/DGkrpts1l5adsgcqRQ
         nfawWVLe5huBvNv3/DutS9t31Sr2Xr9Z01YLLlIxupe+KJnOZK9uRi4CROMt46bfcEYk
         lqZD+9hDlvOIJs67RAEup4JAo8+NuIgARwg97o7VFnRkSVnMbiXA/FV7aVvtTp2ielGk
         6kScFx954N9zYr98z5jyAfvmvdp4VwaaaudFbytw/6KBilM4p6zn/3BR8b/mdXllr5Sa
         2png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oOSicCWhNpoN2Xb8hfcdhiDNzylSo2X/NngolxOC8vQ=;
        b=ny+JQ1I0DaZrLizO2b8R7V+ZA/5ltT32qPUlrqw0Qj5godTwfKrhXOkzqOGblkDQFc
         ghniul3AYBXvcP1ObMN/Rv/WldH5uZ1ZuChp+auOS+ghujo7fKSftgj9qM/FW4Uh8cMK
         5dbK/CB9tqhyDRAs0ISg2FfqJSV6qNoNjat5yH8n2mbGJzhoUjbV1Jb1Go3tvDI56yLc
         vwchVrJR/5pztGEvAuHLLFxGa3/YOYjbOGY4VaSKodBLy06VLmx2+xMZXJJO6XiPkeBP
         wF3WC+Qe93zgF0osUfjN0934tdStUaDFthNq1AThwmfVQgXB5dn7jA6mRCQGaHiNgkBx
         y4cw==
X-Gm-Message-State: AOAM5324b2NxA0nmb0hBVwW+pWS9Oce56qeGpLHenVReeCVqAdBCp3NX
        +mk1USK3hpOJHPgEfmniVc17kg==
X-Google-Smtp-Source: ABdhPJyY6iTjOclycbgMdZR1BJM/NQs428i4F9BST8rtkZMQKzAhUor3EpfauPJw0gENxlNhnY3zKw==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr2548794wmi.20.1606921786422;
        Wed, 02 Dec 2020 07:09:46 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id s4sm2676916wra.91.2020.12.02.07.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 07:09:45 -0800 (PST)
Date:   Wed, 2 Dec 2020 15:09:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 3/7] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20201202150943.GN4801@dell>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-4-j.neuschaefer@gmx.net>
 <20201202130520.GL4801@dell>
 <X8ed7stMOGhnZ18T@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X8ed7stMOGhnZ18T@latitude>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 02 Dec 2020, Jonathan Neuschäfer wrote:

> On Wed, Dec 02, 2020 at 01:05:20PM +0000, Lee Jones wrote:
> > On Sun, 22 Nov 2020, Jonathan Neuschäfer wrote:
> [...]
> > > +	/* Bail out if we encounter an unknown firmware version */
> > > +	switch (version) {
> > > +	case 0xd726: /* found in Kobo Aura */
> > 
> > No magic numbers.
> > 
> > Please submit a subsequent patch to define this.
> 
> Will do.
> 
> But I don't think I'll be able to give it a more meaningful name than
> NTXEC_VERSION_D726. I don't have a good overview of which versions
> appear in which devices. "0xd726 found in Kobo Aura" only means that;
> I don't know if it's the only version used in the Kobo Aura, and I don't
> know if the Kobo Aura is the only device where it is used.

Defines are not set in stone.

They can evolve over time as more is known.

NTXEC_KOBO_AURA would be fine for now.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
