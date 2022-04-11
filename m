Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E964FB71B
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Apr 2022 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiDKJP3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Apr 2022 05:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245384AbiDKJP2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Apr 2022 05:15:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7373FBC3
        for <linux-pwm@vger.kernel.org>; Mon, 11 Apr 2022 02:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB74DB80E61
        for <linux-pwm@vger.kernel.org>; Mon, 11 Apr 2022 09:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC43C385A3;
        Mon, 11 Apr 2022 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649668392;
        bh=G6ZO25/Ykggr6xEHDgRUSWj5HIyhzLYYQqVAX06CjVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHlY2rKwlK2fOYmJvIwN+tZGNg4yONHalHR1elSU8+wwh/pjb6p/ntD/MF/m0pyGG
         TO3wahI7Dx/NjqgAHKE5xbdlTZf3rQr92rYmkgwuh2str4cmysB3Q6oxLyvRBuRAGh
         ff6RTGz3/0uDn/eZjiV0D0RbTyCW0AHNFcoBHaT9ecoX0vHahoaoKoZYxqy7wgoc+n
         f29uPTGnKqhoGvMyXhevVOR/drm1bg2zNAhFReRozalCtr0D8T0bpbOidlA6XQyrm4
         AlT9NGCdklWU5yC/Wstz1yFnKshu5dPrM5Crp4U0EA0TzO2Bebv7qWvTooBOIr/5ce
         hSV2MYe20MdVw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ndq6b-0002xP-TC; Mon, 11 Apr 2022 11:13:05 +0200
Date:   Mon, 11 Apr 2022 11:13:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Drop assignment to struct
 pwm_chip::base
Message-ID: <YlPxIWfaFoQxW63Z@hovoldconsulting.com>
References: <20220411083118.200663-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411083118.200663-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 11, 2022 at 10:31:18AM +0200, Uwe Kleine-König wrote:
> Since commit f9a8ee8c8bcd ("pwm: Always allocate PWM chip base ID
> dynamically") the value held in base isn't used any more in the PWM
> framework. All PMWs get assigned a dynamic ID, so the assignment is
> redundant and can be dropped.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/staging/greybus/pwm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> index ad20ec24031e..3fda172239d2 100644
> --- a/drivers/staging/greybus/pwm.c
> +++ b/drivers/staging/greybus/pwm.c
> @@ -297,7 +297,6 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
>  
>  	pwm->dev = &gbphy_dev->dev;
>  	pwm->ops = &gb_pwm_ops;
> -	pwm->base = -1;			/* Allocate base dynamically */
>  	pwm->npwm = pwmc->pwm_max + 1;
>  
>  	ret = pwmchip_add(pwm);
> 
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17

I'd prefer if you added a "pwm: " module prefix to the summary (even if
the previous patch to this driver didn't have that).

Looks good to me otherwise:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
