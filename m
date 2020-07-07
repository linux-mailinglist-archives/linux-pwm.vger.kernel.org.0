Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EED421669C
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2020 08:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGGGoY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Jul 2020 02:44:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55953 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGGoX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jul 2020 02:44:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id g75so42034572wme.5;
        Mon, 06 Jul 2020 23:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mW3E2MtDuPUcGU+63FpYdbWOc+tTMlG34yDRynkWV5w=;
        b=VpxxgOHjHepxlC25qTOD7CDYCjEB5sjD/XWx3Uz5zBdVOTcNpuzRdyDDhkmbUGuIdq
         0wsC9ppuDEkknV99aXNaKE59x8wbi+yG5Nm/lyfocCh+7aHjW6fo4ZMc+5d2P+s2bl4H
         2a0iKWN+V83d5GKpzQMTazyoQxmpsRMUwvYOffZ67SYHtHwaNsuFDykAoDYNtdpGiDkG
         9HiIBiRgndgprB0PqJJFKymwaY7Q/B8gKx21Fif+wgcNEmmnWjm1cM6rtL6BI/xTyvPX
         nokNIBL4Eut2RJH/x83XlzQRjgwpvUooIe1agQwo+dJOulbPt/feqDbFvEBFY5lXAm4r
         uDsQ==
X-Gm-Message-State: AOAM530HEpp5ACoF5J5JuviSdpOiCAuVzSgwyglBZc7ZMA0sCSS+OmwG
        +ne48eywnC3++JmCIMuX06Z9UR5M
X-Google-Smtp-Source: ABdhPJx/GZ5wwUsHhMP8Dm6hZDOrkdkLfjSEppSoFX56hhEEpuaxQSTp5DpWNcRT9T1chq7Zsb/dBQ==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr2495366wmj.5.1594104260927;
        Mon, 06 Jul 2020 23:44:20 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id o21sm2158458wmh.18.2020.07.06.23.44.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jul 2020 23:44:20 -0700 (PDT)
Date:   Tue, 7 Jul 2020 08:44:17 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v2 4/8] arm64: dts: exynos: Remove DMA controller bus
 node name to fix dtschema warnings
Message-ID: <20200707064417.GB15031@kozik-lap>
References: <20200702155149.12854-1-krzk@kernel.org>
 <20200702155149.12854-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200702155149.12854-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 02, 2020 at 05:51:45PM +0200, Krzysztof Kozlowski wrote:
> There is no need to keep DMA controller nodes under AMBA bus node.
> Remove the "amba" node to fix dtschema warnings like:
> 
>     amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:

Applied.

Best regards,
Krzysztof

