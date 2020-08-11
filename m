Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A25241661
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Aug 2020 08:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHKGhY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Aug 2020 02:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgHKGhX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Aug 2020 02:37:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C27C06174A
        for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2020 23:37:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so1453404wmc.0
        for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2020 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=goH7JSZMWyIR+HDIVljDARSAieBgluozz9Jxq+R5Hyg=;
        b=aAf8vbUl+EWEbaY/2D3jfMw6IpePyjwma7LZ4Y7IB5uHpZD0WRrNqeMvJHS0eUziK7
         xHj13IzFM/CeVFgZ0igTTezoxtpBYOsgLzzd4Vh5aGu7sYbk+nPSx1P8+dcWLL9kAC3n
         QtHKScoG+HSB6DjOKgeXV3W3NbmGuQ/Quw5U2+vXKeIIhbBAFaPS2rbFOIoBhocxEaSk
         haPP9WXOwbboXdrMV/8I820lZ0XKHFtfDc9o6u92x0IEDEs9XymYUi9id3r7Aj/TcDcZ
         gkOJWP3AaMOF0PJdm1347rwOPw321OLw1LgZ9yPoLxAtBAERzvcwWku9kgPc9vaIJ1Lq
         YTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=goH7JSZMWyIR+HDIVljDARSAieBgluozz9Jxq+R5Hyg=;
        b=tlxxOFgUeR8pJ1OHG0kg91k8bvnpyinjJUYH9NevmietSM2I3ID/s66qb1z3C//7nB
         QEAbPMep8Vobv7vpwWS+Zy1qa8Fl2zi5nEreDcO0qbY+8/5xb5axPdl6uvewCzftclU3
         +BUFM8RY3LKoFiR2dnZjkoJvBpjLmZWB46WaZ5ZkiYcaLIbE8Lh8zVZze6aMWRC6d+qz
         AnHVauWz5s4zEtvvQsUFLCUAcQ2ENIdBru8AnRZbtfuTjhrB9qRfrRMT1G92bJFL/4Ac
         hMHi0kESJRY3yLZN3lByhmaiS8G/soDaj1vJb7sYaDpkcwWeHkz9f0fzstMGyN46sdvq
         jvfg==
X-Gm-Message-State: AOAM531d/ddgYXZxUP+VcZGB5wR28RILVM+kHLQDlwEF3mRLRKda+4C3
        tP65loi42mI2SmOkyYa8uF7nEA==
X-Google-Smtp-Source: ABdhPJziQM61tOvsBU1Mv6uzsIeOjhClg7+w8OsOUPwy2fUKCOtj3b2Eo7HDAi0a/rrehsfuWr1lbw==
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr2420473wme.23.1597127841580;
        Mon, 10 Aug 2020 23:37:21 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id i14sm28266124wrc.19.2020.08.10.23.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 23:37:21 -0700 (PDT)
Date:   Tue, 11 Aug 2020 07:37:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/3] pwm: imx27: Use dev_err_probe() to simplify error
 handling
Message-ID: <20200811063719.GE4411@dell>
References: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
 <1597127072-26365-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597127072-26365-2-git-send-email-Anson.Huang@nxp.com>
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
>  drivers/pwm/pwm-imx27.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
