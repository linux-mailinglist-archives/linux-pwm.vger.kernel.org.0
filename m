Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C02F2CC3C9
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 18:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389325AbgLBR33 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 12:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389093AbgLBR32 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 12:29:28 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E0C0613D4;
        Wed,  2 Dec 2020 09:28:48 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id r20so1404183pjp.1;
        Wed, 02 Dec 2020 09:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ryyYawzS2MjebmkZYtVtHUp0Y0QlBniiFC9GtFM7sjg=;
        b=tw6vFMWheYBfBRyRmb/SeKnKrLSaBPqhiconFsvZKlXVrMdZlJFHppDrTxWf3LfQBI
         KeTRTk9piziD0Wf/l9FS8rbKTAMdp2gPym0voKW8jDVYNw32QTCBe7VAswbgNtST5CeK
         dlzkMG1OZwOKB/fQTN2F+RBoLqdn0ZX3m2PuVeKK0xUjpEQYLclgu7y+4nSDgpFm27+k
         q8zF07LNbsiAz55wdEekmg/3/lLd5NgiT/DEmso4SGjlk15Ena7r7QvJ3FIC/z/ZQEP6
         5wUOEc5ix2+sPVRZDPzA2HLya0iJQyGHrq7uAuYvS5dKkpbZ1977xELBU7KIuYBoknsr
         9Mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ryyYawzS2MjebmkZYtVtHUp0Y0QlBniiFC9GtFM7sjg=;
        b=Qxc5XnoT9x3tfF9hdZX/2V/lpXtyayKUYslNgaDsW+3yFByHG8Ao9BNIfQqnwdrFE6
         QiiAxMd6/ribDSHo4udUaxKxRRY281rGEvsUWjlm3nGaAizn5orkCBCVpd3paJD3c1HI
         TIecRy7M9g822f85b7qIZm2y2gpxwzeJJCWH/NFBX3wyj81RCxioGf7lzqphiJkgJAoI
         JRqV6xYZl3dXfPNTizQHSVBpKLCLe7xolzDmYuGl+e6B8Ussn5NJWfgFgAyX4NtbLtAe
         AwPEOqLQ5w4vD0dprb/H0rqERVIilXqL/SFH35piLrXe2YewENCbyN7C0/KCvB3FGd1e
         0kkQ==
X-Gm-Message-State: AOAM5331n/crBjOm41Elt12pG5f69toJaRmPJbAVf/J8ZRcBRImBS2XX
        Xccd4T5HPpkIql34I/JPfLg=
X-Google-Smtp-Source: ABdhPJw8MqBDwX4imfBfsfRPEoXVNfaDQOekjDj2tbT/zgjQRFtXp5d5bCHcfX9TqM9WVEsMk++rKA==
X-Received: by 2002:a17:902:b7c3:b029:da:74c3:427 with SMTP id v3-20020a170902b7c3b02900da74c30427mr3497294plz.38.1606930128158;
        Wed, 02 Dec 2020 09:28:48 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g3sm383218pfr.145.2020.12.02.09.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 09:28:47 -0800 (PST)
Subject: Re: [PATCH v5 03/11] clk: bcm: rpi: Release firmware handle on unbind
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
        andy.shevchenko@gmail.com,
        Michael Turquette <mturquette@baylibre.com>
References: <20201123183833.18750-1-nsaenzjulienne@suse.de>
 <20201123183833.18750-4-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2b9340b0-fdf8-7d9f-0770-495991c359c1@gmail.com>
Date:   Wed, 2 Dec 2020 09:28:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123183833.18750-4-nsaenzjulienne@suse.de>
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
