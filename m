Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4290F241664
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Aug 2020 08:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgHKGhg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Aug 2020 02:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgHKGhg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Aug 2020 02:37:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0806C061756
        for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2020 23:37:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f12so10354950wru.13
        for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2020 23:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SifPsRpLkaxrD4ZjcoMoThiwQxTNvZzjYa5IaG6hde8=;
        b=YtBllsZg4kBmscz/p6NLUbpvsHzTdhjt1w9yzbgwCIripTrkW0vbFz0nfJwKbGP0Sz
         TQ36QNphzzMzjzdLnLLZcbyNLqHoCnOqjtqx1B9/wqel1H8GcpXRwNKtg8pU17upXh3q
         pFxH8TP37Z6nAgGNbs+6OZziTMxiDKO0iL8JkAPycveDs/LspqlYROS9q3NUI0jXAo5k
         fUrP51IMdcy3lPp70/XYZBxpePMpUEXrUK+q3XdClvPWBYGmAH9yi+PfDI1nQOxvbqTZ
         o6QChcfblgWO3+kuXNgdixKLHxYrzb0OIkJBsmsvGkdZRmg3xBQyL4PtnrRCc2Q5+Xz8
         x1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SifPsRpLkaxrD4ZjcoMoThiwQxTNvZzjYa5IaG6hde8=;
        b=tRhGm6RBUfKEoh2ut7gk3Wt3/pouIRs1shKUk9z+yDUxS3EFo8foHm/3DKLw1sJAEQ
         wUZDa/DbNpvhsrohNoxKzaXNkZfzTT61JuunR9JHzw011oLftf3oTRjAXK96VYQzdkRK
         CsNWZ6vv1lsSarHljZJnXjJkBuNs2mnwRQZRJVHI81PpKv60Vbtr4N+UZ0l+OrhIJlxD
         7Va2gTxk+U2efPBsHf0YDYu8uxi5dfAZSC7C9q8JeAKdOjq3bO8S0FTG2favMX6gRL2g
         pOa5MtZGGhh0bLMzSy1spAT8dAw3wPcLtvScskzFWPL16KKGt8hGxlqOw96ZTasGN5hF
         5n3g==
X-Gm-Message-State: AOAM530gVFIxgKSvbblWOmfjKKbYmYKZYYyzlX2RI32Ti+cR/Lr263kD
        I6jWc0OYpayFPNH3RLQTdpPgtg==
X-Google-Smtp-Source: ABdhPJxFj+MYk0TvZa39QuoEprV1NZkS+6cu1rA0zXS/g5tjO0ZQgw3V85/mhdYCrRpHtrhZ0OEkSQ==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr27915927wrn.225.1597127854461;
        Mon, 10 Aug 2020 23:37:34 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id c14sm24838817wrw.85.2020.08.10.23.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 23:37:33 -0700 (PDT)
Date:   Tue, 11 Aug 2020 07:37:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 3/3] pwm: imx1: Use dev_err_probe() to simplify error
 handling
Message-ID: <20200811063732.GF4411@dell>
References: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
 <1597127072-26365-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597127072-26365-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 11 Aug 2020, Anson Huang wrote:

> dev_err_probe() can reduce code size, uniform error handling and record the
> defer probe reason etc., use it to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	- remove redundant return value print.
> ---
>  drivers/pwm/pwm-imx1.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
