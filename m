Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E5A414B6B
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Sep 2021 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhIVOLn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 22 Sep 2021 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhIVOLn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Sep 2021 10:11:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20BAC061574
        for <linux-pwm@vger.kernel.org>; Wed, 22 Sep 2021 07:10:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so7351350wri.1
        for <linux-pwm@vger.kernel.org>; Wed, 22 Sep 2021 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=316eM28pK/8Y6ZPFwh3V4osKtYsZzbtNOZjPZ78hW2o=;
        b=qgeTRI7MZLWaVeFQzGXTpSsFcyvmu7kjfYlSc+NPJCrhsXvE1fEn07XHZl63akX/A9
         yQbXdXADzwP00MT27Hew7Q5+BXqnTnHMX2GPMy8eew9d5u8RXyglhqDuge9gsmwXrD8R
         HAvFLaIw6+HC5YglZjYxDz9U1L+MwF/UV+iop1VTv+4b+TeLv+YtgqdgDzTRzzxMdQBi
         kVYSpNyYlR+kdCs44djZFix4hbr60HjdLscIRa4b55RCcwpz1lxAKHoewcClaR6+Bjai
         CEDO1S4JoEByQsW1f8EyZ+aN8rL1sGz/bP6WNU3H2x5Jzjl6OhYQ9HBAhlyBspTGsysg
         sLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=316eM28pK/8Y6ZPFwh3V4osKtYsZzbtNOZjPZ78hW2o=;
        b=g9Ed17DSd+puMt+9wSx/PkgvMdom2iVjsb0foTWPW6O6d9cOrojmraYui3MZjkxDoj
         kb/kXDO5RjpauucORTi98iLf3j8P+45Aj/B+/w29tliIgjFfUooWjGay7/T2FTKsd5Vz
         YBTfkUM1TR0HoJ++gVi+i/Svq7gC9jtNkEuPAhdP1KvJMmDTlV/wpkTDMY01xB7GQO6r
         7R8OCWL4E8UtgUYs35cE32MNfBpXNURYiu12FcLX1WORB0jnG3mBnhF11GApdDDtWZz0
         gHx+R+kR2DdKAoE4rFqHfL008n2oBjgpINA7Wbyvm1HiMvmMMWpmVrF4Frlev1OdOPZg
         ru3A==
X-Gm-Message-State: AOAM531KoqXiBSndPYNyE2ZSQSVrqYDmrCb0bJeoWybRJzhYG3WoN4Uy
        h9c7mw61L71jMkoi0QagPfQnVg==
X-Google-Smtp-Source: ABdhPJwPWyPwb8fFPniP4WALIolIXo/0F86m+aaMDJzd9oMldjmXMowgEbhBdLf2fAEhdwOQkl2WeQ==
X-Received: by 2002:a5d:64cd:: with SMTP id f13mr41907210wri.419.1632319811428;
        Wed, 22 Sep 2021 07:10:11 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id i203sm5875577wma.7.2021.09.22.07.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:10:10 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:10:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/4] dt-bindings: mfd: qcom,tcsr: document ipq6018
 compatible
Message-ID: <YUs5QAeQnPijfp7z@google.com>
References: <5c95bcf62a9d08208a7da19f0b1cec0689502b9a.1630323987.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c95bcf62a9d08208a7da19f0b1cec0689502b9a.1630323987.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 30 Aug 2021, Baruch Siach wrote:

> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
