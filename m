Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEBF2D71A3
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 09:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436884AbgLKIY3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 03:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436876AbgLKIYG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Dec 2020 03:24:06 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51CAC0613CF;
        Fri, 11 Dec 2020 00:23:26 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t7so6544592pfh.7;
        Fri, 11 Dec 2020 00:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=McHA6ldrHNaYbtcBFUNT3im6pkBwbtgyDVpIeFMCpqk=;
        b=A1cpx8OhI+mlvEtRBFFwNksNbpRnEH7xi58LwSx54juZWdBBptHp6XxO9ROhi5gqBP
         Y6WVYdEVZXs6R12nFX93UP/BYR0Mh4m0r/gsxA4TsfH+eCrhlVtLQYIYjvQeoewx47Ua
         UHKSPi5jqqzYvd9atxymMusqtMcCzhdyxLiHDOS3H+Dh9PcJ1zUFc5uI1DYBo8TxZUhz
         VdjtuojA/r+ujBe+u/0XTdr+E87pE3K3Y4FgJu13iaKiT4tfyhyB04KEtjeAPuPAgSON
         CC68lOmJUZcE3UroXTD29a68yxnH1SOGdrDWksUe/u9dznj1tAPBwJRmiV/Ljcfmfi7w
         w11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=McHA6ldrHNaYbtcBFUNT3im6pkBwbtgyDVpIeFMCpqk=;
        b=riH5laE84QGP5IfyZF98QpghNZgO1jS5D5I1oVFqaUhRrtRGvcR9HZpyUS5JIlJMVK
         3u9aUgzj+pzra3IeoM09Ab0ctg7eS51BpSVur9+RxTuFblDdL45hvoWcQvsZtTSOLi4B
         JAawKW1cp8pEzYibCiAQO4tr1zHfmr6ydGMl0Gj+HeKE0fjImDPEAV9wz7pE9pjv4WDv
         ifbacEer9bqp+8NuqK+nUltsj6wsQNRLcJ2Iuj0FDNtJmRjSyUrHZjm1hLPGeu3mg/OO
         1IYVSjzzW05ns6wUmiqBl/V4BLFQ/6NLBRsbDhVEOFs9cv8jA/ObWUc/iS6N+QEtk/EB
         yiYA==
X-Gm-Message-State: AOAM531/TLdRelMGZdk6fuMcLka5W94o8hPO9MJYWe4w40BMv6EW6QUK
        oOf1nIV+c/35xKXiemainpA=
X-Google-Smtp-Source: ABdhPJzHn33GT+pfpnPdhLtliRf3ack+65/hoyQVDY12l1rMcVdWiY2q00uwnghj1tGezZBYgW5yiA==
X-Received: by 2002:a62:b417:0:b029:18b:8c55:849f with SMTP id h23-20020a62b4170000b029018b8c55849fmr10602060pfn.27.1607675006303;
        Fri, 11 Dec 2020 00:23:26 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id mz1sm9206794pjb.33.2020.12.11.00.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 00:23:25 -0800 (PST)
Date:   Fri, 11 Dec 2020 00:23:22 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND PATCH V20 3/3] Input: new da7280 haptic driver
Message-ID: <X9MsevsOmWDko2HR@google.com>
References: <cover.1606320459.git.Roy.Im@diasemi.com>
 <1e293e8c4830b09255af3b7e1721b73afaefdfa3.1606320459.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e293e8c4830b09255af3b7e1721b73afaefdfa3.1606320459.git.Roy.Im@diasemi.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 26, 2020 at 01:07:39AM +0900, Roy Im wrote:
> Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> multiple mode and integrated waveform memory and wideband support.
> It communicates via an I2C bus to the device.
> 
> Reviewed-by: Jes Sorensen <Jes.Sorensen@gmail.com>.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

Applied with some cosmetic edits, thank you.

-- 
Dmitry
