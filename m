Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFB36FC7D3
	for <lists+linux-pwm@lfdr.de>; Tue,  9 May 2023 15:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjEIN1n (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 May 2023 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjEIN1m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 May 2023 09:27:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6730CF
        for <linux-pwm@vger.kernel.org>; Tue,  9 May 2023 06:27:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3063b5f32aaso3794392f8f.2
        for <linux-pwm@vger.kernel.org>; Tue, 09 May 2023 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683638858; x=1686230858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuQ2FBeCRoqgngylaRdOh7aqiqlvdZtnW5rbAbkcgXI=;
        b=AH1IzWoKD1GbxcF9ng7uQsTL872w02GkxK1Q77af/6B74iG8+N4tcxgxkyb7OF7cca
         Un3CHwFvJCOe9jANPaUvgVp3z6qPeSkMv78Q31nEc+DzNcFSqduVfxqpERiiTgbIxEiL
         uYMUNm2pcXy7AVAl7+aOS38etpxSM74rgG1X9Vn2TIAwXNuN0nU4CXYcCbL+WmYruQEi
         apXr7BQg6zkxzn3spKQUkefPlrDVExBq5LPRdpsYJdRwqgi+PMhrS6V0tRCETTl07OO5
         LrlqLsPxnoVZa2FKaXipGlrepsiGlXi0YGBODqPF6rQGfvwQW0ALnAAUm7XW8EftFs0Y
         qQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683638858; x=1686230858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuQ2FBeCRoqgngylaRdOh7aqiqlvdZtnW5rbAbkcgXI=;
        b=Ur0tgVQbFPaXjsefTK/u9Zf/2sF+tj8Jdq5hxxmxWf+tdfNKXk6zmmOcqLdrs0KXql
         0Exkw3Ve1HhSSUORb8TIjqxSaA3kp4QMEzmYA3ZVk62ZCBPt+5nr7XDKDBAjuSgZxVux
         LaQJQG1hhMQ3FEp1/p8tbHOj0c7/wa7d4PAvK2dcIOOLAK3g2BfS0FdPS4EYwpc+KRBw
         RjMtBGINfLqb7Yq5+DYGPMc8NTNlNIBVoChbc+3lDBMD1blVegyrstdHIvqRzzSp5PFI
         0c5yRHTuBpSrYlLJ81GaK/BDPB4JoGYIPJ6cZJEIbgvftRJDodQrSAXV3ROvmgNKxPqe
         ZpSA==
X-Gm-Message-State: AC+VfDyI6Xq/sHnoi9G9PmWBClRtta6Fmql9Z5DHuBo0zDkuLEpCsPBT
        BSr8tbfogvJGin79Mb+BDogH7w==
X-Google-Smtp-Source: ACHHUZ60LQ2w7jDdb1KfIt1LYeUDMCEJrCrpzMKg5XLc7SVJ/RpGIRMx0wqXtIAXfShUhg+fn2JRHA==
X-Received: by 2002:adf:f491:0:b0:306:31b7:abe4 with SMTP id l17-20020adff491000000b0030631b7abe4mr11390420wro.14.1683638857874;
        Tue, 09 May 2023 06:27:37 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b00306344eaebfsm14415375wrx.28.2023.05.09.06.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 06:27:37 -0700 (PDT)
Date:   Tue, 9 May 2023 14:27:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Maximilian Weigand <mweigand2017@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Maximilian Weigand <mweigand@mweigand.net>
Subject: Re: [PATCH v1] backlight: lm3630a: turn off both led strings when
 display is blank
Message-ID: <20230509132735.GA31274@aspen.lan>
References: <20230505185752.969476-1-mweigand2017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505185752.969476-1-mweigand2017@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 05, 2023 at 08:57:52PM +0200, Maximilian Weigand wrote:
> From: Maximilian Weigand <mweigand@mweigand.net>
>
> Use display_is_blank() to determine if the led strings should be turned

Shouldn't this be backlight_is_blank()?


> off in the update_status() functions of both strings.

Once the description is fixed this is:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
