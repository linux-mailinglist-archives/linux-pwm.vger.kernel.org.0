Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAD262D7C9
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Nov 2022 11:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiKQKOH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Nov 2022 05:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbiKQKOG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Nov 2022 05:14:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA62AC73
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 02:14:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w14so2959769wru.8
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 02:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MaF6TdIwvoDg+ZEHPJVwXdUwTO/7Y9QkB06DBJdBjM8=;
        b=pRuAI1LU+o4rXBUdzTkC7c0hDFbXI/dq1iWDFGOCK2ZQiWLkCd5cKhF64eKxtupmJb
         hb84lewdmBlEld/dJTJVQXRmmY33maZkM2wrd3l8A61gxeLwUV0dPvEvkAbLc6t9wpSN
         fEfGQSqqwnnRFyodhweKmFhxidLx8TwCaGYxE3LHcJ7ISSI6HzvDFaavN5llnDCBf7vF
         SWa4RPjrOjKICU5NBi/SNGn0YpQGFpAwSdmtTPjFR13ZZz/G/GSPAeO/6PFlgznHQZLw
         eC5SHdDKXNBTol5P+UPYfG8EsioWgoXZIUfcQ/tJhoDJ7SuitkiStNlVXhN0ebf2l0TW
         d2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaF6TdIwvoDg+ZEHPJVwXdUwTO/7Y9QkB06DBJdBjM8=;
        b=Sk1CW9tjKw6PGYWwSh6A66NLzq1ua36HKe8TB/oy1BpledsGTWIoVflWcqlJqkN6AU
         K3ewb8OxDhqewF3qRGIuKDIbwa+whW8Ratu/TLpRCYyo8YFvaaWc3VxraHQx0X/vF19b
         HrsCsGZxRsBW7fjlgpxKT9zkWGQ4zYb8AoOFVwivXrkaQctkn09bESJQb3nGpa/Cb1e0
         N7yTuzLSSP7IgLEEJmKKD55nUVe018OG0lof3fa+E2HDciNshflbcE2v0SCcqlZ2CGRD
         t4MQHkW0fkFNf8sowj34hY3vZjDJiR07Fz+zDqSTKd1SGwLFk1IK+QR89V4dMA1F6JDC
         6Qgg==
X-Gm-Message-State: ANoB5pl22klDakPWgteRBjjRXQvOCYAd+pXlKJxMubu7q9BDBA0HLun4
        HU5iHc5Xs/q2APADQNxslTSSrA==
X-Google-Smtp-Source: AA0mqf738mjZ0nMHMQjX6CWSzQAyQe55ylIoQN6dVAjQQr6pMcCqtjt9ZNGz2lB4o0P+ba/ltfPTmA==
X-Received: by 2002:adf:e2ca:0:b0:22e:4ac2:aaa5 with SMTP id d10-20020adfe2ca000000b0022e4ac2aaa5mr1006086wrj.455.1668680043661;
        Thu, 17 Nov 2022 02:14:03 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b003cf75f56105sm934693wmq.41.2022.11.17.02.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 02:14:03 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:14:01 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Drop support for legacy PWM probing
Message-ID: <Y3YJaYx06Jzrs/Ej@maple.lan>
References: <20221117072151.3789691-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117072151.3789691-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 17, 2022 at 08:21:51AM +0100, Uwe Kleine-König wrote:
> There is no in-tree user left which relies on legacy probing. So drop
> support for it which removes another user of the deprecated
> pwm_request() function.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I have to take the "no in-tree user" on faith since I'm not familiar
enough with PWM history to check that. However from a backlight
point-of-view it looks like a nice tidy up:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
