Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FD31E1BAC
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 09:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgEZHAv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 03:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbgEZHAs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 03:00:48 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1FFC061A0E
        for <linux-pwm@vger.kernel.org>; Tue, 26 May 2020 00:00:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so2081147wmb.4
        for <linux-pwm@vger.kernel.org>; Tue, 26 May 2020 00:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L8TiiDzdqmM1LGFjKPSxipAC4aAv2ZlXxCOvAA34JO4=;
        b=WNVjoKCn/BXMVwd6ksjhylPSLlzdBMSDeZqC3XO1UNGE6o1d+WJ/qAszePgebMrpDw
         H0tbDceixrx0YHSneKhw+c9J0OWOkX16dvjlrC6FOTJUQrSlh7v6jBDzY+ExHepeahwk
         vJSEC85PXUFpYl54FFDgtX9A5EXacawUsLdK4sJIKRZfTfNItosXhylloe4zq05Xa5Cc
         vyO9cpU+O+ZPSYbHeZW3ksaveqxljOV0jr3qjLSuu3x+PB5+S3HmOHqIQ2kJLWsicvFh
         kn0gCbeoDhDHodCvYDYJtxLkZgajDlQbr2nOXdBHbG+rf5XSQxq8yWZYUrcBTFodS2sB
         0vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L8TiiDzdqmM1LGFjKPSxipAC4aAv2ZlXxCOvAA34JO4=;
        b=Juw2OZW3ievDMVgOiukhHAmUvczKnzYS8KIdLGdscD67vo6K1OSOOd0wXgEEB7Ef3q
         9VfZU7drRI8oWJFIZYrC+LqdbkKfccwjBA2K/fnGKz/yNCODB0vZWtqDKD/mu509p2Ij
         vefLCfDkyYEzhSflJ4x++0hXWaA88WbewDT6gZ5tUgIPTiovfqSLDetwXgxukOdXcHbT
         2RxcPs/XK2h9W+5q6pAjGtZLrTa4H1VIUeOrY42k0tKFyBS+NbHt1dsDuJ3lb5amXwpW
         47Ol2a6iKeDMpz99ELyTOBLpGDvPQUSXIGp+njaVMIoQL58EimBg9K06yykajDY6KS4i
         e5PQ==
X-Gm-Message-State: AOAM53213/rUqLI4aBodLmAILzVLICloDVKBJcrWodtU2Uc+tQyETo/O
        aAXaCoKflpOqRoK37wbySlRhIaepBU0=
X-Google-Smtp-Source: ABdhPJzdpWRMgGjTIcUg1QCmJz9zkoVDiBzpCYl6ODlrd+6sOxBl3vFTH+nPkYAMXFbO2wsi95nKLg==
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr16587245wmg.70.1590476446197;
        Tue, 26 May 2020 00:00:46 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id a16sm5852484wrx.8.2020.05.26.00.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:00:45 -0700 (PDT)
Date:   Tue, 26 May 2020 08:00:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v13 09/11] backlight: pwm_bl: Use 64-bit division function
Message-ID: <20200526070044.GB3628@dell>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <429c18e1e1461d7cd3ccb93f9093a6719744f6b0.1587523702.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429c18e1e1461d7cd3ccb93f9093a6719744f6b0.1587523702.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 21 Apr 2020, Guru Das Srinagesh wrote:

> Since the PWM framework is switching struct pwm_state.period's datatype
> to u64, prepare for this transition by using div_u64 to handle a 64-bit
> dividend instead of a straight division operation.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
