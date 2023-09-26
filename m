Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337007AE8BC
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Sep 2023 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjIZJRM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 Sep 2023 05:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjIZJRL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Sep 2023 05:17:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4863E126;
        Tue, 26 Sep 2023 02:17:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6890C433C7;
        Tue, 26 Sep 2023 09:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695719824;
        bh=BIyysZ/qJRqN0WjlvEhE3O9YSQ2fL55IakHxJk2wiFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pk0oGlfNE3jFIafSlZ/PJM8crMk0kZpKbAl63Pt8xFxC6dE772Zo11TKkyC+qAfGv
         mC51S4m+kdv7pUDUxDBisK7C5anncKQhVgJKdSTAjChwzIR3g0dzfcWm6nXM303C8x
         x5cqGmxaFPyS3dDy9omSmLG7l27/pmd1rUYsWQMlfrRc8y6bCy5Nf2Otx86cV0BHdN
         HZL51tnpOzeE0oBMzUdzgADTZZEB89cocxYB0GD8TJw0OYtEWP5P3uW3GvK5C0i9YG
         ZUwDroczEB2Rd56K6DGUbvO+ptW1PmDnExiQnH0PaNBGD494RFJpE9SwdV+GAHG3qp
         IA+8vSTmRBB+w==
Date:   Tue, 26 Sep 2023 10:16:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] backlight: pwm_bl: Disable PWM on shutdown and suspend
Message-ID: <20230926091659.GF9999@google.com>
References: <20230926084612.2074692-1-u.kleine-koenig@pengutronix.de>
 <20230926085336.czgrztefbrstzbw7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926085336.czgrztefbrstzbw7@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 26 Sep 2023, Uwe Kleine-König wrote:

> On Tue, Sep 26, 2023 at 10:46:12AM +0200, Uwe Kleine-König wrote:
> > Since commit 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once
> > per backlight toggle") calling pwm_backlight_power_off() doesn't disable
> > the PWM any more. However this is necessary to suspend because PWM
> > drivers usually refuse to suspend if they are still enabled.
> > 
> > Also adapt shutdown to disable the PWM for similar reasons.
> > 
> > Fixes: 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once per backlight toggle")
> > Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
> > Tested-by: Aisheng Dong <asheng.dong@nxp.com>
> 
> The two email addresses should actually be identical, the first one is
> the right one. (Failure introduced by
> https://lore.kernel.org/dri-devel/DB9PR04MB8477D4BBF1B31035789DA08680869@DB9PR04MB8477.eurprd04.prod.outlook.com
> and picked up by b4.) Lee, can you fixup or should I resend?

I'll probably forget by the time Daniel gets around to review.

Your call, but probably safer to turn it around yourself.

-- 
Lee Jones [李琼斯]
