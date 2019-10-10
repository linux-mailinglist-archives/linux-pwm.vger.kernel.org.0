Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9364AD3354
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2019 23:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfJJVXs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Oct 2019 17:23:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36811 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVXs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Oct 2019 17:23:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id 67so6196697oto.3;
        Thu, 10 Oct 2019 14:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8fsaLFcYDAROH9HBoKC5Vafqp1MCH4HA/pJSglSZ4co=;
        b=bKjELxGNAZN7UBGTFrZEAnN7TuoetlHlelmVWf9GsyR5amJTLlVS5UmG4om4QBlfoc
         uZ7XzRvahamKbuTFPmhWzLU7vIPRpfFPqStqvLBY1D3CmnMztcUhcx7I+QUlJU8I+k2D
         EMAUiHjg0tfdNM9GuQq1c/HawnH9s/2bOYZ8q2gJ++E0fBI/QpKIJ/2aFwhkkUel1kXG
         V2O2TJLIhHwjwmm4czN8yNjLFoPXpIB3hFE81KHMTYstsW9Es6cLx1+CaN8Hr41uSP7T
         O5/5AdyHOn+2540VlVk+KBQHidUyrcYKPAosq9dnhgi9B8aK9GxYZZQucHtX8EHHPUl9
         7NVg==
X-Gm-Message-State: APjAAAWE4pp2C/Gyu/UbUgqwLHAdIXjVNL2ivp/Z3RmJEaQ78dy6yT2e
        nFhOVvTEcgLL7otfuWRw4w==
X-Google-Smtp-Source: APXvYqyIyxVe/QML8xBJW19srjEWY1fzMm01BIPfEyxogOHEBtnRrO0q0z3M7piA63qkH2laitZG7g==
X-Received: by 2002:a05:6830:13d8:: with SMTP id e24mr9348918otq.42.1570742627232;
        Thu, 10 Oct 2019 14:23:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v132sm2027358oif.34.2019.10.10.14.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:23:46 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:23:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 4/8] dt-bindings: memory-controllers: Convert Samsung
 Exynos SROM bindings to json-schema
Message-ID: <20191010212346.GA7896@bogus>
References: <20190918173141.4314-1-krzk@kernel.org>
 <20190918173141.4314-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918173141.4314-4-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 18 Sep 2019 19:31:37 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos SROM controller bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Indent example with four spaces (more readable),
> 2. Split examples into two,
> 3. Fix pattern for subnode name,
> 4. Remove checks for #address-cells-ranges-#size-cells,
> 5. Add "additionalProperties" so the wrongly named subnodes would be
>    matched.
> ---
>  .../memory-controllers/exynos-srom.txt        |  79 -----------
>  .../memory-controllers/exynos-srom.yaml       | 128 ++++++++++++++++++
>  2 files changed, 128 insertions(+), 79 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
> 

Applied, thanks.

Rob
