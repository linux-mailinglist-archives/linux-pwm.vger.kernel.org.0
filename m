Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5342B0172
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 10:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgKLJAA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 04:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKLJAA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 04:00:00 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0468C0613D1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2020 00:59:59 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p22so4541666wmg.3
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2020 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XDq/ku5TuZ1WKJcKliRaLnAAy4N+ypKR4lOCr5Mvi9Q=;
        b=um/6KSnjiJa1qWjdLTD7BrlG2j5YakzWsL6W+cT3Uh9bSwjMEOXkZAS2FVwMVAUr6S
         HMHCA+asC0mK2nJnvdS00JrpyQXQu7VMDX32mwqVQdZah9ZE5ww7u/ur56DASXJw7sYm
         rS0C/vofC/UKxhPbWNXxju98rnzGh9XL86v7dnHGnIrk3qyX1nY1AQOVeQAAnqgtBL9q
         GJcViJhTXbuXehxnp0zB/toHZedCdG2MkfpbCPDRpbI3ZzE1PVdLCEl5je/9yiITbZ8a
         r0yTCbTCBvtlzA9qT5mReuPfePB5htUSgPVC1wd5v8/m7Z6zzh20DEikLJn5T/7WNYx2
         qj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XDq/ku5TuZ1WKJcKliRaLnAAy4N+ypKR4lOCr5Mvi9Q=;
        b=Gt7INthPdQmolwv+HokbVZOFKse9lcYentih/MadX9dHwLb4BIqVqqNxD7NDatwyAz
         e+m5SicKyPWHD0oHK7jboieMS9Jk3pHvtjTw2nFszvgufbGxdHM0cuf/u5GYTs1W2SX1
         9lLWs69VgGvX1WNuHPpp94dtHXeH/sFBptN28TUgBPO4I0rAnrg42EyKC+6ls+rJbNE4
         SUsFgi37QgKYmUwYiMJDV3k88KbZxpOVvHmjICni3o2rcclQVv5oiHyK5jva58P4aTRy
         SFOcntnW9bPywipGQmP+GF5YrITWMEz74vPEutFEgou9Zxhgsy8gxQD8QxV9PnxtObib
         /rNg==
X-Gm-Message-State: AOAM530XUqTlQC3MvqtkEaA7UbtHdCBfwMVkHzSwNQn7E4DQLjBXygAs
        tyK9o6O8O+3GP1BWA7xwTTpzflyFM6g7rjI2
X-Google-Smtp-Source: ABdhPJyPI1K4lVTuWFiHA9D2Nq+ktUZ0nMzD43vpac70BPwLvppUhPJQUZYMMCl9sBJgTbhpgRPuTA==
X-Received: by 2002:a1c:c302:: with SMTP id t2mr8859760wmf.189.1605171598448;
        Thu, 12 Nov 2020 00:59:58 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id d10sm5895814wro.89.2020.11.12.00.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 00:59:57 -0800 (PST)
Date:   Thu, 12 Nov 2020 08:59:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ajit Pal Singh <ajitpal.singh@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: sti: Remove unnecessary blank line
Message-ID: <20201112085956.GU2063125@dell>
References: <20201111191449.409402-1-thierry.reding@gmail.com>
 <20201111191449.409402-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111191449.409402-2-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 11 Nov 2020, Thierry Reding wrote:

> A single blank line is enough to separate logical code blocks.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-sti.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
