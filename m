Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B6249A85
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Aug 2020 12:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgHSKjH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Aug 2020 06:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgHSKjF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Aug 2020 06:39:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF76C061757
        for <linux-pwm@vger.kernel.org>; Wed, 19 Aug 2020 03:39:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d190so1580226wmd.4
        for <linux-pwm@vger.kernel.org>; Wed, 19 Aug 2020 03:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kGR3Pfz6EXAe5m6YgDuu64EsFTfCPXi8AHkSgMBltB0=;
        b=sGI4XenIIX/8xOVHFqocZBRsFWsA90Naiffb7s2dWL1VBTXT9ukemZ/KIrLossbohh
         bNOPJneLmf/HPuGQv8Cxc6+oMKEIWMjCchx1wCdz6bp2padRWB9oX8j1uotoSimSbdL6
         UxOofVEoInv1lORba/fV7QoTFC7v4sCpr35D6SmrAgra0Ac5aO9hM86acXaLn2RWrG0k
         JLgL61ueiJbjPZ3gA2M3Ns9ZU/AKv9RlgQApr2F7tBeQsbwfKsseiAMi3+vKatJel7mc
         iIUkQvT8FyDQ4R7oXcjz3O4c8ee/bL4pdBVja1aUVLhurZG1WXT5+q+0C49MXTmdJj7i
         MxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kGR3Pfz6EXAe5m6YgDuu64EsFTfCPXi8AHkSgMBltB0=;
        b=MtPc42/kyKxXxzoO5uX1/1IMb3OA2sk7LG+r9KdCFhwIGQFpK9tZdWBgvtHtJ5Dhkn
         0crYOyg+VbxYGeJ3dVzLa+Pmk7AxCgvEMhiXyRIEtQW/bzia7gk8xVN3D1x8uK8F/QNV
         HORnyh9kevdUbJxzbrhz7INC79QIHy6Ry1b8C1bDfAQdTfMBuzXadhrW5MC8ONL7Rex+
         PIHynk+2RPJ0rK8tcrZGkUUbMXoJF+1KujR9CYVpIKYHl+xkHpBOvSBjPNr7mTp029gy
         P3XQVXmgN4R7Ypai9+vNxcDfj2YmuaUs7sqwSehLrs7IhI+ODer38LDeAhF2QwP5kiyg
         P76A==
X-Gm-Message-State: AOAM532fl687Ta9kIdYiZoQYi4f8sAIcE5DsULvz9wUhltc+0Hnafewx
        2zQVpnwsB/Jz3/S1ZmcEigC/nQ==
X-Google-Smtp-Source: ABdhPJyiT/mSKqHTOW3vd2yM9GdE8YtdKO/xKV58XaGOJtDNYU0ycDyxWhobfxScuFBYit+ctrPUUQ==
X-Received: by 2002:a1c:2350:: with SMTP id j77mr4515892wmj.31.1597833543945;
        Wed, 19 Aug 2020 03:39:03 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id q7sm40362976wra.56.2020.08.19.03.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 03:39:03 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:39:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        ed.blake@sondrel.com, linux-pwm@vger.kernel.org, wigyori@uid0.hu
Subject: Re: [PATCH] pwm: img: Fix null pointer access in probe
Message-ID: <20200819103901.GF4354@dell>
References: <20200815163115.11376-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200815163115.11376-1-hauke@hauke-m.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 15 Aug 2020, Hauke Mehrtens wrote:

> dev_get_drvdata() is called in img_pwm_runtime_resume() before the
> driver data is set.
> When pm_runtime_enabled() returns false in img_pwm_probe() it calls
> img_pwm_runtime_resume() which results in a null pointer access.
> 
> This patch fixes the problem by setting the driver data earlier in the
> img_pwm_probe() function.
> 
> Fixes: e690ae526216 ("pwm: img: Add runtime PM")
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/pwm/pwm-img.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Looks fine.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
