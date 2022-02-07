Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451014AB7AF
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Feb 2022 10:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiBGJjP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Feb 2022 04:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354787AbiBGJbI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Feb 2022 04:31:08 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DEDC043185
        for <linux-pwm@vger.kernel.org>; Mon,  7 Feb 2022 01:31:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k18so23532354wrg.11
        for <linux-pwm@vger.kernel.org>; Mon, 07 Feb 2022 01:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e71qr5cQmHNfaTvqFdZSatwMnOkMecpoZmeynQAfXfU=;
        b=IipD0Md8PLGqTRc8YbhUGW9RZUZYMQMHks4wT414D4MJkTvXaIaxCLgX7q7EqqZkkE
         RniraUcxZGQqnV/BLhI8fR3OhKUqDYUBLkiKkwsuJN/ZNCuhQa9etjVpPPbBQ9jyOrwx
         MGb+BBECiHqPAOCpL/b5+NFypnEjgPgL0Rb5qKUiTSwuyDcdtYMjQxjnCr4gVMsnv1db
         4Li8Ccoityy3n7nCqgyhw562KdbA+9+AlCO3h6k33jebIUk0d7GU1cLOM5H73yN+w4Xf
         YMhAHQA5StGpYsrAUVc3HUB89o5DXP0IdN5Syh15D5UZS0wH6QYVpbsbWtyqGxNwNZ4L
         OgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e71qr5cQmHNfaTvqFdZSatwMnOkMecpoZmeynQAfXfU=;
        b=mBgMJHdiNa6hu2+GOaSvCrURg99DrCLAE/QyGtK2iFj9BOG+KWFICfvSFX6p98+0EV
         xXdYpLxpHVOBt9J6aIA8iQWDePl/YZX1eZB7cNU8d22jJiMsqSE4EZMp122RK2SmC4P+
         TboO4OWu1L8HAnR/HKF5XbLcVI6+6ttgO7ye7vzqn6SXn0BB2mO019OD2/XL/udpzNCi
         objB9V8tXSIMcVtGb0abyYXZtL+4uQU94RwYsBBkgkBRt6OSNJqwxB3oy4xwdQuqYRJm
         Y2aXZ/BRBYR9hH5PqwBaLOSAQtTTl1iTtLpFJ080Ijgkl+H04LaZ0CwVtoQAF4EYJ5SG
         PefQ==
X-Gm-Message-State: AOAM532bTZ2yMHXzHX7Bd0x9K9dTK2S12t8wzvHV6sA4/gB6ZyOR64wM
        /xHJ1VeW1ZsyL1rzdOkJAoQb8w==
X-Google-Smtp-Source: ABdhPJxyfEhDPaQTrpIwF3s8f+P5EuB6O3syjtuhYC4gv/uXtG6GnEb8OsVA43hN5ymF4KDaQpvKuQ==
X-Received: by 2002:a05:6000:385:: with SMTP id u5mr3350003wrf.105.1644226262555;
        Mon, 07 Feb 2022 01:31:02 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n15sm10497806wrf.37.2022.02.07.01.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 01:31:01 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:31:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Avoid open coded arithmetic in memory
 allocation
Message-ID: <YgDm1FWtlneMLCTS@google.com>
References: <bd3d74acfa58d59f6f5f81fc5a9fb409edb8d747.1644046817.git.christophe.jaillet@wanadoo.fr>
 <20220207080128.xmvommcddjfgz7ey@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207080128.xmvommcddjfgz7ey@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 07 Feb 2022, Uwe Kleine-König wrote:

> On Sat, Feb 05, 2022 at 08:40:48AM +0100, Christophe JAILLET wrote:
> > kmalloc_array()/kcalloc() should be used to avoid potential overflow when
> > a multiplication is needed to compute the size of the requested memory.
> > 
> > So turn a kzalloc()+explicit size computation into an equivalent kcalloc().
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> LGTM
> 
> Acked-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Thanks
> Uwe

I am totally confused!

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
