Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8732B6CA4
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Nov 2020 19:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgKQSMT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Nov 2020 13:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbgKQSMS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Nov 2020 13:12:18 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786EAC0617A6
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2020 10:12:18 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so4149846wmg.3
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2020 10:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+GMODFRfJweK1BmKOlqCCplRV7+nRN+C/GDs80/R6/k=;
        b=Q0tnCgsSNeyMOVXH2RbaFvN2nyKJfMizM1foT+Cc9xTTj2/zsGeT20GhN05RtWZOqt
         qnbZXUbA4Pua/+JP9h2U7kGOzOsxLrf2tH4K87o+qrKFmOiY//mB4C6nzSGyKQs9gRMk
         dngOmLo0/lz7oe/z+JoBl9MyDr5T4WGRJhusSxsLqQ9eohqeH+xgHykC9sOvIw14nLgY
         kYFNz9jp7efTADZZXxmCUX4acQ27KJ8fYF0bJn3z0CBdh1sFdHE5w3hlMV5e5Bt4sIen
         yTUW+zzqq+GOJ2nAfvw7zqllYtZ/czhjR+Ajx6g9Ruq4w7tFWjOHAFVm0GUBM8aDTQai
         YDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+GMODFRfJweK1BmKOlqCCplRV7+nRN+C/GDs80/R6/k=;
        b=Zze1QLh+mEfxIQl24zw9GCTvWoCnxyAOSR8kHBALKI9n6XuAtdjK6cPNEoYA9CIfcz
         x3vfOxmRkAAOQtxUErX4h3qpymCc8Pz3V3sN/cvDJasdy2taPWxVS5xbzfU+3iqJ2UMY
         R/tf1OulbBnjIo6q4j5LSjvjOJGCt4jh5eQ5rtFLNgaEvOzKbPT2ZCH8LwzHxgQviUgl
         oBAvq0jyYcuBoiosuFVWg2bMsjgG6yR8a8JGf5RxfFXZp0mEiacbBqpY/hMqYxdHIvcT
         2smx5w5TaSbBJ2LVKw3ezKK1Z51FM6/kZkcxzireRqJDCkNSLrBgHbjbl5dBcsqAC96i
         7W9Q==
X-Gm-Message-State: AOAM5328NoLMOunuX3qtX0xVb4Weq/QyDftLhSrwloFDrLeQSSuP5Tqi
        kapzxB2IUvrarhZhHGpPBfJfRA==
X-Google-Smtp-Source: ABdhPJy7ge+5C9rkfzdiVd0scrS5/yY/Wibq6CDNBh8aQbUfFjanPblGPmyagIaAldj46qwF863JBQ==
X-Received: by 2002:a05:600c:22c5:: with SMTP id 5mr341907wmg.25.1605636736943;
        Tue, 17 Nov 2020 10:12:16 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id h4sm27507577wrq.3.2020.11.17.10.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 10:12:16 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:12:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Soham Biswas <sohambiswas41@gmail.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: core: Use octal permission
Message-ID: <20201117181214.GK1869941@dell>
References: <20201117175452.26914-1-sohambiswas41@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117175452.26914-1-sohambiswas41@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 17 Nov 2020, Soham Biswas wrote:

> Fixed Warning.

Which warning does this fix?

> Replaced symbolic permission 'S_IRUGO' with octal permission '0444'.

This is semantically equivalent.

Not sure what and/or how this fixes anything.

> Signed-off-by: Soham Biswas <sohambiswas41@gmail.com>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1f16f5365d3c..a8eff4b3ee36 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -1338,7 +1338,7 @@ DEFINE_SEQ_ATTRIBUTE(pwm_debugfs);
>  
>  static int __init pwm_debugfs_init(void)
>  {
> -	debugfs_create_file("pwm", S_IFREG | S_IRUGO, NULL, NULL,
> +	debugfs_create_file("pwm", S_IFREG | 0444, NULL, NULL,
>  			    &pwm_debugfs_fops);
>  
>  	return 0;

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
