Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DCE6645CA
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jan 2023 17:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjAJQRX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Jan 2023 11:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjAJQRV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Jan 2023 11:17:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF638ADA
        for <linux-pwm@vger.kernel.org>; Tue, 10 Jan 2023 08:17:20 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so10470346wms.4
        for <linux-pwm@vger.kernel.org>; Tue, 10 Jan 2023 08:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9aNO7QvYwDQS+jP6UmKWe479dR/ZyNUMn3qprKjVB9I=;
        b=wIFmlQ/NS1cd3Ft15IPF5Qt6fSCo5kzlfVvC6NwxMqnEPLSx7IXbm6E5MlcxsTvI/I
         Q3DoELKpnsXbU4QL74nZ9Ynj8at68VE0sCNfWdGPBA8x+SdIK69ws7qT4RUbGm3Hq6nO
         ClaxsemmRkEjTAeBk8iha6ZGxiRQaNUxknlWjtDxzXrQRHbgppNP8MbHtgvtT/2LuFjB
         X0EOfWRmvFL8tW1L4YnYLcRqPoFrNBn3rNIoCKyqhmP/S+hPSzm2uue7ZlXYUmUi6CVm
         8cbu7Pb00PfpS7NPmVxM4VZA6GtZrVUQLcIiEYcb+a34ixYrcngaFnQXcSfUwEbfsTFI
         6rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aNO7QvYwDQS+jP6UmKWe479dR/ZyNUMn3qprKjVB9I=;
        b=IkutAvTmcRVAWACEnKTTlWv0HkUxq9PHo+vCowFUKeoux8MhjzM4NZoTpsUKMGZqFC
         vnJLrO9AIisSLAuL9acrpdLyWIvmBOu1Ms8+Q3lGDs57wsywEJqrXiwkQ2d1iGFRuDSU
         f0wWxFi5WWgmeJtF9Z9p36pO1oEMTL/RtgdMO77JXZXQzGzFWW+gPnJNp8wFC0CnMJ4n
         UdH7DaH60GuYpKWsRO/GLgwKx+kVZdr8pzK6R/geTiBsa5F9D6fp9gnOFo1RlbEtgl3a
         5GtSfNmdOO2fI2x6RzpfUEW8HSqCrxPKVTp2bJLI/8BibRqrtVXRBEm0cMrz6+vBS4Ez
         DySw==
X-Gm-Message-State: AFqh2kqnC1++zfhIU2y8R/lOW+4Z/HrmM2/U39eUbnkkEHH6wAp9f8qk
        HkrPKKt8weAuzX6roDfpFdXnZOhCU6DOsW/R+Qo=
X-Google-Smtp-Source: AMrXdXtdHYGAOOA7IWrfaGhGuGxVKglU2btUiZ2nxiwOMk16l4FnFGqCikuGoCHjUCJQ1uEszp15Qg==
X-Received: by 2002:a05:600c:1d03:b0:3d3:4aa6:4fe6 with SMTP id l3-20020a05600c1d0300b003d34aa64fe6mr48900851wms.3.1673367439208;
        Tue, 10 Jan 2023 08:17:19 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003d9f15efcd5sm6597893wmc.6.2023.01.10.08.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:17:18 -0800 (PST)
Date:   Tue, 10 Jan 2023 16:17:16 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] backlight: pwm_bl: configure pwm only once per
 backlight toggle
Message-ID: <Y72PjEh8QuLdw1hw@aspen.lan>
References: <20230109204758.610400-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109204758.610400-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jan 09, 2023 at 09:47:57PM +0100, Uwe Kleine-König wrote:
> When the function pwm_backlight_update_status() was called with
> brightness > 0, pwm_get_state() was called twice (once directly and once
> in compute_duty_cycle). Also pwm_apply_state() was called twice (once in
> pwm_backlight_power_on() and once directly).
>
> Optimize this to do both calls only once.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

This will reverse the order in which the regulator is toggled versus the
PWM starting/stopping. It would be nice to that in the description.

However I can't see why it would be a problem (since both remain in the
same place relative to the sleeps) so:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
