Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD0524165F
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Aug 2020 08:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgHKGhL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Aug 2020 02:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHKGhK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Aug 2020 02:37:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4E1C06174A
        for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2020 23:37:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f12so10354035wru.13
        for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2020 23:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x5FBMHKZkPQA4hEWyfkPIYXDU01mkVtVLPdybqPOuRs=;
        b=HneRXMMo2ug6nvDJFJXs3QTP2D796MRWPSBPzBFLnmi9zl3hWyPHTa3qSn8b8UWCSn
         aPDtEJsBUcZjTz9I+Q5jfg3drgjUL28RkFTh7v8QimCZwsEjdoxVEUqHA9KzpSy4kiBT
         pDPIDda6jLqIoAm42WvTIX+4pJDFdnFBhKFOqycocgC4JlcsleiqLVKCDbccZLgAvoL5
         Ia7Zz3PLyAsJQn4hERdVMp188kAJ+JgBOecsT8oyxu8whDK2xRKEZtKCgvodes09tvlf
         Qu19y53SUQDfEklbq/0rCBQgpBtGHa45kZPBUXQv8fhcMo+SUwAuScMvdXO+I/lkjL4B
         yxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x5FBMHKZkPQA4hEWyfkPIYXDU01mkVtVLPdybqPOuRs=;
        b=ZDrd6GHRDsrH9dFzR9bCFkgzrU0A//52o5NOKg3uKjKIR4eC7XgrNfpk99Wa9jKpim
         WUr9ZvEPZID6e9H3fU5FPuPod4Ss7U8/+IPeeVsALk13gE0zsDC4H1mPtX8KLqlKQ7Ij
         A2sd+fF5bahR0jC2kqRTBRh3Kb4bogussYmRy5Efq2XjlgaBaww2BLKdplmFtPbRThDr
         SnR9gNs9TI6JCNx/GkcM/1zgsHKW3JboHwvpNdBF9R0XYF34y4gFkILsGazKIdtMsAUu
         BWEonkVfbZPodfpnopVDY9W6cZGO30ofjvM75OB7Ukuhp2M0/v/hZL5zh2Zo7IGrmNbX
         0Fzw==
X-Gm-Message-State: AOAM5313DG8/QSRQfp7+eQDmDZHPG9GjEuta+O9zhNBrmfips3zDA4rj
        nDNA9Ief+8UfXiHknOX+TfqkqQ==
X-Google-Smtp-Source: ABdhPJwsEyKno0MqJ9fO8lldQanSuw2/L/xFkbnxSsLpEiiGx4RbVGJtu2YU9kUdL+EEtXEzMmmgrw==
X-Received: by 2002:adf:ec04:: with SMTP id x4mr26466689wrn.28.1597127828922;
        Mon, 10 Aug 2020 23:37:08 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id b139sm3570352wmd.19.2020.08.10.23.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 23:37:08 -0700 (PDT)
Date:   Tue, 11 Aug 2020 07:37:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] pwm: imx-tpm: Use dev_err_probe() to simplify
 error handling
Message-ID: <20200811063706.GD4411@dell>
References: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
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
>  drivers/pwm/pwm-imx-tpm.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
