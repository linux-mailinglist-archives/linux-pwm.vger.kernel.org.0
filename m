Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8F75AA28
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jul 2023 10:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjGTI6b (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jul 2023 04:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjGTIyX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jul 2023 04:54:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4462C269F
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jul 2023 01:54:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso789388e87.1
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jul 2023 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689843258; x=1692435258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr3GYuI4RGrQA8MLYXyJLt2ld5PTqpatMnFPkHbCrNI=;
        b=Shpu1expb9UmeNTzkrqLpZgKTTgNTFnWaaLHFYEs8X9t52qsEc2qqYzhSS1wKDUyy1
         n4EpvR8sgcpL9FLYrJpRYmBpPkbJYzeu10lN6wdKe7Ba3JMVPmK04th61cyw1jW0vioh
         2k3CoD0TVIieY7nwHyzHbt5z0gDLKPnvLw6UMDKlMyXki3gNfYPvuUq+SrKIZ7RFQuBd
         Px9Xf/3N008B/kEnqXS6fqGuDaol6sbJt4f/XDWyLT7f7F4gTOg0Y1UdNeEYpRgxFEy7
         DaXKvwDjYnKA9he3hNDcHOhrri5jmEMFtNNli0s0ezLRD1kzQDFHIjgsiSo66GqPF4gC
         ZR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689843258; x=1692435258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr3GYuI4RGrQA8MLYXyJLt2ld5PTqpatMnFPkHbCrNI=;
        b=BHIXWUfoakl8PhQDquFjzKiFTyEJYGd46X24plnliecGB0LYIGVyTVwA1JDFQJ3gHe
         fBQax3hpksu7IpwUrgPInccc79MstI3K3mLGaBlWWh+Z58oRrphfLjcqoCFCt9RFHsiO
         GkTMs+wVjXmMapFkPJ+fhq/GColiEWPaTvNtNY+vtEJ01nozS81hmnXuZ4xB2dwMHo5r
         Nu5R4zjR7npYQtGV/ZPPqIR4sipJY134BZoCHgJJrBzNmOV9D/AVCnmwZPC+kHFX9o6i
         rDWOWZ+qCCCz//WVMeqiDzn7i1WBnfRbSLxtZXadmGm1qX7Zm5USvPBBdpovBn17oPfJ
         lxIQ==
X-Gm-Message-State: ABy/qLacfEcq5lWI+GX6U928Z0fUYDCLe2SFaUtk7MqLo1rc3U5n2Hav
        lOo8U6G0dVDtRs/OOY3iHfINGg==
X-Google-Smtp-Source: APBJJlEh3NvNHBbbxheUFFyvpgKd2C0hcz7XJqCW4yZ6/zAz5ujRsINO2b569mPpxzPaezD6Arr+tg==
X-Received: by 2002:a19:ca4a:0:b0:4fb:8dcc:59e5 with SMTP id h10-20020a19ca4a000000b004fb8dcc59e5mr1681346lfj.39.1689843258307;
        Thu, 20 Jul 2023 01:54:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d53cc000000b00313f9a0c521sm657889wrw.107.2023.07.20.01.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 01:54:17 -0700 (PDT)
Message-ID: <a6006558-5eca-a8a0-ed61-dfa746f223ae@linaro.org>
Date:   Thu, 20 Jul 2023 10:54:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/42] ep93xx device tree conversion
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 20/07/2023 13:29, Nikita Shubin via B4 Relay wrote:
> This series aims to convert ep93xx from platform to full device tree support.
> 
> The main goal is to receive ACK's to take it via Arnd's arm-soc branch.
> 
> I've moved to b4, tricking it to consider v0 as v1, so it consider's
> this version to be v3, this exactly the third version.

Fix your clock/timezone, so your patches are not sent in the future.
Unfortunately this will stay at top of my queue, which is unfair, so I
will just ignore for now.

Best regards,
Krzysztof

