Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC062AB04B
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 05:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgKIErw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Nov 2020 23:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIErw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 8 Nov 2020 23:47:52 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B41C0613CF;
        Sun,  8 Nov 2020 20:47:51 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id q19so6947884ljc.10;
        Sun, 08 Nov 2020 20:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cLiYnZqbbTYE+Gmw/2Cct5bDgH44FThPRJ7yw1uOIgg=;
        b=q2vWN2tcxbRALqh8OhrgcjDqiOjQbYaIcNRVNh3xuY/yQantgDrl9u9nLrJnRUv9hA
         ozelSxwbh5ozbLSshRt26t0nn4JgOue72bFZttfyw0OBrgyxy/0q3YUfYR1pgzipa1SN
         6rHhFDgY16ZfVDrPNbw8QVvyGqs9wQGx8X/2T03ASxqQRgNE0dCDud32D9uGfGNfmZew
         AenTGWzR9MZaHnzxGDIGm5LIPE7Dlu6AUnIf3Gl4/2Uz0XXecX93kgVw1IzKv+dHuxNp
         SVxUDP0R0o66WKgdGwDfxEasf8e1tTJw/gWlwvjZlL0cz4D/qEX0YXjFyR4Mid3JYB8g
         gN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cLiYnZqbbTYE+Gmw/2Cct5bDgH44FThPRJ7yw1uOIgg=;
        b=UaY+v+txMD7MF/ktpnuLEeAVK8VkJVDYQZTixSWKFFF+39x3srEL8g/b3TMAFSH+lF
         rDQ1ArMTXPaCM9BhCg940oMoboMQkpkNs+UtgX/R5lf2J5ZYsn8QyiClmJ5KTLJy5qoh
         yFSHLGeBCKflFajhO9CJLFBxKJxkkLpK4Wn6OWvHdmphhpR0+tU8FeT8ambDVEspqm/y
         TJjlu3Cq190qtsjmQO+O3rMM4u8A78d/iPLPGilnSF48NSolxdJuuOQu0wUJQ6GJ31pV
         1DzmcmPxodZcR8wdLgpxDGA9fTtrOKLbMDaHUZ6mnU/HxHXu2OWh2D2YEEt+jPx+ZNwz
         uahg==
X-Gm-Message-State: AOAM530Vr6J+yXS9gv7zWyAmVXtatMRCiiPhOCuiNoEXMD3fSijrFW02
        uEmlaV5WalzhxfXn2Q7A0Q5Q15Lg+2M=
X-Google-Smtp-Source: ABdhPJyDE2aG8TshKuizrAN7qDH3x0b/P0IYn1ToY1b01Ld0Wj957fykeNLLAtH1r4vAPpkK8xTQfg==
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr218668ljo.371.1604897270127;
        Sun, 08 Nov 2020 20:47:50 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id w13sm795441lfq.72.2020.11.08.20.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 20:47:49 -0800 (PST)
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20201104234427.26477-1-digetx@gmail.com>
 <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
 <cd147ab0-1304-a491-7a56-ee6199c02d32@gmail.com>
 <2716c195-083a-112f-f1e5-2f6b7152a4b5@gmail.com>
 <20201109044354.ljd5pomhob6b7u5v@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <713b319e-bb7b-4743-59f0-b9892c3da92d@gmail.com>
Date:   Mon, 9 Nov 2020 07:47:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109044354.ljd5pomhob6b7u5v@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

09.11.2020 07:43, Viresh Kumar пишет:
> On 08-11-20, 15:19, Dmitry Osipenko wrote:
>> I took a detailed look at the GENPD and tried to implement it. Here is
>> what was found:
>>
>> 1. GENPD framework doesn't aggregate performance requests from the
>> attached devices. This means that if deviceA requests performance state
>> 10 and then deviceB requests state 3, then framework will set domain's
>> state to 3 instead of 10.
> 
> It does. Look at _genpd_reeval_performance_state().
> 

Thanks, I probably had a bug in the quick prototype and then overlooked
that function.
