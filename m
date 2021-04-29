Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA036E58D
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Apr 2021 09:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhD2HHo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 03:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbhD2HHn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 03:07:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74210C06138B
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 00:06:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z6so4361014wrm.4
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 00:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kr8BmFndPx3gvcqViLkXwW6+aAE4CRPNFv47IW8MWfE=;
        b=WOEzMDCC8eYunFMSsYUbqrepv32DAs+Z5JFboR/vBer0Jv4hmk1l6sXGM0jpgKUNDC
         cosKRcBydCW4G2UkVVThs5Bv4HcAvhnMbotFoyiXxbwFyVm42p7nv17GIs8Ne1qZQLvh
         rnqDN2tpZouZQpXfrxo9EmzzIJf7iXxoSX1j1gMp+6IxFHFwRSAbq2pM6qwgtiRwqO+s
         A4s1T+8NOF7HMrynXvljhe6MUHQbcKQD9xiHx7s62uBnox8xygF4Lq6DZCxedy9IvEtE
         Pu+cnn0XuKsunl/npoR9jzly7c7B8InC0QrvyF6iM5SMwlGGui2HdFNrahBIKFcXNf9g
         KVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kr8BmFndPx3gvcqViLkXwW6+aAE4CRPNFv47IW8MWfE=;
        b=GmzDmdQREQ4nw79ldEVuh4xAiqLJmLbVmCHF19NHq7CUBZICtpJXJX6dYKBRYuPM1y
         xs+B0BVXK9M2FcaF0yAypj4qTk0A+D6A2H4LSuR4Kbf1nLi0I+AVKNtnN0YiXUuF4tEx
         iroqrNgFgqrCt82TVJvexpgvUsiH6S1a4CB1Qzm477wcuc8z7Y8jz3bPgv0OATVKdczU
         Hk+gPO58k28LQQTfqtsUh2wYWyROCXk+AuF3DbHn7rFFYGAIvp5Jy2Wrrh4avr3P0F4/
         cQKg8WDfgnvPmCj/vqdnnyGZsKy0SeSfzydVu68bFR1MmHI8MOYjIsBZeGsFlcPk+TjV
         wOIA==
X-Gm-Message-State: AOAM530q3LVEocuLcTdWbFsFuNMQ7LJxYDr/xYEUt999htXF+5mc9OV1
        NhEMuIS+7hZPaSlJrO4uJsT8ChtEIXfgVg==
X-Google-Smtp-Source: ABdhPJyDF0stlq20VtjLqRHuDkWygYgpAxi8Cw2UYWcVTzs9XuzSpk2MuIvbGFlujyQbW3yldBTJhw==
X-Received: by 2002:adf:e98d:: with SMTP id h13mr26997701wrm.1.1619680016198;
        Thu, 29 Apr 2021 00:06:56 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id r18sm3658131wrs.90.2021.04.29.00.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 00:06:55 -0700 (PDT)
Date:   Thu, 29 Apr 2021 08:06:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Fenglin Wu <fenglinw@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, subbaram@codeaurora.org,
        collinsd@codeaurora.org, aghayal@codeaurora.org
Subject: Re: [PATCH 2/2] pwm: pwm-qcom: add driver for PWM modules in QCOM
 PMICs
Message-ID: <20210429070653.GJ6446@dell>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
 <20210427102247.822-3-fenglinw@codeaurora.org>
 <20210427170748.wglupc6zwrndalxs@pengutronix.de>
 <YImfkM/ll1nCmopq@orome.fritz.box>
 <20210429065213.inajpznvfxa2xsld@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210429065213.inajpznvfxa2xsld@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 29 Apr 2021, Uwe Kleine-König wrote:

> Hello,
> 
> On Wed, Apr 28, 2021 at 07:46:56PM +0200, Thierry Reding wrote:
> > On Tue, Apr 27, 2021 at 07:07:48PM +0200, Uwe Kleine-König wrote:
> > > I would like to see the register definition to use a common prefix (like
> > > QCOM_PWM_) and that the names of bit fields include the register name.
> > > So something like:
> > > 
> > > 	#define QCOM_PWM_PWM_SIZE_CLK		0x41
> > > 	#define QCOM_PWM_PWM_SIZE_CLK_FREQ_SEL 		GENMASK(1, 0)
> > > 
> > > even if the names are quite long, its usage is less error prone. Maybe
> > > it makes sense to drop the duplicated PWM (but only if all or no
> > > register contains PWM in its name according to the reference manual).
> > > Also maybe QCOM_PWM_PWMSIZECLK_FREQSEL might be a good choice. I let you
> > > judge about the details.
> > 
> > Please stop requesting this. A common prefix is good for namespacing
> > symbols, but these defines are used only within this file, so there's no
> > need to namespace them.
> 
> I do consider it important. The goal of my review comments is to improve
> the drivers according to what I consider sensible even if that might not
> fit your metrics. 
> 
> Consistent name(space)ing is sensible because the names of static
> functions are used in backtraces. It is sensible because tools like
> ctags, etags and cscope work better when names are unique. It is
> sensible because it's harder than necessary to spot the error in
> 
> 	writel(PWM_EN_GLITCH_REMOVAL_MASK, base + REG_ENABLE_CONTROL);
> 
> . It is sensible because the rule "Use namespacing for all symbols" is
> easier than "Use namespacing for symbols that might conflict with
> (present or future) names in the core or that might appear in user
> visible messages like backtraces or KASAN reports". It's sensible
> because then it's obvious when reading a code line that the symbol is
> driver specific. It is useful to have a common prefix for driver
> functions because that makes it easier to select them for tracing.
> 
> > Forcing everyone to use a specific prefix is just going to add a bunch
> > of characters but doesn't actually add any value.
> 
> That's your opinion and I disagree. I do see a value and the "burden" of
> these additional characters is quite worth its costs. In my bubble most
> people also see this value. This includes the coworkers I talked to,
> several other maintainers also insist on common prefixes[1] and it
> matches what my software engineering professor taught me during my
> studies. I also agree that longer names are more annoying than short
> ones, but that doesn't outweigh the advantages in my eyes and a good
> editor helps here.

FWIW, I'm +1 for proper namespacing for the purposes of; tracing,
logging and future proofing, even if it does add a few more chars.
Less of a problem now the 80-char rule is waning.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
