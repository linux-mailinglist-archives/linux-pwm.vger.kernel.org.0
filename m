Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D958B755EA2
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jul 2023 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGQIjn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Jul 2023 04:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjGQIjn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Jul 2023 04:39:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C31D8
        for <linux-pwm@vger.kernel.org>; Mon, 17 Jul 2023 01:39:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so42877845e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 17 Jul 2023 01:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689583180; x=1692175180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvXy/QD/Pk1wVQOh6YjaEGgI2E+g61IPu7wSGMnkliU=;
        b=L7QarnmjyFnGGDP+dtzUQ+m9EkC03vr9oMUyRD+RKckUnMK92aQ+1hzqssBvr/VS8t
         ybG4szpchIROTfFkul5BgUelxLI6lLkqBdpxAQTRPETqHAP2NehvpjUXL880COyw6pqw
         3Npn5/xMcQn/CD7SxVZqrG+u3uioULXDPh/wgUR4bvGzos0vymTWM4kwgTixw3kFmGA1
         LnOlykAitHhn2wyaqgUP7mMN2CpUB7Hg6K3uG/SfXntBPe+F9LUl5u6h9FbOzIyd2OeN
         HyUlKZTruFFbwELpiucIaKZpq4Ix7WZds0o+xJ6g6/XO6mrgq7EfL+I6fjLY0ID2mdUc
         Z0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689583180; x=1692175180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvXy/QD/Pk1wVQOh6YjaEGgI2E+g61IPu7wSGMnkliU=;
        b=YyhMeL4CULYh+D9oRcS8syQdjOt0FNRI5DV9KzRvczzsMaF1LANy675TJXq4oqPy/N
         8LnTAgVPUF0quS8cNHyfccSO0LFInRKYU+MkajHGBh+yadGiT2fzYnmZS6aIJz04ZBRO
         f2Y+QtnubQtgMZSnP1lTPbWwohKZxQFVLtAtmjKk4QZuUIkoGcYBpARnbk2Y9ZABgiQQ
         H70UgzIABxbGJx/Z13lyDj0sZbD7gszzbR5UY7HjcBxABHHKuSeDO8za06KPBACVPpnj
         f3BKI9mqKqGrIuL46JRPnOjITpt7rjWSzNmnClR+xE2sls5KjFSdLGau0RdS+cPX2dTC
         TRrQ==
X-Gm-Message-State: ABy/qLa9xvw6f/4LznlouoSSSK0OwhpM1QLenu77I/3jZ5/1qdwEgAgI
        CJVG0cxFFJ9cj24hFTUskNcYKQ==
X-Google-Smtp-Source: APBJJlHgZ4E1mKTLXPhXfFVpcxT5qb27bMkUkVf2TsNNUrMgy5l8jHfpRhxNmjMn8BqDmr9/iS7uzQ==
X-Received: by 2002:a7b:c4c7:0:b0:3fb:40ff:1cba with SMTP id g7-20020a7bc4c7000000b003fb40ff1cbamr9475089wmk.6.1689583180223;
        Mon, 17 Jul 2023 01:39:40 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id i6-20020a5d55c6000000b003145521f4e5sm18523160wrw.116.2023.07.17.01.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 01:39:39 -0700 (PDT)
Date:   Mon, 17 Jul 2023 09:39:38 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] backlight: lp855x: Catch errors when changing
 brightness
Message-ID: <20230717083938.GB3448956@aspen.lan>
References: <20230714121440.7717-1-aweber.kernel@gmail.com>
 <20230714121440.7717-3-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714121440.7717-3-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 14, 2023 at 02:14:40PM +0200, Artur Weber wrote:
> The lp855x_bl_update_status function's return type is int, but
> it always returns 0, without checking for the results of the
> write_byte/pwm_ctrl functions called within.
>
> Make this function return the return values of the functions it
> calls, and modify the lp855x_pwm_ctrl function to return errors.
>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
