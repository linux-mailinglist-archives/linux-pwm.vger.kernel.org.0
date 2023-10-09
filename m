Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B3A7BD85E
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Oct 2023 12:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346048AbjJIKSj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Oct 2023 06:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbjJIKSj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Oct 2023 06:18:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8769C
        for <linux-pwm@vger.kernel.org>; Mon,  9 Oct 2023 03:18:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50433d8385cso5787860e87.0
        for <linux-pwm@vger.kernel.org>; Mon, 09 Oct 2023 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696846716; x=1697451516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KzjqhcxTplk/fjWtjjswcwgpKZ+f2AVwpc+PUpIKpZs=;
        b=ZEUKLlgG/gqJMRxvNHNWSDthUAREEt003CrTKeTuRNfvd/UOpwsu93VQOfO34/amnB
         y88jK5pmZAvN9dvwadadS3zMDa8Bldab1Gae6gQtRKl65J9k41zsPih/MEPw46HTiiAp
         xrx7tvKvSZrUlq3YxRJVyqwpUXwNnMgmonDsoiBXNiDfYZH90xdHl5xtjq9bvXRNNGKH
         HcJmwcjfxYTd2R4dNQdhmEU9IRDOobevYP1O1AexRCNsw6sslBJEv6FKPjWlkvl7x8Zn
         NLPxxVJU/WmKI4B87j1mOQDV0R3TC0eff4jQv3ODtCNSiDUg1uWmSi0SwwC4gQYKnown
         XzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696846716; x=1697451516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzjqhcxTplk/fjWtjjswcwgpKZ+f2AVwpc+PUpIKpZs=;
        b=D3n9oqQw+KvZqObfh1EsSSicQNiestcksrdhR2t9VEoiAx215pdC3doNajdqZUZG8A
         KkXXRCD2/V4qhykU78LeyLEUv+IVQWoEza4dqbLkBPwJphYEHZRn5mdFyNl7jXicZR4x
         yvAJgeQZYrnQMzDFMZ5ZJp2DBegnvU1fSCjiFoWtoHFnE+5F5J47ceidUu6EkWq36bAB
         iyMfcmXtv+HcehndnI0kEJBvj9TvSIp88ZrWRlL6+9D7E9NMLDDn6NLJKJf9bYygMiFa
         99npXvhmZzBczo0lfcibLVpDR7k9NsAXLgxZhtucrYBT+iQvuNOJgCluXjbwJu3AL1lj
         jSUg==
X-Gm-Message-State: AOJu0YwhcxVmfUduCZnqVf9EZwYeTZaCFL4UBl53p3AJIwW3Nrv10GFV
        0+OlEcyVwbL4se5K+9yPbBUFoQ==
X-Google-Smtp-Source: AGHT+IGY9WKDt7ALyy/qcEMDEosc8dNznZ/T5vS8ZD92++froNBAqLNU25PJBwaTdb63LswVmU9kIQ==
X-Received: by 2002:a05:6512:250c:b0:503:8fa:da21 with SMTP id be12-20020a056512250c00b0050308fada21mr16362091lfb.43.1696846715809;
        Mon, 09 Oct 2023 03:18:35 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003fe61c33df5sm13038355wmi.3.2023.10.09.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:18:35 -0700 (PDT)
Date:   Mon, 9 Oct 2023 11:18:33 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v4] backlight: pwm_bl: Disable PWM on shutdown, suspend
 and remove
Message-ID: <20231009101833.GB223751@aspen.lan>
References: <20231009093223.227286-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009093223.227286-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Oct 09, 2023 at 11:32:23AM +0200, Uwe Kleine-König wrote:
> Since commit 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once
> per backlight toggle") calling pwm_backlight_power_off() doesn't disable
> the PWM any more. However this is necessary to suspend because PWM
> drivers usually refuse to suspend if they are still enabled.
>
> Also adapt shutdown and remove callbacks to disable the PWM for similar
> reasons.
>
> Fixes: 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once per backlight toggle")
> Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
> Tested-by: Aisheng Dong <aisheng.dong@nxp.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
