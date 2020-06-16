Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C09C1FA983
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jun 2020 09:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFPHG7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 16 Jun 2020 03:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgFPHG6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Jun 2020 03:06:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9DC03E96A
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jun 2020 00:06:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so402470wrs.11
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jun 2020 00:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S6Wt2049xOyn9uDBo8RtO0TmdMtlWUY24rAkQY/ouSI=;
        b=jH5zB2sl5+QcbiTOlHEBYBJ5vMNw9h/Hu8/Q/WEvwbj4Xt+SONwj0Ppd7fh90BM0tT
         Hp3sfHy3IVyWzMSLyGu+k1OIJ6ma1DlcfUSDapcAbZeSUH9tyVMMA8SQzqMulzp1Kt3d
         fvQz79e35Zb+AzwR0jFx8+bCiM6L9/rWBZhlCy0Rb2ZaUY7FKU1tY3oC+qgcODyEqvxo
         DcHJFVViyExCkxevk0UEBlUOHoAblTD3Rkc6pL0QvjGA0QoWnaO1KIbUWByQ0JgPixsX
         CzLA+ByKo8IhJysdlKawbnk+SPhUyylISdd+xf8uicFILiScM4a9RY6qVrhbplhLgOf1
         ZZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S6Wt2049xOyn9uDBo8RtO0TmdMtlWUY24rAkQY/ouSI=;
        b=SjbYf77otGBR+QR6wm98j+Z/J71hovvcMHjUIkKBx2d/NZvno9gykry0ZBgFsZUJSW
         VDhmjXFXLDgcFmADnildM0aZ8GEwJlM7MMiEEjCs5+NA5sLif9S3Myj00mncmm25AK/R
         asJSPVcUKDdLXX8VrXk6qAQhTyTqL26va6P62IywmcKB7gq0SzsZ+x1ODEXItadSfqSe
         E+AhXPM6gSPWtdvgot3loyySlhQOgpTzSuocd6ZR1KDkAfKv2nRPP+K8iAbYxJyJPIhS
         /GiTlGbju3G9tX7FwN4ePaBUrUIBQ4dNPD/OseG4iWbvXk513J355Zvu99Ajvcoq0Wnk
         z9cg==
X-Gm-Message-State: AOAM531iOYv/tFsMTs7IVC41HxnUUqgzfH7W+vtx4OX7tHwEkIPjucX8
        AEBC+p0B21nkN4tH6aPZ/Rqakg==
X-Google-Smtp-Source: ABdhPJxTcyWzB10Tj4UoI0tMy/u3LqUlapmPnhWb4IqpH0dhk1/y3mG9xdwdxvPulRAXR8aBPGJpnQ==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr1425261wrs.223.1592291217037;
        Tue, 16 Jun 2020 00:06:57 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id a81sm2809160wmd.25.2020.06.16.00.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:06:56 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:06:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: iqs620a: Use 64-bit division
Message-ID: <20200616070654.GC2608702@dell>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
 <20200615141606.2814208-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615141606.2814208-3-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 15 Jun 2020, Thierry Reding wrote:

> The PWM framework is going to change the PWM period and duty cycles to
> be 64-bit unsigned integers. To avoid build errors on platforms that do
> not natively support 64-bit division, use explicity 64-bit division.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-iqs620a.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
