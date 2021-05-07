Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55E7375E2E
	for <lists+linux-pwm@lfdr.de>; Fri,  7 May 2021 03:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhEGBHC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 May 2021 21:07:02 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34741 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhEGBHC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 May 2021 21:07:02 -0400
Received: by mail-oi1-f178.google.com with SMTP id l6so7310043oii.1;
        Thu, 06 May 2021 18:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qNz9umZ4AwFT7+0+9QX1oMvRnHAxwDwQzkL23KUHYkY=;
        b=XV5BdpQB35EClzUANf9YAt2GhaQ3kL+/VNDC9QVKwl6Aptt6XFElXVIeG+v+ajnIBw
         S00+BZ2am+/922ud97e1FpGRi5i/CDXAu3Z7QnrUuHa7txPAOggHrByhuXsQZ2mmYGgc
         PHDkNbzeDHyeKvD3IVAIt08oK8g+8bbfioTM5RNbYAHqCpdWG2mAOhq+JE0W2lRm53Vy
         K1JlUYeB78Rs/G1NZqI6InDEZiforYG6j81XFRxE/YCcCpazDlqH6YytuSZsLUDtE6Mc
         dCUhMy1xXn2mzAonjwZ8U5+i48as/vNVab4zo4BgYmba4NVen+gOR81wUtXdpar2uBf6
         +Cmg==
X-Gm-Message-State: AOAM530Op8AlsLgcKOTuyoikEs7fgbpovB81qJuwV4K7r1N1+xpdXdkf
        nxW+f95tDjgIDQxkXGkEU0POuOLXMw==
X-Google-Smtp-Source: ABdhPJx5iGfusIGqyuo8OAS7ETonBnhCqs0VbRUpxTjFfadb0udpobnAeLQ5u5krefupdXNR/CJgMQ==
X-Received: by 2002:a54:410a:: with SMTP id l10mr12692079oic.15.1620349563250;
        Thu, 06 May 2021 18:06:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e20sm834132oot.11.2021.05.06.18.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 18:06:02 -0700 (PDT)
Received: (nullmailer pid 1115466 invoked by uid 1000);
        Fri, 07 May 2021 01:06:01 -0000
Date:   Thu, 6 May 2021 20:06:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v3 0/2] Support pwm driver for aspeed ast26xx
Message-ID: <20210507010601.GA1110621@robh.at.kernel.org>
References: <20210506061050.8001-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506061050.8001-1-billy_tsai@aspeedtech.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, May 06, 2021 at 02:10:48PM +0800, Billy Tsai wrote:
> The legacy driver of aspeed pwm is binding with tach controller and it
> doesn't follow the pwm framworks usage. In addition, the pwm register
> usage of the 6th generation of ast26xx has drastic change. So these
> patch serials add the new aspeed pwm driver to fix up the problem above.
> 
> Changes since v2:
> - Remove the tach node, #address-cells and #size-cells from pwm-tach.yaml

So you don't need tach functions, they don't need it to be described in 
DT any more, or you plan to add them back later? The last one is not 
acceptable.

> - Add clocks and reset properties to pwm-tach.yaml
> - Kconfig/Makfile sorted alphabetically
> - pwm-aspeed-g6.c suggested by Uwe Kleine-König
>   - Add more hardware descriptions at top of the driver.
>   - Remove unused api request and free
>   - Move the initialize settings of all pwm channel to probe.
>   - Change the method of getting the approximate period.
>   - Read the hardware register values to fill the state for .get_state()
> 
> Changes since v1:
> - Fix the dt_binding_check fail suggested by Rob Herring
> - Add depends to PWM_ASPEED_G6 configure suggested by Uwe Kleine-Konig
> - pwm-aspeed-g6.c suggested by Uwe Kleine-König
>   - Fix license header
>   - Use bitfiled.h macro to define register fields
>   - Implement .remove device function
>   - Implement .get_state pwm api
> 
> 
> Billy Tsai (2):
>   dt-bindings: Add bindings for aspeed pwm-tach and pwm.
>   pwm: Add Aspeed ast2600 PWM support
> 
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml |  55 +++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  41 ++
>  drivers/pwm/Kconfig                           |   8 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-aspeed-g6.c                   | 368 ++++++++++++++++++
>  5 files changed, 473 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
>  create mode 100644 drivers/pwm/pwm-aspeed-g6.c
> 
> -- 
> 2.25.1
> 
