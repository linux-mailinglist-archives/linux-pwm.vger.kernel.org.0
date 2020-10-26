Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE3298975
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Oct 2020 10:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422427AbgJZJeP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Oct 2020 05:34:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38229 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422413AbgJZJdF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Oct 2020 05:33:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id n18so11564687wrs.5
        for <linux-pwm@vger.kernel.org>; Mon, 26 Oct 2020 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2bOUn5m9NyFMqvT986ixJh3xh+3M02D/EaNOhInlC6M=;
        b=kZghs12KHIWgkOwooNyYjuCNzZPbWoLFlviGhIeOqsMJZvOQWyGVfuy5KS3RTRBl6U
         KOhOZyglsgXCVC9ZL16o8z1fwHxol0a+c8uewTyWHoiZUmjw4K1TM8ygxJWwx4y39kxz
         wHS9IhWVwUSzw/+YhKg267V7l2wdana81uMeeD2Wb8/kncuuEvuuRv7ghOaQe9yodKSo
         spx0xwUbvnE15Q35w+2cSX4ku7gkN59YPJgotj34gTiGzmYusDxsKLuiHhMF+PXE1O8j
         0sgWDY5q6WKhMX5cvX7p34EhUNzcKia3juTiL13p7Q9gbKtVv8mvuCHW8Sb9sSSmyYad
         EUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2bOUn5m9NyFMqvT986ixJh3xh+3M02D/EaNOhInlC6M=;
        b=Z2YtAUirjDzlaeT5Hp4VA5PhLrPh9Fp9HhpuKnNj8nRy7zyIk3mKXE6+HaDRjvhmQO
         T9xQiXc1CJflYlaqPKgjRKhPhlWkrI31iyEccgm8LcpdBerDusGHto4q/eZvSVkrNQZU
         ED8Lwsav545HUNtJnkSKSvkCVGmRWRr2p8IfvEC9teinDBTRKgDiWYw80JT4X9uxOV+o
         2QObj9oMfJrwdVkVo6SAN3Eo5wvXUQ8FjHD11/4Ho0UrR13GHDGfvuWzVsIq8Mz11KGd
         KE4W1HlOI3OOSZHW+64rUQ9AZHkocX6hgFZbBakIoV/PrMQ2BTrztfcZpKb9TdqJKXZu
         Kwdg==
X-Gm-Message-State: AOAM530Z6Xu/CXfyIGr46ihxyjyyCm3coCJZd0wpDg5tcs24xF/dLfG0
        VApJxgO9cv6uFJmCTBmfzJvPUw==
X-Google-Smtp-Source: ABdhPJzagCH/8gBrs2uzHvWxWGZZMEiJ1t9WdJjL2RdJeY5mVcv4wtivJ9sI0j7AIZRfRuGvNUb6aw==
X-Received: by 2002:a05:6000:1d1:: with SMTP id t17mr17662997wrx.164.1603704783882;
        Mon, 26 Oct 2020 02:33:03 -0700 (PDT)
Received: from dell ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id k18sm20809703wrx.96.2020.10.26.02.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 02:33:02 -0700 (PDT)
Date:   Mon, 26 Oct 2020 09:33:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: ab8500: Add error message if pwmchip_add() fails
Message-ID: <20201026093300.GB3926206@dell>
References: <20200812075214.499-1-u.kleine-koenig@pengutronix.de>
 <20200812081139.GC4354@dell>
 <20201022192253.5c2c2jmxtsji2fnh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201022192253.5c2c2jmxtsji2fnh@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 22 Oct 2020, Uwe Kleine-König wrote:

> On Wed, Aug 12, 2020 at 09:11:39AM +0100, Lee Jones wrote:
> > On Wed, 12 Aug 2020, Uwe Kleine-König wrote:
> > 
> > > pwmchip_add() doesn't emit an error message, so add one in the driver.
> > 
> > Maybe placing one there would be a good idea.
> > 
> > It would certainly cut down on a lot of superfluous strings.
> 
> Hmm, I'm not convinced. Do you want to work on that? If not I suggest to
> still apply the patch as currently it is justified.

I haven't looked at implementing it.  Does it look difficult/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
