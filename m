Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36B82CC3BD
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 18:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389218AbgLBR2b (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 12:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389133AbgLBR2a (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 12:28:30 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9A4C0613CF;
        Wed,  2 Dec 2020 09:27:50 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x15so1512991pll.2;
        Wed, 02 Dec 2020 09:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+UdVXmhs/4Phj5/5bdllmyNQP2Xy3BlDAzSJt7PwcBQ=;
        b=CunhwlfKnzPtfdmbBnX7BUQ7LUIF4t1GqAq/HZj8+ogdRbMBahd8LRFwOQmntOrW0c
         pGa156PZDBgVaIjtVsWLj4ZLpATBQ7PfE62i0E5OqcQj5FfsAtURN5cIJpg/VMhjhaZZ
         192m4inZFbDtCeS9+IHkIQYjme89nyDQuCIDUGyHVc9nVdITI67VCmV7OQxDgoebkyO8
         v1vVcQwqTNk8Jj9LSrE+9TVkfcTI4EhJMrAmfzYuSnJPlt+vBFwdaL3iujwfGl/WLQOp
         249M3B4JxN1ccIKxROdBnHeuNw9VOnvH75HGixeyj6cucnw255ZyfdAgtxWvVXiWywu8
         2o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UdVXmhs/4Phj5/5bdllmyNQP2Xy3BlDAzSJt7PwcBQ=;
        b=GyBFwvNfeWM96/rRXSQAyI/ZabZ+dmkBNvVbqYprRD/Osm9snDceGxGIGPEss6Sjzz
         NoEQ78MBWJ976jUv4DnIFXDExlm0qXV2KZScBVu8UyNxbndIGyXEvMHi45ab+DoLVy6L
         rhJmeKJstAFYSJh5jlJXH2lntWCKP8If0H0+yhX/yHw6K3DWZqPEFEKsb2IJRYNSz6Ay
         DsHvgv2Kx8WIZAI4UESRnkBGu8Cjyjy15Zyx2755DmsamRoRvMlk/IFqbdvHOP+uH8AZ
         aIsEViVUAgoifbmx1iVmEI3j0ahFfQAKhXU39SuigGf8XMKvbCVCQipLo5XL/UvjXv34
         z6kw==
X-Gm-Message-State: AOAM532RDIuFd4P2Q2LZQzU7tWzHliKXx0KfWp9TOiiAHrO3PQjYrdqv
        nlow/8XTIZQhEpvhZ9oFkN8=
X-Google-Smtp-Source: ABdhPJxcrTULgHKNSH5y26fS9YrVHQBUqB13+rzeYYBT0V6asDNO/KiMUjFV7pXoYk5j1YcS6o5y6g==
X-Received: by 2002:a17:90b:1c0d:: with SMTP id oc13mr807603pjb.113.1606930070265;
        Wed, 02 Dec 2020 09:27:50 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h7sm371319pfr.210.2020.12.02.09.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 09:27:49 -0800 (PST)
Subject: Re: [PATCH v5 02/11] firmware: raspberrypi: Introduce
 devm_rpi_firmware_get()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, wahrenst@gmx.net,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-rpi-kernel@lists.infradead.org,
        bgolaszewski@baylibre.com, andy.shevchenko@gmail.com
References: <20201123183833.18750-1-nsaenzjulienne@suse.de>
 <20201123183833.18750-3-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1870d3c2-048c-7438-602a-6e5207efe515@gmail.com>
Date:   Wed, 2 Dec 2020 09:27:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123183833.18750-3-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 11/23/2020 10:38 AM, Nicolas Saenz Julienne wrote:
> It'll simplify the firmware handling for most consumers.
> 
> Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
