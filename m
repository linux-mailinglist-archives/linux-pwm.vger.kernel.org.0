Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE34A1EBD05
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2020 15:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgFBNXk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 09:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgFBNXk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 09:23:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B537AC061A0E
        for <linux-pwm@vger.kernel.org>; Tue,  2 Jun 2020 06:23:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r9so2921495wmh.2
        for <linux-pwm@vger.kernel.org>; Tue, 02 Jun 2020 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DDjjMQdi6tyaSs3LHoybbsQC58w7hEdj8O+UkyfJUfI=;
        b=LirUsOK6cB1KQGFNSgQGNpfpPdAcqWpyPUtADNyD32knuARwC189FW3j7lxuFI5OZa
         Y5JQ5gVAJ1oAbOvbIhsbKerXoBKBNanbjMAJk3fC91r8nztHyIe3xV1IdnA5jAoLJp2L
         D59YKy6Mo8qAsGfx/re162wJLLX5/d2I91Go3jxiEK1WYG1unXONQAi9aMSXlhjAJWAH
         SlVxyOmATicxbkGCNm6ui3ZqtI27gaPOEOmYRe9gxgfb4/GwapYm6xzeXZNqMiPVsZN3
         c6EYL5nOtnnI6Top78r2xXRkwZzWUZQidBNsxG84Oow/NW8G41ew+NVZLWXhOxV6ztdL
         lROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DDjjMQdi6tyaSs3LHoybbsQC58w7hEdj8O+UkyfJUfI=;
        b=mht+r+TszUs5xRZLkIEhSzOeXari39s+9rIXcnqVw6Iwu1vZr30n7ACawYAW/uXwP4
         i6F93mcTXkD+zPeYx9Y5e+bxZ6chVUvewvsq6Bdmig/3mDLn00fTtD42+tetfqVOfrN2
         jhhILvuhtBm/hGH5o+Sl/1+ITwsl+fTMI9RbwhQpOEXOVnhL+ht1EBJnXpzsR4mV1ai9
         HRt68rhXzs2+JYu43cXDfvu9hAPLqXg5BumMpGO5s9UndUk9oOwpT7VglzSQBdbtmjdg
         jKmngQKe/+Y5b78ksWtR8sZ8ftFt0U0T6m/bb4l4n1smn5wD1RPP4hoPt6Ozeiz/fFyj
         AHPw==
X-Gm-Message-State: AOAM5338P6b+14C2Tq2HOhCNXR+abdt/ilFL38bjlCmeRmMP2lupBpHX
        z2SW5YA45YB93KhVWXT72x/pQgrSAao=
X-Google-Smtp-Source: ABdhPJzHubA9KYD5dADuAivSew3mk3H5PKiLlQS4fNMN/glcBAN+37ecHErZX7XQtRmGCuC2dSPBAQ==
X-Received: by 2002:a1c:305:: with SMTP id 5mr4106444wmd.60.1591104218399;
        Tue, 02 Jun 2020 06:23:38 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id p16sm4365287wru.27.2020.06.02.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 06:23:37 -0700 (PDT)
Date:   Tue, 2 Jun 2020 14:23:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Lee Jones as reviewer for the PWM
 subsystem
Message-ID: <20200602132336.GF3714@dell>
References: <20200602123241.3363904-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200602123241.3363904-1-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 02 Jun 2020, Thierry Reding wrote:

> Lee has kindly offered his help in sharing the patch review workload for
> the PWM subsystem. If this works out well between Lee, Uwe and myself it
> may be a good idea to maintain the subsystem as a group.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Works for me.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
