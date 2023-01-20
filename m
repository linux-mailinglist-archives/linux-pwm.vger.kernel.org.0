Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF7A675AC2
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jan 2023 18:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjATRHS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Jan 2023 12:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjATRHS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Jan 2023 12:07:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C8929162;
        Fri, 20 Jan 2023 09:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51D09B8290B;
        Fri, 20 Jan 2023 17:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71900C433EF;
        Fri, 20 Jan 2023 17:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674234433;
        bh=yrSqpcs8yxwI9UUhr3/WzrPeWuyl/ClrxQ9Yls6h0KE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UbQUQKw3wAPAPV336MhRFF45ylggW2RQ5swyP56hsO5qG6lYQXwjOgdXbIJK4EfKi
         WDxoQpoWj/httmpiZv+qhGJh1V++68dn0wNBwgyipWyhK+IUZ0I9eko6a3V0jmVRL4
         I7+TCZnIuhIIDjYlNjkCa2ylM06AheCq4i3MRLn4pA3qZsFR+1ayoHrR3trFpGUoZR
         qOtb8TMpRGsJ5/VHi9iWMyYvv7bNboa+vZZ7UXF36GmNx+JBMUCRRTou4IVJkS0KIR
         QHIbguy5y1rQ1IW4sp+X/hvMawSzwEankSx6otN3GvRXFfRCwidyOqbR/B8q6v4by8
         uhwk713JliSyA==
Date:   Fri, 20 Jan 2023 17:07:06 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 1/2] backlight: pwm_bl: Configure pwm only once per
 backlight toggle
Message-ID: <Y8rKOozBnOGg2Sxg@google.com>
References: <20230120120018.161103-1-u.kleine-koenig@pengutronix.de>
 <20230120120018.161103-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230120120018.161103-2-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 20 Jan 2023, Uwe Kleine-König wrote:

> When the function pwm_backlight_update_status() was called with
> brightness > 0, pwm_get_state() was called twice (once directly and once
> in compute_duty_cycle). Also pwm_apply_state() was called twice (once in
> pwm_backlight_power_on() and once directly).
> 
> Optimize this to do both calls only once.
> 
> Note that with this affects the order of regulator and PWM setup. It's
> not expected to have a relevant effect on hardware. The rationale for
> this is that the regulator (and the GPIO) are reasonable to switch in
> pwm_backlight_power_on()/pwm_backlight_power_off() but the PWM has
> nothing to do with power. (The post_pwm_on_delay and pwm_off_delay are
> still there though.)
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/backlight/pwm_bl.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
