Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E063B8E4E
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2019 12:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393374AbfITKOR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Sep 2019 06:14:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45274 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393353AbfITKOR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Sep 2019 06:14:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so6112844wrm.12
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2019 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ZARvlMGzUOLlDd3Qz++HvoWRZDtFBjq+Ck4U0kIZJ0=;
        b=W6nzOE9+ubRnrXYaddn4a21F2+zaZqCfW5jYKljj9XjJqQ9t+UHwh8ByKvVJeZxs5T
         fNr6h9fu1qTNCNjta8Tngtiah1PSd0me8UgBwWXGumP+jzpGVEOQpqPhj9CAHNXJK+qn
         7KxxqKGRYpmRQ3h4qyXCfzUQqGIW73rHtkObqsExqBGkjXiD2JXOALqcc/ijZdPdBNa5
         mxzZ7u4kFImnnhqGHksmDkJxGROJvZoq2mtAx08mC2DufbIbzt0vcRYodcdpV/tU4iBL
         tjLELQ+Av7uCHUQLoUEKytOxo2cjZfLqKTf7grg7HYe+CmvC9NOxOmKh4bs3A2g1SBlT
         OO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ZARvlMGzUOLlDd3Qz++HvoWRZDtFBjq+Ck4U0kIZJ0=;
        b=FmaFwfwE6oHC37qPO7UsAVWpZ57KzbFE6NjiEVsRICNF9Nzi+97fEhDwdFarvH+kcX
         RBRP6FuFKz6I9HQ7unP32hiodTMP00eXRoZ6Ntbp7FkaAZm3VyIDUmxhFifFaNsKGbET
         UTtNYf5GpgJgwXDuWVirnQYYoK69u+pA/u+3OtKw1RasvAC0J+M6ST0haKcPZ+eA5qKm
         yxDjb7AUmYliIN2jvOXQ5H+ToK12RGRNZAs89DGHGbXxdkzrKnTWvcZiyRIJ2/lIB6AJ
         lRfKUbmA1iMAWOMBiST4n7IdNNk38lQ75Q+Hl2UUbfeEeS3IJbAn4I/EQXU02Wn6JUVq
         2doA==
X-Gm-Message-State: APjAAAWs90U0vKGjpbmN9snWNv0KR0sXH3HYQJdt4707m0nQ0+9CC3LH
        wEP+90LHv/IvM22yOIZ4rLn5mqApYAk=
X-Google-Smtp-Source: APXvYqyKLOgmfl8hv9NLxhkcUW8cJq4QiBvFCFxi3sIHPyIEplkcQ/E1SKt7/3vCOBdKqIxZ7o8nBQ==
X-Received: by 2002:a5d:4742:: with SMTP id o2mr11160970wrs.253.1568974455339;
        Fri, 20 Sep 2019 03:14:15 -0700 (PDT)
Received: from holly.lan (82-132-212-65.dab.02.net. [82.132.212.65])
        by smtp.gmail.com with ESMTPSA id z9sm2200313wrp.26.2019.09.20.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 03:14:14 -0700 (PDT)
Date:   Fri, 20 Sep 2019 11:14:05 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] backlight: pwm_bl: fix cie1913 comments and constant
Message-ID: <20190920101405.yuu4bymublj45kd4@holly.lan>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rasmus

Has something gone wrong with the mail out for this patch set. I didn't
get a covering letter or patch 5/5?


Daniel.
