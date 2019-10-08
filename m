Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841FAD0459
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2019 01:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfJHXqN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Oct 2019 19:46:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39789 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbfJHXqN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Oct 2019 19:46:13 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so883029ioc.6
        for <linux-pwm@vger.kernel.org>; Tue, 08 Oct 2019 16:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SPl3L4+4Zy9QlJN3K7IuqOc2JedlA0ldY7i+AP0Siqo=;
        b=I+N5hkvPCF8K1LY460NnH3Bs+ppv36e7pHAAko5cPGtVK7Q1xpMFtMk1sbwX3EL9Ae
         UX5ufwjfjE2WsQxxVvaJrkkGtrrD1A1swJroeZ6oWYFiFUD/gbGKkY6710T0F0X5S5Xo
         BF95rAFQKdDZy+9dBrgr05QKn2VguSytZtPaHPhpxauj1vAvK0o8UX1wBJzBZa1yl7EV
         jLHoqHF7Hse1l/Ohr1dGC6ATYWRzE6EftbRk42hoGB79bBRXmsmPeyS2gmRpO97jk05b
         X+CS58w6j5DGF3spjHV4AncNibrgaK8A9wTUdRqszmiSN3PwPwqQA/IsTfJ60gtOiuUB
         4Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=SPl3L4+4Zy9QlJN3K7IuqOc2JedlA0ldY7i+AP0Siqo=;
        b=am89WlAJ7xfHwI0n/6lcCuIEUiQrgYiJpzDuBbvgpQdiBL4ELd4Eqyp5hWy3CbSJlj
         WZfZ8d8yWz2O0eYpsbs8uxJJtM9Lvp7CaRWiebbPbfGjq8+NWH7oIvPbZH+N7MHGbq+i
         KbEGWJASCVFlHpfnqRLGdkJydOUCVH0pq7oGaicHucuvbj5bqluWZqSbchs6CYbK/Wfc
         wa1Un7A+HuzhIkITmmsHDeW2OJpbB9I0MNSd6yg4voNilLE5DTjNRg39nqw9H2rANhFR
         PnzS4AbR3kAZbLUYjk4b5LvllVSVmBaLIlgqWhHC5ofXrlbOk+/RC7s8rmMF7dKa/7N9
         J4uQ==
X-Gm-Message-State: APjAAAVC1WqQvJELJ4HQokFpFECZJPny4kVAp4DP0jSiC75NQGDowNq1
        cHwrNHYbr8jGr2XR1re1KsfDDQ==
X-Google-Smtp-Source: APXvYqz97nlCIt/+/P4PPfxa3nO+CVIeqE66+NVgtpZhnKj/IpAG2fhUxvCWOIqX/CoRt6DSjpBBFw==
X-Received: by 2002:a92:d084:: with SMTP id h4mr287013ilh.223.1570578372595;
        Tue, 08 Oct 2019 16:46:12 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id m11sm250603ioq.5.2019.10.08.16.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 16:46:12 -0700 (PDT)
Date:   Tue, 8 Oct 2019 16:46:06 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Krzysztof Kozlowski <krzk@kernel.org>
cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Convert PWM bindings to
 json-schema
In-Reply-To: <20191002164047.14499-1-krzk@kernel.org>
Message-ID: <alpine.DEB.2.21.9999.1910081643220.11044@viisi.sifive.com>
References: <20191002164047.14499-1-krzk@kernel.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 2 Oct 2019, Krzysztof Kozlowski wrote:

> Convert generic PWM bindings to DT schema format using json-schema.  The
> consumer bindings are split to separate file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 

[ ... ]

> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> index 36447e3c9378..3d1dd7b06efc 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> @@ -17,7 +17,7 @@ Required properties:
>    Please refer to sifive-blocks-ip-versioning.txt for details.
>  - reg: physical base address and length of the controller's registers
>  - clocks: Should contain a clock identifier for the PWM's parent clock.
> -- #pwm-cells: Should be 3. See pwm.txt in this directory
> +- #pwm-cells: Should be 3. See pwm.yaml in this directory
>    for a description of the cell format.
>  - interrupts: one interrupt per PWM channel

For the SiFive PWM driver documentation:

Acked-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
