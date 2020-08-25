Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C085250F9E
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHYCmA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:42:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42509 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgHYCl7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:41:59 -0400
Received: by mail-io1-f66.google.com with SMTP id g13so10946484ioo.9;
        Mon, 24 Aug 2020 19:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qJ01SWGuBbiIyJmwzW9cEQYUGRbCtsSrpYWxMtrlig=;
        b=lBmjYnKNglsbhSfFzSsQQ+HAUOYvMbuHCxc6fPJaqDmeDM8AByQ1sjmyIXI0WhGdeH
         qYTl+uSkgN+SU3A/Yq2kbNUiwx3Ti6hxW7msk2Mv/INgKOaO2hZXe80YJvCk6kq/kbnT
         rJKx446rHbWvCb4kqPyTdIs2TguD+4X2+EEfyJFpRcmKcdsb6hb59rAiACBbUch8YRK6
         c7aLBXqOjf+bECjfy+QL5VbV9mLhGEpEGDjUFcNYXQApFrC531E5OjQbQaF9jKMPdRWo
         GdfsSeP4gYT4ICdxJR5Qw46wyU7yC9yXbYDIPoHM4VoX1Wqj4c3soRgcSC/OSn5+mFle
         hcxw==
X-Gm-Message-State: AOAM532Sa1rp4/KI7k6oLWQU/hYa+9O+lUYEF5wtzgBinikdeoeINJ1A
        SkUcZH+eXU4xDPiJ24+47A==
X-Google-Smtp-Source: ABdhPJwIoAEUIJKIMwDQPWHs0k21rGkfs3GgLpmxkM2yHKbA+qx6fuPAbJw+Rlnd/ohVZnSP58F7NQ==
X-Received: by 2002:a05:6638:130d:: with SMTP id r13mr8168767jad.89.1598323318518;
        Mon, 24 Aug 2020 19:41:58 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r2sm8321197ila.22.2020.08.24.19.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:41:58 -0700 (PDT)
Received: (nullmailer pid 3843521 invoked by uid 1000);
        Tue, 25 Aug 2020 02:41:54 -0000
Date:   Mon, 24 Aug 2020 20:41:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 03/19] dt-bindings: gpio: fsl-imx-gpio: Add parsing of
 hogs
Message-ID: <20200825024154.GA3841561@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-3-krzk@kernel.org>
 <20200825023306.GA3827348@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825023306.GA3827348@bogus>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 08:33:06PM -0600, Rob Herring wrote:
> On Mon, Aug 24, 2020 at 06:26:36PM +0200, Krzysztof Kozlowski wrote:
> > Allow parsing GPIO controller children nodes with GPIO hogs to fix
> > warning:
> > 
> >   arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: gpio@30240000: 'wl-reg-on' does not match any of the regexes: 'pinctrl-[0-9]+'
> >     From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> 
> The below change isn't going to fix 'wl-reg-on'?

Never mind, saw you changed it.

Reviewed-by: Rob Herring <robh@kernel.org>
