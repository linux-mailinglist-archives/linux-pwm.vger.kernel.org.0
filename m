Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA012CC461
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 18:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgLBR4E (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 12:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLBR4D (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 12:56:03 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AC9C0613CF;
        Wed,  2 Dec 2020 09:55:23 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id o9so1705238pfd.10;
        Wed, 02 Dec 2020 09:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ryyYawzS2MjebmkZYtVtHUp0Y0QlBniiFC9GtFM7sjg=;
        b=JrsjG0IzQ0TgPk4TC/V99EGsekn3FhEaEM4vkQy2ZkEdIf0DtUX+LwjaFp4XV1VvqP
         s/sNvoVcWMzNggQacUTfqCbGGuaZOsIJU8y4uRrdHWXpCg8BCP5PgMQB6RqAQd5F+SGX
         AGdrkNQlhr1T1fqcdxAOVz4sBkV0hGM4j3k9Qr9SOmHXvb1mAqbxHNqQkT1M1kfBY3tr
         CvMZb4i8rbJPLgka7aiMcbL3xkzi+tM+Of4E/94umUvUAJIlzFmg92Tl4izJOQfQCFgE
         gpFti5D7qDz8BQC0PBjIjUhdiv0VpUBjin5pfTSVNhmFo7FQCvIiCCHvO4tNO7jgNWwm
         sEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ryyYawzS2MjebmkZYtVtHUp0Y0QlBniiFC9GtFM7sjg=;
        b=muf/J0nrPN2jwrUNR4hvACI/ozNH/xmNuongeq8EERm4eJz7I/rNqDlwbIooka4ahT
         87VgOsRF8LdMxihfHVO9aehqbsyqtInOzexGhqL2kCeMjV46xoYrH+3f5fd8HqSrrh2Y
         0clFC5re+J+ieEFs1M0/U2GGV8A60wN+ApKafKtQItiINEF80VEPZaoWdGC2yWR2x2hb
         MWLvsjsX8T20OrdIfZYKMyMP90NpPelNB68wp4PWjNqbcH2PftWj58Enfk7NhtJsvbO0
         yZOGoTkN6vBsotxF6cHBQxUMPLtfLuv6cIiILvr+/j/rQ0fLN8q4UVw0w/sTmNNaN5vc
         NHvA==
X-Gm-Message-State: AOAM530cyKQyY05U22XhQ3p7atO431rnFLYcM21Nu89iGGfhq4BhNGwG
        GFVBQl2rc0kQkR4fTiJUweW0s5LRuhM=
X-Google-Smtp-Source: ABdhPJzZJfnJTKZDgnB349gIV43CHB4pRQpSz6yZhKExglNfal84cKW05LLkbAViYODkjL4H+6trjg==
X-Received: by 2002:a62:1c96:0:b029:198:1cb6:26bd with SMTP id c144-20020a621c960000b02901981cb626bdmr3599343pfc.33.1606931722779;
        Wed, 02 Dec 2020 09:55:22 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a3sm409853pfh.106.2020.12.02.09.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 09:55:21 -0800 (PST)
Subject: Re: [PATCH v5 06/11] soc: bcm: raspberrypi-power: Release firmware
 handle on unbind
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
References: <20201123183833.18750-1-nsaenzjulienne@suse.de>
 <20201123183833.18750-7-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f3fb5ec0-78e9-9245-8a08-247313e45a57@gmail.com>
Date:   Wed, 2 Dec 2020 09:55:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123183833.18750-7-nsaenzjulienne@suse.de>
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
