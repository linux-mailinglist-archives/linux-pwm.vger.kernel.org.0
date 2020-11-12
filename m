Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7082B00E6
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 09:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKLILW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 03:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLILV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 03:11:21 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DDFC0613D1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2020 00:11:21 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id o15so5002651wru.6
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2020 00:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=I0psH8a/+Fx4/4wpzIQacUhJVjG866uveAuMFzdUVxc=;
        b=popkwFDT2ARLJlAsoaDMJY1l8bBNtTboRVQodxN2Qzbkpx35POXd7SI9kI3+LEzbTv
         91UXlM4EtFWpwtBVkGbtmx07ZCRn63044p2KXsoqD3mFrsT/DNnV6t3lrkcI/d7U0ACh
         3MSWFeyAMV0bXtAnAKSyfA4UQEAti5S7MZdmTKCTvLpDyuDzwOuED8XHShT6Pvj8hemh
         5rYYmZ4hTL6tyOjK9kfuJU0Blw3hitA9pxek0ti3sp75kASuX35HBAlF/oskZkwSdANW
         /gOz15MIV7+Yoe3Uscu/DitLlIw4iwGVGo/XYjUENrBXwQfycV/CnoTGbw/70Cng9Ua8
         eRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I0psH8a/+Fx4/4wpzIQacUhJVjG866uveAuMFzdUVxc=;
        b=JSe1QvyJr2hhJqkR11Uvdn83mlNRgujkL18PeqLIuymxy1KU4dSXkrRTA1vqn+vy+O
         Z0gRWwLmO9uD8LYzzkd3cxGltT5t5g0KW/8sSltnNruzHb1QWlz3lKmxPMJMdnk3ZFb6
         iKmq0rvjsYzobjUb5vFqeBqLDNHmtXgC+M+lAcf7XRel67NJOql2Ti9oCiifHdLe0+g+
         H7pdRXuP+M4uShr3nE8Oko7hwj2c+PMRV6ac405mNzmTY/jmvfw1wf7L4Bgbea/bUsUU
         tkG/SOJcYLFFRhHsk8ySqlxHrCSf68C9+/AWMg1JQIpK7s9ruG+rPFl1Fl5NH/Ls3SX4
         0JxQ==
X-Gm-Message-State: AOAM533cw3sckGoyyNmVdLL3NNcCyZlyVmtEveATA8pxKDrJYiqp7Txs
        jmvUc3lDf8hR1zm1e2O9+Jkg7w==
X-Google-Smtp-Source: ABdhPJzsRtsMuymzGfu+yz7W7enJUxNQJtPe3qYk9KCEks/g3K4kfgFnbPXXJ+Vu2bkNy2kMZDDB+A==
X-Received: by 2002:adf:e350:: with SMTP id n16mr35327370wrj.419.1605168680157;
        Thu, 12 Nov 2020 00:11:20 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id i6sm5641910wma.42.2020.11.12.00.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 00:11:19 -0800 (PST)
Date:   Thu, 12 Nov 2020 08:11:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Use -EINVAL for unsupported polarity
Message-ID: <20201112081117.GS2063125@dell>
References: <20201111202257.414889-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111202257.414889-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 11 Nov 2020, Thierry Reding wrote:

> Instead of using a mix of -EOPNOTSUPP and -ENOTSUPP, use the more
> standard -EINVAL to signal that the specified polarity value was
> invalid.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-crc.c     | 2 +-
>  drivers/pwm/pwm-iqs620a.c | 2 +-
>  drivers/pwm/pwm-rcar.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
