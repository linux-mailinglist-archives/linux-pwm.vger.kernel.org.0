Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F39675AC8
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jan 2023 18:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjATRH5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Jan 2023 12:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjATRH4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Jan 2023 12:07:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B72DA24F;
        Fri, 20 Jan 2023 09:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3333CB82941;
        Fri, 20 Jan 2023 17:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B027FC433EF;
        Fri, 20 Jan 2023 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674234472;
        bh=I6PH2H2Yw675+U9o8hDY9JH33oLdXehSqpyemY5dpRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JaEnJgLx9EHv3vhiH7sCQTn9pOT9W8ogMRKD3E44E/5bgeqq2dSWZhN8bXVgaIM1k
         GNTAIcGK13iQCJlPl7fqc6FUd8IP2H4hUzQ9n7bNDsq8zIgBMaG8cYOvqZmABY63vQ
         jT6I+Bhgdp05A8MlQD+I5Ths0h297fbsJ9OLuas35U47/aZ2y7Pm8RRASmhC6wSDD7
         9V/b+uoEAcmoCN5bIGxZ17JdE5Zg+gujKXLfJjpl7c6/+PYLyIQl6EO+P8QbZIqt6n
         U+4S3G/RjkgcauE3ZmrnbQO/w79B6fX+NP6wbf/BQaW3LTAYSsxaXBHHN4tRWTApug
         1sliVIDuuLCCA==
Date:   Fri, 20 Jan 2023 17:07:45 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 2/2] backlight: pwm_bl: Don't rely on a disabled PWM
 emiting inactive state
Message-ID: <Y8rKYUVU90Y6HgK+@google.com>
References: <20230120120018.161103-1-u.kleine-koenig@pengutronix.de>
 <20230120120018.161103-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230120120018.161103-3-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 20 Jan 2023, Uwe Kleine-König wrote:

> Most but not all PWMs drive the PWM pin to its inactive state when
> disabled. However if there is no enable_gpio and no regulator the PWM
> must drive the inactive state to actually disable the backlight.
> 
> So keep the PWM on in this case.
> 
> Note that to determine if there is a regulator some effort is required
> because it might happen that there isn't actually one but the regulator
> core gave us a dummy. (A nice side effect is that this makes the
> regulator actually optional even on fully constrained systems.)
> 
> This fixes backlight disabling e.g. on i.MX6 when an inverted PWM is
> used.
> 
> Hint for the future: If this change results in a regression, the bug is
> in the lowlevel PWM driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/backlight/pwm_bl.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
