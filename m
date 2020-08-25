Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5C2512D8
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 09:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgHYHRk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 03:17:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44519 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgHYHRi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Aug 2020 03:17:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id c15so11570333wrs.11;
        Tue, 25 Aug 2020 00:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VUO6i/U3AVhRZX9XkX8wTuXOsuDoxa3aV3dAz0woA4o=;
        b=B5MJrhLrcQOv6vRhgOJDKnTX6i2punZBmlED4d9nHBgO4GDgjRlXucq8UVrIk/Hs0u
         KxOCtmKrmiukHNUkrco6xa0Idv0062LAodAWPgcLXNOZe6UPcOkG5uA6HpgGzUoTUxRQ
         bVs0TXd1toasqxcoFwCsbmkCa7D/Cbw4EGa5tDd/khQvV2i3d76+1WfPqE0SNp0+/vRT
         bZkDdW7lutuovzf1UphK6AYlwhSd/eg9vQ2+kQ0Mk+7JVr9jJD6nQIzenAVnN0Dk8IDc
         WBni8SPBdi26MqRYWRcPvQ1OlVD0PJtCGaa1aHgUTLNE8/BKuACYwCPuupE4tx9iVYTU
         kndQ==
X-Gm-Message-State: AOAM533rXg3WB00+MNa0CB+S+sh2T8LirELK547/L2c3u8/saju7/EbJ
        hOJ7UCyUkHNZBWvj9rW9PNY=
X-Google-Smtp-Source: ABdhPJzJYPNbntZuVXqhHtMzbv8B44RjyoelOfsWDije4BgkxJQBl+U8ambvcHbMGJuX5NndB1iaIw==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr8719602wrr.243.1598339855693;
        Tue, 25 Aug 2020 00:17:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id y3sm20848575wrs.36.2020.08.25.00.17.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 00:17:35 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:17:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
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
Subject: Re: [PATCH v2 13/19] dt-bindings: nvmem: imx-ocotp: Update i.MX 8M
 compatibles
Message-ID: <20200825071732.GD3458@kozik-lap>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-13-krzk@kernel.org>
 <20200825044653.GK13023@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825044653.GK13023@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 25, 2020 at 06:46:53AM +0200, Sascha Hauer wrote:
> On Mon, Aug 24, 2020 at 06:26:46PM +0200, Krzysztof Kozlowski wrote:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - fsl,imx6q-ocotp
> > +              - fsl,imx6sl-ocotp
> > +              - fsl,imx6sx-ocotp
> > +              - fsl,imx6ul-ocotp
> > +              - fsl,imx6ull-ocotp
> > +              - fsl,imx7d-ocotp
> > +              - fsl,imx6sll-ocotp
> > +              - fsl,imx7ulp-ocotp
> > +              - fsl,imx8mq-ocotp
> > +              - fsl,imx8mm-ocotp
> > +              - fsl,imx8mn-ocotp
> > +              - fsl,imx8mp-ocotp
> > +          - const: syscon
> > +      - items:
> > +          # The devices are not really compatible with fsl,imx8mm-ocotp, however
> > +          # the code for getting SoC revision depends on fsl,imx8mm-ocotp compatible.
> 
> Shouldn't this be fixed? It seems strange to justify a binding with
> existing code.

The fsl,imx8mn-ocotp is actually compatible with "mm", only the
fsl,imx8mp-ocotp is not (although someone might argue that subset of
"mp" falls into "mn").

The problem is that drivers/soc/imx/soc-imx8m.c checks revision only
against the fsl,imx8mm-ocotp compatible, not the others. It's the
pattern used in that driver also for other i.MX 8. Therefore it is a
binding implemented and actually used, regardless whether it is correct
from hardware point of view or not.

If that's preferred, I could adjust the drivers/soc/imx/soc-imx8m.c for
the incompatible "mp". It should not break anything.

Best regards,
Krzysztof

