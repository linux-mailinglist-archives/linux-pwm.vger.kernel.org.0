Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C875ADA656
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404942AbfJQHXQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 03:23:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37712 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfJQHXP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 03:23:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so1049742wro.4
        for <linux-pwm@vger.kernel.org>; Thu, 17 Oct 2019 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bJaZjiCjaQtaB4bTbXFULjRD1sl5x1sEWLifkMF+gkw=;
        b=a/EiLVXZW+HT/sD53bL0i7pXjmuVsDqccI/74Zl4d+EkKXzOjQeh7W9o//pg1SqadH
         5ibWdUKmmJick7gLUUHWIot5SMAATRHPqt2lIjjgzGKSSi3tCqcwveLYq4/5FIn+K7E2
         ClGUIIHWRNcG8Kf12GMv8VcBIFNmxgqh4X0S7YHOiVyNQVd0D8inN6Pm9nvECG0tm+Jb
         uyg0jWtT7ipqPGy2y6cg71kq/AYkxvC+86gc+eWRZ/d8KLaTSJ7SdHqgvn3KyiafxEdQ
         WCO2n4wB3LeqYr3pSF2QlA1QqKv73z5EG/MG4cRbALdEUMu9Qdxoy2gKTxVOuPIcZJn+
         GYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bJaZjiCjaQtaB4bTbXFULjRD1sl5x1sEWLifkMF+gkw=;
        b=e1foslR/46rYZL+5unNlly2wUJnoPsScPlf8aIHwEGQl1sh4CCO2jQbSIrbmYWH5BP
         ZWqST9YPAiNMFifwup6/4l5iQNfQDQTPZD8+9fILjFAi2FYt9KhKNqNxXrLiC4Uh4Ion
         cQ5sLQ5Nac2PqYQP0SoxajoUdE7kr4rx4eRdlDpQp3avU7LcBNakCtOqWwa5cumcN19M
         box+UqkIeiBABtJ6ElNNlK630u1+UN1NrVdRWZ2DyAxL3VFORf9bTFxknpQ/98mnrRjM
         Z2l5P+6+QDnkel6bdTVvuLzJmtcIQQY8/dmwgHWavQ+pyak5wmpT3olVu59sDgbDQRVt
         66iA==
X-Gm-Message-State: APjAAAXpyNjd7kLXEPUhNGyuHCUnzVUzOG53SffYxSWGw8mnoKjEMKjW
        0Q6CewUE0LqmQiUoEgmYJaDvSg==
X-Google-Smtp-Source: APXvYqwG1PUY2YSznRp+xzXuWxf9Lb+1WbAdj4Wwau7GWQHe9gwTD6Vp2mN9FrJsc1ayE8NYCfon4A==
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr1699652wrw.286.1571296993299;
        Thu, 17 Oct 2019 00:23:13 -0700 (PDT)
Received: from dell ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id z13sm1408861wrm.64.2019.10.17.00.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 00:23:12 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:23:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: stm32: Remove clutter from ternary operator
Message-ID: <20191017072311.GJ4365@dell>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
 <20191016110601.1765415-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016110601.1765415-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 16 Oct 2019, Thierry Reding wrote:

> Remove usage of the ternary operator to assign values for register
> fields. Instead, parameterize the register and field offset macros
> and pass the index to them.
> 
> This removes clutter and improves readability.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-stm32.c          | 21 +++++++++------------

>  include/linux/mfd/stm32-timers.h | 12 ++++--------

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
