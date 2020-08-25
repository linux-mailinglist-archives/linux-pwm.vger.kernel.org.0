Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3062B250F8A
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgHYCkQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:40:16 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42416 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYCkQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:40:16 -0400
Received: by mail-il1-f196.google.com with SMTP id t13so9129583ile.9;
        Mon, 24 Aug 2020 19:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DBbGNGBjMQHX+/0e9zWJwieDwZ+vk9KNeNFH7XE04vU=;
        b=KsoSRc04GG6j3VqOZ8EYqeYrLJepe1nRJJuTsLmd3IylOVuUPd18z3IQYoAoBXDX5U
         nlMlf6TtTDWssZMVTpc/F3TsozdTQ4TpN9oeZTxhnbInwQpbXF7JaAc1/k0h/5zTYzVr
         GwMRhm4b1waPR9No93Qq9Cpe387+sSptNtaQ3cHkO7Gpb3PJ99j0C+p6BPkB7M7Oujd6
         fn/6Aj4ApPI3DG+M7Mq79j3i1/jvH+6u4wgUivRFyzjasEmRsvI9j0Xcf9NA9F5hUQ95
         M2SiUDXREgtOryy1A1jw/cZZHJ2VIsb3X6jjBJjC4o9K0kEosgwWU2zN1PXSv0Cs2Qwv
         RZsA==
X-Gm-Message-State: AOAM533kSoVvIm5XwHl/WNKokh7HyfzX1HblbD3wPmwVs7vq6zZS3dyS
        qJqumrN3Dt2a5V6V9BUxyg==
X-Google-Smtp-Source: ABdhPJxkF97gjn61yOeKwZGd4PsRdtUbaNMPNP/yf7yzDKVCZ/CBJvhkxZR1uVkBoPp55VowvkrYIg==
X-Received: by 2002:a92:9996:: with SMTP id t22mr7169891ilk.216.1598323214649;
        Mon, 24 Aug 2020 19:40:14 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id z1sm8310046ilh.13.2020.08.24.19.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:40:14 -0700 (PDT)
Received: (nullmailer pid 3840594 invoked by uid 1000);
        Tue, 25 Aug 2020 02:40:10 -0000
Date:   Mon, 24 Aug 2020 20:40:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-mmc@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-serial@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>, Han Xu <han.xu@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org, Frank Li <frank.li@nxp.com>,
        linux-pm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-gpio@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 15/19] dt-bindings: arm: fsl: Add ZII Ultra boards
 binding
Message-ID: <20200825024010.GA3840543@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-15-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-15-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:48 +0200, Krzysztof Kozlowski wrote:
> Document the binding for Zodiac Inflight Innovations Ultra Boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
