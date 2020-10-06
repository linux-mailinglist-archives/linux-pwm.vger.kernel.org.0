Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3915B284885
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Oct 2020 10:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgJFIZN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Oct 2020 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgJFIZM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2020 04:25:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9B5C0613D7
        for <linux-pwm@vger.kernel.org>; Tue,  6 Oct 2020 01:25:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h7so8788554wre.4
        for <linux-pwm@vger.kernel.org>; Tue, 06 Oct 2020 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YdhpNKlTW8M5AEVFobND3IcWnRcYsnTU1ylxUOoxLOQ=;
        b=qHporHfANLglN4o1QtjGAQRWNnN7asjRL3cjazvXjsHh09RfWeLWPhNLVvwSLhWTRD
         dq9W25RBebcUYOBXWtFq8Xg4Jpr5iwt1eXNmqsekvon7Xl48K0UpprSPFSz88KD7f3X5
         mVcgrKZ1Q+07rFYOZ6TaIw9SiDE9zLlxqZ10OzeIv3M1P2sRohlLAogcHVmvgwhtbxWh
         aDv0+4vxSuOdMGAP1BZwP0BlcnNmUE37U3q6XBhiOW2IywzQSNU0oPIf35dwBbDiZGem
         YyfEcoZuw1vq+eSTNb3BPCippk6TyfUXDjeg7Imo0qPxxzlaz4AKfZHvUV+rJldsOuzH
         6yMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YdhpNKlTW8M5AEVFobND3IcWnRcYsnTU1ylxUOoxLOQ=;
        b=hLIDuamjqkIHH4IvzKFEBWef3M7a2PQt+7tGfirO3wyYZIydI+IegUpSN1OuwIUR/P
         ZEojJFuaFBf+aZPSOxIIpPMPng6mn1sH3ZqaMQ6YmWBDKsrfW5P02P0Hgvh/ZypmT5Xm
         gw5TBY6cwWTyXGfubfFOgSKZgXZRDoJLBkkjJZLVrDSESyjnyV+Z0DaICtVH9VY8MW8w
         PfX+fcRXghybGfyQWsq8jMa2MzxTlVUzSMBmMmQnTB7fEhZtVYbarlKQKe74mArH9nh1
         TKrmmkQ4s4CmH3DT7NBXYWSujNXtD8NM+eC8aBf0sneUBEhs4o8MFMArHRcC1UC7Ia+Q
         Cntg==
X-Gm-Message-State: AOAM5337DwUvSmIszGeShw/outkwyzoP2nwdSL6Vk9PGma4pzaLuEK2n
        3TLAaV1F7grI3/+sauzGR8mXZg==
X-Google-Smtp-Source: ABdhPJxsjuEumsaEtaU67N9vbg2cBftfsc/wZW21wnFzsv2BjeMFHC1JmQFLaFRJtrvHxARri2Z8Zg==
X-Received: by 2002:a5d:6409:: with SMTP id z9mr120080wru.391.1601972710164;
        Tue, 06 Oct 2020 01:25:10 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id y11sm3353486wrs.16.2020.10.06.01.25.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 01:25:09 -0700 (PDT)
Subject: Re: [PATCH 0/4] dt-bindings: additional/unevaluatedProperties
 clean-ups
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Lunn <andrew@lunn.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "David S. Miller" <davem@davemloft.net>, dmaengine@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Jens Axboe <axboe@kernel.dk>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Richard Weinberger <richard@nod.at>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20201005183830.486085-1-robh@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d04c47dd-6e37-a7ac-f3c4-d6e6c308dbcd@linaro.org>
Date:   Tue, 6 Oct 2020 09:25:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201005183830.486085-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 05/10/2020 19:38, Rob Herring wrote:
> The default behavior for json-schema is any unknown property is allowed.
> T
> 
> hat is generally not the behavior we want for DT. In order to disallow
> extra properties, schemas need to define 'additionalProperties: false'
> typically. Ideally, we'd just add that automatically with the tools, but
> there are some exceptions so only making things explicit everywhere
> really works. Missing 'additionalProperties' or 'unevaluatedProperties'
> has been a constant source of review comments, so a meta-schema check is
> really needed here.
> 
>   Documentation/devicetree/bindings/nvmem/nvmem.yaml     |  2 ++
>   .../devicetree/bindings/nvmem/qcom,qfprom.yaml         |  2 ++

for nvmem parts,

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


thanks,
--srini
