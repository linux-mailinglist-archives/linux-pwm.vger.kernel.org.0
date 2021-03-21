Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834A234355F
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Mar 2021 23:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCUWX4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 21 Mar 2021 18:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhCUWXv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 21 Mar 2021 18:23:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F77C061574;
        Sun, 21 Mar 2021 15:23:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so10172692pjb.1;
        Sun, 21 Mar 2021 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZocK+lEX6bhNxI2jv7CoDE+irXUEmIHfQ5j/xvFprW8=;
        b=prEm9IRHetMEEw4QYjFcl5DuLLURfHvGGRQBJzfOxmQJBfIUrRkSg0AI/JAcdI8zqU
         SdKGMzGK/83S/x9/6zK/3SxHo2pkG/hhu22vQXeM93UHRY3EVcRTVnTJ0ZcOPPZYQRPK
         s5jLqdMG7B1ptuZcM0U/SeNBgOj9yANk6Z9qQqVkNV680bv+H2XduROED4WPf8czA5Me
         +26DoICU5h7XmikipHv2nouGljYh9j5uRnkVjAkBdljG3E6FgVFvvrzx76d97BXeNxi7
         3YUuwXV58ljxHrPUKPYebi4ifT+qbOpP7p+Ex9AHiFQSFmqz0TSMU1g7K86AisfYuN7e
         hBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZocK+lEX6bhNxI2jv7CoDE+irXUEmIHfQ5j/xvFprW8=;
        b=gtP2mHXo9OocGu8T+B8pFzJw029SIuBhqLyn7USDpkvdT/S4wFm0+kPqvuMEgkMmOO
         NjiRZgOcc7loWXdIH6PLkbunTjF/Js9Lv2Ze+L+b8E5fp2eLMGt726uvFlPuUampCgE2
         03wuIb4VnZiIU6XBYgtNxlJrfn1JV/5ierxP1JghFWc/TwfXFD702ksyZgIObO0+Ue7c
         rjKwoRjTxtDtZHekkM0t9X80L1TVwBgXXA2365hckew4Cq8occUeH6pEn9FQtcDAJXTz
         UFIJ2EpdUkdul4p/VuO/p6sPibijWtLw2K3z+v/+D73HhWBO+QlYUeeFA8a1CuUcQSGL
         9PCw==
X-Gm-Message-State: AOAM532M8lK1s3q152bjBz238W/W955yw+fHql5MlCwozdYUQJqGaF2o
        27bSQkWO86K77+C+E/TeijM=
X-Google-Smtp-Source: ABdhPJwpo0KS6Wy7bGOD5Jb4U5aUtf7dGouMuY2+XMMB8cc48/xBZo1MovWY4ye6LeQeqJ0G8v5WBQ==
X-Received: by 2002:a17:90a:8083:: with SMTP id c3mr9624140pjn.134.1616365430416;
        Sun, 21 Mar 2021 15:23:50 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:85c2:9df1:533a:87e9])
        by smtp.gmail.com with ESMTPSA id gt22sm11843383pjb.35.2021.03.21.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 15:23:49 -0700 (PDT)
Date:   Sun, 21 Mar 2021 15:23:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] input: misc: max8997: Switch to pwm_apply()
Message-ID: <YFfHciL2CXX0aERa@google.com>
References: <20210316203813.48999-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316203813.48999-1-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, Mar 16, 2021 at 09:38:13PM +0100, Uwe Kleine-König wrote:
> max8997_haptic_enable() is the only caller of
> max8997_haptic_set_duty_cycle(). For the non-external case the PWM is
> already enabled in max8997_haptic_set_duty_cycle(), so this can be done

Are you sure about that? I think the intent was to enable it in
max8997_haptic_configure(), and only after "inmotor" regulator is
enabled. If the device is enabled earlier then I'd say we need to make
sure we disable it until it is needed.

Thanks.

-- 
Dmitry
