Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BDC2B7AA5
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 10:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgKRJtm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 04:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKRJtm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 04:49:42 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50BEC061A4D
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2020 01:49:41 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so2079326wmb.5
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2020 01:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HFTcDZeHbwdubfzDRBdCD5cLqNYQsMR4r/D4QoM7A9E=;
        b=fIqNcNl6ja8EnvxJpWgdSivTffK0XWt93PUp7LrFxkzxJDeFRtNtztf6dYRXd0vQOQ
         OSIGMXRSpZvHHcDg13LTqH1NswQ4hh9turaglP9WSI/LTH78lomhvzgUrL0rRnAQc61F
         mPBQlGBw/96qg+ZUxMMjUwHwvQIneAaq+wvqQErE8AaGH2VcfTWoloS2RtS8xXTG4Puz
         0jtkLPw8xtzXxBfqhGpH+6BDbXx/+EYAxVD7xNamxzZOIjdXivuanjxvGDY91xX9xh9+
         0My2kDduJokNwvAW1ao5L4Ljb8t3b7+bcloT2j7kTtcVbECGqB4Do7HHQ+7LupQyja87
         WtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HFTcDZeHbwdubfzDRBdCD5cLqNYQsMR4r/D4QoM7A9E=;
        b=VVYopmiZTwEn+8yg5fdhZ+bqcU1+9Zz+8WM8U/slT1xR1D8i/jqtCa5T0iUya5a8TC
         NlUPzq5C214PeF7c6OR5TxkD1CaP9slAMUOqa+qVc6JrDBp5EqL2VK78nEOXjlTyfe2e
         N0WpXl7zwVznvdiEBl52EZZfpZ15W1QmgjwY2kIW1oj2JXzxOvp8nfYlp5m4HdCHzw2h
         m2TVVLRItL/03Xi+jAyOfbPPM4MyopCAoBamId7mcaEVYe/gxX7dRX6B40grN5aB9ZM1
         qKbPMV/ePaPZiv/4ByTf5QedQCH7eP1tNWlIaSr/h79CRUw6KXTV11aiQXP5AUyt+E1a
         x1dg==
X-Gm-Message-State: AOAM530Zmgs7dun6mvZby0GusiP3Jq2UzzvXsCvCnhuZ2DObudlqKeqZ
        h2wie2vk3mCSj6ypG/FarSBY8Q==
X-Google-Smtp-Source: ABdhPJyEcNTG6/Gz7Fa8vL0gPcb+JqRdX7fRKh1H/5GyTm2gynqxN0ZHezxGR+PfPl4uud2EMioCpg==
X-Received: by 2002:a1c:9c56:: with SMTP id f83mr3678999wme.49.1605692980555;
        Wed, 18 Nov 2020 01:49:40 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id v20sm2737501wmh.44.2020.11.18.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 01:49:39 -0800 (PST)
Date:   Wed, 18 Nov 2020 09:49:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Soham Biswas <sohambiswas41@gmail.com>,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: core: Use octal permission
Message-ID: <20201118094938.GP1869941@dell>
References: <20201117175452.26914-1-sohambiswas41@gmail.com>
 <20201117181214.GK1869941@dell>
 <CAMmt7eO5te05AuVC+MR-zLB-z+r9FCuJwtON=1QXXY2YwQG0eg@mail.gmail.com>
 <20201118085113.GO1869941@dell>
 <20201118093506.srljfosnamxe5wwz@pengutronix.de>
 <ebe315dae8855ed2c55d6ce48f84aa4edd93e5fd.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebe315dae8855ed2c55d6ce48f84aa4edd93e5fd.camel@perches.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 18 Nov 2020, Joe Perches wrote:

> On Wed, 2020-11-18 at 10:35 +0100, Uwe Kleine-König wrote:
> 
> > Actually I'd prefer keeping the symbolic name because this is easier to
> > grep for. So to convince me a better reason than "checkpatch says so" is
> > needed.
> 
> https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/
> -------------------------------------------------------------------
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 2 Aug 2016 16:58:29 -0400
> 
> The symbolic names are good for the *other* bits (ie sticky bit, and
> the inode mode _type_ numbers etc), but for the permission bits, the
> symbolic names are just insane crap. Nobody sane should ever use them.
> Not in the kernel, not in user space.
> 
>            Linus

I was waiting for this!

I see your "checkpatch" filter is working well Joe. :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
