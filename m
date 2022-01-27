Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8793949ED5D
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jan 2022 22:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbiA0VYZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jan 2022 16:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbiA0VYZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jan 2022 16:24:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B7FC061714;
        Thu, 27 Jan 2022 13:24:24 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x7so7828538lfu.8;
        Thu, 27 Jan 2022 13:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bNhNRSivDvjrtPG8xj2mWcD1Z+8aigQB44phju05G1M=;
        b=lkhNPvV+uUYrXxXURbZkUvww/NUhONx1qzODBskAql50MWZVDpHu21QTiiNEMU3JjX
         kjq2dnmBp0G6bYqQKJ2EJRFySvhxHX8sklIBkP9e/wpm0JJrx+75L9I6APYcd+LyOIou
         Ef+V5v4+jGurlRF3nMvcAxs8+ek7fe3M/fHNV0BPbepqBVXFRECMvXQUVLwtW9gyLVhr
         dfJEXN2gvb7PyFlYlnWRLnEQr92uHugJVZ90mBq211DMw23SKVwRWF6zbWGeAqexi+h+
         ByCFZTCSE60eqtsKVdrJvKhC79lnjMao6nA9NmMTEFLYVMo+TysWNmDoZC3TtGlxDezD
         zO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bNhNRSivDvjrtPG8xj2mWcD1Z+8aigQB44phju05G1M=;
        b=Z+nWmYd+AG8t5CGvx81Lgw7LcQY4cpJVC3cRM/JZ8dMmZ4TrvhqBe09k3iqvbSditP
         jyXSLyLqSZW6pvofpADytLi9A/jC3pnd7cIotXTlWtRxb3L7zWFVg1vA+NhniAzns5AU
         /kFOLSQdrFdX/gf8N7Z70V7F2S8DjWxbY4AYYNJssEtAB2eOqG1Skj/QVlhNIUzplhxy
         vuXvuN5YWfK/b06YjIl4CSImH7oF7vVlEhV51Ozv/N5ISmAErfxI/MZzvA1BO0IS/12R
         A37kaWUFqo7AgcffW4mPS72PG7fE00ko3YTSkn39o4p8RynYcdh9XCn8cpBzOa0u9xbR
         G/KA==
X-Gm-Message-State: AOAM531lAUB1TJiM2v3fgfqGvfHe+8vv7zkyUQNVPQet1wRvuD3R2lJd
        HeLwFLzxCt9em5n25/NJnu8=
X-Google-Smtp-Source: ABdhPJx7QXLxUmbGFHiBxxdUCvj2xSJi9io3hJiEueQPJegwsoGXrZGHRxncjrIsdi2Jsa6zy96K5g==
X-Received: by 2002:ac2:4e8b:: with SMTP id o11mr3880575lfr.531.1643318663241;
        Thu, 27 Jan 2022 13:24:23 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id i18sm2293223lfv.257.2022.01.27.13.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 13:24:22 -0800 (PST)
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
To:     sven@svenschwermer.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de
References: <20220126104844.246068-1-sven@svenschwermer.de>
 <20220126104844.246068-2-sven@svenschwermer.de>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <00d8de09-360e-4e0f-1496-642ba1cbf863@gmail.com>
Date:   Thu, 27 Jan 2022 22:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220126104844.246068-2-sven@svenschwermer.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sven,

On 1/26/22 11:48 AM, sven@svenschwermer.de wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> This allows to group multiple PWM-connected monochrome LEDs into
> multicolor LEDs, e.g. RGB LEDs.
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
[...]
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    rgb-led {
> +        compatible = "pwm-leds-multicolor";
> +
> +        multi-led {
> +          color = <LED_COLOR_ID_RGB>;
> +          function = LED_FUNCTION_INDICATOR;
> +          max-brightness = <65535>;

It doesn't make much sense to have such a big resolution of global
multi color brightness. 255 will be sufficient.

> +          led-red {
> +              pwms = <&pwm1 0 1000000>;
> +              color = <LED_COLOR_ID_RED>;
> +          };
> +
> +          led-green {
> +              pwms = <&pwm2 0 1000000>;
> +              color = <LED_COLOR_ID_GREEN>;
> +          };
> +
> +          led-blue {
> +              pwms = <&pwm3 0 1000000>;
> +              color = <LED_COLOR_ID_BLUE>;
> +          };
> +        };
> +    };
> +
> +...
> 

-- 
Best regards,
Jacek Anaszewski
