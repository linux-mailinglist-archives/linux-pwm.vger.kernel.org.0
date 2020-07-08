Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11A9218588
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2020 13:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGHLHV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jul 2020 07:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgGHLHV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jul 2020 07:07:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ACFC08C5DC
        for <linux-pwm@vger.kernel.org>; Wed,  8 Jul 2020 04:07:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so2468306wmi.3
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jul 2020 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D3AIqKAC7WmKPj2+3TyOKcuKXPxkDzQZQxQTNoRIip4=;
        b=Zsmq3p2O8CDTh2JBxYietiIf1X/JeoMYQfrO8bH/zhTk2c6c0q87B7jTQ9BJQ1SNMa
         z4QbljZQhml4oeQzeuCYz7DDkaBgRHTYXOZOQcnUGFUzi+c9I+tz3DMV3/UAzF7uJs32
         oI9Z4p8B0OX0UNk57Q0KPuXBcV49Ric7fC7RsA7rre4Huj7nMxAruJLkHmKPLaPADxFn
         pT26/T2ODexcvcgUhBmfQCqlPuewJtjJzsGhkrwfUFitEL9qVoh5ZnkkzL/u8VoOs2gu
         VlB/+zk/v0XCrbtzHBYOkBMtRTITtKml9qbjyF92TO0TGXdjvEe6ati1M8uda8lm+YkP
         iq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D3AIqKAC7WmKPj2+3TyOKcuKXPxkDzQZQxQTNoRIip4=;
        b=UIcSKytrL9y8eXyTWSHlco4+0XupJKbzYFh+3uBFQY+eN+juuCf79JkHPEkYrhw/kQ
         wo8XwjOBNmDwgualxQDYsydMNwZwKbFDNBaX6NNqbUmy12NdDE+vCVwgStItCD9w9ItK
         OmoBmkh7l7fORJIWekL79kojnX18pOHeKtc0U00QVXlVF3VJe/TJzaM4mQrBGfhhWOxn
         wXHvYVwQatSbOJgsH2bM29OVcH/D1HvjHysID2l3MjxuTX+4aiWZfuvF/7rFc8414G0A
         77eHyYdCfiOo/53ZAOB8qnkAuhL5gSvWKeILA8lVyx3vZh5L5cEXGNkSScFDm0xHfeut
         qYVw==
X-Gm-Message-State: AOAM533BLxW57rOj7aek+hBEpOSKPbOHhCwjHr3Ha9i3sV3lrp9+Imf8
        d/E4iga0rdgSZ4gM1pEb+AlNUg==
X-Google-Smtp-Source: ABdhPJyzUcSnzwndQ5uj4ZqTICfcftsD4XVNdp7Zn+6g19c8oHbGDWXjBfPfdP19gVRbBXXRQl119A==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr8670972wmg.116.1594206439431;
        Wed, 08 Jul 2020 04:07:19 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 22sm6045568wmb.11.2020.07.08.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:07:18 -0700 (PDT)
Date:   Wed, 8 Jul 2020 12:07:16 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 15/20] backlight: gpio_backlight: simplify
 update_status()
Message-ID: <20200708110716.2ujel24lqjcudu5f@holly.lan>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-16-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703184546.144664-16-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 03, 2020 at 08:45:41PM +0200, Sam Ravnborg wrote:
> Introduce the use of backlight_get_brightness() to simplify
> the update_status() operation.
> With the simpler implementation drop the gpio_backlight_get_next_brightness()
> helper as it was now a one-liner.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
