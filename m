Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC121E5E1
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2020 04:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgGNCqz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Jul 2020 22:46:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40079 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGNCqz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jul 2020 22:46:55 -0400
Received: by mail-io1-f67.google.com with SMTP id l17so4254065iok.7;
        Mon, 13 Jul 2020 19:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bc5jq0niHA3gC08P2rOK06R4R1evL8StG0uwWdkja3Y=;
        b=Evieg6i57U43gQpqsD3U6XyErOPHli7xCwhKjUmBiOGDTMLEYWoTYdQ36cewIH8jfn
         Im0KrBpmAR17jGZOqRQKfDT4BPhBefkwWrdGsxsPu/p9HueJy/OU/qJw+acHBuuecl4/
         tGjTbrlBPCE295lMfHPnhbVHSGiv4F9e8csGSyzbLqRn4SJ5FsskjKo8v74TgV6GdClz
         5/dV9TRSNNTfzuC4O0ZtnsUKFCniw2/rXbIJ0bbs0Z5kWsdEeU1jx7cpvno/BYxF0w0a
         W0Tj38Jq6GI3++8tUSM1r+71X58NNK07Yate97P0IhozXVEfqGMNFtGfC+kc0nrqnZaW
         f+Ew==
X-Gm-Message-State: AOAM5325YPcLG/kLi8UAanx235TNA9+M66q4pK39APtX0o8p1HqtnHoi
        y30mnEr3Vuv7RVjIFteswQ==
X-Google-Smtp-Source: ABdhPJxtEZf0uhmPI6XNqvrxc/TEXzwKQHie8nqQYbol8cjKgBqiy0lDcBQvXMLpVO0RWLzVhVfD0g==
X-Received: by 2002:a6b:1ce:: with SMTP id 197mr2922980iob.76.1594694813895;
        Mon, 13 Jul 2020 19:46:53 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x12sm9349060ile.14.2020.07.13.19.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 19:46:53 -0700 (PDT)
Received: (nullmailer pid 1184151 invoked by uid 1000);
        Tue, 14 Jul 2020 02:46:52 -0000
Date:   Mon, 13 Jul 2020 20:46:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/8] dt-bindings: pwm: samsung: Do not require
 interrupts on Exynos SoCs
Message-ID: <20200714024652.GA1184042@bogus>
References: <20200702155149.12854-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702155149.12854-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 02 Jul 2020 17:51:42 +0200, Krzysztof Kozlowski wrote:
> The bindings required interrupts for all SoCs but actually only the PWM
> timer clocksource (for S3C/S5P SoCs) was using them.  This PWM timer
> clocksource driver is not used on Exynos SoCs thus the interrupts can be
> marked as optional.
> 
> Reported-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  .../devicetree/bindings/pwm/pwm-samsung.yaml  | 23 +++++++++++++++----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 

Applied, thanks!
