Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FC32CC3D5
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbgLBRaL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 12:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgLBRaK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 12:30:10 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D418C0613D6;
        Wed,  2 Dec 2020 09:29:24 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f17so1494435pge.6;
        Wed, 02 Dec 2020 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ryyYawzS2MjebmkZYtVtHUp0Y0QlBniiFC9GtFM7sjg=;
        b=b5xlFRCbMRItD+HFZcCZb+HbaGxsWgbgub+SCO6VZOqdgpgiloLzr/Y3f6m5NGZo0d
         a06NZbtaF62w8BaesFML+kfHSY3EA/Cr0qy/0FKGZsYKU5xWQ7SdQMrYwA/YOYjnp58R
         C+IZ+hRMg8vXYCOfWmC8kCy06LKQmkl8hfGwmZzYoFlsnNw8g1qls4moR92HIgzX2sQm
         ielZze+J7rzOAPhPK8pXaoHE17NH8yvyRVCYK8+cPJ/0SPYNMxR0FMF9CGcOgaysfWCl
         HZaLHO8O+3DfP/7mV5VA5YooTJXfZu7eORXTqHf8udFT4V2DiMWK5NzAnMBNcr4UO9JW
         QArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ryyYawzS2MjebmkZYtVtHUp0Y0QlBniiFC9GtFM7sjg=;
        b=gqTPsB1tj5FkwMhUGT+us1O0oV+BU5+W6SOmw+3R82eq+L2My2wuQGPjmJat6P38wR
         iceDYegrDriY8ltv4Bxqe1U/MnvQb7lGCmWgJ3CJGLKDUOOZ2u6jkmITQ/LuI7mhIXnS
         QzybciFxn1daUbNXnY6ZFdFnQ1Q/CAG1xklQwsrQSyD0+AIL1vDSE8ni1DEi2H4ZL+lz
         m+zSjr6WUl+eTIaXZWW3mFF62Azp4s0VDDr5JtnZCDKyCPoWYTyyH0gh7A0imftGReB8
         3MJw/glOJWWWdPEmVonCzTf25WuPcJ02ukw+wuGGC8t8Pc9yfcWcGfVIeWoalvG3pv48
         G4yg==
X-Gm-Message-State: AOAM532wPYSYuYsUv6PxX3Acq1cD9IY+2j2zEI6aNBsDjVzdgknadhtz
        BJ5sjXtTxkeGj6fYUG4FWmreHHrFFR8=
X-Google-Smtp-Source: ABdhPJxgQXx0kr1Swrb/KX+SjSrYEdQ3otcHAy5qmZ1c9fTmh11kgvfHr8IV/bJ85O7X3P1SA1xN8w==
X-Received: by 2002:a62:6405:0:b029:197:cc73:397b with SMTP id y5-20020a6264050000b0290197cc73397bmr3927426pfb.51.1606930164131;
        Wed, 02 Dec 2020 09:29:24 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q14sm382946pfl.163.2020.12.02.09.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 09:29:22 -0800 (PST)
Subject: Re: [PATCH v5 05/11] reset: raspberrypi: Release firmware handle on
 unbind
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-rpi-kernel@lists.infradead.org,
        bgolaszewski@baylibre.com, andy.shevchenko@gmail.com
References: <20201123183833.18750-1-nsaenzjulienne@suse.de>
 <20201123183833.18750-6-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <848fa5ae-9cc2-a119-64a5-130f25157d56@gmail.com>
Date:   Wed, 2 Dec 2020 09:29:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123183833.18750-6-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 11/23/2020 10:38 AM, Nicolas Saenz Julienne wrote:
> Use devm_rpi_firmware_get() so as to make sure we release RPi's firmware
> interface when unbinding the device.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
