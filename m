Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A162CC3D1
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389337AbgLBR3q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 12:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389239AbgLBR3p (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 12:29:45 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FD2C0613CF;
        Wed,  2 Dec 2020 09:29:05 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t3so1478989pgi.11;
        Wed, 02 Dec 2020 09:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1zd2A4b3H4W7rof/if1DjaC7z+bwx7utHHR11ZaV7KI=;
        b=Ku59e9QB5fODwHs76IPpDyNYKuTfFB8V4ma4EP+h2FNKCMx+aY1GJbS4umSCeJiZoM
         6PCJlcBKIyeCLOWyIUks/EeZVuzqX6s8FRd2+WLLjshOdoPQ8tnH/jFCswwTT6yeM1Ej
         WUs4PtqITpZ2Fr6n3Vn080sqF0cI4FqRxkyC7wHcDnIhnskpD2bYd4WzMX716kN0Lagr
         RXmrGe4DRciWT/nbOClXOOG4uQMzGvdNReNyRWZ7LShggNlWNrQru6+JeHR7EIDIrIzQ
         9NZLyeESgpMDucD/YP6xHG/JF9yU0dyovi9sk1ao2gJGS6apyg7PLlgDZKIMt8Q2hDXx
         CdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1zd2A4b3H4W7rof/if1DjaC7z+bwx7utHHR11ZaV7KI=;
        b=rY1GbpLBL9MSujmid0JlcoMY59MYpy8sVuhxAfQKLQPc1kIgzv3+zhQKVJqmFWhB5R
         hLiP/Ceb810Ooe+s+VYbj5zu6G5mE/ysVF6ne2P25BqgH8zShSA9/WadVUJQ+K5dZdXj
         jmx7hcoD7mY17rKYreSotY5hVB9L8dbcoAeoXLFySG0rzQ3xGJtfZPd1shopr1dGREM+
         b1B9aFsnaZcduKp8SK7a+kHjieW6O4knYNhYIRifQc3RR+Cr6b+kPZd9CdAqdAYjrSVY
         9x9MPujUt4kAWfbH3rOsVubwW2s9dMaHvjZ6C3RYmG8c59g0fGn8GtMh4y61gydR/KGz
         APug==
X-Gm-Message-State: AOAM532jbMjgwfcUCs/ppFIBfLTyE+ElpzUp4DUAMYjxTSGcXfTVNWcf
        uMu2zFYz/gsQDyDj98ua8yQ=
X-Google-Smtp-Source: ABdhPJxQDcY1DQubBXpw7TsyWKzjziBWPqyqoTcEmilGbyfzvlDrvmyHnr8hcmY8gv1fKTZ+vo6KBg==
X-Received: by 2002:a63:1514:: with SMTP id v20mr797640pgl.203.1606930144918;
        Wed, 02 Dec 2020 09:29:04 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 188sm366246pfd.188.2020.12.02.09.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 09:29:03 -0800 (PST)
Subject: Re: [PATCH v5 04/11] gpio: raspberrypi-exp: Release firmware handle
 on unbind
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-rpi-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com
References: <20201123183833.18750-1-nsaenzjulienne@suse.de>
 <20201123183833.18750-5-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a2485ad7-85a2-4f10-5e40-27461a10c797@gmail.com>
Date:   Wed, 2 Dec 2020 09:29:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123183833.18750-5-nsaenzjulienne@suse.de>
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
> Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
